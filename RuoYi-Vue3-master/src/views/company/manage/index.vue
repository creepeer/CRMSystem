<template>
  <div class="enterprise-verify-container">
    <!-- 顶部品牌栏 -->
    <div class="brand-header">
      <h1>先锋互联</h1>
    </div>

    <!-- 页面标题栏 -->
    <div class="page-title-bar">
      <div>
        <h2>企业验证管理</h2>
        <p class="sub-title">管理所有企业验证信息</p>
      </div>
    </div>

    <!-- 搜索筛选区 -->
    <div class="search-filter-card">
      <el-form :inline="true" :model="searchForm" class="search-form">
        <el-form-item label="企业名称">
          <el-input v-model="searchForm.companyName" placeholder="请输入企业名称" />
        </el-form-item>

        <el-form-item label="验证状态">
          <el-select v-model="selectedStatus" placeholder="请选择状态" style="width: 160px">
            <el-option label="全部" value="" />
            <!-- 后端 state：常见约定：1待审核 2通过 3驳回 -->
            <el-option label="待审核" value="1" />
            <el-option label="已通过" value="2" />
            <el-option label="已驳回" value="3" />
          </el-select>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" class="search-btn" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <!-- 数据列表 -->
    <div class="table-card">
      <el-table :data="tableData" border stripe style="width: 100%" size="large" v-loading="loading">
        <el-table-column prop="id" label="企业编号" width="120" />

        <el-table-column label="企业名称" min-width="200">
          <template #default="scope">
            <div class="company-name-item">
              <el-avatar :size="36" class="name-avatar">
                {{ (scope.row.name || '').slice(0, 1) }}
              </el-avatar>
              <span class="name-text">{{ scope.row.name }}</span>
            </div>
          </template>
        </el-table-column>

        <el-table-column prop="leName" label="法人" width="120" />
        <el-table-column prop="lePhone" label="联系方式" width="160" />
        <el-table-column prop="createTime" label="申请时间" width="200" />

        <el-table-column label="验证状态" width="140">
          <template #default="scope">
            <el-tag :class="stateTagClass(scope.row.state)" size="medium">
              {{ stateLabel(scope.row.state) }}
            </el-tag>
          </template>
        </el-table-column>

        <el-table-column label="操作" width="180">
          <template #default="scope">
            <el-button type="text" class="operate-btn" @click="handleDetail(scope.row)">详情</el-button>
            <el-button
              v-if="Number(scope.row.state) === 1"
              type="text"
              class="operate-btn audit-btn"
              @click="handleAudit(scope.row)"
            >
              审核
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页组件 -->
      <div class="pagination-container">
        <span class="total-count">共 {{ total }} 条记录</span>
        <el-pagination
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          layout="prev, pager, next, jumper"
          :page-size="pageSize"
          :total="total"
          background
          style="margin-left: 10px"
          size="large"
        />
      </div>
    </div>

    <!-- 详情弹窗 -->
    <el-dialog
      v-model="detailDialogVisible"
      title="企业验证详情"
      width="70%"
      destroy-on-close
      :close-on-click-modal="false"
      :custom-class="'detail-dialog'"
    >
      <div v-if="currentRow" class="detail-content">
        <el-descriptions :column="2" border size="large" style="width: 100%">
          <el-descriptions-item label="企业编号">{{ currentRow.id }}</el-descriptions-item>
          <el-descriptions-item label="企业名称">{{ currentRow.name }}</el-descriptions-item>

          <el-descriptions-item label="企业地址">{{ currentRow.address || '-' }}</el-descriptions-item>
          <el-descriptions-item label="申请时间">{{ currentRow.createTime || '-' }}</el-descriptions-item>

          <el-descriptions-item label="法人">{{ currentRow.leName || '-' }}</el-descriptions-item>
          <el-descriptions-item label="联系方式">{{ currentRow.lePhone || '-' }}</el-descriptions-item>

          <el-descriptions-item label="法人邮箱">{{ currentRow.leEmail || '-' }}</el-descriptions-item>
          <el-descriptions-item label="法人年龄">{{ currentRow.leAge ?? '-' }}</el-descriptions-item>

          <el-descriptions-item label="法人证件号" span="2">
            {{ currentRow.leCard || '-' }}
          </el-descriptions-item>

          <el-descriptions-item label="备注" span="2">
            {{ currentRow.remark || '无' }}
          </el-descriptions-item>

          <el-descriptions-item label="验证状态">
            <el-tag :class="stateTagClass(currentRow.state)" size="medium">
              {{ stateLabel(currentRow.state) }}
            </el-tag>
          </el-descriptions-item>
        </el-descriptions>

        <!-- 企业资质图片展示：后端字段可能是 license / cplicense -->
        <div class="cert-img-container" v-if="currentCertImgs.length">
          <h4 class="cert-title">企业资质证明：</h4>
          <div class="img-list">
            <el-image
              v-for="(img, index) in currentCertImgs"
              :key="index"
              :src="img"
              fit="contain"
              style="width: 200px; height: 200px; margin-right: 20px; margin-top: 10px"
              :preview-src-list="currentCertImgs"
            >
              <template #error>
                <div class="image-placeholder">资质图片</div>
              </template>
            </el-image>
          </div>
        </div>
      </div>

      <template #footer>
        <el-button @click="detailDialogVisible = false" size="large">关闭</el-button>
      </template>
    </el-dialog>

    <!-- 审核弹窗 -->
    <el-dialog
      v-model="auditDialogVisible"
      title="企业验证审核"
      width="50%"
      destroy-on-close
      :close-on-click-modal="false"
      :custom-class="'audit-dialog'"
    >
      <div v-if="currentRow" class="audit-content">
        <el-form :model="auditForm" label-width="80px" size="large">
          <el-form-item label="审核结果" prop="result">
            <el-radio-group v-model="auditForm.result">
              <el-radio label="passed" border size="large">通过</el-radio>
              <el-radio label="rejected" border size="large">驳回</el-radio>
            </el-radio-group>
          </el-form-item>

          <!-- 说明：你当前后端不接收审核意见字段，这里仅做前端校验 -->
          <el-form-item label="审核意见" prop="opinion" v-if="auditForm.result">
            <el-input
              v-model="auditForm.opinion"
              type="textarea"
              :rows="5"
              placeholder="请输入审核意见（驳回时必填）"
              size="large"
            />
          </el-form-item>
        </el-form>
      </div>

      <template #footer>
        <el-button @click="auditDialogVisible = false" size="large">取消</el-button>
        <el-button type="primary" @click="handleSubmitAudit" size="large" :loading="submitLoading">
          提交
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed } from 'vue';
import { ElMessage } from 'element-plus';

