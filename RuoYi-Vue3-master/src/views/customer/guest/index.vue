<template>
  <div class="customer-container">
    <!-- 顶部导航栏 -->
    <nav class="navbar">
      <div class="navbar-brand">
        <div class="logo">
          <i class="fas fa-chart-network"></i>
          <h1>先锋互联</h1>
        </div>
      </div>
      <div class="navbar-menu">
        <a href="#" class="navbar-item">
          <i class="fas fa-home"></i>
          <span>主页</span>
        </a>
        <a href="#" class="navbar-item">
          <i class="fas fa-sitemap"></i>
          <span>公司架构</span>
        </a>
        <a href="#" class="navbar-item active">
          <i class="fas fa-users"></i>
          <span>客户</span>
        </a>
      </div>
      <div class="navbar-user">
        <div class="user-info">
          <div class="user-avatar">
            <i class="fas fa-user-circle"></i>
          </div>
          <span class="user-name">管理员</span>
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
              <tr v-for="(customer, index) in filteredCustomers" :key="index + customer.id">
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
            共 {{ filteredCustomers.length }} 条记录
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
                  pattern="\d{7,11}"
                  title="联系方式需为7-11位数字"
                >
              </div>
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
              <button type="submit" class="btn btn-primary">
                确认添加
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
                  pattern="\d{7,11}"
                  title="联系方式需为7-11位数字"
                >
              </div>
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
              <button type="submit" class="btn btn-primary">
                确认修改
              </button>
            </div>
          </form>
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
          <!-- 导入说明 -->
          <div class="import-tips">
            <p class="tips-title"><i class="fas fa-info-circle text-primary"></i> 导入说明</p>
            <ul class="tips-list">
              <li>支持.xlsx/.xls格式，单个文件最大5MB</li>
              <li>必填字段：客户姓名、年龄（1-120）、联系方式（7-11位数字）</li>
              <li>状态仅支持：活跃/非活跃/VIP，不填默认「活跃」</li>
              <li>重复联系方式会自动跳过</li>
            </ul>
          </div>

          <!-- 模板下载 -->
          <div class="template-download">
            <button class="btn btn-outline" @click="downloadTemplate">
              <i class="fas fa-download"></i>
              下载导入模板
            </button>
            <p class="template-desc">按模板格式填写，避免导入失败</p>
          </div>

          <!-- 文件上传 -->
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

            <!-- 已选文件 -->
            <div v-if="selectedFileName" class="selected-file">
              <i class="fas fa-file-excel text-success"></i>
              <span class="file-name">{{ selectedFileName }}</span>
              <button type="button" class="remove-file-btn" @click="clearSelectedFile">
                <i class="fas fa-times"></i>
              </button>
            </div>
          </div>

          <!-- 导入按钮 -->
          <div class="form-actions import-actions">
            <button type="button" class="btn btn-outline" @click="closeExcelModal">
              取消
            </button>
            <button 
              class="btn btn-primary"
              @click="handleExcelImport"
              :disabled="!selectedFile"
            >
              <i class="fas fa-upload"></i>
              开始导入
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// 修复：使用CDN引入xlsx（避免npm依赖问题）
const XLSX = window.XLSX || {};

