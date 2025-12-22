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
      <!-- 可扩展功能按钮（如新增） -->
    </div>

    <!-- 搜索筛选区 -->
    <div class="search-filter-card">
      <el-form :inline="true" :model="searchForm" class="search-form">
        <el-form-item label="企业名称">
          <el-input v-model="searchForm.companyName" placeholder="请输入企业名称"></el-input>
        </el-form-item>
        <el-form-item label="验证状态">
          <!-- 下拉框设置固定宽度，保证字体显示空间 -->
          <el-select 
            v-model="selectedStatus" 
            placeholder="请选择状态"
            style="width: 160px;">
            <el-option label="全部" value=""></el-option>
            <el-option label="待审核" value="pending"></el-option>
            <el-option label="已通过" value="passed"></el-option>
            <el-option label="已驳回" value="rejected"></el-option>
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
      <el-table :data="tableData" border stripe style="width: 100%" size="large">
        <el-table-column prop="id" label="企业编号" width="120"></el-table-column>
        <el-table-column label="企业名称" min-width="200">
          <template #default="scope">
            <div class="company-name-item">
              <el-avatar :size="36" class="name-avatar">
                {{ scope.row.companyName.slice(0, 1) }}
              </el-avatar>
              <span class="name-text">{{ scope.row.companyName }}</span>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="legalPerson" label="法人" width="120"></el-table-column>
        <el-table-column prop="phone" label="联系方式" width="160"></el-table-column>
        <el-table-column prop="applyTime" label="申请时间" width="200"></el-table-column>
        <el-table-column prop="status" label="验证状态" width="140">
          <template #default="scope">
            <el-tag 
              :class="scope.row.status === 'pending' ? 'tag-warning' : 
                      scope.row.status === 'passed' ? 'tag-success' : 'tag-danger'"
              size="medium">
              {{ scope.row.status === 'pending' ? '待审核' : 
                 scope.row.status === 'passed' ? '已通过' : '已驳回' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="180">
          <template #default="scope">
            <el-button type="text" class="operate-btn" @click="handleDetail(scope.row)">详情</el-button>
            <el-button 
              v-if="scope.row.status === 'pending'" 
              type="text" 
              class="operate-btn audit-btn" 
              @click="handleAudit(scope.row)">审核
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页组件（与客户管理页风格一致） -->
      <div class="pagination-container">
        <span class="total-count">共 {{ total }} 条记录</span>
        <el-pagination
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          layout="prev, pager, next, jumper"
          :page-size="pageSize"
          :total="total"
          background
          style="margin-left: 10px;"
          size="large">
        </el-pagination>
      </div>
    </div>

    <!-- 详情弹窗（保持风格统一） -->
    <el-dialog
      v-model="detailDialogVisible"
      title="企业验证详情"
      width="70%"
      destroy-on-close
      :close-on-click-modal="false"
      :custom-class="'detail-dialog'">
      <div v-if="currentRow" class="detail-content">
        <el-descriptions :column="2" border size="large" style="width: 100%">
          <el-descriptions-item label="企业编号">{{ currentRow.id }}</el-descriptions-item>
          <el-descriptions-item label="企业名称">{{ currentRow.companyName }}</el-descriptions-item>
          <el-descriptions-item label="统一社会信用代码">{{ currentRow.creditCode }}</el-descriptions-item>
          <el-descriptions-item label="法人">{{ currentRow.legalPerson }}</el-descriptions-item>
          <el-descriptions-item label="企业地址">{{ currentRow.address }}</el-descriptions-item>
          <el-descriptions-item label="联系方式">{{ currentRow.phone }}</el-descriptions-item>
          <el-descriptions-item label="申请时间">{{ currentRow.applyTime }}</el-descriptions-item>
          <el-descriptions-item label="验证状态">
            <el-tag 
              :class="currentRow.status === 'pending' ? 'tag-warning' : 
                      currentRow.status === 'passed' ? 'tag-success' : 'tag-danger'"
              size="medium">
              {{ currentRow.status === 'pending' ? '待审核' : 
                 currentRow.status === 'passed' ? '已通过' : '已驳回' }}
            </el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="审核时间" v-if="currentRow.auditTime">{{ currentRow.auditTime }}</el-descriptions-item>
          <el-descriptions-item label="审核意见" v-if="currentRow.auditOpinion" span="2">
            {{ currentRow.auditOpinion || '无' }}
          </el-descriptions-item>
        </el-descriptions>

        <!-- 企业资质图片展示（替换为可访问的示例图） -->
        <div class="cert-img-container" v-if="currentRow.certImgs && currentRow.certImgs.length">
          <h4 class="cert-title">企业资质证明：</h4>
          <div class="img-list">
            <el-image
              v-for="(img, index) in currentRow.certImgs"
              :key="index"
              :src="img"
              fit="contain"
              style="width: 200px; height: 200px; margin-right: 20px; margin-top: 10px"
              preview-src-list="currentRow.certImgs">
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
      :custom-class="'audit-dialog'">
      <div v-if="currentRow" class="audit-content">
        <el-form :model="auditForm" label-width="80px" size="large">
          <el-form-item label="审核结果" prop="result">
            <el-radio-group v-model="auditForm.result">
              <el-radio label="passed" border size="large">通过</el-radio>
              <el-radio label="rejected" border size="large">驳回</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="审核意见" prop="opinion" v-if="auditForm.result">
            <el-input
              v-model="auditForm.opinion"
              type="textarea"
              :rows="5"
              placeholder="请输入审核意见（驳回时必填）"
              size="large"></el-input>
          </el-form-item>
        </el-form>
      </div>
      <template #footer>
        <el-button @click="auditDialogVisible = false" size="large">取消</el-button>
        <el-button type="primary" @click="handleSubmitAudit" size="large">提交</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue';
import { ElMessage } from 'element-plus';

// 搜索表单：仅保留必要字段，简化逻辑
const searchForm = reactive({
  companyName: ''
});

// 关键：单独定义下拉框绑定值（直接对应option的value，Element Plus会自动显示对应的label）
const selectedStatus = ref(''); // 初始为空，下拉框显示占位符

// 原始表格数据（替换为可访问的示例图片）
const originTableData = ref([
  {
    id: 'ENT001',
    companyName: '北京字节跳动科技有限公司',
    creditCode: '911101085923662400',
    legalPerson: '张一鸣',
    address: '北京市海淀区中关村软件园',
    phone: '010-12345678',
    applyTime: '2025-12-01 10:20:30',
    status: 'pending',
    auditTime: '',
    auditOpinion: '',
    certImgs: [
      'https://picsum.photos/400/300?random=1',
      'https://picsum.photos/400/300?random=2'
    ]
  },
  {
    id: 'ENT002',
    companyName: '深圳市腾讯计算机系统有限公司',
    creditCode: '91440300708461136T',
    legalPerson: '马化腾',
    address: '广东省深圳市南山区腾讯大厦',
    phone: '0755-83765566',
    applyTime: '2025-12-02 14:30:20',
    status: 'passed',
    auditTime: '2025-12-02 16:00:00',
    auditOpinion: '资料齐全，审核通过',
    certImgs: []
  },
  {
    id: 'ENT003',
    companyName: '阿里巴巴（中国）有限公司',
    creditCode: '91330100768225698A',
    legalPerson: '张勇',
    address: '浙江省杭州市余杭区文一西路969号',
    phone: '0571-85022088',
    applyTime: '2025-12-03 09:15:10',
    status: 'rejected',
    auditTime: '2025-12-03 10:00:00',
    auditOpinion: '资质证明模糊，驳回重新提交',
    certImgs: []
  },
  {
    id: 'ENT004',
    companyName: '百度在线网络技术（北京）有限公司',
    creditCode: '91110000802100433B',
    legalPerson: '李彦宏',
    address: '北京市海淀区百度科技园',
    phone: '010-59928888',
    applyTime: '2025-12-04 11:20:00',
    status: 'pending',
    auditTime: '',
    auditOpinion: '',
    certImgs: []
  }
]);

// 表格数据（用于展示和筛选）
const tableData = ref([...originTableData.value]);

// 分页参数
const currentPage = ref(1);
const pageSize = ref(10);
const total = ref(tableData.value.length);

// 弹窗相关
const detailDialogVisible = ref(false);
const auditDialogVisible = ref(false);
const currentRow = ref<any>(null);

// 审核表单
const auditForm = reactive({
  result: '',
  opinion: ''
});

// 生命周期 - 页面加载
onMounted(() => {
  // 可在此处调用接口获取数据
});

// 搜索事件：直接使用selectedStatus的值进行筛选
const handleSearch = () => {
  const filteredData = originTableData.value.filter(item => {
    const nameMatch = item.companyName.includes(searchForm.companyName);
    const statusMatch = selectedStatus.value ? item.status === selectedStatus.value : true;
    return nameMatch && statusMatch;
  });
  tableData.value = filteredData;
  total.value = filteredData.length;
  currentPage.value = 1;
};

// 重置事件：清空所有筛选条件
const handleReset = () => {
  searchForm.companyName = '';
  selectedStatus.value = ''; // 重置下拉框为初始状态（显示占位符）
  tableData.value = [...originTableData.value];
  total.value = tableData.value.length;
  currentPage.value = 1;
};

// 分页 - 当前页改变
const handleCurrentChange = (val: number) => {
  currentPage.value = val;
};

// 查看详情
const handleDetail = (row: any) => {
  currentRow.value = { ...row };
  detailDialogVisible.value = true;
};

// 审核操作
const handleAudit = (row: any) => {
  currentRow.value = { ...row };
  auditForm.result = '';
  auditForm.opinion = '';
  auditDialogVisible.value = true;
};

// 提交审核
const handleSubmitAudit = () => {
  if (!auditForm.result) {
    ElMessage.warning('请选择审核结果');
    return;
  }
  if (auditForm.result === 'rejected' && !auditForm.opinion) {
    ElMessage.warning('驳回时请输入审核意见');
    return;
  }

  // 同时更新表格数据和原始数据
  const tableIndex = tableData.value.findIndex(item => item.id === currentRow.value.id);
  if (tableIndex > -1) {
    tableData.value[tableIndex].status = auditForm.result;
    tableData.value[tableIndex].auditTime = new Date().toLocaleString();
    tableData.value[tableIndex].auditOpinion = auditForm.opinion;
  }

  const originIndex = originTableData.value.findIndex(item => item.id === currentRow.value.id);
  if (originIndex > -1) {
    originTableData.value[originIndex].status = auditForm.result;
    originTableData.value[originIndex].auditTime = new Date().toLocaleString();
    originTableData.value[originIndex].auditOpinion = auditForm.opinion;
  }

  ElMessage.success('审核提交成功');
  auditDialogVisible.value = false;
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