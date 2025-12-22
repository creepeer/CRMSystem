<template>
  <div class="app-container">
    <!-- 导航栏 -->
    <nav class="navbar">
      <div class="navbar-brand">
        <div class="logo">
          <i class="fas fa-users"></i>
          <h1>员工管理</h1>
        </div>
      </div>
    </nav>

    <!-- 主要内容区域 -->
    <main class="main-content">
      <!-- 页面标题和操作栏 -->
      <div class="page-header">
        <div class="header-content">
          <h2 class="page-title">员工管理</h2>
          <p class="page-subtitle">管理公司员工信息</p>
        </div>
        <div class="actions">
          <button class="btn btn-primary" @click="openAdd">
            <i class="fas fa-plus"></i>
            新增员工
          </button>
          <button class="btn btn-outline" @click="toggleSearch">
            <i class="fas" :class="showSearch ? 'fa-search-minus' : 'fa-search'"></i>
            {{ showSearch ? '隐藏搜索' : '显示搜索' }}
          </button>
          <button class="btn btn-outline" @click="toggleExpandAll">
            <i class="fas" :class="isExpandAll ? 'fa-compress' : 'fa-expand'"></i>
            {{ isExpandAll ? '折叠全部' : '展开全部' }}
          </button>
        </div>
      </div>

      <!-- 查询条件 -->
      <div v-show="showSearch" class="query-card">
        <div class="query-row">
          <div class="query-group">
            <label class="query-label">姓名</label>
            <input type="text" v-model="queryParams.nickName" placeholder="请输入姓名" class="query-input"
              @keyup.enter="getList">
          </div>
          <div class="query-group">
            <label class="query-label">账号</label>
            <input type="text" v-model="queryParams.userName" placeholder="请输入账号" class="query-input"
              @keyup.enter="getList">
          </div>
          <div class="query-group">
            <label class="query-label">部门</label>
            <select v-model="queryParams.deptId" class="query-select">
              <option value="">全部部门</option>
              <option v-for="d in deptSelectOptions" :key="d.deptId" :value="d.deptId">
                {{ d.deptName }}
              </option>
            </select>
          </div>
          <div class="query-actions">
            <button class="btn btn-primary" @click="getList">
              <i class="fas fa-search"></i>
              搜索
            </button>
            <button class="btn btn-outline" @click="resetQuery">
              <i class="fas fa-redo"></i>
              重置
            </button>
          </div>
        </div>
      </div>

      <!-- 主要区域 -->
      <div class="content-layout">
        <!-- 左侧部门树 -->
        <div class="sidebar">
          <div class="sidebar-card">
            <div class="sidebar-header">
              <i class="fas fa-sitemap"></i>
              <h3>部门列表</h3>
            </div>
            <div class="sidebar-search">
              <input type="text" v-model="deptFilter" placeholder="输入部门名称搜索..." class="sidebar-input"
                @input="filterDeptTree">
            </div>

            <div class="dept-tree-container">
              <div v-if="loading" class="loading-state">
                <i class="fas fa-spinner fa-spin"></i>
                <p>加载中...</p>
              </div>

              <div v-else-if="filteredDeptTree.length === 0" class="empty-tree">
                <i class="fas fa-search"></i>
                <p>未找到匹配的部门</p>
              </div>

              <div v-else class="dept-tree">
                <div v-for="dept in filteredDeptTree" :key="dept.deptId" class="dept-tree-item">
                  <div class="dept-item">
                    <div class="dept-item-main" :class="{ active: queryParams.deptId === dept.deptId }"
                      @click="handleDeptSelect(dept)">
                      <div class="dept-item-content">
                        <div v-if="dept.children && dept.children.length > 0" class="dept-icon"
                          @click.stop="toggleDeptExpand(dept.deptId)">
                          <i :class="dept._expanded ? 'fas fa-chevron-down' : 'fas fa-chevron-right'"></i>
                        </div>
                        <div v-else class="dept-icon">
                          <i class="fas fa-minus"></i>
                        </div>

                        <div class="dept-info">
                          <div class="dept-name">
                            {{ dept.label }}
                            <span v-if="dept.children && dept.children.length > 0" class="dept-count">
                              ({{ dept.children.length }})
                            </span>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- 子部门 -->
                  <div v-if="dept.children && dept.children.length > 0 && dept._expanded" class="dept-children"
                    style="margin-left: 1.5rem;">
                    <div v-for="child in dept.children" :key="child.deptId" class="dept-child-item">
                      <div class="dept-item">
                        <div class="dept-item-main" :class="{ active: queryParams.deptId === child.deptId }"
                          @click="handleDeptSelect(child)">
                          <div class="dept-item-content">
                            <div v-if="child.children && child.children.length > 0" class="dept-icon"
                              @click.stop="toggleDeptExpand(child.deptId)">
                              <i :class="child._expanded ? 'fas fa-chevron-down' : 'fas fa-chevron-right'"></i>
                            </div>
                            <div v-else class="dept-icon">
                              <i class="fas fa-minus"></i>
                            </div>

                            <div class="dept-info">
                              <div class="dept-name">
                                {{ child.label }}
                                <span v-if="child.children && child.children.length > 0" class="dept-count">
                                  ({{ child.children.length }})
                                </span>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>

                      <!-- 孙部门 -->
                      <div v-if="child.children && child.children.length > 0 && child._expanded" class="dept-children"
                        style="margin-left: 1.5rem; border-left: 1px solid #e8e8e8; padding-left: 1rem;">
                        <div v-for="grandChild in child.children" :key="grandChild.deptId" class="dept-child-item">
                          <div class="dept-item">
                            <div class="dept-item-main" :class="{ active: queryParams.deptId === grandChild.deptId }"
                              @click="handleDeptSelect(grandChild)">
                              <div class="dept-item-content">
                                <div class="dept-icon">
                                  <i class="fas fa-minus"></i>
                                </div>
                                <div class="dept-info">
                                  <div class="dept-name">
                                    {{ grandChild.label }}
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>

                    </div>
                  </div>

                </div>
              </div>
            </div>

          </div>
        </div>

        <!-- 右侧员工表格 -->
        <div class="content-main">
          <div class="table-header">
            <div class="table-info">
              <span class="info-text">
                共 <span class="info-number">{{ total }}</span> 条记录
              </span>
              <span v-if="queryParams.deptId" class="dept-selected">
                <i class="fas fa-filter"></i>
                当前部门筛选
              </span>
            </div>
          </div>

          <div class="table-card">
            <div v-if="loading" class="loading-state">
              <div class="loading-spinner">
                <i class="fas fa-spinner fa-spin"></i>
              </div>
              <p>正在加载员工数据...</p>
            </div>

            <div v-else-if="tableData.length === 0" class="empty-state">
              <i class="fas fa-users empty-icon"></i>
              <p>暂无员工数据</p>
              <button class="btn btn-outline mt-3" @click="openAdd">
                <i class="fas fa-plus"></i>
                立即添加员工
              </button>
            </div>

            <div v-else class="staff-table">
              <table class="data-table">
                <thead>
                  <tr>
                    <th style="width: 110px;">员工号</th>
                    <th>姓名</th>
                    <th>部门</th>
                    <th>年龄</th>
                    <th>职位</th>
                    <th style="width: 210px;">操作</th>
                  </tr>
                </thead>

                <tbody>
                  <!-- 关键：员工行 + 展开行 -->
                  <template v-for="staff in tableData" :key="staff.userId">
                    <!-- 员工行：点击展开客户树（把 userId 传后端） -->
                    <tr class="staff-row" :class="{ 'staff-row-active': expandedStaffId === staff.userId }"
                      @click="toggleStaffCustomers(staff)">
                      <td>
                        <div class="staff-id">
                          <span class="row-expand-icon">
                            <i class="fas"
                              :class="expandedStaffId === staff.userId ? 'fa-chevron-down' : 'fa-chevron-right'"></i>
                          </span>
                          {{ staff.userId }}
                        </div>
                      </td>

                      <td>
                        <div class="staff-info">
                          <div class="staff-avatar">
                            {{ getAvatarText(staff.nickName) }}
                          </div>
                          <div class="staff-name">{{ staff.nickName }}</div>
                        </div>
                      </td>

                      <td>
                        <div class="dept-cell">
                          <i class="fas fa-building"></i>
                          <span>{{ staff.dept?.deptName || '-' }}</span>
                        </div>
                      </td>

                      <td>
                        <span class="age-badge">{{ staff.age }}</span>
                      </td>

                      <td>
                        <span class="role-tag" :class="getRoleClass(staff.roleId)">
                          {{ getRoleText(staff.roleId) }}
                        </span>
                      </td>

                      <td>
                        <div class="action-buttons">
                          <button class="btn-action edit" @click.stop="openEdit(staff)">
                            <i class="fas fa-edit"></i>
                            编辑
                          </button>
                          <button class="btn-action delete" @click.stop="deleteStaff(staff.userId)">
                            <i class="fas fa-trash"></i>
                            删除
                          </button>
                        </div>
                      </td>
                    </tr>

                    <!-- 展开行：客户树（类似部门树的UI风格） -->
                    <tr v-if="expandedStaffId === staff.userId" class="expand-row">
                      <td colspan="6" class="expand-cell">
                        <div class="customer-panel">
                          <div class="customer-panel-header">
                            <div class="customer-panel-title">
                              <i class="fas fa-sitemap"></i>
                              <h3>客户列表</h3>
                              <span class="customer-count" v-if="customerList.length">
                                ({{ customerList.length }})
                              </span>
                            </div>

                            <button class="btn btn-outline btn-sm" @click.stop="collapseCustomers">
                              <i class="fas fa-compress"></i>
                              收起
                            </button>
                          </div>

                          <div class="customer-tree-container">
                            <div v-if="customerLoading" class="loading-state small-loading">
                              <i class="fas fa-spinner fa-spin"></i>
                              <p>正在加载该员工客户...</p>
                            </div>

                            <div v-else-if="filteredCustomerList.length === 0" class="empty-tree">
                              <i class="fas fa-user-slash"></i>
                              <p>该员工暂无客户或未匹配到结果</p>
                            </div>

                            <div v-else class="dept-tree customer-tree">
                              <!-- 根节点（树风格） -->
                              <div class="dept-tree-item">
                                <div class="dept-item">
                                  <div class="dept-item-main active" @click.stop>
                                    <div class="dept-item-content">
                                      <div class="dept-icon">
                                        <i class="fas fa-user-tie"></i>
                                      </div>
                                      <div class="dept-info">
                                        <div class="dept-name">
                                          {{ staff.nickName }} 的客户
                                          <span class="dept-count">({{ filteredCustomerList.length }})</span>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>

                                <!-- 子节点（客户列表） -->
                                <div class="dept-children"
                                  style="margin-left: 1.5rem; border-left: 1px solid #e8e8e8; padding-left: 1rem;">
                                  <div v-for="c in filteredCustomerList"
                                    :key="c.customerId || c.id || c.customerName + '_' + c.phone"
                                    class="dept-child-item">
                                    <div class="dept-item">
                                      <div class="dept-item-main" @click.stop>
                                        <div class="dept-item-content">
                                          <div class="dept-icon">
                                            <i class="fas fa-minus"></i>
                                          </div>
                                          <div class="dept-info">
                                            <div class="dept-name">
                                              {{ c.customerName || '-' }}
                                            </div>
                                            <div class="customer-contact">
                                              <span v-if="c.phone">
                                                <i class="fas fa-phone"></i>
                                                {{ c.phone }}
                                              </span>

                                              <span v-if="c.email">
                                                <i class="fas fa-envelope"></i>
                                                {{ c.email }}
                                              </span>

                                              <!-- 新增：地址 -->
                                              <span v-if="c.address">
                                                <i class="fas fa-location-dot"></i>
                                                {{ c.address }}
                                              </span>

                                              <!-- 新增：备注 -->
                                              <span v-if="c.remark">
                                                <i class="fas fa-note-sticky"></i>
                                                {{ c.remark }}
                                              </span>

                                              <span v-if="!c.phone && !c.email && !c.address && !c.remark"
                                                class="no-contact">
                                                未提供联系方式/地址/备注
                                              </span>
                                            </div>

                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>

                              </div>
                            </div>
                          </div>

                        </div>
                      </td>
                    </tr>
                  </template>
                </tbody>
              </table>
            </div>

            <!-- 分页 -->
            <div v-if="total > 0" class="pagination-container">
              <div class="pagination-info">
                显示第 {{ (queryParams.pageNum - 1) * queryParams.pageSize + 1 }} 到
                {{ Math.min(queryParams.pageNum * queryParams.pageSize, total) }} 条记录，
                共 {{ total }} 条
              </div>
              <div class="pagination-controls">
                <button class="pagination-btn" :disabled="queryParams.pageNum === 1"
                  @click="handlePageChange(queryParams.pageNum - 1)">
                  <i class="fas fa-chevron-left"></i>
                </button>

                <button v-for="page in visiblePages" :key="page" class="pagination-btn"
                  :class="{ active: page === queryParams.pageNum }" @click="handlePageChange(page)">
                  {{ page }}
                </button>

                <button class="pagination-btn"
                  :disabled="queryParams.pageNum >= Math.ceil(total / queryParams.pageSize)"
                  @click="handlePageChange(queryParams.pageNum + 1)">
                  <i class="fas fa-chevron-right"></i>
                </button>
              </div>
            </div>

          </div>
        </div>
      </div>
    </main>

    <!-- 新增/编辑对话框 -->
    <div v-if="dialogVisible" class="modal-overlay" @click="dialogVisible = false">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3><i class="fas" :class="isAdd ? 'fa-user-plus' : 'fa-user-edit'"></i> {{ dialogTitle }}</h3>
          <button class="close-btn" @click="dialogVisible = false">
            <i class="fas fa-times"></i>
          </button>
        </div>

        <div class="modal-body">
          <form ref="formRef" @submit.prevent="submitForm" class="staff-form">
            <div class="form-row">
              <div class="form-group">
                <label class="form-label required">
                  <i class="fas fa-user"></i> 姓名
                </label>
                <input type="text" v-model="form.nickName" placeholder="请输入员工姓名" class="form-input" required>
              </div>
              <div class="form-group">
                <label class="form-label required">
                  <i class="fas fa-user-circle"></i> 账号
                </label>
                <input type="text" v-model="form.userName" placeholder="请输入登录账号" class="form-input" required>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label class="form-label required">
                  <i class="fas fa-building"></i> 部门
                </label>
                <select v-model="form.deptId" class="form-input">
                  <option value="">请选择部门</option>
                  <option v-for="d in deptSelectOptions" :key="d.deptId" :value="d.deptId">
                    {{ d.deptName }}
                  </option>
                </select>
              </div>

              <div class="form-group">
                <label class="form-label" :class="{ required: isAdd }">
                  <i class="fas fa-lock"></i> 密码
                </label>
                <div class="password-input">
                  <input :type="showPassword ? 'text' : 'password'" v-model="form.password"
                    :placeholder="isAdd ? '请输入登录密码' : '留空则不修改密码'" class="form-input" :required="isAdd">
                  <button type="button" class="password-toggle" @click="showPassword = !showPassword">
                    <i :class="showPassword ? 'fas fa-eye-slash' : 'fas fa-eye'"></i>
                  </button>
                </div>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label class="form-label required">
                  <i class="fas fa-user-tag"></i> 职位
                </label>
                <select v-model="form.roleId" class="form-input" required>
                  <option value="">请选择职位</option>
                  <option value="2">经理</option>
                  <option value="100">员工</option>
                </select>
              </div>
              <div class="form-group">
                <label class="form-label required">
                  <i class="fas fa-birthday-cake"></i> 年龄
                </label>
                <input type="number" v-model.number="form.age" min="18" max="70" placeholder="请输入年龄" class="form-input"
                  required>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label class="form-label">
                  <i class="fas fa-phone"></i> 电话
                </label>
                <input type="tel" v-model="form.phone" placeholder="请输入联系电话" class="form-input">
              </div>
              <div class="form-group">
                <label class="form-label">
                  <i class="fas fa-envelope"></i> 邮箱
                </label>
                <input type="email" v-model="form.email" placeholder="请输入邮箱地址" class="form-input">
              </div>
            </div>

            <div class="form-group">
              <label class="form-label">
                <i class="fas fa-comment"></i> 备注
              </label>
              <textarea v-model="form.remark" placeholder="请输入备注信息" class="form-textarea" rows="3"></textarea>
            </div>

            <div class="form-actions">
              <button type="button" class="btn btn-outline" @click="dialogVisible = false">
                取消
              </button>
              <button type="submit" class="btn btn-primary">
                <i class="fas fa-check"></i>
                {{ isAdd ? '确认添加' : '确认修改' }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- 删除确认弹窗（保留你原来的结构） -->
    <div v-if="showDeleteConfirm" class="modal-overlay" @click="cancelDelete">
      <div class="modal-content confirm-modal" @click.stop>
        <div class="modal-header">
          <h3><i class="fas fa-exclamation-triangle text-warning"></i> 确认删除</h3>
          <button class="close-btn" @click="cancelDelete">
            <i class="fas fa-times"></i>
          </button>
        </div>

        <div class="modal-body">
          <div class="confirm-content">
            <i class="fas fa-user-slash confirm-icon"></i>
            <p class="confirm-message">
              确定要删除此员工信息吗？
            </p>
            <p class="confirm-warning">
              删除后，该员工的所有信息将无法恢复！
            </p>
          </div>

          <div class="confirm-actions">
            <button type="button" class="btn btn-outline" @click="cancelDelete">
              取消
            </button>
            <button type="button" class="btn btn-danger" @click="confirmDelete">
              确认删除
            </button>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed, nextTick } from "vue";
