<template>
  <div class="employee-container">
    <!-- 简化后导航栏（仅保留logo） -->
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
          <p class="page-subtitle">管理系统员工信息</p>
        </div>
        <div class="actions">
          <button class="btn btn-primary" @click="handleAdd">
            <i class="fas fa-plus"></i>
            新增
          </button>
          <button class="btn btn-outline" @click="handleExport">
            <i class="fas fa-download"></i>
            导出
          </button>
          <button class="btn btn-outline" @click="toggleSearch">
            <i class="fas" :class="showSearch ? 'fa-search-minus' : 'fa-search'"></i>
            {{ showSearch ? '隐藏搜索' : '显示搜索' }}
          </button>
        </div>
      </div>

      <!-- 查询条件 -->
      <div v-show="showSearch" class="query-card">
        <div class="query-row">
          <div class="query-group">
            <label class="query-label">员工姓名</label>
            <input 
              type="text" 
              v-model="queryParams.roleName"
              placeholder="请输入员工姓名"
              class="query-input"
              @keyup.enter="handleQuery"
            >
          </div>
          <div class="query-group">
            <label class="query-label">部门</label>
            <input 
              type="text" 
              v-model="queryParams.roleKey"
              placeholder="请输入部门"
              class="query-input"
              @keyup.enter="handleQuery"
            >
          </div>
          <div class="query-group">
            <label class="query-label">创建时间</label>
            <div class="date-range-picker">
              <input 
                type="date" 
                v-model="dateRangeStart"
                class="query-input"
                placeholder="开始日期"
              >
              <span class="date-separator">至</span>
              <input 
                type="date" 
                v-model="dateRangeEnd"
                class="query-input"
                placeholder="结束日期"
              >
            </div>
          </div>
          <div class="query-actions">
            <button class="btn btn-primary" @click="handleQuery">
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

      <!-- 批量操作栏 -->
      <div class="batch-actions" v-if="ids.length > 0">
        <span class="batch-info">已选择 {{ ids.length }} 项</span>
        <button 
          class="btn btn-outline delete" 
          @click="handleBatchDelete"
          :disabled="multiple"
        >
          <i class="fas fa-trash"></i>
          批量删除
        </button>
        <button class="btn btn-outline" @click="clearSelection">
          <i class="fas fa-times"></i>
          取消选择
        </button>
      </div>

      <!-- 员工列表 -->
      <div class="content-card">
        <div class="table-container">
          <table class="employee-table">
            <thead>
              <tr>
                <th>
                  <input 
                    type="checkbox" 
                    v-model="selectAll"
                    @change="toggleSelectAll"
                  >
                </th>
                <th>员工号</th>
                <th>姓名</th>
                <th>部门</th>
                <th>年龄</th>
                <th>职位</th>
                <th class="actions-col">操作</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(role, index) in roleList" :key="index + role.roleId">
                <td class="selection-col">
                  <input 
                    type="checkbox" 
                    v-model="ids" 
                    :value="role.roleId"
                    @change="handleSelectionChange"
                  >
                </td>
                <td class="employee-id">{{ role.roleId }}</td>
                <td>
                  <div class="employee-name">
                    <div class="avatar">
                      {{ role.roleName?.charAt(0) || '?' }}
                    </div>
                    {{ role.roleName }}
                  </div>
                </td>
                <td>{{ role.roleKey }}</td>
                <td>{{ role.roleSort || '-' }}岁</td>
                <td>
                  <span class="position-badge" :class="role.status === '0' ? 'manager' : 'employee'">
                    {{ role.status === '0' ? '经理' : '员工' }}
                  </span>
                </td>
                <td class="actions-col">
                  <div class="actions-cell">
                    <button 
                      class="btn-action edit" 
                      @click="handleUpdate(role)"
                      v-if="role.roleId !== 1"
                    >
                      <i class="fas fa-edit"></i>
                      修改
                    </button>
                    <button 
                      class="btn-action delete" 
                      @click="handleDelete(role)"
                    >
                      <i class="fas fa-trash"></i>
                      删除
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- 空状态 -->
        <div v-if="roleList.length === 0" class="empty-state">
          <i class="fas fa-user-friends empty-icon"></i>
          <p>暂无员工数据</p>
          <button class="btn btn-outline mt-3" @click="handleAdd">
            <i class="fas fa-plus"></i>
            立即添加员工
          </button>
        </div>

        <!-- 分页 -->
        <div class="pagination" v-if="roleList.length > 0">
          <div class="pagination-info">
            共 {{ total }} 条记录
          </div>
          <div class="pagination-controls">
            <button 
              class="pagination-btn" 
              :disabled="queryParams.pageNum === 1" 
              @click="prevPage"
            >
              <i class="fas fa-chevron-left"></i>
            </button>
            <span class="pagination-text">
              第 {{ queryParams.pageNum }} / {{ Math.ceil(total / queryParams.pageSize) }} 页
            </span>
            <button 
              class="pagination-btn" 
              :disabled="queryParams.pageNum >= Math.ceil(total / queryParams.pageSize)" 
              @click="nextPage"
            >
              <i class="fas fa-chevron-right"></i>
            </button>
          </div>
        </div>
      </div>
    </main>

    <!-- 新增/编辑员工弹窗 -->
    <div v-if="open" class="modal-overlay" @click="cancel">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3>{{ title }}</h3>
          <button class="close-btn" @click="cancel">
            <i class="fas fa-times"></i>
          </button>
        </div>
        
        <div class="modal-body">
          <form @submit.prevent="submitForm" class="employee-form">
            <div class="form-row">
              <div class="form-group">
                <label class="form-label required">员工号</label>
                <input 
                  type="text" 
                  v-model="form.roleId"
                  placeholder="请输入员工号"
                  class="form-input"
                  :disabled="form.roleId !== undefined"
                >
              </div>
              <div class="form-group">
                <label class="form-label required">职位</label>
                <select v-model="form.status" class="form-select" required>
                  <option value="0">经理</option>
                  <option value="1">员工</option>
                </select>
              </div>
            </div>
            
            <div class="form-row">
              <div class="form-group">
                <label class="form-label required">姓名</label>
                <input 
                  type="text" 
                  v-model="form.roleName"
                  placeholder="请输入姓名"
                  class="form-input"
                  required
                >
              </div>
              <div class="form-group">
                <label class="form-label required">账号</label>
                <input 
                  type="text" 
                  v-model="form.remark"
                  placeholder="请输入登录账号"
                  class="form-input"
                  required
                >
              </div>
            </div>
            
            <div class="form-row">
              <div class="form-group">
                <label class="form-label required">部门</label>
                <input 
                  type="text" 
                  v-model="form.roleKey"
                  placeholder="请输入部门"
                  class="form-input"
                  required
                >
              </div>
              <div class="form-group">
                <label class="form-label" :class="{ required: !form.roleId }">
                  {{ form.roleId ? '密码' : '密码（留空则不修改）' }}
                </label>
                <div class="password-input">
                  <input 
                    :type="showPassword ? 'text' : 'password'"
                    v-model="form.password"
                    :placeholder="form.roleId ? '请输入新密码' : '请输入密码'"
                    class="form-input"
                    :required="!form.roleId"
                  >
                  <button 
                    type="button" 
                    class="password-toggle"
                    @click="showPassword = !showPassword"
                  >
                    <i :class="showPassword ? 'fas fa-eye-slash' : 'fas fa-eye'"></i>
                  </button>
                </div>
              </div>
            </div>
            
            <div class="form-row">
              <div class="form-group">
                <label class="form-label required">年龄</label>
                <input 
                  type="number" 
                  v-model.number="form.roleSort"
                  placeholder="请输入年龄"
                  min="18"
                  max="65"
                  class="form-input"
                  required
                >
              </div>
              <div class="form-group"></div> <!-- 占位 -->
            </div>
            
            <div class="form-actions">
              <button type="button" class="btn btn-outline" @click="cancel">
                取消
              </button>
              <button type="submit" class="btn btn-primary">
                {{ form.roleId ? '确认修改' : '确认添加' }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, toRefs, computed, nextTick } from 'vue'
