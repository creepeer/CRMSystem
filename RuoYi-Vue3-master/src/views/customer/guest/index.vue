<template>
  <div class="customer-container">
    <!-- 简化后导航栏（仅保留logo） -->
    <nav class="navbar">
      <div class="navbar-brand">
        <div class="logo">
          <i class="fas fa-chart-network"></i>
          <h1>先锋互联</h1>
        </div>
      </div>
    </nav>

    <!-- 主要内容区域 -->
    <main class="main-content">
      <!-- 页面标题和操作栏 -->
      <div class="page-header">
        <div class="header-content">
          <h2 class="page-title">客户管理</h2>
          <p class="page-subtitle">管理所有客户信息</p>
        </div>
        <div class="actions">
          <button class="btn btn-primary" @click="showAddCustomer = true">
            <i class="fas fa-plus"></i>
            新增
          </button>
          <button class="btn btn-outline" @click="showExcelImport = true">
            <i class="fas fa-file-excel"></i>
            Excel导入
          </button>
        </div>
      </div>

      <!-- 查询条件 -->
      <div class="query-card">
        <div class="query-row">
          <div class="query-group">
            <label class="query-label">客户姓名</label>
            <input 
              type="text" 
              v-model="queryParams.name"
              placeholder="请输入客户姓名"
              class="query-input"
            >
          </div>
          <div class="query-group">
            <label class="query-label">联系方式</label>
            <input 
              type="text" 
              v-model="queryParams.contact"
              placeholder="请输入联系方式"
              class="query-input"
            >
          </div>
          <div class="query-group">
            <label class="query-label">状态</label>
            <select v-model="queryParams.status" class="query-select">
              <option value="">全部</option>
              <option value="active">活跃</option>
              <option value="inactive">非活跃</option>
              <option value="vip">VIP</option>
            </select>
          </div>
          <div class="query-actions">
            <button class="btn btn-primary" @click="handleQuery">
              <i class="fas fa-search"></i>
              搜索
            </button>
            <button class="btn btn-outline" @click="handleReset">
              <i class="fas fa-redo"></i>
              重置
            </button>
          </div>
        </div>
      </div>

      <!-- 客户列表 -->
      <div class="content-card">
        <div class="table-container">
          <table class="customer-table">
            <thead>
              <tr>
                <th>客户编号</th>
                <th>客户姓名</th>
                <th>联系方式</th>
                <th>年龄</th>
                <th>状态</th>
                <th>创建时间</th>
                <th class="actions-col">操作</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="customer in filteredCustomers" :key="customer.id">
                <td class="customer-id">{{ customer.id }}</td>
                <td>
                  <div class="customer-name">
                    <div class="avatar">
                      {{ customer.name.charAt(0) || '?' }}
                    </div>
                    {{ customer.name }}
                  </div>
                </td>
                <td>{{ customer.contact }}</td>
                <td>{{ customer.age }}岁</td>
                <td>
                  <span class="status-badge" :class="customer.status">
                    {{ getStatusText(customer.status) }}
                  </span>
                </td>
                <td>{{ customer.createTime }}</td>
                <td class="actions-col">
                  <div class="actions-cell">
                    <button class="btn-action detail" @click="viewCustomerDetail(customer)" title="详情">
                      <i class="fas fa-eye"></i>
                      详情
                    </button>
                    <button class="btn-action edit" @click="editCustomer(customer)" title="修改">
                      <i class="fas fa-edit"></i>
                      修改
                    </button>
                    <button class="btn-action delete" @click="deleteCustomer(customer.id)" title="删除">
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
        <div v-if="filteredCustomers.length === 0" class="empty-state">
          <i class="fas fa-users empty-icon"></i>
          <p>暂无客户数据</p>
          <button class="btn btn-outline mt-3" @click="showAddCustomer = true">
            <i class="fas fa-plus"></i>
            立即新增客户
          </button>
        </div>

        <!-- 分页 -->
        <div class="pagination" v-if="filteredCustomers.length > 0">
          <div class="pagination-info">
            共 {{ totalFilteredCount }} 条记录
          </div>
          <div class="pagination-controls">
            <button class="pagination-btn" :disabled="currentPage === 1" @click="prevPage">
              <i class="fas fa-chevron-left"></i>
            </button>
            <span class="pagination-text">第 {{ currentPage }} / {{ totalPages }} 页</span>
            <button class="pagination-btn" :disabled="currentPage === totalPages" @click="nextPage">
              <i class="fas fa-chevron-right"></i>
            </button>
          </div>
        </div>
      </div>
    </main>

    <!-- 新增客户弹窗 -->
    <div v-if="showAddCustomer" class="modal-overlay" @click="closeAddModal">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3>新增客户</h3>
          <button class="close-btn" @click="closeAddModal">
            <i class="fas fa-times"></i>
          </button>
        </div>
        
        <div class="modal-body">
          <form @submit.prevent="addCustomer" class="customer-form">
            <div class="form-row">
              <div class="form-group">
                <label for="customerName" class="form-label required">客户姓名</label>
                <input 
                  type="text" 
                  id="customerName"
                  v-model="newCustomer.name"
                  placeholder="请输入客户姓名"
                  class="form-input"
                  required
                >
              </div>
              <div class="form-group">
                <label for="customerAddress" class="form-label">客户地址</label>
                <input 
                  type="text" 
                  id="customerAddress"
                  v-model="newCustomer.address"
                  placeholder="请输入客户地址"
                  class="form-input"
                >
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label for="customerAge" class="form-label required">年龄</label>
                <input 
                  type="number" 
                  id="customerAge"
                  v-model="newCustomer.age"
                  placeholder="请输入年龄"
                  min="1"
                  max="120"
                  class="form-input"
                  required
                >
              </div>
              <div class="form-group">
                <label for="customerTeam" class="form-label required">负责团队</label>
                <select 
                  id="customerTeam" 
                  v-model="newCustomer.teamId" 
                  class="form-select" 
                  required
                  @change="handleTeamChange"
                >
                  <option value="">请选择负责团队</option>
                  <option v-for="team in teamList" :key="team.id" :value="team.id">
                    {{ team.name }}
                  </option>
                </select>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label for="customerContact" class="form-label required">联系方式</label>
                <input 
                  type="text" 
                  id="customerContact"
                  v-model="newCustomer.contact"
                  placeholder="请输入联系方式"
                  class="form-input"
                  required
                >
              </div>
              <div class="form-group">
                <label for="customerStaff" class="form-label required">负责员工</label>
                <select 
                  id="customerStaff" 
                  v-model="newCustomer.userId" 
                  class="form-select" 
                  required
                >
                  <option value="">请选择负责员工</option>
                  <option v-for="staff in filteredStaffList" :key="staff.id" :value="staff.id">
                    {{ staff.name }}
                  </option>
                </select>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label for="customerEmail" class="form-label">客户邮箱</label>
                <input 
                  type="email" 
                  id="customerEmail"
                  v-model="newCustomer.email"
                  placeholder="请输入客户邮箱"
                  class="form-input"
                >
              </div>
              <div class="form-group">
                <label for="customerRemark" class="form-label">备注</label>
                <input 
                  type="text" 
                  id="customerRemark"
                  v-model="newCustomer.remark"
                  placeholder="请输入备注"
                  class="form-input"
                >
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label for="customerStatus" class="form-label required">状态</label>
                <select id="customerStatus" v-model="newCustomer.status" class="form-select" required>
                  <option value="active">活跃</option>
                  <option value="inactive">非活跃</option>
                  <option value="vip">VIP</option>
                </select>
              </div>
            </div>
            
            <div class="form-actions">
              <button type="button" class="btn btn-outline" @click="closeAddModal">
                取消
              </button>
              <button type="submit" class="btn btn-primary" :disabled="isSubmitting">
                <i v-if="isSubmitting" class="fas fa-spinner fa-spin"></i>
                <i v-else class="fas fa-check"></i>
                {{ isSubmitting ? '处理中...' : '确认添加' }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- 编辑客户弹窗 -->
    <div v-if="showEditCustomer" class="modal-overlay" @click="closeEditModal">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3>修改客户</h3>
          <button class="close-btn" @click="closeEditModal">
            <i class="fas fa-times"></i>
          </button>
        </div>
        
        <div class="modal-body">
          <form @submit.prevent="updateCustomer" class="customer-form">
            <div class="form-row">
              <div class="form-group">
                <label for="editCustomerName" class="form-label required">客户姓名</label>
                <input 
                  type="text" 
                  id="editCustomerName"
                  v-model="editCustomerData.name"
                  placeholder="请输入客户姓名"
                  class="form-input"
                  required
                >
              </div>
              <div class="form-group">
                <label for="editCustomerAddress" class="form-label">客户地址</label>
                <input 
                  type="text" 
                  id="editCustomerAddress"
                  v-model="editCustomerData.address"
                  placeholder="请输入客户地址"
                  class="form-input"
                >
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label for="editCustomerAge" class="form-label required">年龄</label>
                <input 
                  type="number" 
                  id="editCustomerAge"
                  v-model="editCustomerData.age"
                  placeholder="请输入年龄"
                  min="1"
                  max="120"
                  class="form-input"
                  required
                >
              </div>
              <div class="form-group">
                <label for="editCustomerTeam" class="form-label required">负责团队</label>
                <select 
                  id="editCustomerTeam" 
                  v-model="editCustomerData.teamId" 
                  class="form-select" 
                  required
                  @change="handleEditTeamChange"
                >
                  <option value="">请选择负责团队</option>
                  <option v-for="team in teamList" :key="team.id" :value="team.id">
                    {{ team.name }}
                  </option>
                </select>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label for="editCustomerContact" class="form-label required">联系方式</label>
                <input 
                  type="text" 
                  id="editCustomerContact"
                  v-model="editCustomerData.contact"
                  placeholder="请输入联系方式"
                  class="form-input"
                  required
                >
              </div>
              <div class="form-group">
                <label for="editCustomerStaff" class="form-label required">负责员工</label>
                <select 
                  id="editCustomerStaff" 
                  v-model="editCustomerData.userId" 
                  class="form-select" 
                  required
                >
                  <option value="">请选择负责员工</option>
                  <option v-for="staff in filteredEditStaffList" :key="staff.id" :value="staff.id">
                    {{ staff.name }}
                  </option>
                </select>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label for="editCustomerEmail" class="form-label">客户邮箱</label>
                <input 
                  type="email" 
                  id="editCustomerEmail"
                  v-model="editCustomerData.email"
                  placeholder="请输入客户邮箱"
                  class="form-input"
                >
              </div>
              <div class="form-group">
                <label for="editCustomerRemark" class="form-label">备注</label>
                <input 
                  type="text" 
                  id="editCustomerRemark"
                  v-model="editCustomerData.remark"
                  placeholder="请输入备注"
                  class="form-input"
                >
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label for="editCustomerStatus" class="form-label required">状态</label>
                <select id="editCustomerStatus" v-model="editCustomerData.status" class="form-select" required>
                  <option value="active">活跃</option>
                  <option value="inactive">非活跃</option>
                  <option value="vip">VIP</option>
                </select>
              </div>
            </div>
            
            <div class="form-actions">
              <button type="button" class="btn btn-outline" @click="closeEditModal">
                取消
              </button>
              <button type="submit" class="btn btn-primary" :disabled="isUpdating">
                <i v-if="isUpdating" class="fas fa-spinner fa-spin"></i>
                <i v-else class="fas fa-check"></i>
                {{ isUpdating ? '处理中...' : '确认修改' }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- 客户详情弹窗 -->
    <div v-if="showCustomerDetail" class="modal-overlay" @click="closeDetailModal">
      <div class="modal-content detail-modal" @click.stop>
        <div class="modal-header">
          <h3>客户详情</h3>
          <button class="close-btn" @click="closeDetailModal">
            <i class="fas fa-times"></i>
          </button>
        </div>
        
        <div class="modal-body">
          <div class="detail-card">
            <div class="detail-header">
              <div class="detail-avatar">
                {{ currentDetailCustomer.name?.charAt(0) || '?' }}
              </div>
              <div class="detail-title">
                <h4>{{ currentDetailCustomer.name }}</h4>
                <span class="status-badge" :class="currentDetailCustomer.status">
                  {{ getStatusText(currentDetailCustomer.status) }}
                </span>
              </div>
            </div>
            <div class="detail-content">
              <div class="detail-row">
                <div class="detail-item">
                  <label class="detail-label">客户编号</label>
                  <span class="detail-value">{{ currentDetailCustomer.id }}</span>
                </div>
                <div class="detail-item">
                  <label class="detail-label">年龄</label>
                  <span class="detail-value">{{ currentDetailCustomer.age }}岁</span>
                </div>
              </div>
              <div class="detail-row">
                <div class="detail-item">
                  <label class="detail-label">联系方式</label>
                  <span class="detail-value">{{ currentDetailCustomer.contact }}</span>
                </div>
                <div class="detail-item">
                  <label class="detail-label">客户邮箱</label>
                  <span class="detail-value">{{ currentDetailCustomer.email || '无' }}</span>
                </div>
              </div>
              <div class="detail-row">
                <div class="detail-item">
                  <label class="detail-label">客户地址</label>
                  <span class="detail-value">{{ currentDetailCustomer.address || '无' }}</span>
                </div>
                <div class="detail-item">
                  <label class="detail-label">负责团队</label>
                  <span class="detail-value">
                    {{ getTeamNameById(currentDetailCustomer.teamId) || '无' }}
                  </span>
                </div>
              </div>
              <div class="detail-row">
                <div class="detail-item">
                  <label class="detail-label">负责员工</label>
                  <span class="detail-value">
                    {{ getStaffNameById(currentDetailCustomer.userId) || '无' }}
                  </span>
                </div>
                <div class="detail-item">
                  <label class="detail-label">创建时间</label>
                  <span class="detail-value">{{ currentDetailCustomer.createTime }}</span>
                </div>
              </div>
              <div class="detail-row full-width">
                <div class="detail-item">
                  <label class="detail-label">备注</label>
                  <span class="detail-value">{{ currentDetailCustomer.remark || '无' }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Excel导入弹窗 -->
    <div v-if="showExcelImport" class="modal-overlay" @click="closeExcelModal">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3>Excel导入客户</h3>
          <button class="close-btn" @click="closeExcelModal">
            <i class="fas fa-times"></i>
          </button>
        </div>
        
        <div class="modal-body">
          <div class="import-tips">
            <p class="tips-title"><i class="fas fa-info-circle text-primary"></i> 导入说明</p>
            <ul class="tips-list">
              <li>支持.xlsx/.xls格式，单个文件最大5MB</li>
              <li>必填字段：客户姓名、年龄（1-120）、联系方式（7-11位数字）、负责团队、负责员工</li>
              <li>状态仅支持：活跃/非活跃/VIP，不填默认「活跃」</li>
              <li>重复联系方式会自动跳过</li>
            </ul>
          </div>

          <div class="template-download">
            <button class="btn btn-outline" @click="downloadTemplate">
              <i class="fas fa-download"></i>
              下载导入模板
            </button>
            <p class="template-desc">按模板格式填写，避免导入失败</p>
          </div>

          <div class="file-upload-section">
            <label class="form-label required">选择Excel文件</label>
            <div class="file-upload-area">
              <label for="excelFile" class="upload-label">
                <i class="fas fa-cloud-upload-alt text-primary"></i>
                <p class="upload-text">点击或拖拽文件至此处</p>
                <p class="upload-hint">支持.xlsx/.xls，最大5MB</p>
                <input 
                  type="file" 
                  id="excelFile" 
                  accept=".xlsx,.xls" 
                  class="file-input"
                  @change="handleFileSelect"
                >
              </label>
            </div>

            <div v-if="selectedFileName" class="selected-file">
              <i class="fas fa-file-excel text-success"></i>
              <span class="file-name">{{ selectedFileName }}</span>
              <button type="button" class="remove-file-btn" @click="clearSelectedFile">
                <i class="fas fa-times"></i>
              </button>
            </div>
          </div>

          <div class="form-actions import-actions">
            <button type="button" class="btn btn-outline" @click="closeExcelModal">
              取消
            </button>
            <button 
              class="btn btn-primary"
              @click="handleExcelImport"
              :disabled="!selectedFile || isImporting"
            >
              <i v-if="isImporting" class="fas fa-spinner fa-spin"></i>
              <i v-else class="fas fa-upload"></i>
              {{ isImporting ? '导入中...' : '开始导入' }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import request from '@/utils/request';
const XLSX = window.XLSX;

export default {
  name: 'CustomerManagement',
  data() {
    return {
      // 弹窗控制
      showAddCustomer: false,
      showEditCustomer: false,
      showExcelImport: false,
      showCustomerDetail: false,
      
      // 加载状态
      isSubmitting: false,
      isUpdating: false,
      isImporting: false,
      
      // 分页与查询
      currentPage: 1,
      pageSize: 10,
      queryParams: {
        name: '',
        contact: '',
        status: ''
      },
      
      // 团队和员工列表
      teamList: [],
      staffList: [],
      filteredStaffList: [],
      filteredEditStaffList: [],
      
      // 表单数据
      newCustomer: {
        name: '',
        age: '',
        contact: '',
        status: 'active',
        address: '',
        teamId: '',
        userId: '',
        email: '',
        remark: ''
      },
      editCustomerData: {
        id: '',
        name: '',
        age: '',
        contact: '',
        status: 'active',
        address: '',
        teamId: '',
        userId: '',
        email: '',
        remark: ''
      },
      
      // 当前详情客户数据
      currentDetailCustomer: {},
      
      // 客户列表数据
      customers: [],
      
      // Excel导入相关
      selectedFile: null,
      selectedFileName: '',
      validStatus: ['active', 'inactive', 'vip']
    };
  },
  created() {
    this.getTeamAndStaffList();
    this.getCustomerList();
  },
  computed: {
    filteredCustomersAll() {
      let result = [...this.customers];
      if (this.queryParams.name.trim()) {
        const name = this.queryParams.name.trim().toLowerCase();
        result = result.filter(cust => cust.name.toLowerCase().includes(name));
      }
      if (this.queryParams.contact.trim()) {
        const contact = this.queryParams.contact.trim();
        result = result.filter(cust => cust.contact.includes(contact));
      }
      if (this.queryParams.status) {
        result = result.filter(cust => cust.status === this.queryParams.status);
      }
      return result;
    },
    filteredCustomers() {
      const start = (this.currentPage - 1) * this.pageSize;
      return this.filteredCustomersAll.slice(start, start + this.pageSize);
    },
    totalFilteredCount() {
      return this.filteredCustomersAll.length;
    },
    totalPages() {
      return Math.ceil(this.totalFilteredCount / this.pageSize);
    }
  },
  methods: {
    // ===================== 接口请求相关 =====================
    // 获取团队和员工列表
    async getTeamAndStaffList() {
      try {
        // 获取团队列表 - 从 company/teams/list 接口
        const teamResponse = await request.get('/company/teams/list');
        console.log('团队接口响应:', teamResponse);
        
        if (teamResponse.code === 200 && teamResponse.data && Array.isArray(teamResponse.data)) {
          // 根据您提供的接口数据结构，团队信息在data数组中
          this.teamList = teamResponse.data.map(item => ({
            id: item.deptId, // 使用deptId作为团队ID
            name: item.deptName // 使用deptName作为团队名称
          }));
          console.log('处理后的团队列表:', this.teamList);
        } else {
          this.teamList = [];
          console.warn('获取团队列表失败或数据格式不正确');
        }
        
        // 获取员工列表 - 从 company/staff/list 接口（和负责团队一样的处理方式）
        const staffResponse = await request.get('/company/staff/list');
        console.log('员工接口响应:', staffResponse);
        
        // 和负责团队一样的处理方式：优先从 data 字段获取，如果没有则从 rows 获取
        if (staffResponse.code === 200) {
          let staffData = [];
          
          // 优先尝试从 data 字段获取（和团队列表一样）
          if (staffResponse.data && Array.isArray(staffResponse.data)) {
            staffData = staffResponse.data;
          } else if (staffResponse.rows && Array.isArray(staffResponse.rows)) {
            // 如果 data 不存在，则从 rows 获取（兼容现有接口）
            staffData = staffResponse.rows;
          }
          
          if (staffData.length > 0) {
            // 和团队列表一样的映射方式
            this.staffList = staffData.map(item => ({
              id: item.userId, // 使用userId作为员工ID
              name: item.nickName || item.userName, // 优先使用nickName，没有则用userName
              teamId: item.deptId || 0 // 使用deptId作为团队ID
            })).filter(staff => staff.id && staff.name); // 过滤掉无效数据
            
            console.log('处理后的员工列表:', this.staffList);
          } else {
            this.staffList = [];
            console.warn('获取员工列表失败或数据格式不正确');
          }
        } else {
          this.staffList = [];
          console.warn('获取员工列表失败或数据格式不正确');
        }
        
      } catch (error) {
        console.error('获取团队/员工列表失败：', error);
        // 不使用模拟数据，直接设置为空数组
        this.teamList = [];
        this.staffList = [];
        alert('获取团队/员工列表失败：' + (error.message || '网络异常'));
      }
    },

    // 新增客户接口请求（适配Apifox接口文档）
    async addCustomerApi(customerData) {
      try {
        // 状态映射：前端状态字符串转为后端数字
        const statusMap = { active: 1, inactive: 2, vip: 3 };
        
        // 构建请求参数（完全按照Apifox文档格式）
        const requestData = {
          name: customerData.name ? String(customerData.name).trim() : '',
          age: Number(customerData.age) || 0,
          phone: customerData.contact ? String(customerData.contact).trim() : '', // 后端字段为phone
          email: customerData.email ? String(customerData.email).trim() : '',
          address: customerData.address ? String(customerData.address).trim() : '',
          teamId: Number(customerData.teamId) || 0,
          userId: Number(customerData.userId) || 0,
          status: statusMap[customerData.status] || 1, // 默认活跃状态
          remark: customerData.remark ? String(customerData.remark).trim() : ''
        };

        console.log('新增客户请求参数:', JSON.stringify(requestData));

        // 发送POST请求到/customer/add
        const response = await request.post('/customer/add', requestData);
        
        console.log('新增客户响应:', response);
        
        // 检查响应是否成功（若依框架返回 code: 200 表示成功）
        if (response.code === 200) {
          return response.data || response;
        } else {
          throw new Error(response.msg || '请求失败');
        }
      } catch (error) {
        console.error('新增客户失败：', error);
        
        // 详细的错误处理
        let errorMsg = '网络异常或接口错误';
        if (error.response) {
          // 服务器响应了错误状态码
          const status = error.response.status;
          const data = error.response.data;
          errorMsg = data?.message || `服务器错误 ${status}`;
          console.error('响应状态:', status);
          console.error('响应数据:', data);
        } else if (error.request) {
          // 请求已发送但无响应
          errorMsg = '服务器无响应，请检查网络连接';
          console.error('请求数据:', error.request);
        } else if (error.message) {
          // 其他错误
          errorMsg = error.message;
        }
        
        console.error('详细错误信息:', error);
        throw new Error(`新增客户失败：${errorMsg}`);
      }
    },

    // 修改客户接口请求（适配Apifox接口文档）
    async updateCustomerApi(customerData) {
      try {
        // 状态映射：前端状态字符串转为后端数字
        const statusMap = { active: 1, inactive: 2, vip: 3 };
        
        // 构建请求参数（完全按照Apifox文档格式）
        const requestData = {
          id: Number(customerData.id) || 0, // 必须有id，用于标识要修改的客户
          name: customerData.name ? String(customerData.name).trim() : '',
          age: Number(customerData.age) || 0,
          phone: customerData.contact ? String(customerData.contact).trim() : '',
          email: customerData.email ? String(customerData.email).trim() : '',
          address: customerData.address ? String(customerData.address).trim() : '',
          teamId: Number(customerData.teamId) || 0,
          userId: Number(customerData.userId) || 0,
          status: statusMap[customerData.status] || 1,
          remark: customerData.remark ? String(customerData.remark).trim() : ''
        };

        console.log('修改客户请求参数:', JSON.stringify(requestData));
        console.log('修改客户userId:', requestData.userId, '原始值:', customerData.userId);

        // 发送PUT请求到/customer/update
        const response = await request.put('/customer/update', requestData);
        
        console.log('修改客户响应:', response);
        
        // 检查响应是否成功（若依框架返回 code: 200 表示成功）
        if (response.code === 200) {
          return response.data || response;
        } else {
          throw new Error(response.msg || '请求失败');
        }
      } catch (error) {
        console.error('修改客户失败：', error);
        
        let errorMsg = '网络异常或接口错误';
        if (error.response) {
          const status = error.response.status;
          const data = error.response.data;
          errorMsg = data?.message || `服务器错误 ${status}`;
          console.error('响应状态:', status);
          console.error('响应数据:', data);
        } else if (error.request) {
          errorMsg = '服务器无响应，请检查网络连接';
          console.error('请求数据:', error.request);
        } else if (error.message) {
          errorMsg = error.message;
        }
        
        console.error('详细错误信息:', error);
        throw new Error(`修改客户失败：${errorMsg}`);
      }
    },

    // 从后端拉取客户列表
    async getCustomerList() {
      try {
        const response = await request.get('/customer/list');
        console.log('客户列表接口响应:', response);
        
        // 适配多种返回格式
        if (response.code === 200) {
          let customerData = [];
          
          if (response.data && Array.isArray(response.data)) {
            customerData = response.data;
          } else if (response.rows && Array.isArray(response.rows)) {
            customerData = response.rows;
          } else if (Array.isArray(response)) {
            customerData = response;
          }
          
          this.customers = customerData.map(item => ({
            id: item.id || `CUST${Date.now()}`,
            name: item.name || '未命名客户',
            age: item.age || 0,
            contact: item.phone || item.contact || '',
            status: this.getStatusByNumber(item.status),
            createTime: item.createdAt || item.createTime || new Date().toLocaleString('zh-CN'),
            address: item.address || '',
            // 负责团队：兼容多种字段名，和负责员工保持一致
            teamId: item.teamId || item.team_id || 0,
            // 负责员工：兼容 userid（后端返回的小写）和 userId（驼峰）两种格式，和 teamId 保持一致的处理方式
            userId: item.userid || item.userId || item.user_id || 0,
            email: item.email || '',
            remark: item.remark || ''
          }));

          
          
          console.log('处理后的客户列表:', this.customers);
        } else {
          this.customers = [];
          console.warn('获取客户列表失败:', response.msg);
        }
      } catch (error) {
        console.error('获取客户列表失败：', error);
        this.customers = [];
        alert('获取客户列表失败：' + (error.message || '网络异常'));
      }
    },

    // ===================== 团队/员工筛选相关 =====================
    handleTeamChange() {
      const teamId = Number(this.newCustomer.teamId);
      if (!teamId) {
        this.filteredStaffList = [];
        this.newCustomer.userId = '';
        return;
      }
      // 筛选属于该团队的员工
      this.filteredStaffList = this.staffList.filter(staff => {
        // 兼容teamId可能是字符串或数字的情况
        const staffTeamId = Number(staff.teamId);
        return staffTeamId === teamId;
      });
      console.log(`团队${teamId}的筛选后员工:`, this.filteredStaffList);
      this.newCustomer.userId = '';
    },

    handleEditTeamChange() {
      const teamId = Number(this.editCustomerData.teamId);
      if (!teamId) {
        this.filteredEditStaffList = [];
        this.editCustomerData.userId = '';
        return;
      }
      // 筛选属于该团队的员工
      this.filteredEditStaffList = this.staffList.filter(staff => {
        const staffTeamId = Number(staff.teamId);
        return staffTeamId === teamId;
      });
      console.log(`编辑-团队${teamId}的筛选后员工:`, this.filteredEditStaffList);
      this.editCustomerData.userId = '';
    },

      getTeamNameById(teamId) {
      if (!teamId) return '';
      const team = this.teamList.find(item => Number(item.id) === Number(teamId));
      return team ? team.name : '';
    },

    getStaffNameById(userId) {
      if (!userId) return '';
      const staff = this.staffList.find(item => Number(item.id) === Number(userId));
      return staff ? staff.name : '';
    },

    // ===================== 基础功能 =====================
    closeAddModal() {
      this.showAddCustomer = false;
      this.isSubmitting = false;
      this.resetNewCustomer();
    },

    closeEditModal() {
      this.showEditCustomer = false;
      this.isUpdating = false;
    },

    closeExcelModal() {
      this.showExcelImport = false;
      this.isImporting = false;
      this.clearSelectedFile();
    },

    viewCustomerDetail(customer) {
      this.currentDetailCustomer = { ...customer };
      this.showCustomerDetail = true;
    },

    closeDetailModal() {
      this.showCustomerDetail = false;
      this.currentDetailCustomer = {};
    },

    resetNewCustomer() {
      this.newCustomer = {
        name: '',
        age: '',
        contact: '',
        status: 'active',
        address: '',
        teamId: '',
        userId: '',
        email: '',
        remark: ''
      };
      this.filteredStaffList = [];
    },

    getStatusText(status) {
      const map = { active: '活跃', inactive: '非活跃', vip: 'VIP' };
      return map[status] || '未知';
    },

    // 辅助方法：将状态数字转为前端使用的状态字符串
    getStatusByNumber(statusNum) {
      const statusMap = { 1: 'active', 2: 'inactive', 3: 'vip' };
      return statusMap[statusNum] || 'active';
    },

    // ===================== 客户操作 =====================
    // 新增客户
    async addCustomer() {
      try {
        // 前端校验
        if (!this.newCustomer.name || !this.newCustomer.name.trim()) {
          alert('客户姓名不能为空！');
          return;
        }
        if (!this.newCustomer.age || this.newCustomer.age < 1 || this.newCustomer.age > 120) {
          alert('年龄需为1-120的数字！');
          return;
        }
        if (!this.newCustomer.contact || !/^\d{7,11}$/.test(this.newCustomer.contact.trim())) {
          alert('联系方式需为7-11位数字！');
          return;
        }
        if (!this.newCustomer.teamId) {
          alert('请选择负责团队！');
          return;
        }
        if (!this.newCustomer.userId) {
          alert('请选择负责员工！');
          return;
        }
        
        // 检查联系方式重复
        const contact = this.newCustomer.contact.trim();
        const isDuplicate = this.customers.some(cust => cust.contact === contact);
        if (isDuplicate) {
          alert('该联系方式已存在！');
          return;
        }

        // 设置提交状态
        this.isSubmitting = true;

        // 调用新增接口
        const newCustomerData = await this.addCustomerApi(this.newCustomer);
        
        if (!newCustomerData) {
          alert('新增客户失败，未收到服务器响应！');
          return;
        }

        // 如果接口调用成功，使用后端返回的数据更新本地列表
        const newCust = {
          id: newCustomerData.id || `CUST${Date.now()}`,
          name: newCustomerData.name || this.newCustomer.name.trim(),
          age: newCustomerData.age || Number(this.newCustomer.age),
          contact: newCustomerData.phone || this.newCustomer.contact.trim(),
          status: this.getStatusByNumber(newCustomerData.status) || this.newCustomer.status,
          createTime: new Date().toLocaleString('zh-CN', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit'
          }),
          address: newCustomerData.address || this.newCustomer.address.trim(),
          teamId: newCustomerData.teamId || Number(this.newCustomer.teamId),
          userId: newCustomerData.userId || Number(this.newCustomer.userId),
          email: newCustomerData.email || this.newCustomer.email.trim(),
          remark: newCustomerData.remark || this.newCustomer.remark.trim()
        };

        this.customers.unshift(newCust);
        alert('客户添加成功！');
        this.closeAddModal();

      } catch (error) {
        console.error('新增客户出错：', error);
        alert(error.message || '新增客户失败，请检查网络连接或联系管理员！');
      } finally {
        this.isSubmitting = false;
      }
    },

    // 编辑客户
    editCustomer(customer) {
      this.editCustomerData = { ...customer };
      // 负责团队：转换为字符串
      this.editCustomerData.teamId = String(customer.teamId || '');
      // 负责员工：和负责团队一样的处理方式，直接转换为字符串
      this.editCustomerData.userId = String(customer.userId || '');
      
      const teamId = Number(customer.teamId);
      // 筛选属于该团队的员工
      this.filteredEditStaffList = this.staffList.filter(staff => {
        const staffTeamId = Number(staff.teamId);
        return staffTeamId === teamId;
      });
      console.log('编辑客户时的筛选员工:', this.filteredEditStaffList);
      this.showEditCustomer = true;
    },

    // 更新客户
    async updateCustomer() {
      try {
        // 前端校验
        if (!this.editCustomerData.name || !this.editCustomerData.name.trim()) {
          alert('客户姓名不能为空！');
          return;
        }
        if (!this.editCustomerData.age || this.editCustomerData.age < 1 || this.editCustomerData.age > 120) {
          alert('年龄需为1-120的数字！');
          return;
        }
        if (!this.editCustomerData.contact || !/^\d{7,11}$/.test(this.editCustomerData.contact.trim())) {
          alert('联系方式需为7-11位数字！');
          return;
        }
        if (!this.editCustomerData.teamId) {
          alert('请选择负责团队！');
          return;
        }
        if (!this.editCustomerData.userId) {
          alert('请选择负责员工！');
          return;
        }
        
        // 检查联系方式重复（排除自身）
        const contact = this.editCustomerData.contact.trim();
        const isDuplicate = this.customers.some(
          cust => cust.contact === contact && cust.id !== this.editCustomerData.id
        );
        if (isDuplicate) {
          alert('该联系方式已存在！');
          return;
        }

        // 设置更新状态
        this.isUpdating = true;

        // 调用修改接口
        const updateResult = await this.updateCustomerApi(this.editCustomerData);
        
        if (!updateResult) {
          alert('修改客户失败，未收到服务器响应！');
          return;
        }

        // 保存当前详情弹窗状态
        const wasDetailOpen = this.showCustomerDetail;
        const detailCustomerId = this.currentDetailCustomer.id;

        // 重新从后端获取客户列表，确保数据是最新的（包括 userid 字段）
        await this.getCustomerList();
        
        // 如果详情弹窗之前是打开的，重新打开并更新数据
        if (wasDetailOpen && detailCustomerId) {
          const updatedCustomer = this.customers.find(cust => cust.id == detailCustomerId);
          if (updatedCustomer) {
            this.currentDetailCustomer = { ...updatedCustomer };
            this.showCustomerDetail = true;
          }
        }
        
        alert('客户修改成功！');
        this.closeEditModal();

      } catch (error) {
        console.error('修改客户出错：', error);
        alert(error.message || '修改客户失败，请检查网络连接或联系管理员！');
      } finally {
        this.isUpdating = false;
      }
    },

    // 删除客户 - 接口方式
    async deleteCustomer(custId) {
      if (confirm('确定要删除该客户吗？删除后不可恢复！')) {
        try {
          // 构建请求URL和参数
          const requestUrl = `/customer/${custId}`;
          console.log('删除客户请求URL:', requestUrl);
          
          // 发送DELETE请求
          const response = await request.delete(requestUrl);
          
          console.log('删除客户响应:', response);
          
          // 检查响应是否成功（若依框架返回 code: 200 表示成功）
          if (response.code === 200) {
            // 前端本地删除
            this.customers = this.customers.filter(cust => cust.id !== custId);
            
            // 如果当前页没有数据了，且不是第一页，则跳转到上一页
            if (this.filteredCustomers.length === 0 && this.currentPage > 1) {
              this.currentPage--;
            }
            
            alert('客户删除成功！');
            
            // 可选：重新从服务器获取最新数据
            // await this.getCustomerList();
          } else {
            throw new Error(response.msg || '删除失败');
          }
          
        } catch (error) {
          console.error('删除客户失败：', error);
          
          // 详细的错误处理
          let errorMsg = '网络异常或接口错误';
          if (error.response) {
            // 服务器响应了错误状态码
            const status = error.response.status;
            const data = error.response.data;
            errorMsg = data?.message || `服务器错误 ${status}`;
            console.error('响应状态:', status);
            console.error('响应数据:', data);
            
            // 如果接口返回未授权等错误，可以跳转到登录页
            if (status === 401) {
              alert('登录已过期，请重新登录');
              // window.location.href = '/login';
              return;
            }
            
            // 如果是404错误，可能是客户已被删除
            if (status === 404) {
              errorMsg = '该客户可能已被删除';
              // 前端本地同步删除
              this.customers = this.customers.filter(cust => cust.id !== custId);
            }
          } else if (error.request) {
            // 请求已发送但无响应
            errorMsg = '服务器无响应，请检查网络连接';
            console.error('请求数据:', error.request);
          } else if (error.message) {
            // 其他错误
            errorMsg = error.message;
          }
          
          // 如果是404错误，已经在前端删除了，可以只提示不弹窗
          if (error.response?.status !== 404) {
            alert('删除客户失败：' + errorMsg);
          } else {
            alert('客户已被删除或不存在');
          }
        }
      }
    },

    // ===================== 查询与分页 =====================
    handleQuery() {
      this.currentPage = 1;
    },

    handleReset() {
      this.queryParams = { name: '', contact: '', status: '' };
      this.currentPage = 1;
    },

    prevPage() {
      if (this.currentPage > 1) {
        this.currentPage--;
      }
    },

    nextPage() {
      if (this.currentPage < this.totalPages) {
        this.currentPage++;
      }
    },

    // ===================== Excel导入 =====================
    downloadTemplate() {
      try {
        const templateData = [
          { 
            '客户姓名': '示例1', 
            '年龄': 30, 
            '联系方式': '13800138001', 
            '状态（活跃/非活跃/VIP）': '活跃',
            '客户地址': '示例地址',
            '负责团队': '研发部门',
            '负责员工': '若依',
            '客户邮箱': 'example@xxx.com',
            '备注': '示例备注'
          },
          { 
            '客户姓名': '示例2', 
            '年龄': 45, 
            '联系方式': '13900139002', 
            '状态（活跃/非活跃/VIP）': 'VIP',
            '客户地址': '示例地址2',
            '负责团队': '测试部门',
            '负责员工': '若依',
            '客户邮箱': 'example2@xxx.com',
            '备注': '示例备注2'
          }
        ];
        const ws = XLSX.utils.json_to_sheet(templateData);
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, '客户模板');
        XLSX.writeFile(wb, '客户导入模板.xlsx');
      } catch (error) {
        alert('模板下载失败，请手动创建Excel！');
        console.error('模板下载错误：', error);
      }
    },

    handleFileSelect(e) {
      const file = e.target.files[0];
      if (!file) return;

      const ext = file.name.split('.').pop().toLowerCase();
      if (!['xlsx', 'xls'].includes(ext)) {
        alert('请选择.xlsx或.xls格式的文件！');
        e.target.value = '';
        return;
      }
      if (file.size > 5 * 1024 * 1024) {
        alert('文件大小不能超过5MB！');
        e.target.value = '';
        return;
      }

      this.selectedFile = file;
      this.selectedFileName = file.name;
    },

    clearSelectedFile() {
      this.selectedFile = null;
      this.selectedFileName = '';
      const fileInput = document.getElementById('excelFile');
      if (fileInput) fileInput.value = '';
    },

    parseExcel(file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = (e) => {
          try {
            const data = new Uint8Array(e.target.result);
            const wb = XLSX.read(data, { type: 'array' });
            const wsName = wb.SheetNames[0];
            const ws = wb.Sheets[wsName];
            const jsonData = XLSX.utils.sheet_to_json(ws, {
              header: ['name', 'age', 'contact', 'status', 'address', 'team', 'staff', 'email', 'remark'],
              skipHeader: 1
            });
            const validRows = jsonData.filter(row => row.name || row.age || row.contact || row.status);
            resolve(validRows);
          } catch (error) {
            reject('文件解析失败：' + error.message);
          }
        };
        reader.onerror = () => reject('文件读取失败，请检查文件是否损坏');
        reader.readAsArrayBuffer(file);
      });
    },

    validateImportData(rawData) {
      const validData = [];
      const existingContacts = new Set(this.customers.map(cust => cust.contact));
      const errorMsgList = [];

      rawData.forEach((row, index) => {
        const rowNum = index + 2;
        const data = {
          name: (row.name || '').trim(),
          age: Number(row.age) || 0,
          contact: (row.contact || '').trim(),
          status: (row.status || '活跃').trim().toLowerCase(),
          address: (row.address || '').trim(),
          teamName: (row.team || '').trim(),
          staffName: (row.staff || '').trim(),
          email: (row.email || '').trim(),
          remark: (row.remark || '').trim()
        };

        if (!data.name) {
          errorMsgList.push(`第${rowNum}行：客户姓名不能为空`);
          return;
        }
        if (isNaN(data.age) || data.age < 1 || data.age > 120) {
          errorMsgList.push(`第${rowNum}行：年龄需为1-120的数字`);
          return;
        }
        if (!/^\d{7,11}$/.test(data.contact)) {
          errorMsgList.push(`第${rowNum}行：联系方式需为7-11位数字`);
          return;
        }
        if (existingContacts.has(data.contact)) {
          errorMsgList.push(`第${rowNum}行：联系方式已存在，跳过`);
          return;
        }
        // 根据团队名称查找团队ID
        const team = this.teamList.find(item => item.name === data.teamName);
        if (!team) {
          errorMsgList.push(`第${rowNum}行：负责团队不存在`);
          return;
        }
        data.teamId = team.id;
        // 根据员工名称和团队ID查找员工
        const staff = this.staffList.find(item => 
          item.name === data.staffName && Number(item.teamId) === Number(team.id)
        );
        if (!staff) {
          errorMsgList.push(`第${rowNum}行：负责员工不存在或不属于该团队`);
          return;
        }
        data.userId = staff.id;
        if (!this.validStatus.includes(data.status)) {
          data.status = 'active';
        }

        validData.push(data);
        existingContacts.add(data.contact);
      });

      return { validData, errorMsgList };
    },

    async handleExcelImport() {
      if (!this.selectedFile) return;

      try {
        this.isImporting = true;
        const rawData = await this.parseExcel(this.selectedFile);
        if (rawData.length === 0) {
          alert('Excel文件中无有效数据！');
          return;
        }

        const { validData, errorMsgList } = this.validateImportData(rawData);
        
        if (errorMsgList.length > 0) {
          alert(`导入校验提示：\n${errorMsgList.join('\n')}`);
        }

        if (validData.length === 0) {
          alert('没有可导入的有效数据！');
          return;
        }

        // 可选：批量导入接口调用
        // await request.post('/customer/batchAdd', validData);

        // 本地导入
        const newCustomers = validData.map(data => {
          const newId = `CUST${(this.customers.length + 1).toString().padStart(3, '0')}`;
          return {
            id: newId,
            name: data.name,
            age: data.age,
            contact: data.contact,
            status: data.status,
            createTime: new Date().toLocaleString('zh-CN', {
              year: 'numeric',
              month: '2-digit',
              day: '2-digit',
              hour: '2-digit',
              minute: '2-digit'
            }),
            address: data.address,
            teamId: data.teamId,
            userId: data.userId,
            email: data.email,
            remark: data.remark
          };
        });

        this.customers.unshift(...newCustomers);

        alert(`导入完成！\n总数据：${rawData.length}条\n成功导入：${validData.length}条\n跳过无效/重复：${rawData.length - validData.length}条`);
        this.closeExcelModal();
      } catch (error) {
        alert('导入失败：' + error);
        console.error('导入错误：', error);
      } finally {
        this.isImporting = false;
      }
    }
  }
};
</script>

