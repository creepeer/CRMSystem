<template>
  <div class="dept-container">
    <!-- 导航栏 -->
    <nav class="navbar">
      <div class="navbar-brand">
        <div class="logo">
          <i class="fas fa-sitemap"></i>
          <h1>部门管理</h1>
        </div>
      </div>
    </nav>

    <!-- 主要内容区域 -->
    <main class="main-content">
      <!-- 页面标题和操作栏 -->
      <div class="page-header">
        <div class="header-content">
          <h2 class="page-title">部门管理</h2>
          <p class="page-subtitle">管理系统组织架构</p>
        </div>
        <div class="actions">
          <button class="btn btn-primary" @click="handleAdd">
            <i class="fas fa-plus"></i>
            新增部门
          </button>
          <button class="btn btn-outline" @click="toggleExpandAll">
            <i class="fas" :class="isExpandAll ? 'fa-compress' : 'fa-expand'"></i>
            {{ isExpandAll ? '折叠全部' : '展开全部' }}
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
            <label class="query-label">部门名称</label>
            <input 
              type="text" 
              v-model="queryParams.deptName"
              placeholder="请输入部门名称"
              class="query-input"
              @keyup.enter="handleQuery"
            >
          </div>
          <div class="query-group">
            <label class="query-label">状态</label>
            <select v-model="queryParams.status" class="query-select">
              <option value="">全部状态</option>
              <option v-for="dict in sys_normal_disable" :key="dict.value" :value="dict.value">
                {{ dict.label }}
              </option>
            </select>
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

      <!-- 部门列表 -->
      <div class="content-card">
        <div class="table-container">
          <div class="dept-tree" v-if="refreshTable && !loading">
            <div 
              v-for="dept in deptList" 
              :key="dept.deptId"
              class="dept-tree-item"
            >
              <!-- 部门项 -->
              <div class="dept-item">
                <div class="dept-item-main">
                  <div class="dept-item-content">
                    <div class="dept-icon" @click="toggleDept(dept)">
                      <i :class="dept._expanded ? 'fas fa-folder-open' : 'fas fa-folder'"></i>
                    </div>
                    <div class="dept-info">
                      <div class="dept-name">
                        {{ dept.deptName }}
                        <span class="order-num">排序：{{ dept.orderNum }}</span>
                      </div>
                      <div class="dept-details">
                        <span class="status-badge" :class="dept.status === '0' ? 'active' : 'inactive'">
                          {{ getStatusText(dept.status) }}
                        </span>
                        <span class="create-time">
                          创建：{{ formatTime(dept.createTime) }}
                        </span>
                      </div>
                    </div>
                  </div>
                  <div class="dept-actions">
                    <button class="btn-action edit" @click="handleUpdate(dept)">
                      <i class="fas fa-edit"></i>
                      修改
                    </button>
                    <button class="btn-action add" @click="handleAdd(dept)">
                      <i class="fas fa-plus"></i>
                      新增子部门
                    </button>
                    <button 
                      v-if="dept.parentId != 0" 
                      class="btn-action delete"
                      @click="handleDelete(dept)"
                    >
                      <i class="fas fa-trash"></i>
                      删除
                    </button>
                  </div>
                </div>
              </div>

              <!-- 子部门 -->
              <div 
                v-show="dept._expanded && dept.children && dept.children.length > 0"
                class="dept-children"
              >
                <div 
                  v-for="child in dept.children" 
                  :key="child.deptId"
                  class="dept-child-item"
                >
                  <div class="dept-item">
                    <div class="dept-item-main">
                      <div class="dept-item-content">
                        <div class="dept-icon">
                          <i class="fas fa-folder"></i>
                        </div>
                        <div class="dept-info">
                          <div class="dept-name">
                            {{ child.deptName }}
                            <span class="order-num">排序：{{ child.orderNum }}</span>
                          </div>
                          <div class="dept-details">
                            <span class="status-badge" :class="child.status === '0' ? 'active' : 'inactive'">
                              {{ getStatusText(child.status) }}
                            </span>
                            <span class="create-time">
                              创建：{{ formatTime(child.createTime) }}
                            </span>
                          </div>
                        </div>
                      </div>
                      <div class="dept-actions">
                        <button class="btn-action edit" @click="handleUpdate(child)">
                          <i class="fas fa-edit"></i>
                          修改
                        </button>
                        <button class="btn-action add" @click="handleAdd(child)">
                          <i class="fas fa-plus"></i>
                          新增子部门
                        </button>
                        <button class="btn-action delete" @click="handleDelete(child)">
                          <i class="fas fa-trash"></i>
                          删除
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- 加载状态 -->
          <div v-if="loading" class="loading-state">
            <div class="loading-spinner">
              <i class="fas fa-spinner fa-spin"></i>
            </div>
            <p>正在加载部门数据...</p>
          </div>

          <!-- 空状态 -->
          <div v-if="!loading && deptList.length === 0" class="empty-state">
            <i class="fas fa-sitemap empty-icon"></i>
            <p>暂无部门数据</p>
            <button class="btn btn-outline mt-3" @click="handleAdd">
              <i class="fas fa-plus"></i>
              立即创建部门
            </button>
          </div>
        </div>
      </div>
    </main>

    <!-- 添加或修改部门弹窗 -->
    <div v-if="open" class="modal-overlay" @click="cancel">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3>{{ title }}</h3>
          <button class="close-btn" @click="cancel">
            <i class="fas fa-times"></i>
          </button>
        </div>
        
        <div class="modal-body">
          <form @submit.prevent="submitForm" class="dept-form">
            <!-- 上级部门选择 -->
            <div class="form-group" v-if="form.parentId !== 0">
              <label class="form-label required">上级部门</label>
              <div class="tree-select">
                <input 
                  type="text" 
                  :value="getDeptName(form.parentId)"
                  readonly
                  class="form-input"
                  placeholder="选择上级部门"
                  @click="showTreeSelect = !showTreeSelect"
                >
                <button type="button" class="tree-select-toggle" @click="showTreeSelect = !showTreeSelect">
                  <i class="fas" :class="showTreeSelect ? 'fa-chevron-up' : 'fa-chevron-down'"></i>
                </button>
                
                <!-- 部门树选择 -->
                <div v-show="showTreeSelect" class="tree-select-dropdown">
                  <div class="tree-search">
                    <input 
                      type="text" 
                      v-model="treeSearch" 
                      placeholder="搜索部门"
                      class="tree-search-input"
                    >
                  </div>
                  <div class="tree-list">
                    <div 
                      v-for="dept in filteredDeptOptions" 
                      :key="dept.deptId"
                      class="tree-item"
                      :style="{ 'padding-left': `${(dept.level || 0) * 20}px` }"
                      @click="selectDept(dept)"
                    >
                      <i class="fas fa-folder"></i>
                      <span>{{ dept.deptName }}</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label class="form-label required">部门名称</label>
                <input 
                  type="text" 
                  v-model="form.deptName"
                  placeholder="请输入部门名称"
                  class="form-input"
                  required
                >
              </div>
              <div class="form-group">
                <label class="form-label required">显示排序</label>
                <input 
                  type="number" 
                  v-model.number="form.orderNum"
                  placeholder="请输入排序"
                  min="0"
                  class="form-input"
                  required
                >
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label class="form-label">负责人</label>
                <input 
                  type="text" 
                  v-model="form.leader"
                  placeholder="请输入负责人"
                  class="form-input"
                  maxlength="20"
                >
              </div>
              <div class="form-group">
                <label class="form-label">联系电话</label>
                <input 
                  type="tel" 
                  v-model="form.phone"
                  placeholder="请输入联系电话"
                  class="form-input"
                  maxlength="11"
                  pattern="^1[3|4|5|6|7|8|9][0-9]\d{8}$"
                >
                <div class="input-hint">11位手机号码</div>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label class="form-label">邮箱</label>
                <input 
                  type="email" 
                  v-model="form.email"
                  placeholder="请输入邮箱"
                  class="form-input"
                  maxlength="50"
                >
              </div>
              <div class="form-group">
                <label class="form-label">部门状态</label>
                <div class="status-radio-group">
                  <label 
                    v-for="dict in sys_normal_disable" 
                    :key="dict.value"
                    class="status-radio"
                  >
                    <input 
                      type="radio" 
                      v-model="form.status"
                      :value="dict.value"
                      class="radio-input"
                    >
                    <span class="radio-label">{{ dict.label }}</span>
                  </label>
                </div>
              </div>
            </div>

            <div class="form-actions">
              <button type="button" class="btn btn-outline" @click="cancel">
                取消
              </button>
              <button type="submit" class="btn btn-primary">
                {{ form.deptId ? '确认修改' : '确认添加' }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- 删除确认弹窗 -->
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
            <i class="fas fa-trash-alt confirm-icon"></i>
            <p class="confirm-message">
              确定要删除部门 <strong>"{{ deleteDeptName }}"</strong> 吗？
            </p>
            <p class="confirm-warning">
              删除后，该部门下的所有子部门和相关员工信息将无法恢复！
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
import { ref, reactive, toRefs, computed, nextTick } from 'vue'
import { listDept, getDept, delDept, addDept, updateDept, listDeptExcludeChild } from "@/api/system/dept"

const { proxy } = getCurrentInstance()
const { sys_normal_disable } = proxy.useDict("sys_normal_disable")

// 响应式数据
const deptList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const title = ref("")
const deptOptions = ref([])
const isExpandAll = ref(true)
const refreshTable = ref(true)
const showTreeSelect = ref(false)
const treeSearch = ref('')
const showDeleteConfirm = ref(false)
const deleteDeptId = ref(null)
const deleteDeptName = ref('')

// 处理部门树展开状态
const processedDeptList = computed(() => {
  const expandDept = (depts) => {
    return depts.map(dept => {
      const expandedDept = {
        ...dept,
        _expanded: isExpandAll.value
      }
      if (dept.children && dept.children.length > 0) {
        expandedDept.children = expandDept(dept.children)
      }
      return expandedDept
    })
  }
  return expandDept(deptList.value)
})

// 过滤部门选项用于搜索
const filteredDeptOptions = computed(() => {
  if (!treeSearch.value) return deptOptions.value
  
  const searchTerm = treeSearch.value.toLowerCase()
  const filterDepts = (depts, level = 0) => {
    return depts.filter(dept => {
      const matches = dept.deptName.toLowerCase().includes(searchTerm)
      const childMatches = dept.children ? filterDepts(dept.children, level + 1) : []
      
      if (matches) {
        return { ...dept, level }
      } else if (childMatches.length > 0) {
        return { ...dept, level, children: childMatches }
      }
      return null
    }).filter(Boolean)
  }
  
  return filterDepts(deptOptions.value)
})

// 主数据对象
const data = reactive({
  form: {
    deptId: undefined,
    parentId: undefined,
    deptName: undefined,
    orderNum: 0,
    leader: undefined,
    phone: undefined,
    email: undefined,
    status: "0"
  },
  queryParams: {
    deptName: undefined,
    status: undefined
  }
})

const { queryParams, form } = toRefs(data)

/** 查询部门列表 */
function getList() {
  loading.value = true
  listDept(queryParams.value).then(response => {
    deptList.value = proxy.handleTree(response.data, "deptId")
    loading.value = false
  }).catch(() => {
    loading.value = false
  })
}

/** 获取状态文本 */
function getStatusText(status) {
  const dict = sys_normal_disable.value?.find(item => item.value === status)
  return dict?.label || '未知'
}

/** 格式化时间 */
function formatTime(time) {
  if (!time) return '-'
  return new Date(time).toLocaleString('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit'
  })
}