import { useRouter } from 'vue-router'
import { 
  addRole, 
  dataScope, 
  delRole, 
  getRole, 
  listRole, 
  updateRole, 
  deptTreeSelect 
} from "@/api/system/role"

const router = useRouter()

// 响应式数据
const roleList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const showPassword = ref(false)
const dateRangeStart = ref('')
const dateRangeEnd = ref('')
const deptOptions = ref([])
const openDataScope = ref(false)
const deptRef = ref(null)
const selectAll = ref(false)

// 数据范围选项
const dataScopeOptions = ref([
  { value: "1", label: "全部数据权限" },
  { value: "2", label: "自定数据权限" },
  { value: "3", label: "本部门数据权限" },
  { value: "4", label: "本部门及以下数据权限" },
  { value: "5", label: "仅本人数据权限" }
])

// 主数据对象
const data = reactive({
  form: {
    roleId: undefined,
    roleName: undefined,
    roleKey: undefined,
    roleSort: undefined,
    status: "1",
    password: undefined,
    remark: undefined,
    menuIds: [],
    deptIds: [],
    menuCheckStrictly: true,
    deptCheckStrictly: true,
  },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    roleName: undefined,
    roleKey: undefined
  },
  rules: {
    roleName: [{ required: true, message: "姓名不能为空", trigger: "blur" }],
    roleKey: [{ required: true, message: "部门不能为空", trigger: "blur" }],
    roleSort: [{ required: true, message: "年龄不能为空", trigger: "blur" }]
  },
})