<style scoped>
/* 样式部分保持不变 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
}

.customer-container {
  min-height: 100vh;
  background-color: #f5f7fa;
}

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

.main-content {
  padding: 1.5rem;
  max-width: 1400px;
  margin: 0 auto;
}

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

.query-actions {
  display: flex;
  gap: 0.75rem;
  margin-left: auto;
  margin-bottom: 0.6rem;
}

.content-card {
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  overflow: hidden;
}

.table-container {
  overflow-x: auto;
}

.customer-table {
  width: 100%;
  border-collapse: collapse;
  min-width: 800px;
}

.customer-table th {
  background-color: #fafafa;
  padding: 1rem;
  text-align: left;
  font-size: 0.9rem;
  color: #2c3e50;
  font-weight: 600;
  border-bottom: 1px solid #e8e8e8;
}

.customer-table td {
  padding: 1rem;
  border-bottom: 1px solid #e8e8e8;
  font-size: 0.85rem;
  color: #595959;
}

.customer-table tr:hover {
  background-color: #fafafa;
}

.customer-id {
  font-family: 'Courier New', monospace;
  color: #1890ff;
  font-weight: 600;
}

.customer-name {
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

.status-badge {
  padding: 0.25rem 0.75rem;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 500;
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

.status-badge.vip {
  background-color: #fff7e6;
  color: #fa8c16;
  border: 1px solid #ffd591;
}

.actions-col {
  width: 220px;
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

.btn-action.detail {
  background-color: #f0f7ff;
  color: #1890ff;
  border: 1px solid #91d5ff;
}

.btn-action.detail:hover {
  background-color: #bae7ff;
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

.detail-modal {
  max-width: 700px;
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

.customer-form {
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

.form-actions {
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
  margin-top: 2rem;
}

.detail-card {
  background-color: #fafafa;
  border-radius: 8px;
  padding: 1.5rem;
}

.detail-header {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 2rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #e8e8e8;
}

.detail-avatar {
  width: 64px;
  height: 64px;
  border-radius: 50%;
  background-color: #1890ff;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.5rem;
  font-weight: 600;
}

.detail-title {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.detail-title h4 {
  font-size: 1.3rem;
  color: #2c3e50;
  font-weight: 600;
}

.detail-content {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.detail-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.5rem;
}

.detail-row.full-width {
  grid-template-columns: 1fr;
}

.detail-item {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.detail-label {
  font-size: 0.9rem;
  color: #8c8c8c;
  font-weight: 500;
}

.detail-value {
  font-size: 1rem;
  color: #2c3e50;
  font-weight: 500;
}

.import-tips {
  background-color: #f0f7ff;
  border-radius: 6px;
  padding: 1rem;
  margin-bottom: 1.5rem;
}

.tips-title {
  font-size: 0.9rem;
  color: #1890ff;
  font-weight: 600;
  margin-bottom: 0.5rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.tips-list {
  list-style: disc;
  padding-left: 1.5rem;
  font-size: 0.85rem;
  color: #595959;
  line-height: 1.6;
}

.template-download {
  margin-bottom: 1.5rem;
}

.template-desc {
  font-size: 0.8rem;
  color: #8c8c8c;
  margin-top: 0.5rem;
}

.file-upload-section {
  margin-bottom: 1.5rem;
}

.file-upload-area {
  margin-top: 0.5rem;
}

.upload-label {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 2rem;
  border: 2px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s;
  background-color: #fafafa;
}

.upload-label:hover {
  border-color: #1890ff;
  background-color: #f0f7ff;
}

.upload-label i {
  font-size: 2rem;
  margin-bottom: 1rem;
}

.upload-text {
  font-size: 0.9rem;
  color: #595959;
  margin-bottom: 0.5rem;
  font-weight: 500;
}

.upload-hint {
  font-size: 0.8rem;
  color: #8c8c8c;
}

.file-input {
  display: none;
}

.selected-file {
  display: flex;
  align-items: center;
  gap: 0.8rem;
  padding: 0.8rem;
  background-color: #fafafa;
  border-radius: 6px;
  margin-top: 1rem;
  font-size: 0.85rem;
}

.file-name {
  flex: 1;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  color: #595959;
}

.remove-file-btn {
  background: none;
  border: none;
  color: #8c8c8c;
  cursor: pointer;
  padding: 0.3rem;
  border-radius: 4px;
  transition: all 0.3s;
}

.remove-file-btn:hover {
  color: #ff4d4f;
  background-color: #fff2f0;
}

.import-actions {
  margin-top: 1rem;
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

  .detail-row {
    grid-template-columns: 1fr;
    gap: 1rem;
  }

  .detail-avatar {
    width: 48px;
    height: 48px;
    font-size: 1.2rem;
  }
}
</style>

<!-- 引入Font Awesome和XLSX库 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">
<script src="https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js"></script>