/** 获取部门名称 */
function getDeptName(deptId) {
  const findDept = (depts) => {
    for (const dept of depts) {
      if (dept.deptId === deptId) return dept.deptName
      if (dept.children) {
        const found = findDept(dept.children)
        if (found) return found
      }
    }
    return ''
  }
  return findDept(deptOptions.value) || ''
}

/** 选择部门 */
function selectDept(dept) {
  form.value.parentId = dept.deptId
  showTreeSelect.value = false
  treeSearch.value = ''
}

/** 切换部门展开状态 */
function toggleDept(dept) {
  if (dept.children && dept.children.length > 0) {
    dept._expanded = !dept._expanded
  }
}

/** 取消按钮 */
function cancel() {
  open.value = false
  reset()
  showTreeSelect.value = false
  treeSearch.value = ''
}

/** 表单重置 */
function reset() {
  form.value = {
    deptId: undefined,
    parentId: undefined,
    deptName: undefined,
    orderNum: 0,
    leader: undefined,
    phone: undefined,
    email: undefined,
    status: "0"
  }
}

/** 搜索按钮操作 */
function handleQuery() {
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  queryParams.value.deptName = ''
  queryParams.value.status = ''
  handleQuery()
}

/** 切换搜索显示 */
function toggleSearch() {
  showSearch.value = !showSearch.value
}