const { queryParams, form, rules } = toRefs(data)

// 计算属性
const dateRange = computed(() => {
  if (dateRangeStart.value && dateRangeEnd.value) {
    return [dateRangeStart.value, dateRangeEnd.value]
  }
  return []
})

/** 查询角色列表 */
function getList() {
  loading.value = true
  const params = { ...queryParams.value }
  if (dateRangeStart.value) params.startTime = dateRangeStart.value
  if (dateRangeEnd.value) params.endTime = dateRangeEnd.value
  
  listRole(params).then(response => {
    roleList.value = response.rows || []
    total.value = response.total || 0
    loading.value = false
  }).catch(() => {
    loading.value = false
  })
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  dateRangeStart.value = ''
  dateRangeEnd.value = ''
  queryParams.value.roleName = ''
  queryParams.value.roleKey = ''
  handleQuery()
}

/** 切换搜索显示 */
function toggleSearch() {
  showSearch.value = !showSearch.value
}

/** 全选/取消全选 */
function toggleSelectAll() {
  if (selectAll.value) {
    ids.value = roleList.value.map(role => role.roleId)
  } else {
    ids.value = []
  }
  handleSelectionChange()
}

/** 清除选择 */
function clearSelection() {
  ids.value = []
  selectAll.value = false
  handleSelectionChange()
}

/** 批量删除 */
function handleBatchDelete() {
  if (ids.value.length === 0) return
  
  if (confirm(`确定要删除选中的 ${ids.value.length} 个员工吗？`)) {
    delRole(ids.value.join(',')).then(() => {
      alert('删除成功！')
      getList()
      clearSelection()
    }).catch(err => {
      alert('删除失败：' + err.message)
    })
  }
}

/** 删除按钮操作 */
function handleDelete(row) {
  const roleIds = row.roleId || ids.value.join(',')
  if (confirm(`确定要删除员工号 "${roleIds}" 的数据吗？`)) {
    delRole(roleIds).then(() => {
      alert('删除成功！')
      getList()
      clearSelection()
    }).catch(err => {
      alert('删除失败：' + err.message)
    })
  }
}

/** 导出按钮操作 */
function handleExport() {
  alert('导出功能需要后端API支持')
  // 实际使用时调用后端导出接口
  // proxy.download("system/role/export", { ...queryParams.value }, `employee_${new Date().getTime()}.xlsx`)
}

/** 多选框选中数据 */
function handleSelectionChange() {
  single.value = ids.value.length !== 1
  multiple.value = ids.value.length === 0
  selectAll.value = ids.value.length === roleList.value.length && roleList.value.length > 0
}

/** 重置表单 */
function reset() {
  form.value = {
    roleId: undefined,
    roleName: undefined,
    roleKey: undefined,
    roleSort: undefined,
    status: "1",
    password: undefined,
    remark: undefined,
    menuIds: [],
    deptIds: [],
    menuCheckStrictly: true,
    deptCheckStrictly: true,
  }
}

/** 添加角色 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "员工添加"
}

/** 修改角色 */
function handleUpdate(row) {
  reset()
  const roleId = row.roleId
  getRole(roleId).then(response => {
    form.value = response.data || {}
    form.value.roleSort = Number(form.value.roleSort)
    open.value = true
    title.value = "员工修改"
  }).catch(() => {
    alert('获取员工信息失败')
  })
}

/** 提交按钮 */
function submitForm() {
  // 前端校验
  if (!form.value.roleName?.trim()) {
    alert('姓名不能为空！')
    return
  }
  if (!form.value.roleKey?.trim()) {
    alert('部门不能为空！')
    return
  }
  if (!form.value.roleSort || form.value.roleSort < 18 || form.value.roleSort > 65) {
    alert('年龄需为18-65的数字！')
    return
  }
  if (!form.value.roleId && !form.value.password) {
    alert('新增员工必须设置密码！')
    return
  }

  if (form.value.roleId != undefined) {
    // 更新
    updateRole(form.value).then(response => {
      alert('修改成功！')
      open.value = false
      getList()
    }).catch(err => {
      alert('修改失败：' + err.message)
    })
  } else {
    // 新增
    addRole(form.value).then(response => {
      alert('新增成功！')
      open.value = false
      getList()
    }).catch(err => {
      alert('新增失败：' + err.message)
    })
  }
}

/** 取消按钮 */
function cancel() {
  open.value = false
  reset()
}

/** 上一页 */
function prevPage() {
  if (queryParams.value.pageNum > 1) {
    queryParams.value.pageNum--
    getList()
  }
}

/** 下一页 */
function nextPage() {
  const totalPages = Math.ceil(total.value / queryParams.value.pageSize)
  if (queryParams.value.pageNum < totalPages) {
    queryParams.value.pageNum++
    getList()
  }
}