export default {
  name: 'CustomerManagement',
  data() {
    return {
      // 弹窗控制
      showAddCustomer: false,
      showEditCustomer: false,
      showExcelImport: false,
      // 分页与查询
      currentPage: 1,
      pageSize: 10,
      queryParams: {
        name: '',
        contact: '',
        status: ''
      },
      // 表单数据
      newCustomer: {
        name: '',
        age: '',
        contact: '',
        status: 'active' // 默认活跃
      },
      editCustomerData: {
        id: '',
        name: '',
        age: '',
        contact: '',
        status: 'active'
      },
      // 客户列表数据
      customers: [
        { id: 'CUST001', name: '张三', age: 30, contact: '2222222', status: 'active', createTime: '2024-10-22 09:30' },
        { id: 'CUST002', name: '李四', age: 44, contact: '2222223', status: 'vip', createTime: '2024-10-23 14:15' },
        { id: 'CUST003', name: '王五', age: 26, contact: '2222224', status: 'active', createTime: '2024-10-23 16:20' },
        { id: 'CUST004', name: '赵六', age: 43, contact: '2222225', status: 'inactive', createTime: '2024-10-24 10:10' }
      ],
      // Excel导入相关
      selectedFile: null,
      selectedFileName: '',
      validStatus: ['active', 'inactive', 'vip']
    };
  },
  computed: {
    // 过滤客户列表
    filteredCustomers() {
      let result = [...this.customers];
      // 姓名过滤
      if (this.queryParams.name.trim()) {
        const name = this.queryParams.name.trim().toLowerCase();
        result = result.filter(cust => cust.name.toLowerCase().includes(name));
      }
      // 联系方式过滤
      if (this.queryParams.contact.trim()) {
        const contact = this.queryParams.contact.trim();
        result = result.filter(cust => cust.contact.includes(contact));
      }
      // 状态过滤
      if (this.queryParams.status) {
        result = result.filter(cust => cust.status === this.queryParams.status);
      }
      // 分页处理
      const start = (this.currentPage - 1) * this.pageSize;
      return result.slice(start, start + this.pageSize);
    },
    // 总页数
    totalPages() {
      return Math.ceil(this.customers.length / this.pageSize);
    }
  },
  methods: {
    // ===================== 基础功能 =====================
    // 关闭新增弹窗
    closeAddModal() {
      this.showAddCustomer = false;
      this.resetNewCustomer();
    },
    // 关闭编辑弹窗
    closeEditModal() {
      this.showEditCustomer = false;
    },
    // 关闭Excel弹窗
    closeExcelModal() {
      this.showExcelImport = false;
      this.clearSelectedFile();
    },
    // 重置新增表单
    resetNewCustomer() {
      this.newCustomer = {
        name: '',
        age: '',
        contact: '',
        status: 'active'
      };
    },
    // 获取状态文本
    getStatusText(status) {
      const map = { active: '活跃', inactive: '非活跃', vip: 'VIP' };
      return map[status] || '未知';
    },

    // ===================== 客户操作 =====================
    // 新增客户
    addCustomer() {
      // 前端二次校验
      if (!this.newCustomer.name.trim()) {
        alert('客户姓名不能为空！');
        return;
      }
      if (!this.newCustomer.age || this.newCustomer.age < 1 || this.newCustomer.age > 120) {
        alert('年龄需为1-120的数字！');
        return;
      }
      if (!/^\d{7,11}$/.test(this.newCustomer.contact.trim())) {
        alert('联系方式需为7-11位数字！');
        return;
      }
      // 检查联系方式重复
      const isDuplicate = this.customers.some(cust => cust.contact === this.newCustomer.contact.trim());
      if (isDuplicate) {
        alert('该联系方式已存在！');
        return;
      }

      // 生成客户ID
      const newId = `CUST${(this.customers.length + 1).toString().padStart(3, '0')}`;
      // 新增客户
      this.customers.unshift({
        id: newId,
        name: this.newCustomer.name.trim(),
        age: Number(this.newCustomer.age),
        contact: this.newCustomer.contact.trim(),
        status: this.newCustomer.status,
        createTime: new Date().toLocaleString('zh-CN', {
          year: 'numeric',
          month: '2-digit',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit'
        })
      });

      alert('客户添加成功！');
      this.closeAddModal();
    },
    // 编辑客户（加载数据）
    editCustomer(customer) {
      this.editCustomerData = { ...customer };
      this.showEditCustomer = true;
    },
    // 更新客户
    updateCustomer() {
      // 校验
      if (!this.editCustomerData.name.trim()) {
        alert('客户姓名不能为空！');
        return;
      }
      if (!this.editCustomerData.age || this.editCustomerData.age < 1 || this.editCustomerData.age > 120) {
        alert('年龄需为1-120的数字！');
        return;
      }
      if (!/^\d{7,11}$/.test(this.editCustomerData.contact.trim())) {
        alert('联系方式需为7-11位数字！');
        return;
      }
      // 检查联系方式重复（排除自身）
      const isDuplicate = this.customers.some(
        cust => cust.contact === this.editCustomerData.contact.trim() && cust.id !== this.editCustomerData.id
      );
      if (isDuplicate) {
        alert('该联系方式已存在！');
        return;
      }

      // 查找并更新
      const index = this.customers.findIndex(cust => cust.id === this.editCustomerData.id);
      if (index !== -1) {
        this.customers[index] = {
          ...this.customers[index],
          name: this.editCustomerData.name.trim(),
          age: Number(this.editCustomerData.age),
          contact: this.editCustomerData.contact.trim(),
          status: this.editCustomerData.status
        };
        alert('客户修改成功！');
        this.closeEditModal();
      }
    },
    // 删除客户
    deleteCustomer(custId) {
      if (confirm('确定要删除该客户吗？删除后不可恢复！')) {
        this.customers = this.customers.filter(cust => cust.id !== custId);
        alert('客户删除成功！');
        // 重置分页（避免删除后无数据）
        if (this.filteredCustomers.length === 0 && this.currentPage > 1) {
          this.currentPage--;
        }
      }
    },

    // ===================== 查询与分页 =====================
    // 搜索查询
    handleQuery() {
      this.currentPage = 1; // 重置到第一页
    },
    // 重置查询条件
    handleReset() {
      this.queryParams = { name: '', contact: '', status: '' };
      this.currentPage = 1;
    },
    // 上一页
    prevPage() {
      if (this.currentPage > 1) {
        this.currentPage--;
      }
    },
    // 下一页
    nextPage() {
      if (this.currentPage < this.totalPages) {
        this.currentPage++;
      }
    },

    // ===================== Excel导入 =====================
    // 下载模板
    downloadTemplate() {
      try {
        // 模板数据
        const templateData = [
          { '客户姓名': '示例1', '年龄': 30, '联系方式': '13800138001', '状态（活跃/非活跃/VIP）': '活跃' },
          { '客户姓名': '示例2', '年龄': 45, '联系方式': '13900139002', '状态（活跃/非活跃/VIP）': 'VIP' }
        ];
        // 创建工作表
        const ws = XLSX.utils.json_to_sheet(templateData);
        // 创建工作簿
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, '客户模板');
        // 下载
        XLSX.writeFile(wb, '客户导入模板.xlsx');
      } catch (error) {
        alert('模板下载失败，请手动创建Excel（表头：客户姓名、年龄、联系方式、状态）');
        console.error('模板下载错误：', error);
      }
    },
    // 选择文件
    handleFileSelect(e) {
      const file = e.target.files[0];
      if (!file) return;

      // 校验格式
      const ext = file.name.split('.').pop().toLowerCase();
      if (!['xlsx', 'xls'].includes(ext)) {
        alert('请选择.xlsx或.xls格式的文件！');
        e.target.value = '';
        return;
      }
      // 校验大小（5MB）
      if (file.size > 5 * 1024 * 1024) {
        alert('文件大小不能超过5MB！');
        e.target.value = '';
        return;
      }

      // 保存文件信息
      this.selectedFile = file;
      this.selectedFileName = file.name;
    },
    // 清空已选文件
    clearSelectedFile() {
      this.selectedFile = null;
      this.selectedFileName = '';
      const fileInput = document.getElementById('excelFile');
      if (fileInput) fileInput.value = '';
    },
    // 解析Excel数据
    parseExcel(file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = (e) => {
          try {
            const data = new Uint8Array(e.target.result);
            const wb = XLSX.read(data, { type: 'array' });
            // 读取第一个工作表
            const wsName = wb.SheetNames[0];
            const ws = wb.Sheets[wsName];
            // 转换为JSON（表头映射）
            const jsonData = XLSX.utils.sheet_to_json(ws, {
              header: ['name', 'age', 'contact', 'status'], // 对应Excel列：姓名、年龄、联系方式、状态
              skipHeader: 1 // 跳过第一行表头
            });
            // 过滤空行
            const validRows = jsonData.filter(row => 
              row.name || row.age || row.contact || row.status
            );
            resolve(validRows);
          } catch (error) {
            reject('文件解析失败：' + error.message);
          }
        };
        reader.onerror = () => reject('文件读取失败，请检查文件是否损坏');
        reader.readAsArrayBuffer(file);
      });
    },
    // 校验导入数据
    validateImportData(rawData) {
      const validData = [];
      const existingContacts = new Set(this.customers.map(cust => cust.contact));
      const errorMsgList = [];

      rawData.forEach((row, index) => {
        const rowNum = index + 2; // Excel行号（跳过表头，从第2行开始）
        const data = {
          name: (row.name || '').trim(),
          age: Number(row.age) || 0,
          contact: (row.contact || '').trim(),
          status: (row.status || '活跃').trim().toLowerCase()
        };

        // 校验姓名
        if (!data.name) {
          errorMsgList.push(`第${rowNum}行：客户姓名不能为空`);
          return;
        }
        // 校验年龄
        if (isNaN(data.age) || data.age < 1 || data.age > 120) {
          errorMsgList.push(`第${rowNum}行：年龄需为1-120的数字`);
          return;
        }
        // 校验联系方式
        if (!/^\d{7,11}$/.test(data.contact)) {
          errorMsgList.push(`第${rowNum}行：联系方式需为7-11位数字`);
          return;
        }
        // 校验重复联系方式
        if (existingContacts.has(data.contact)) {
          errorMsgList.push(`第${rowNum}行：联系方式已存在，跳过`);
          return;
        }
        // 校验状态（自动修正）
        if (!this.validStatus.includes(data.status)) {
          data.status = 'active'; // 默认活跃
        }

        // 有效数据
        validData.push(data);
        existingContacts.add(data.contact);
      });

      return { validData, errorMsgList };
    },
    // 处理Excel导入
    async handleExcelImport() {
      if (!this.selectedFile) return;

      try {
        // 解析文件
        const rawData = await this.parseExcel(this.selectedFile);
        if (rawData.length === 0) {
          alert('Excel文件中无有效数据！');
          return;
        }

        // 校验数据
        const { validData, errorMsgList } = this.validateImportData(rawData);
        
        // 显示错误信息
        if (errorMsgList.length > 0) {
          alert(`导入校验提示：\n${errorMsgList.join('\n')}`);
        }

        // 无有效数据
        if (validData.length === 0) {
          alert('没有可导入的有效数据！');
          return;
        }

        // 批量添加客户
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
            })
          };
        });

        // 添加到列表
        this.customers.unshift(...newCustomers);

        // 导入结果提示
        alert(`导入完成！\n总数据：${rawData.length}条\n成功导入：${validData.length}条\n跳过无效/重复：${rawData.length - validData.length}条`);
        
        // 关闭弹窗并重置
        this.closeExcelModal();
      } catch (error) {
        alert('导入失败：' + error);
        console.error('导入错误：', error);
      }
    }
  },
  // 初始化：检查xlsx依赖
  mounted() {
    // 若未加载xlsx，动态引入CDN
    if (!window.XLSX) {
      const script = document.createElement('script');
      script.src = 'https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js';
      script.onload = () => {
        console.log('XLSX库加载成功');
      };
      script.onerror = () => {
        alert('Excel导入功能依赖的XLSX库加载失败，导入功能可能无法使用');
      };
      document.head.appendChild(script);
    }
  }
};
</script>