/** 新增按钮操作 */
function handleAdd(row) {
  reset()
  listDept().then(response => {
    deptOptions.value = proxy.handleTree(response.data, "deptId")
  })
  if (row != undefined) {
    form.value.parentId = row.deptId
  }
  open.value = true
  title.value = "添加部门"
}

/** 展开/折叠操作 */
function toggleExpandAll() {
  isExpandAll.value = !isExpandAll.value
  refreshTable.value = false
  nextTick(() => {
    refreshTable.value = true
  })
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  listDeptExcludeChild(row.deptId).then(response => {
    deptOptions.value = proxy.handleTree(response.data, "deptId")
  })
  getDept(row.deptId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改部门"
  })
}

/** 提交按钮 */
function submitForm() {
  // 前端校验
  if (!form.value.deptName?.trim()) {
    alert('部门名称不能为空！')
    return
  }
  
  if (form.value.parentId === undefined && form.value.parentId !== 0) {
    alert('请选择上级部门！')
    return
  }
  
  if (form.value.orderNum === undefined || form.value.orderNum < 0) {
    alert('排序必须大于等于0！')
    return
  }

  const submitData = { ...form.value }
  
  if (submitData.deptId != undefined) {
    // 更新
    updateDept(submitData).then(response => {
      alert('修改成功！')
      open.value = false
      getList()
    }).catch(err => {
      alert('修改失败：' + err.message)
    })
  } else {
    // 新增
    addDept(submitData).then(response => {
      alert('新增成功！')
      open.value = false
      getList()
    }).catch(err => {
      alert('新增失败：' + err.message)
    })
  }
}