// 初始化
getList()
</script>

<style scoped>
/* 复用代码一的基础样式 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
}

.employee-container {
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
  max-width: 1400px;
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

.btn-outline.delete {
  color: #ff4d4f;
  border-color: #ff4d4f;
}

.btn-outline.delete:hover {
  background-color: #fff2f0;
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
  min-width: 180px;
  flex: 1;
  max-width: 300px;
}

.query-label {
  font-size: 0.9rem;
  color: #2c3e50;
  font-weight: 500;
}

.query-input, .query-select {
  padding: 0.6rem 1rem;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  font-size: 0.85rem;
  transition: border-color 0.3s;
}

.query-input:focus, .query-select:focus {
  outline: none;
  border-color: #1890ff;
  box-shadow: 0 0 0 2px rgba(24, 144, 255, 0.1);
}

.date-range-picker {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.date-separator {
  color: #8c8c8c;
  font-size: 0.85rem;
}

.query-actions {
  display: flex;
  gap: 0.75rem;
  margin-left: auto;
  margin-bottom: 0.6rem;
}

/* 批量操作 */
.batch-actions {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  background-color: #f0f7ff;
  border-radius: 6px;
  margin-bottom: 1rem;
}

.batch-info {
  font-size: 0.9rem;
  color: #1890ff;
  font-weight: 500;
}

/* 内容卡片 */
.content-card {
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  overflow: hidden;
}

/* 表格样式 */
.table-container {
  overflow-x: auto;
}

.employee-table {
  width: 100%;
  border-collapse: collapse;
  min-width: 800px;
}

.employee-table th {
  background-color: #fafafa;
  padding: 1rem;
  text-align: left;
  font-size: 0.9rem;
  color: #2c3e50;
  font-weight: 600;
  border-bottom: 1px solid #e8e8e8;
}

.employee-table td {
  padding: 1rem;
  border-bottom: 1px solid #e8e8e8;
  font-size: 0.85rem;
  color: #595959;
}

.employee-table tr:hover {
  background-color: #fafafa;
}

/* 表格单元格样式 */
.selection-col {
  width: 50px;
  text-align: center;
}

.employee-id {
  font-family: 'Courier New', monospace;
  color: #1890ff;
  font-weight: 600;
}

.employee-name {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background-color: #1890ff;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.8rem;
  font-weight: 600;
}

.position-badge {
  padding: 0.25rem 0.75rem;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 500;
}

.position-badge.manager {
  background-color: #fff7e6;
  color: #fa8c16;
  border: 1px solid #ffd591;
}

.position-badge.employee {
  background-color: #f6ffed;
  color: #52c41a;
  border: 1px solid #b7eb8f;
}

/* 操作列 */
.actions-col {
  width: 180px;
}

.actions-cell {
  display: flex;
  gap: 0.5rem;
  align-items: center;
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
  min-width: 60px;
  justify-content: center;
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

/* 空状态 */
.empty-state {
  padding: 3rem 2rem;
  text-align: center;
  color: #bfbfbf;
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

/* 分页样式 */
.pagination {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 1.5rem;
  border-top: 1px solid #e8e8e8;
}

.pagination-info {
  font-size: 0.85rem;
  color: #8c8c8c;
}

.pagination-controls {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.pagination-btn {
  width: 32px;
  height: 32px;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  background-color: #fff;
  color: #595959;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s;
}

.pagination-btn:hover:not(:disabled) {
  border-color: #1890ff;
  color: #1890ff;
}

.pagination-btn:disabled {
  background-color: #f5f5f5;
  color: #bfbfbf;
  cursor: not-allowed;
}

.pagination-text {
  font-size: 0.85rem;
  color: #595959;
}

/* 弹窗样式 */
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
  max-width: 600px;
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

/* 表单样式 */
.employee-form {
  margin-bottom: 0;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.5rem;
  margin-bottom: 1.5rem;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.form-label {
  font-size: 0.9rem;
  color: #2c3e50;
  font-weight: 500;
}

.form-label.required::after {
  content: '*';
  color: #ff4d4f;
  margin-left: 4px;
}

.form-input, .form-select {
  padding: 0.6rem 1rem;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  font-size: 0.85rem;
  transition: all 0.3s;
}

.form-input:focus, .form-select:focus {
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

.password-toggle:hover {
  color: #595959;
}

.form-actions {
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
  margin-top: 2rem;
}

/* 响应式设计 */
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

  .batch-actions {
    flex-wrap: wrap;
  }

  .actions-cell {
    flex-direction: column;
    gap: 0.5rem;
  }

  .btn-action {
    min-width: 100%;
  }

  .pagination {
    flex-direction: column;
    gap: 1rem;
  }

  .modal-content {
    margin: 0.5rem;
  }
}
</style>

<!-- 引入Font Awesome图标库 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">