import { ElMessage, ElMessageBox } from "element-plus";
import request from "@/utils/request";

/* ---------- API ---------- */
const listStaff = (params) => request({ url: "/company/staff/list", method: "get", params });
const addStaff = (data) => request({ url: "/company/staff/add", method: "post", data });
const updateStaff = (data) => request({ url: "/company/staff/update", method: "put", data });
const deleteStaffApi = (id) => request({ url: `/company/staff/${id}`, method: "delete" });
const getDeptTree = () => request({ url: "/company/staff/deptTree", method: "get" });

/**
 * 关键新增：根据员工号获取客户列表
 * 你把下面这个 url 改成你后端真实接口即可：
 * - 例1：GET /company/staff/customers?userId=123
 * - 例2：GET /company/staff/123/customers
 */
const getStaffCustomersApi = (userId) =>
  request({
    url: "/company/staff/customers",
    method: "get",
    params: { userId },
  });

/* ---------- 响应式数据 ---------- */
const loading = ref(false);
const tableData = ref([]);
const total = ref(0);
const showSearch = ref(true);
const showPassword = ref(false);
const showDeleteConfirm = ref(false);
const deleteStaffId = ref(null);
const isExpandAll = ref(true);
const refreshTable = ref(true);

const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  nickName: "",
  userName: "",
  deptId: undefined,
});