<style scoped>
/* 基础样式重置 */
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

/* 导航栏样式 */
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
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

.navbar-menu {
  display: flex;
  gap: 2rem;
}

.navbar-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.6rem 1rem;
  border-radius: 6px;
  color: #7f8c8d;
  text-decoration: none;
  font-weight: 500;
  transition: all 0.3s;
}

.navbar-item:hover, .navbar-item.active {
  color: #1890ff;
  background-color: #e3f2fd;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.5rem 1rem;
  border-radius: 6px;
  transition: background-color 0.3s;
}

.user-info:hover {
  background-color: #f8f9fa;
}

.user-avatar i {
  font-size: 2rem;
  color: #7f8c8d;
}

.user-name {
  color: #2c3e50;
  font-weight: 500;
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

/* 按钮基础样式 */
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
}

/* 表格样式 */
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

/* 表格单元格样式 */
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

/* Excel导入弹窗样式 */
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
    flex-direction: column;
    padding: 1rem;
    gap: 1rem;
  }

  .navbar-menu {
    gap: 1rem;
    width: 100%;
    justify-content: center;
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
}
</style>

<!-- 引入Font Awesome图标库（确保图标正常显示） -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">
<!-- 引入XLSX库（Excel解析依赖） -->
<script src="https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js"></script>