// 只改前端且不动项目配置：用 @ts-ignore 压掉 ts-plugin(2307) 报错（运行仍由构建工具解析 @ 别名）
// @ts-ignore
import request from '@/utils/request';

type CompanyRow = {
  id: number;
  name: string;
  address?: string | null;
  // 你接口返回里是 license，但你日志 SQL 里是 cplicense；这里两者都兼容
  license?: string | null;
  cplicense?: string | null;

  leName?: string | null;
  leAge?: number | null;
  leEmail?: string | null;
  lePhone?: string | null;
  leCard?: string | null;

  state?: number | null;
  remark?: string | null;
  createTime?: string | null;
  updateTime?: string | null;

  tenantId?: number | null;
  isDeleted?: number | null;

  // 允许后端多余字段
  [k: string]: any;
};

const loading = ref(false);
const submitLoading = ref(false);

// 搜索表单
const searchForm = reactive({
  companyName: ''
});
const selectedStatus = ref<string>(''); // '', '1','2','3'

// 列表与分页
const tableData = ref<CompanyRow[]>([]);
const total = ref(0);
const currentPage = ref(1);
const pageSize = ref(10);

// 弹窗
const detailDialogVisible = ref(false);
const auditDialogVisible = ref(false);
const currentRow = ref<CompanyRow | null>(null);

// 审核表单
const auditForm = reactive({
  result: '' as '' | 'passed' | 'rejected',
  opinion: ''
});

/** 状态显示：按常见约定 1待审核 2通过 3驳回 */
const stateLabel = (state?: number | null) => {
  const s = Number(state);
  if (s === 1) return '待审核';
  if (s === 2) return '已通过';
  if (s === 3) return '已驳回';
  return '未知';
};
const stateTagClass = (state?: number | null) => {
  const s = Number(state);
  if (s === 1) return 'tag-warning';
  if (s === 2) return 'tag-success';
  if (s === 3) return 'tag-danger';
  return 'tag-warning';
};