/* =======================
 * DEMO：员工号=1 的假客户数据（用于展示树形展开）
 * 用完可把 DEMO_ENABLE 改成 false 或删掉整段
 * ======================= */
const DEMO_ENABLE = true;
const DEMO_STAFF_ID = 1;

const DEMO_CUSTOMERS_FOR_STAFF_1 = [
  { customerId: 1001, customerName: "张三（演示）", phone: "13800000001", email: "zhangsan_demo@corp.com", address: "杭州市西湖区文三路 1 号", remark: "意向客户，回访中" },
  { customerId: 1002, customerName: "李四（演示）", phone: "13800000002", email: "lisi_demo@corp.com", address: "上海市浦东新区世纪大道 88 号", remark: "已成交，维护关系" },
  { customerId: 1003, customerName: "王五（演示）", phone: "13800000003", email: "", address: "北京市海淀区中关村大街 10 号", remark: "关注价格，需二次报价" },
  { customerId: 1004, customerName: "赵六（演示）", phone: "", email: "zhaoliu_demo@corp.com", address: "深圳市南山区科技园 5 号楼", remark: "备注为空也可展示 '-'" },
];



/* ---------- 部门树 ---------- */
const deptTree = ref([]);
const deptFilter = ref("");
const deptSelectOptions = ref([]);
const filteredDeptTree = ref([]);