/** 删除按钮操作 */
function handleDelete(row) {
  deleteDeptId.value = row.deptId
  deleteDeptName.value = row.deptName
  showDeleteConfirm.value = true
}

/** 确认删除 */
function confirmDelete() {
  delDept(deleteDeptId.value).then(() => {
    alert('删除成功！')
    showDeleteConfirm.value = false
    getList()
  }).catch(err => {
    alert('删除失败：' + err.message)
    showDeleteConfirm.value = false
  })
}

/** 取消删除 */
function cancelDelete() {
  showDeleteConfirm.value = false
  deleteDeptId.value = null
  deleteDeptName.value = ''
}

// 初始化
getList()
</script>

<style scoped>
/* 复用基础样式 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
}

.dept-container {
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

.btn-danger {
  background-color: #ff4d4f;
  color: #fff;
}

.btn-danger:hover {
  background-color: #ff7875;
  box-shadow: 0 2px 8px rgba(255, 77, 79, 0.3);
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

.query-actions {
  display: flex;
  gap: 0.75rem;
  margin-left: auto;
  margin-bottom: 0.6rem;
}

/* 内容卡片 */
.content-card {
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  overflow: hidden;
  min-height: 300px;
}

/* 部门树样式 */
.dept-tree {
  padding: 1rem;
}

.dept-tree-item {
  margin-bottom: 0.5rem;
}

.dept-item {
  border: 1px solid #e8e8e8;
  border-radius: 8px;
  margin-bottom: 0.5rem;
  transition: all 0.3s;
  background-color: #fff;
}

.dept-item:hover {
  border-color: #1890ff;
  box-shadow: 0 2px 8px rgba(24, 144, 255, 0.1);
}

