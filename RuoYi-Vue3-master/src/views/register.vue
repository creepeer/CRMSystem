<template>
  <div class="register-container">
    <!-- 导航栏 -->
    <nav class="navbar">
      <div class="navbar-brand">
        <div class="logo">
          <i class="fas fa-building"></i>
          <h1>企业管理系统</h1>
        </div>
      </div>
    </nav>

    <!-- 主要内容区域 -->
    <main class="main-content">
      <!-- 页面标题 -->
      <div class="page-header">
        <div class="header-content">
          <h2 class="page-title">企业注册</h2>
          <p class="page-subtitle">填写企业信息完成注册</p>
        </div>
        <div class="actions">
          <button class="btn btn-outline" @click="goBack">
            <i class="fas fa-arrow-left"></i>
            返回登录
          </button>
        </div>
      </div>

      <!-- 注册表单卡片 -->
      <div class="content-card">
        <form @submit.prevent="handleRegister" class="register-form" ref="formRef">
          <!-- 两列布局 -->
          <div class="form-row">
            <!-- 左列 -->
            <div class="form-column">
              <div class="form-group">
                <label for="name" class="form-label required">企业名称</label>
                <input 
                  type="text" 
                  id="name"
                  v-model="registerForm.name"
                  placeholder="请输入企业名称"
                  class="form-input"
                  :class="{ 'error': errors.name }"
                  @blur="validateField('name')"
                  @input="clearError('name')"
                >
                <div v-if="errors.name" class="error-message">
                  {{ errors.name }}
                </div>
              </div>

              <div class="form-group">
                <label for="address" class="form-label required">企业地址</label>
                <input 
                  type="text" 
                  id="address"
                  v-model="registerForm.address"
                  placeholder="请输入企业地址"
                  class="form-input"
                  :class="{ 'error': errors.address }"
                  @blur="validateField('address')"
                  @input="clearError('address')"
                >
                <div v-if="errors.address" class="error-message">
                  {{ errors.address }}
                </div>
              </div>

              <div class="form-group">
                <label for="license" class="form-label required">营业执照</label>
                <div class="file-upload-group">
                  <input 
                    type="text" 
                    id="license"
                    v-model="registerForm.license"
                    placeholder="营业执照文件路径"
                    class="form-input"
                    :class="{ 'error': errors.license }"
                    readonly
                    @blur="validateField('license')"
                  >
                  <label for="licenseFile" class="upload-label">
                    <i class="fas fa-cloud-upload-alt"></i>
                    选择文件
                    <input 
                      type="file" 
                      id="licenseFile"
                      accept="image/*"
                      @change="onLicenseChange"
                      class="file-input"
                    >
                  </label>
                </div>
                <div v-if="errors.license" class="error-message">
                  {{ errors.license }}
                </div>
              </div>

              <div class="form-group">
                <label for="leName" class="form-label required">法人姓名</label>
                <input 
                  type="text" 
                  id="leName"
                  v-model="registerForm.leName"
                  placeholder="请输入法人姓名"
                  class="form-input"
                  :class="{ 'error': errors.leName }"
                  @blur="validateField('leName')"
                  @input="clearError('leName')"
                >
                <div v-if="errors.leName" class="error-message">
                  {{ errors.leName }}
                </div>
              </div>

              <div class="form-group">
                <label for="username" class="form-label required">管理员账号</label>
                <input 
                  type="text" 
                  id="username"
                  v-model="registerForm.username"
                  placeholder="请输入管理员账号"
                  class="form-input"
                  :class="{ 'error': errors.username }"
                  @blur="validateField('username')"
                  @input="clearError('username')"
                >
                <div v-if="errors.username" class="error-message">
                  {{ errors.username }}
                </div>
              </div>
            </div>

            <!-- 右列 -->
            <div class="form-column">
              <div class="form-group">
                <label for="leAge" class="form-label required">法人年龄</label>
                <div class="age-input-group">
                  <button 
                    type="button" 
                    class="age-btn" 
                    @click="registerForm.leAge > 0 ? registerForm.leAge-- : 0; validateField('leAge')"
                  >
                    <i class="fas fa-minus"></i>
                  </button>
                  <input 
                    type="number" 
                    id="leAge"
                    v-model.number="registerForm.leAge"
                    min="0"
                    max="150"
                    class="form-input age-input"
                    :class="{ 'error': errors.leAge }"
                    @blur="validateField('leAge')"
                    @input="clearError('leAge')"
                  >
                  <button 
                    type="button" 
                    class="age-btn" 
                    @click="registerForm.leAge < 150 ? registerForm.leAge++ : 150; validateField('leAge')"
                  >
                    <i class="fas fa-plus"></i>
                  </button>
                </div>
                <div v-if="errors.leAge" class="error-message">
                  {{ errors.leAge }}
                </div>
              </div>

              <div class="form-group">
                <label for="leCard" class="form-label required">法人身份证</label>
                <input 
                  type="text" 
                  id="leCard"
                  v-model="registerForm.leCard"
                  placeholder="请输入法人身份证号码"
                  class="form-input"
                  :class="{ 'error': errors.leCard }"
                  @blur="validateField('leCard')"
                  @input="clearError('leCard')"
                >
                <div v-if="errors.leCard" class="error-message">
                  {{ errors.leCard }}
                </div>
              </div>

              <div class="form-group">
                <label for="lePhone" class="form-label required">法人电话</label>
                <input 
                  type="tel" 
                  id="lePhone"
                  v-model="registerForm.lePhone"
                  placeholder="请输入法人手机号码"
                  class="form-input"
                  :class="{ 'error': errors.lePhone }"
                  @blur="validateField('lePhone')"
                  @input="clearError('lePhone')"
                >
                <div v-if="errors.lePhone" class="error-message">
                  {{ errors.lePhone }}
                </div>
              </div>

              <div class="form-group">
                <label for="leEmail" class="form-label required">法人邮箱</label>
                <input 
                  type="email" 
                  id="leEmail"
                  v-model="registerForm.leEmail"
                  placeholder="请输入法人邮箱"
                  class="form-input"
                  :class="{ 'error': errors.leEmail }"
                  @blur="validateField('leEmail')"
                  @input="clearError('leEmail')"
                >
                <div v-if="errors.leEmail" class="error-message">
                  {{ errors.leEmail }}
                </div>
              </div>

              <div class="form-group">
                <label for="password" class="form-label required">管理员密码</label>
                <div class="password-group">
                  <input 
                    :type="showPassword ? 'text' : 'password'"
                    id="password"
                    v-model="registerForm.password"
                    placeholder="请输入管理员密码"
                    class="form-input"
                    :class="{ 'error': errors.password }"
                    @blur="validateField('password')"
                    @input="clearError('password')"
                  >
                  <button 
                    type="button" 
                    class="password-toggle"
                    @click="showPassword = !showPassword"
                  >
                    <i :class="showPassword ? 'fas fa-eye-slash' : 'fas fa-eye'"></i>
                  </button>
                </div>
                <div v-if="errors.password" class="error-message">
                  {{ errors.password }}
                </div>
              </div>
            </div>
          </div>

          <!-- 第二行（确认密码和状态） -->
          <div class="form-row">
            <div class="form-column">
              <div class="form-group">
                <label for="confirmPassword" class="form-label required">确认密码</label>
                <div class="password-group">
                  <input 
                    :type="showConfirmPassword ? 'text' : 'password'"
                    id="confirmPassword"
                    v-model="registerForm.confirmPassword"
                    placeholder="请再次输入密码"
                    class="form-input"
                    :class="{ 'error': errors.confirmPassword }"
                    @blur="validateField('confirmPassword')"
                    @input="clearError('confirmPassword')"
                    @keyup.enter="handleRegister"
                  >
                  <button 
                    type="button" 
                    class="password-toggle"
                    @click="showConfirmPassword = !showConfirmPassword"
                  >
                    <i :class="showConfirmPassword ? 'fas fa-eye-slash' : 'fas fa-eye'"></i>
                  </button>
                </div>
                <div v-if="errors.confirmPassword" class="error-message">
                  {{ errors.confirmPassword }}
                </div>
              </div>
            </div>

            <div class="form-column">
              <div class="form-group">
                <label for="state" class="form-label required">账号状态</label>
                <div class="status-options">
                  <label class="status-option">
                    <input 
                      type="radio" 
                      v-model="registerForm.state" 
                      :value="1" 
                      class="status-radio"
                      @change="validateField('state')"
                    >
                    <span class="status-label">
                      <i class="fas fa-check-circle"></i>
                      启用
                    </span>
                  </label>
                  <label class="status-option">
                    <input 
                      type="radio" 
                      v-model="registerForm.state" 
                      :value="0" 
                      class="status-radio"
                      @change="validateField('state')"
                    >
                    <span class="status-label">
                      <i class="fas fa-times-circle"></i>
                      禁用
                    </span>
                  </label>
                </div>
                <div v-if="errors.state" class="error-message">
                  {{ errors.state }}
                </div>
              </div>
            </div>
          </div>

          <!-- 备注 -->
          <div class="form-group">
            <label for="remark" class="form-label">备注信息</label>
            <textarea 
              id="remark"
              v-model="registerForm.remark"
              placeholder="填写企业备注信息（选填）"
              class="form-textarea"
              rows="3"
            ></textarea>
          </div>

          <!-- 提交按钮 -->
          <div class="form-actions">
            <button 
              type="button" 
              class="btn btn-outline" 
              @click="goBack"
              :disabled="loading"
            >
              取消
            </button>
            <button 
              type="submit" 
              class="btn btn-primary" 
              :disabled="loading"
            >
              <i v-if="loading" class="fas fa-spinner fa-spin"></i>
              <i v-else class="fas fa-user-plus"></i>
              {{ loading ? "注册中..." : "立即注册" }}
            </button>
          </div>
        </form>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ElMessage, ElMessageBox } from "element-plus"