const initDeptExpandStatus = (depts) => {
  return depts.map(dept => {
    const newDept = {
      ...dept,
      _expanded: isExpandAll.value
    };
    if (dept.children && dept.children.length > 0) {
      newDept.children = initDeptExpandStatus(dept.children);
    }
    return newDept;
  });
};

const filterDeptTree = () => {
  if (!deptFilter.value) {
    filteredDeptTree.value = initDeptExpandStatus(deptTree.value);
    return;
  }

  const searchText = deptFilter.value.toLowerCase();

  const filterDepts = (depts) => {
    return depts.filter(dept => {
      const matches = (dept.label || "").toLowerCase().includes(searchText);
      if (matches) return true;

      if (dept.children && dept.children.length > 0) {
        const filteredChildren = filterDepts(dept.children);
        if (filteredChildren.length > 0) {
          dept.children = filteredChildren;
          dept._expanded = true;
          return true;
        }
      }
      return false;
    });
  };

  const filtered = filterDepts(JSON.parse(JSON.stringify(deptTree.value)));
  filteredDeptTree.value = initDeptExpandStatus(filtered);
};

const handleDeptSelect = (dept) => {
  queryParams.deptId = dept.deptId;
  getList();
};

const toggleDeptExpand = (deptId) => {
  const toggle = (depts) => {
    for (const dept of depts) {
      if (dept.deptId === deptId) {
        dept._expanded = !dept._expanded;
        return true;
      }
      if (dept.children && dept.children.length > 0) {
        if (toggle(dept.children)) return true;
      }
    }
    return false;
  };

  toggle(filteredDeptTree.value);
  refreshTable.value = false;
  nextTick(() => {
    refreshTable.value = true;
  });
};

const toggleExpandAll = () => {
  isExpandAll.value = !isExpandAll.value;

  const setAllExpand = (depts, expand) => {
    depts.forEach(dept => {
      dept._expanded = expand;
      if (dept.children && dept.children.length > 0) {
        setAllExpand(dept.children, expand);
      }
    });
  };

  setAllExpand(filteredDeptTree.value, isExpandAll.value);
  refreshTable.value = false;
  nextTick(() => {
    refreshTable.value = true;
  });
};

/* ---------- 表单 ---------- */
const dialogVisible = ref(false);
const dialogTitle = ref("");
const isAdd = ref(true);

const form = reactive({
  userId: null,
  nickName: "",
  userName: "",
  password: "",
  deptId: null,
  age: 18,
  roleId: null,
  phone: "",
  email: "",
  remark: "",
});

const validateForm = () => {
  const errors = [];
  if (!form.nickName || form.nickName.trim() === '') errors.push('请输入员工姓名');
  if (!form.userName || form.userName.trim() === '') errors.push('请输入登录账号');
  if (isAdd.value && (!form.password || form.password.trim() === '')) errors.push('请输入密码');
  if (!form.deptId) errors.push('请选择部门');
  if (!form.roleId) errors.push('请选择职位');
  if (!form.age) errors.push('请输入年龄');
  return errors;
};

/* ---------- 辅助函数 ---------- */
const getAvatarText = (name) => {
  if (!name) return '?';
  return name.length > 2 ? name.substring(name.length - 2) : name;
};

const getRoleText = (roleId) => {
  if (roleId === 2) return "经理";
  if (roleId === 100) return "员工";
  return "-";
};

const getRoleClass = (roleId) => {
  if (roleId === 2) return "role-manager";
  if (roleId === 100) return "role-staff";
  return "";
};

/* ---------- 加载部门数据 ---------- */
const loadDept = async () => {
  const res = await getDeptTree();
  const tree = res.data || [];
  deptSelectOptions.value = flattenDeptTree(tree);
};