/** 图片 URL 兜底拼接：尽量不依赖项目配置；若你能访问 /profile/xxx，可把 fallbackPrefix 改成 /profile/ */
const resolveFileUrl = (p: string) => {
  if (!p) return '';
  if (/^https?:\/\//i.test(p)) return p;

  // 若后端返回 /images/1.png 这种绝对路径，直接用（或由代理自动补前缀）
  if (p.startsWith('/')) return p;

  // 若只返回文件名：给一个兜底前缀（按你项目实际静态资源路径调整）
  const fallbackPrefix = '/profile/';
  return `${fallbackPrefix}${p}`;
};

const currentCertImgs = computed(() => {
  const lic = currentRow.value?.license || currentRow.value?.cplicense;
  if (!lic) return [];
  // 允许逗号分隔多个
  const parts = String(lic)
    .split(',')
    .map((s) => s.trim())
    .filter(Boolean);
  return parts.map(resolveFileUrl).filter(Boolean);
});

/** 拉取列表：GET /company/manage/list */
const fetchList = async () => {
  loading.value = true;
  try {
    const params: Record<string, any> = {
      pageNum: currentPage.value,
      pageSize: pageSize.value
    };
    if (searchForm.companyName) params.name = searchForm.companyName;
    if (selectedStatus.value) params.state = Number(selectedStatus.value);

    const res: any = await request({
      url: '/company/manage/list',
      method: 'get',
      params
    });

    if (res?.code !== 200) {
      ElMessage.error(res?.msg || '查询失败');
      tableData.value = [];
      total.value = 0;
      return;
    }

    tableData.value = (res.rows || []) as CompanyRow[];
    total.value = Number(res.total ?? tableData.value.length);
  } catch (e) {
    ElMessage.error('查询失败，请检查接口/权限/网络');
    tableData.value = [];
    total.value = 0;
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  fetchList();
});

// 搜索
const handleSearch = () => {
  currentPage.value = 1;
  fetchList();
};

// 重置
const handleReset = () => {
  searchForm.companyName = '';
  selectedStatus.value = '';
  currentPage.value = 1;
  fetchList();
};

// 分页
const handleCurrentChange = (val: number) => {
  currentPage.value = val;
  fetchList();
};

// 详情
const handleDetail = (row: CompanyRow) => {
  currentRow.value = { ...row };
  detailDialogVisible.value = true;
};

// 审核
const handleAudit = (row: CompanyRow) => {
  currentRow.value = { ...row };
  auditForm.result = '';
  auditForm.opinion = '';
  auditDialogVisible.value = true;
};

/**
 * 提交审核 —— 只改前端且绕开后端 /updateState 的 500 异常：
 * 1) GET /company/manage/{id} 拿详情
 * 2) 修改 state
 * 3) PUT /company/manage/update 提交完整对象
 */
const handleSubmitAudit = async () => {
  if (!auditForm.result) {
    ElMessage.warning('请选择审核结果');
    return;
  }
  if (auditForm.result === 'rejected' && !auditForm.opinion) {
    ElMessage.warning('驳回时请输入审核意见');
    return;
  }
  if (!currentRow.value?.id) {
    ElMessage.error('缺少企业ID，无法提交');
    return;
  }

  // 映射：通过=2，驳回=3（按你当前接口返回/常见约定）
  const newState = auditForm.result === 'passed' ? 2 : 3;

  submitLoading.value = true;
  try {
    // 1) 拉详情（避免只传 id/state 导致其他字段被置空）
    const detailRes: any = await request({
      url: `/company/manage/${currentRow.value.id}`,
      method: 'get'
    });

    if (detailRes?.code !== 200) {
      ElMessage.error(detailRes?.msg || '获取企业详情失败');
      return;
    }

    const company: CompanyRow = detailRes.data;
    if (!company?.id) {
      ElMessage.error('企业详情数据异常');
      return;
    }

    // 2) 改状态
    company.state = newState;

    // 3) 调用 update（后端是 @PutMapping("/update")）
    const updateRes: any = await request({
      url: '/company/manage/update',
      method: 'put',
      data: company
    });

    if (updateRes?.code !== 200) {
      ElMessage.error(updateRes?.msg || '提交失败');
      return;
    }

    ElMessage.success('审核提交成功');
    auditDialogVisible.value = false;

    // 4) 刷新列表
    fetchList();
  } catch (e) {
    ElMessage.error('提交失败，请检查接口/权限/网络');
  } finally {
    submitLoading.value = false;
  }
};
</script>

<style scoped>
/* 全局容器：设置基础字体大小，作为页面字体基准 */
.enterprise-verify-container {
  background-color: #f5f5f7;
  min-height: 100vh;
  font-family: "Microsoft Yahei", sans-serif;
  font-size: 16px; /* 基础字体增大，子元素会继承 */
}

/* 品牌头部 - 增大字体，调整间距 */
.brand-header {
  background-color: #fff;
  padding: 16px 24px; /* 增大内边距，配合字体大小 */
  border-bottom: 1px solid #eee;
}
.brand-header h1 {
  font-size: 28px; /* 进一步增大品牌名称字体 */
  font-weight: 600;
  color: #333;
  margin: 0;
  text-align: center;
}

/* 页面标题栏 - 增大标题和副标题字体 */
.page-title-bar {
  padding: 24px 24px; /* 增大内边距 */
  background-color: #fff;
  margin-bottom: 16px;
  border-bottom: 1px solid #eee;
}
.page-title-bar h2 {
  font-size: 26px; /* 增大页面标题字体 */
  font-weight: 600;
  color: #333;
  margin: 0 0 8px 0; /* 增加与副标题的间距 */
}
.page-title-bar .sub-title {
  font-size: 18px; /* 增大副标题字体 */
  color: #999;
  margin: 0;
}

/* 搜索筛选卡片：增大表单元素字体和间距 */
.search-filter-card {
  background-color: #fff;
  padding: 20px 24px; /* 增大内边距 */
  margin: 0 24px 16px;
  border-radius: 4px;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}
.search-form {
  display: flex;
  align-items: center;
  gap: 16px; /* 增加表单元素之间的间距 */
}
/* 增大表单标签字体 */
:deep(.el-form-item__label) {
  font-size: 17px;
  font-weight: 500;
}
/* 增大输入框、下拉框字体和高度 */
:deep(.el-input__inner), :deep(.el-select__wrapper) {
  font-size: 17px;
  padding: 10px 12px; /* 增大内边距，提升高度 */
}
/* 增大按钮字体和尺寸 */
:deep(.el-button) {
  font-size: 17px;
  padding: 10px 20px;
}

/* 表格卡片：调整表格内字体和元素大小 */
.table-card {
  background-color: #fff;
  margin: 0 24px 24px;
  border-radius: 4px;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
  padding: 20px; /* 增大内边距 */
}
/* 增大表格头部字体 */
:deep(.el-table__header-cell) {
  font-size: 17px;
  font-weight: 600;
}
/* 增大表格内容字体 */
:deep(.el-table__cell) {
  font-size: 16px;
  padding: 16px 0; /* 增大单元格上下内边距 */
}

/* 企业名称项：配合字体增大调整头像和文字 */
.company-name-item {
  display: flex;
  align-items: center;
}
.name-avatar {
  background-color: #409eff;
  color: #fff;
  margin-right: 12px; /* 增大头像与文字间距 */
}
.name-text {
  font-size: 17px; /* 增大企业名称字体 */
  color: #333;
}

/* 状态标签：增大标签字体和尺寸 */
:deep(.el-tag) {
  font-size: 16px; /* 增大标签文字 */
  padding: 6px 12px; /* 增大标签内边距 */
}
.tag-warning {
  background-color: #fff8e1;
  color: #faad14;
  border-color: #ffe58f;
}
.tag-success {
  background-color: #f0f9eb;
  color: #52c41a;
  border-color: #b7eb8f;
}
.tag-danger {
  background-color: #fff1f0;
  color: #f5222d;
  border-color: #ffccc7;
}

/* 操作按钮：增大按钮字体 */
.operate-btn {
  color: #1890ff;
  padding: 0 8px;
  font-size: 17px; /* 增大操作按钮字体 */
}
.audit-btn {
  color: #52c41a;
}

/* 分页容器：增大分页文字和组件字体 */
.pagination-container {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  margin-top: 20px; /* 增大上边距 */
  font-size: 17px; /* 增大分页文字字体 */
  color: #666;
}
.total-count {
  margin-right: 16px;
}
/* 增大分页组件字体 */
:deep(.el-pagination) {
  font-size: 17px;
}

/* 详情弹窗：增大弹窗内字体 */
.detail-dialog {
  font-size: 17px; /* 弹窗基础字体 */
}
.detail-dialog .el-dialog__body {
  padding: 24px; /* 增大弹窗内边距 */
}
.cert-title {
  font-size: 18px; /* 增大资质标题字体 */
  font-weight: 500;
  color: #333;
  margin: 20px 0 12px 0; /* 调整间距 */
}
.image-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f5f5f5;
  color: #999;
  font-size: 16px; /* 增大占位符字体 */
}

/* 审核弹窗：增大弹窗内字体 */
.audit-dialog {
  font-size: 17px; /* 弹窗基础字体 */
}
.audit-dialog .el-dialog__body {
  padding: 24px; /* 增大弹窗内边距 */
}
/* 增大单选框字体 */
:deep(.el-radio__label) {
  font-size: 17px;
}
/* 增大文本域字体 */
:deep(.el-textarea__inner) {
  font-size: 17px;
}
</style>