import { register } from "@/api/login"
import { ref, reactive } from "vue"

const router = useRouter()
const { proxy } = getCurrentInstance()

const registerForm = reactive({
  // 企业
  name: "",
  address: "",
  license: "",
  state: 1,
  remark: "",

  // 法人
  leName: "",
  leEmail: "",
  lePhone: "",
  leCard: "",
  leAge: 18,

  // 管理员
  username: "",
  password: "",

  // 前端校验用（不提交）
  confirmPassword: ""
})

const loading = ref(false)
const showPassword = ref(false)
const showConfirmPassword = ref(false)
const errors = reactive({})

const validationRules = {
  name: { required: true, message: "请输入企业名称" },
  address: { required: true, message: "请输入企业地址" },
  license: { required: true, message: "请选择营业执照文件" },
  leName: { required: true, message: "请输入法人姓名" },
  leAge: { required: true, message: "请输入法人年龄" },
  leCard: { required: true, message: "请输入法人身份证" },
  lePhone: { 
    required: true, 
    message: "请输入法人电话",
    pattern: /^1\d{10}$/,
    patternMessage: "手机号格式不正确"
  },
  leEmail: { 
    required: true, 
    message: "请输入法人邮箱",
    pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
    patternMessage: "邮箱格式不正确"
  },
  username: { required: true, message: "请输入管理员账号" },
  password: { 
    required: true, 
    message: "请输入管理员密码",
    minLength: 6,
    maxLength: 30,
    lengthMessage: "密码长度建议 6-30 位",
    pattern: /^[^<>"'|\\]+$/,
    patternMessage: "不能包含非法字符：< > \" ' \\ |"
  },
  confirmPassword: { 
    required: true, 
    message: "请再次输入管理员密码",
    match: "password",
    matchMessage: "两次输入的密码不一致"
  },
  state: { required: true, message: "请选择账号状态" }
}

function validateField(field) {
  const rule = validationRules[field]
  const value = registerForm[field]
  
  // 清除之前的错误
  delete errors[field]
  
  // 必填验证
  if (rule.required && (value === "" || value === undefined || value === null)) {
    errors[field] = rule.message
    return false
  }
  
  // 手机号格式验证
  if (field === 'lePhone' && value && rule.pattern && !rule.pattern.test(value)) {
    errors[field] = rule.patternMessage
    return false
  }
  
  // 邮箱格式验证
  if (field === 'leEmail' && value && rule.pattern && !rule.pattern.test(value)) {
    errors[field] = rule.patternMessage
    return false
  }
  
  // 密码长度验证
  if (field === 'password' && value) {
    if (rule.minLength && value.length < rule.minLength) {
      errors[field] = rule.lengthMessage
      return false
    }
    if (rule.maxLength && value.length > rule.maxLength) {
      errors[field] = rule.lengthMessage
      return false
    }
    if (rule.pattern && !rule.pattern.test(value)) {
      errors[field] = rule.patternMessage
      return false
    }
  }
  
  // 确认密码验证
  if (field === 'confirmPassword' && rule.match && value !== registerForm[rule.match]) {
    errors[field] = rule.matchMessage
    return false
  }
  
  return true
}

function clearError(field) {
  if (errors[field]) {
    delete errors[field]
  }
}

function validateForm() {
  let isValid = true
  
  // 验证所有字段
  Object.keys(validationRules).forEach(field => {
    if (!validateField(field)) {
      isValid = false
    }
  })
  
  return isValid
}

function onLicenseChange(event) {
  const file = event.target.files[0]
  if (file) {
    // 文件验证
    if (file.size > 5 * 1024 * 1024) {
      errors.license = "文件大小不能超过5MB"
      return
    }
    if (!file.type.startsWith('image/')) {
      errors.license = "请选择图片文件"
      return
    }
    
    // 显示文件名
    registerForm.license = file.name
    clearError('license')
    
    // 实际开发中这里应该上传文件到服务器
    // const formData = new FormData()
    // formData.append('file', file)
    // uploadLicense(formData).then(res => {
    //   registerForm.license = res.data.url
    // })
  }
}

async function handleRegister() {
  // 验证表单
  if (!validateForm()) {
    // 如果表单验证失败，滚动到第一个错误位置
    const firstErrorField = Object.keys(errors)[0]
    if (firstErrorField) {
      const element = document.getElementById(firstErrorField)
      if (element) {
        element.scrollIntoView({ behavior: 'smooth', block: 'center' })
        element.focus()
      }
    }
    ElMessage.warning("请正确填写所有必填项")
    return
  }

  loading.value = true

  const payload = {
    name: registerForm.name,
    address: registerForm.address,
    license: registerForm.license,
    leName: registerForm.leName,
    leEmail: registerForm.leEmail,
    lePhone: registerForm.lePhone,
    leCard: registerForm.leCard,
    state: registerForm.state,
    username: registerForm.username,
    password: registerForm.password,
    leAge: registerForm.leAge,
    remark: registerForm.remark
  }

  try {
    await register(payload)
    ElMessageBox.alert(
      `<div class="success-message">
        <i class="fas fa-check-circle"></i>
        <h3>注册成功！</h3>
        <p>管理员账号：<strong>${payload.username}</strong></p>
        <p class="success-tip">请使用该账号登录系统</p>
      </div>`,
      "系统提示",
      { 
        dangerouslyUseHTMLString: true,
        showConfirmButton: true,
        confirmButtonText: "前往登录",
        callback: () => router.push("/login")
      }
    )
  } catch (e) {
    ElMessage.error(e.message || "注册失败，请检查填写信息")
  } finally {
    loading.value = false
  }
}

function goBack() {
  router.push("/login")
}
</script>

<style scoped>
/* 基础样式重置 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
}

.register-container {
  min-height: 100vh;
  background-color: #f5f7fa;
}

/* 导航栏样式 */
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
  max-width: 1200px;
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

.btn-primary:hover:not(:disabled) {
  background-color: #40a9ff;
  box-shadow: 0 2px 8px rgba(24, 144, 255, 0.3);
}

.btn-primary:disabled {
  background-color: #bae7ff;
  cursor: not-allowed;
}

.btn-outline {
  background-color: transparent;
  border: 1px solid #d9d9d9;
  color: #595959;
}

.btn-outline:hover:not(:disabled) {
  border-color: #1890ff;
  color: #1890ff;
}

.btn-outline:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

/* 内容卡片 */
.content-card {
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  padding: 2rem;
}

/* 注册表单 */
.register-form {
  max-width: 900px;
  margin: 0 auto;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 2rem;
  margin-bottom: 1.5rem;
}

@media (max-width: 768px) {
  .form-row {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
}

.form-column {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
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

.form-input, .form-textarea {
  padding: 0.75rem 1rem;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  font-size: 0.85rem;
  transition: all 0.3s;
  width: 100%;
}

.form-input:focus, .form-textarea:focus {
  outline: none;
  border-color: #1890ff;
  box-shadow: 0 0 0 2px rgba(24, 144, 255, 0.1);
}

.form-input.error {
  border-color: #ff4d4f;
}

.form-input.error:focus {
  border-color: #ff4d4f;
  box-shadow: 0 0 0 2px rgba(255, 77, 79, 0.1);
}

.form-textarea {
  resize: vertical;
  min-height: 80px;
}

/* 文件上传样式 */
.file-upload-group {
  display: flex;
  gap: 0.75rem;
}

.upload-label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.6rem 1rem;
  background-color: #f5f5f5;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s;
  white-space: nowrap;
}

.upload-label:hover {
  background-color: #e6f7ff;
  border-color: #1890ff;
  color: #1890ff;
}

.upload-label i {
  font-size: 0.9rem;
}

.file-input {
  display: none;
}

/* 年龄输入样式 */
.age-input-group {
  display: flex;
  gap: 0.5rem;
  align-items: center;
}

.age-btn {
  width: 36px;
  height: 36px;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  background-color: #f5f5f5;
  color: #595959;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s;
}

.age-btn:hover {
  border-color: #1890ff;
  color: #1890ff;
}

.age-input {
  flex: 1;
  text-align: center;
  padding: 0.5rem;
}

/* 密码输入样式 */
.password-group {
  position: relative;
}

.password-toggle {
  position: absolute;
  right: 0.75rem;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  color: #8c8c8c;
  cursor: pointer;
  padding: 0.25rem;
}

.password-toggle:hover {
  color: #1890ff;
}

/* 状态选项样式 */
.status-options {
  display: flex;
  gap: 1rem;
}

.status-option {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
}

.status-radio {
  display: none;
}

.status-label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  transition: all 0.3s;
}

.status-radio:checked + .status-label {
  border-color: #1890ff;
  background-color: #e6f7ff;
  color: #1890ff;
}

.status-label i {
  font-size: 0.9rem;
}

/* 错误消息 */
.error-message {
  font-size: 0.75rem;
  color: #ff4d4f;
  margin-top: 0.25rem;
  animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-5px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 表单操作按钮 */
.form-actions {
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
  margin-top: 2rem;
  padding-top: 1.5rem;
  border-top: 1px solid #e8e8e8;
}

/* 成功消息样式 */
.success-message {
  text-align: center;
  padding: 1rem;
}

.success-message i {
  font-size: 3rem;
  color: #52c41a;
  margin-bottom: 1rem;
}

.success-message h3 {
  font-size: 1.2rem;
  color: #2c3e50;
  margin-bottom: 0.5rem;
}

.success-message p {
  color: #595959;
  margin-bottom: 0.5rem;
}

.success-message strong {
  color: #1890ff;
  font-size: 1.1rem;
}

.success-tip {
  color: #8c8c8c;
  font-size: 0.9rem;
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

  .content-card {
    padding: 1.5rem;
  }

  .form-row {
    gap: 1rem;
  }

  .file-upload-group {
    flex-direction: column;
  }

  .upload-label {
    justify-content: center;
  }

  .status-options {
    flex-direction: column;
    gap: 0.5rem;
  }

  .form-actions {
    flex-direction: column;
  }

  .form-actions .btn {
    width: 100%;
    justify-content: center;
  }
}
</style>

<!-- 引入Font Awesome图标库 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">