const flattenDeptTree = (tree) => {
  const result = [];
  function dfs(nodes) {
    nodes.forEach((n) => {
      result.push({
        deptId: n.deptId || n.id,
        deptName: n.deptName || n.label,
      });
      if (n.children?.length) dfs(n.children);
    });
  }
  dfs(tree);
  return result;
};

const loadTree = async () => {
  const res = await getDeptTree();
  const raw = res.data || [];

  const convertToDeptTree = (node) => ({
    ...node,
    deptId: node.deptId || node.id,
    label: node.deptName || node.label || "未命名部门",
    children: node.children?.map(convertToDeptTree) || [],
  });

  const treeData = raw.map(convertToDeptTree);
  deptTree.value = treeData;
  filteredDeptTree.value = initDeptExpandStatus(treeData);
};

/* ---------- 员工列表 ---------- */
const getList = async () => {
  loading.value = true;
  try {
    const res = await listStaff(queryParams);

    tableData.value = (res.rows || []).map(item => ({
      userId: item.userId,
      nickName: item.nickName || '',
      userName: item.userName || '',
      deptId: item.deptId || null,
      dept: item.dept || null,
      age: item.age || 18,
      roleId: item.roleId || 100,
      phone: item.phone || item.telephone || item.mobile || '',
      email: item.email || '',
      remark: item.remark || ''
    }));

    total.value = res.total || 0;

    // 列表刷新后，如果当前展开员工不在本页了，自动收起
    if (expandedStaffId.value && !tableData.value.some(s => s.userId === expandedStaffId.value)) {
      collapseCustomers();
    }
  } finally {
    loading.value = false;
  }
};

const resetQuery = () => {
  queryParams.nickName = "";
  queryParams.userName = "";
  queryParams.deptId = undefined;
  queryParams.pageNum = 1;
  getList();
};

const openAdd = () => {
  dialogTitle.value = "新增员工";
  isAdd.value = true;
  Object.assign(form, {
    userId: null,
    nickName: "",
    userName: "",
    password: "",
    deptId: null,
    age: 18,
    roleId: null,
    phone: "",
    email: "",
    remark: "",
  });
  dialogVisible.value = true;
  showPassword.value = false;
};

const openEdit = (row) => {
  dialogTitle.value = "编辑员工";
  isAdd.value = false;

  Object.assign(form, {
    userId: row.userId,
    nickName: row.nickName || "",
    userName: row.userName || "",
    password: "",
    deptId: row.deptId || null,
    age: row.age || 18,
    roleId: row.roleId || null,
    phone: row.phone || "",
    email: row.email || "",
    remark: row.remark || "",
  });

  dialogVisible.value = true;
  showPassword.value = false;
};

const submitForm = async () => {
  const errors = validateForm();
  if (errors.length > 0) {
    ElMessage.error(errors[0]);
    return;
  }

  const submitData = { ...form };

  if (!isAdd.value) {
    if (!submitData.password || submitData.password.trim() === '') {
      delete submitData.password;
    }
  }

  if (submitData.deptId) submitData.deptId = Number(submitData.deptId);
  if (submitData.roleId) submitData.roleId = Number(submitData.roleId);
  if (submitData.age) submitData.age = Number(submitData.age);

  try {
    const api = isAdd.value ? addStaff : updateStaff;
    const res = await api(submitData);
    if (res.code === 200) {
      ElMessage.success(isAdd.value ? '添加成功' : '修改成功');
      dialogVisible.value = false;
      getList();
    } else {
      ElMessage.error(res.msg || '操作失败');
    }
  } catch (err) {
    ElMessage.error('操作失败：' + (err.message || '网络错误'));
  }
};