.dept-item-main {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 1.5rem;
}

.dept-item-content {
  display: flex;
  align-items: center;
  gap: 1rem;
  flex: 1;
}

.dept-icon {
  width: 36px;
  height: 36px;
  border-radius: 8px;
  background-color: #e6f7ff;
  color: #1890ff;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s;
}

.dept-icon:hover {
  background-color: #bae7ff;
}

.dept-info {
  flex: 1;
}

.dept-name {
  font-size: 1rem;
  color: #2c3e50;
  font-weight: 600;
  margin-bottom: 0.25rem;
  display: flex;
  align-items: center;
  gap: 1rem;
}

.order-num {
  font-size: 0.85rem;
  color: #8c8c8c;
  font-weight: normal;
}

.dept-details {
  display: flex;
  gap: 1.5rem;
  align-items: center;
}

.status-badge {
  padding: 0.25rem 0.75rem;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 500;
  display: inline-block;
}

.status-badge.active {
  background-color: #f6ffed;
  color: #52c41a;
  border: 1px solid #b7eb8f;
}

.status-badge.inactive {
  background-color: #fff2f0;
  color: #ff4d4f;
  border: 1px solid #ffccc7;
}

.create-time {
  font-size: 0.85rem;
  color: #8c8c8c;
}

.dept-actions {
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
  min-width: 80px;
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

.btn-action.add {
  background-color: #f6ffed;
  color: #52c41a;
  border: 1px solid #b7eb8f;
}

.btn-action.add:hover {
  background-color: #d9f7be;
}

.btn-action.delete {
  background-color: #fff2f0;
  color: #ff4d4f;
  border: 1px solid #ffccc7;
}

.btn-action.delete:hover {
  background-color: #ffccc7;
}

.dept-children {
  margin-left: 3rem;
  border-left: 2px dashed #e8e8e8;
  padding-left: 1.5rem;
}

.dept-child-item {
  margin-top: 0.5rem;
}

.dept-child-item .dept-item {
  border-color: #f0f0f0;
  background-color: #fafafa;
}

.dept-child-item .dept-icon {
  background-color: #f6ffed;
  color: #52c41a;
}

/* 加载状态 */
.loading-state {
  padding: 3rem;
  text-align: center;
  color: #1890ff;
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

.confirm-message strong {
  color: #ff4d4f;
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
.dept-form {
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
  margin-bottom: 1.5rem;
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

.input-hint {
  font-size: 0.8rem;
  color: #8c8c8c;
  margin-top: 0.25rem;
}

/* 树选择 */
.tree-select {
  position: relative;
}

.tree-select-toggle {
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

.tree-select-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background-color: #fff;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  z-index: 1000;
  max-height: 300px;
  overflow-y: auto;
  margin-top: 0.5rem;
}

.tree-search {
  padding: 0.75rem;
  border-bottom: 1px solid #f0f0f0;
}

.tree-search-input {
  padding: 0.5rem 1rem;
  border: 1px solid #d9d9d9;
  border-radius: 4px;
  width: 100%;
  font-size: 0.85rem;
}

.tree-list {
  padding: 0.5rem 0;
}

.tree-item {
  padding: 0.5rem 1rem;
  cursor: pointer;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.tree-item:hover {
  background-color: #f5f5f5;
}

.tree-item i {
  color: #1890ff;
}

/* 状态单选组 */
.status-radio-group {
  display: flex;
  gap: 1.5rem;
  align-items: center;
}

.status-radio {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
}

.radio-input {
  width: 16px;
  height: 16px;
  cursor: pointer;
}

.radio-label {
  font-size: 0.9rem;
  color: #2c3e50;
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

  .dept-item-main {
    flex-direction: column;
    align-items: stretch;
    gap: 1rem;
  }

  .dept-actions {
    justify-content: flex-start;
  }

  .btn-action {
    min-width: auto;
    flex: 1;
  }

  .dept-children {
    margin-left: 1rem;
  }

  .dept-details {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
  }

  .modal-content {
    margin: 0.5rem;
  }
}
</style>

<!-- 引入Font Awesome图标库 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">