const deleteStaff = (id) => {
  ElMessageBox.confirm('确定要删除此员工吗？', '删除确认', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(async () => {
    try {
      const res = await deleteStaffApi(id);
      if (res.code === 200) {
        ElMessage.success('删除成功');
        getList();
      } else {
        ElMessage.error(res.msg || '删除失败');
      }
    } catch (err) {
      ElMessage.error('删除失败：' + (err.message || '网络错误'));
    }
  }).catch(() => { });
};

/* ---------- 分页 ---------- */
const visiblePages = computed(() => {
  const totalPages = Math.ceil(total.value / queryParams.pageSize);
  const currentPage = queryParams.pageNum;
  const pages = [];

  let start = Math.max(1, currentPage - 2);
  let end = Math.min(totalPages, start + 4);

  if (end - start < 4) {
    start = Math.max(1, end - 4);
  }

  for (let i = start; i <= end; i++) pages.push(i);
  return pages;
});

const handlePageChange = (page) => {
  if (page < 1 || page > Math.ceil(total.value / queryParams.pageSize)) return;
  queryParams.pageNum = page;
  getList();
};

const toggleSearch = () => {
  showSearch.value = !showSearch.value;
};

/* =======================================================================================
 * 关键新增：点击员工 -> 拉取该员工客户 -> 展示树
 * ======================================================================================= */
const expandedStaffId = ref(null);       // 当前展开的员工 userId
const customerLoading = ref(false);      // 客户加载状态
const customerList = ref([]);            // 当前员工的客户列表

// 缓存：避免同一个员工反复点击时重复请求
const customerCache = reactive({}); // { [userId]: customers[] }

const normalizeCustomers = (list) => {
  return (list || []).map((c) => ({
    customerId: c.customerId || c.id || c.cid || null,
    customerName: c.customerName || c.name || c.nickName || c.realName || "",
    phone: c.phone || c.mobile || c.telephone || "",
    email: c.email || "",
    // 新增：地址（兼容几种常见字段名）
    address: c.address || c.addr || c.location || c.customerAddress || "",
    // 新增：备注（兼容几种常见字段名）
    remark: c.remark || c.note || c.memo || c.comment || "",
  }));
};


const loadCustomersByStaff = async (userId) => {
  if (!userId) {
    customerList.value = [];
    return;
  }

  // DEMO：员工号=1 时直接返回假客户，确保能展示树形展开效果
  if (DEMO_ENABLE && Number(userId) === DEMO_STAFF_ID) {
    const normalized = normalizeCustomers(DEMO_CUSTOMERS_FOR_STAFF_1);
    customerCache[userId] = normalized;
    customerList.value = normalized;
    return;
  }


  // 有缓存直接用
  if (customerCache[userId]) {
    customerList.value = customerCache[userId];
    return;
  }

  customerLoading.value = true;
  try {
    const res = await getStaffCustomersApi(userId);

    // 兼容多种返回结构：data / rows
    const rawList = res.data || res.rows || [];
    let normalized = normalizeCustomers(rawList);

    /** 演示数据：仅用于员工号=1 且后端没返回任何客户时 */
    if (String(userId) === "1" && (!normalized || normalized.length === 0)) {
      normalized = normalizeCustomers([
        {
          id: 101,
          customerName: "张三",
          phone: "13800001111",
          email: "zhangsan@example.com",
          address: "杭州市西湖区文三路 88 号",
          remark: "重点客户，意向强",
        },
        {
          id: 102,
          customerName: "李四",
          phone: "13900002222",
          email: "lisi@example.com",
          address: "杭州市滨江区江南大道 66 号",
          remark: "下周回访",
        },
        {
          id: 103,
          customerName: "王五",
          phone: "",
          email: "",
          address: "杭州市上城区延安路 1 号",
          remark: "仅线下沟通",
        },
      ]);
    }

    customerCache[userId] = normalized;
    customerList.value = normalized;

  } catch (e) {
    customerList.value = [];
    ElMessage.error("获取客户失败：" + (e.message || "网络错误"));
  } finally {
    customerLoading.value = false;
  }
};

const toggleStaffCustomers = async (staff) => {
  const userId = staff?.userId;
  if (!userId) {
    ElMessage.error("该员工缺少员工号(userId)，无法查询客户");
    return;
  }

  // 再点一次：收起
  if (expandedStaffId.value === userId) {
    collapseCustomers();
    return;
  }

  // 展开新员工
  expandedStaffId.value = userId;
  customerList.value = [];

  await loadCustomersByStaff(userId);
};

const collapseCustomers = () => {
  expandedStaffId.value = null;
  customerList.value = [];
};

const filteredCustomerList = computed(() => customerList.value);


/* ---------- 初始化 ---------- */
onMounted(() => {
  loadDept();
  loadTree();
  getList();
});


</script>

<style scoped>
/* 基础样式 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
}

.app-container {
  min-height: 100vh;
  background-color: #f5f7fa;
}

/* 导航栏 */
.navbar {
  display: flex;
  justify-content: center;
  padding: 1rem 2rem;
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  position: sticky;
  top: 0;
  z-index: 100;
}

.logo {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.logo i {
  font-size: 1.8rem;
  color: #1890ff;
}

.navbar-brand h1 {
  font-size: 1.5rem;
  color: #2c3e50;
  font-weight: 700;
}

/* 主内容区域 */
.main-content {
  padding: 1.5rem;
  max-width: 1600px;
  margin: 0 auto;
}

/* 页面标题 */
.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
}

.page-title {
  font-size: 1.8rem;
  color: #2c3e50;
  font-weight: 700;
  margin-bottom: 0.25rem;
}

.page-subtitle {
  font-size: 1rem;
  color: #7f8c8d;
}

.actions {
  display: flex;
  gap: 1rem;
}

/* 按钮样式 */
.btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.6rem 1.2rem;
  border: none;
  border-radius: 6px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s;
  font-size: 0.85rem;
}

.btn-primary {
  background-color: #1890ff;
  color: #fff;
}

.btn-primary:hover {
  background-color: #40a9ff;
  box-shadow: 0 2px 8px rgba(24, 144, 255, 0.3);
}

.btn-outline {
  background-color: transparent;
  border: 1px solid #d9d9d9;
  color: #595959;
}

.btn-outline:hover {
  border-color: #1890ff;
  color: #1890ff;
}

.btn-danger {
  background-color: #ff4d4f;
  color: #fff;
}

.btn-danger:hover {
  background-color: #ff7875;
  box-shadow: 0 2px 8px rgba(255, 77, 79, 0.3);
}

.btn-sm {
  padding: 0.35rem 0.8rem;
  font-size: 0.8rem;
  border-radius: 6px;
}

/* 查询卡片 */
.query-card {
  background-color: #fff;
  border-radius: 8px;
  padding: 1.5rem;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  margin-bottom: 1.5rem;
}

.query-row {
  display: flex;
  align-items: flex-end;
  gap: 1.5rem;
  flex-wrap: wrap;
}

.query-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  min-width: 200px;
  flex: 1;
  max-width: 300px;
}

.query-label {
  font-size: 0.9rem;
  color: #2c3e50;
  font-weight: 500;
}

.query-input,
.query-select {
  padding: 0.6rem 1rem;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  font-size: 0.85rem;
  transition: border-color 0.3s;
  width: 100%;
}

.query-input:focus,
.query-select:focus {
  outline: none;
  border-color: #1890ff;
  box-shadow: 0 0 0 2px rgba(24, 144, 255, 0.1);
}

.query-actions {
  display: flex;
  gap: 0.75rem;
  margin-left: auto;
  margin-bottom: 0.6rem;
}

/* 主要内容布局 */
.content-layout {
  display: grid;
  grid-template-columns: 300px 1fr;
  gap: 1.5rem;
  min-height: 600px;
}

/* 侧边栏 */
.sidebar {
  background: transparent;
}

.sidebar-card {
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  height: 100%;
  display: flex;
  flex-direction: column;
}

.sidebar-header {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1.25rem 1.5rem;
  border-bottom: 1px solid #f0f0f0;
}

.sidebar-header i {
  color: #1890ff;
  font-size: 1.2rem;
}

.sidebar-header h3 {
  font-size: 1rem;
  color: #2c3e50;
  font-weight: 600;
  margin: 0;
}

.sidebar-search {
  padding: 1rem 1.5rem;
  border-bottom: 1px solid #f0f0f0;
}

.sidebar-input {
  width: 100%;
  padding: 0.5rem 1rem;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  font-size: 0.85rem;
  transition: border-color 0.3s;
}

.sidebar-input:focus {
  outline: none;
  border-color: #1890ff;
}

.dept-tree-container {
  flex: 1;
  overflow-y: auto;
  padding: 0.5rem 0;
}

.empty-tree {
  padding: 3rem 1rem;
  text-align: center;
  color: #bfbfbf;
}

.empty-tree i {
  font-size: 2rem;
  margin-bottom: 1rem;
  opacity: 0.3;
}

.empty-tree p {
  font-size: 0.9rem;
}

/* 部门树样式 */
.dept-tree {
  padding: 0.5rem 0;
}

.dept-tree-item {
  margin-bottom: 0.25rem;
}

.dept-item {
  border-radius: 6px;
  margin-bottom: 0.25rem;
  transition: all 0.3s;
}

.dept-item-main {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.75rem 1rem;
  cursor: pointer;
  border-radius: 6px;
  transition: all 0.3s;
}

.dept-item-main:hover {
  background-color: #f5f5f5;
}

.dept-item-main.active {
  background-color: #e6f7ff;
  border-left: 3px solid #1890ff;
}

.dept-item-content {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  flex: 1;
}

.dept-icon {
  width: 24px;
  height: 24px;
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s;
  color: #8c8c8c;
  flex-shrink: 0;
}

.dept-icon:hover {
  background-color: #e6e6e6;
  color: #1890ff;
}

.dept-info {
  flex: 1;
  min-width: 0;
}

.dept-name {
  font-size: 0.9rem;
  color: #2c3e50;
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.dept-count {
  font-size: 0.8rem;
  color: #8c8c8c;
  font-weight: normal;
}

.dept-children {
  margin-top: 0.25rem;
  transition: all 0.3s;
}

.dept-child-item {
  margin-top: 0.25rem;
}

/* 主要内容区域 */
.content-main {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.table-header {
  background-color: #fff;
  border-radius: 8px;
  padding: 1rem 1.5rem;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.info-text {
  font-size: 0.9rem;
  color: #595959;
  display: flex;
  align-items: center;
  gap: 1rem;
}

.info-number {
  font-weight: 600;
  color: #1890ff;
}

/* 表格卡片 */
.table-card {
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  overflow: hidden;
  flex: 1;
  display: flex;
  flex-direction: column;
}

/* 加载状态 */
.loading-state {
  padding: 3rem;
  text-align: center;
  color: #1890ff;
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.small-loading {
  padding: 1.8rem;
}

.loading-spinner {
  font-size: 2rem;
  margin-bottom: 1rem;
}

.loading-state p {
  font-size: 1rem;
  color: #8c8c8c;
}

/* 空状态 */
.empty-state {
  padding: 4rem 2rem;
  text-align: center;
  color: #bfbfbf;
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.empty-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
  opacity: 0.3;
}

.empty-state p {
  font-size: 1rem;
  margin-bottom: 1.5rem;
}

.mt-3 {
  margin-top: 1rem;
}

/* 员工表格 */
.staff-table {
  flex: 1;
  overflow-x: auto;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  min-width: 900px;
}

.data-table thead {
  background-color: #fafafa;
  border-bottom: 2px solid #f0f0f0;
}

.data-table th {
  padding: 1rem;
  font-weight: 600;
  color: #2c3e50;
  text-align: left;
  font-size: 0.9rem;
  white-space: nowrap;
}

.data-table tbody tr {
  border-bottom: 1px solid #f0f0f0;
  transition: all 0.3s;
}

.data-table tbody tr:hover {
  background-color: #fafafa;
}

.data-table td {
  padding: 1rem;
  vertical-align: middle;
}

/* 关键新增：员工行可点击 + 展开箭头 */
.staff-row {
  cursor: pointer;
}

.staff-row-active {
  background-color: #f0f9ff;
}

.row-expand-icon {
  display: inline-flex;
  width: 18px;
  margin-right: 6px;
  color: #8c8c8c;
}

.staff-id {
  font-family: 'Courier New', monospace;
  font-weight: 600;
  color: #1890ff;
  font-size: 0.9rem;
  display: flex;
  align-items: center;
}

/* 员工信息样式 */
.staff-info {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.staff-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 0.9rem;
  flex-shrink: 0;
}

.staff-name {
  font-weight: 500;
  color: #2c3e50;
}

.dept-cell {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #595959;
  font-size: 0.9rem;
}

.dept-cell i {
  color: #1890ff;
}

.age-badge {
  display: inline-block;
  padding: 0.25rem 0.75rem;
  background-color: #f0f9ff;
  color: #1890ff;
  border-radius: 12px;
  font-size: 0.85rem;
  font-weight: 500;
  border: 1px solid #91d5ff;
}

.role-tag {
  display: inline-block;
  padding: 0.25rem 0.75rem;
  border-radius: 12px;
  font-size: 0.85rem;
  font-weight: 500;
}

.role-tag.role-manager {
  background-color: #f6ffed;
  color: #52c41a;
  border: 1px solid #b7eb8f;
}

.role-tag.role-staff {
  background-color: #f0f5ff;
  color: #2f54eb;
  border: 1px solid #adc6ff;
}

.action-buttons {
  display: flex;
  gap: 0.5rem;
}

.btn-action {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.4rem 0.8rem;
  border-radius: 4px;
  font-size: 0.8rem;
  font-weight: 500;
  cursor: pointer;
  border: none;
  transition: all 0.3s;
}

.btn-action.edit {
  background-color: #e6f7ff;
  color: #1890ff;
  border: 1px solid #91d5ff;
}

.btn-action.edit:hover {
  background-color: #bae7ff;
}

.btn-action.delete {
  background-color: #fff2f0;
  color: #ff4d4f;
  border: 1px solid #ffccc7;
}

.btn-action.delete:hover {
  background-color: #ffccc7;
}

/* 展开行（客户树容器） */
.expand-row td {
  padding: 0;
  background: #fff;
}

.expand-cell {
  padding: 0 !important;
}

.customer-panel {
  padding: 1rem 1.25rem 1.25rem;
  border-top: 1px solid #f0f0f0;
  background: #fafcff;
}

.customer-panel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.8rem;
}

.customer-panel-title {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  color: #2c3e50;
}

.customer-panel-title i {
  color: #1890ff;
}

.customer-panel-title h3 {
  font-size: 1rem;
  margin: 0;
  font-weight: 600;
}

.customer-count {
  color: #8c8c8c;
  font-size: 0.85rem;
}

.customer-panel-search {
  margin-bottom: 0.8rem;
}

/* 客户联系方式显示 */
.customer-contact {
  margin-top: 0.25rem;
  display: flex;
  gap: 0.9rem;
  flex-wrap: wrap;
  font-size: 0.82rem;
  color: #8c8c8c;
}

.customer-contact i {
  margin-right: 0.35rem;
  color: #1890ff;
}

.no-contact {
  color: #bfbfbf;
}

.customer-tree-container {
  background: #fff;
  border: 1px solid #eef2f6;
  border-radius: 8px;
  overflow: hidden;
}

.customer-tree {
  padding: 0.5rem 0;
}

/* 分页样式 */
.pagination-container {
  border-top: 1px solid #f0f0f0;
  padding: 1rem 1.5rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #fafafa;
}

.pagination-info {
  font-size: 0.85rem;
  color: #595959;
}

.pagination-controls {
  display: flex;
  gap: 0.5rem;
  align-items: center;
}

.pagination-btn {
  width: 32px;
  height: 32px;
  border: 1px solid #d9d9d9;
  background-color: white;
  border-radius: 4px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #595959;
  transition: all 0.3s;
}

.pagination-btn:hover:not(:disabled) {
  border-color: #1890ff;
  color: #1890ff;
}

.pagination-btn.active {
  background-color: #1890ff;
  color: white;
  border-color: #1890ff;
}

.pagination-btn:disabled {
  background-color: #f5f5f5;
  color: #d9d9d9;
  cursor: not-allowed;
}

/* 弹窗样式（保留你原来的） */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 1rem;
}

.modal-content {
  background-color: #fff;
  border-radius: 8px;
  width: 100%;
  max-width: 700px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.25rem 1.5rem;
  border-bottom: 1px solid #e8e8e8;
}

.modal-header h3 {
  font-size: 1.2rem;
  color: #2c3e50;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.text-warning {
  color: #faad14;
}

.close-btn {
  background: none;
  border: none;
  font-size: 1.1rem;
  color: #8c8c8c;
  cursor: pointer;
  padding: 0.4rem;
  border-radius: 4px;
  transition: all 0.3s;
}

.close-btn:hover {
  background-color: #f5f5f5;
  color: #595959;
}

.modal-body {
  padding: 1.5rem;
}

/* 确认弹窗 */
.confirm-modal {
  max-width: 450px;
}

.confirm-content {
  text-align: center;
  padding: 1rem 0 2rem;
}

.confirm-icon {
  font-size: 3rem;
  color: #ff4d4f;
  margin-bottom: 1rem;
  opacity: 0.8;
}

.confirm-message {
  font-size: 1rem;
  color: #2c3e50;
  margin-bottom: 1rem;
}

.confirm-warning {
  font-size: 0.9rem;
  color: #fa8c16;
  background-color: #fff7e6;
  padding: 0.75rem;
  border-radius: 6px;
  border: 1px solid #ffd591;
}

.confirm-actions {
  display: flex;
  gap: 1rem;
  justify-content: center;
}

/* 表单样式 */
.staff-form {
  margin-bottom: 0;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  margin-bottom: 1.5rem;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.5rem;
}

.form-label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.9rem;
  color: #2c3e50;
  font-weight: 500;
}

.form-label.required::after {
  content: '*';
  color: #ff4d4f;
  margin-left: 4px;
}

.form-input {
  padding: 0.6rem 1rem;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  font-size: 0.85rem;
  transition: all 0.3s;
  width: 100%;
}

.form-input:focus {
  outline: none;
  border-color: #1890ff;
  box-shadow: 0 0 0 2px rgba(24, 144, 255, 0.1);
}

.form-textarea {
  padding: 0.6rem 1rem;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  font-size: 0.85rem;
  transition: all 0.3s;
  width: 100%;
  resize: vertical;
  min-height: 80px;
}

.form-textarea:focus {
  outline: none;
  border-color: #1890ff;
  box-shadow: 0 0 0 2px rgba(24, 144, 255, 0.1);
}

.password-input {
  position: relative;
}

.password-toggle {
  position: absolute;
  right: 0.5rem;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  color: #8c8c8c;
  cursor: pointer;
  padding: 0.25rem;
}

.form-actions {
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
  margin-top: 2rem;
}

/* 表格头部选中的部门提示 */
.dept-selected {
  margin-left: 1rem;
  padding: 0.25rem 0.75rem;
  background-color: #e6f7ff;
  color: #1890ff;
  border-radius: 12px;
  font-size: 0.8rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

/* 响应式 */
@media (max-width: 1200px) {
  .content-layout {
    grid-template-columns: 1fr;
  }

  .sidebar {
    max-height: 400px;
  }
}

@media (max-width: 768px) {
  .navbar {
    padding: 1rem;
  }

  .main-content {
    padding: 1rem;
  }

  .page-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
  }

  .actions {
    width: 100%;
    flex-wrap: wrap;
  }

  .btn {
    flex: 1;
    min-width: 120px;
    justify-content: center;
  }

  .query-row {
    flex-direction: column;
    align-items: stretch;
  }

  .query-group {
    max-width: 100%;
  }

  .query-actions {
    margin-left: 0;
    width: 100%;
    justify-content: flex-end;
  }

  .form-row {
    grid-template-columns: 1fr;
    gap: 1rem;
  }

  .data-table th,
  .data-table td {
    padding: 0.75rem;
  }

  .action-buttons {
    flex-direction: column;
    gap: 0.5rem;
  }

  .pagination-container {
    flex-direction: column;
    gap: 1rem;
    align-items: center;
  }

  .modal-content {
    margin: 0.5rem;
  }

  .dept-children {
    margin-left: 1rem !important;
  }
}
</style>

<!-- 引入Font Awesome图标库 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
