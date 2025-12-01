<template>
  <div class="register">
    <div class="register-container">
      <!-- 顶部标题区域 -->
      <div class="register-header">
        <div class="logo">🚀</div>
        <h1 class="system-title">先锋互联管理系统</h1>
      </div>

      <!-- 注册表单区域 -->
      <div class="register-form-wrapper">
        <h3 class="form-title">用户注册</h3>
        
        <el-form ref="registerRef" :model="registerForm" :rules="registerRules" class="register-form">
          
          <el-form-item prop="username">
            <el-input
              v-model="registerForm.username" 
              type="text" 
              size="large" 
              auto-complete="off" 
              placeholder="账号"
              class="custom-input"
            />
          </el-form-item>
          
          <el-form-item prop="password">
            <el-input
              v-model="registerForm.password"
              type="password"
              size="large" 
              auto-complete="off"
              placeholder="密码"
              class="custom-input"
              @keyup.enter="handleRegister"
            />
          </el-form-item>
          
          <el-form-item prop="confirmPassword">
            <el-input
              v-model="registerForm.confirmPassword"
              type="password"
              size="large" 
              auto-complete="off"
              placeholder="确认密码"
              class="custom-input"
              @keyup.enter="handleRegister"
            />
          </el-form-item>

          <el-form-item prop="companyCode">
            <el-input
              v-model="registerForm.companyCode"
              type="text"
              size="large"
              auto-complete="off"
              placeholder="公司编号"
              class="custom-input"
            />
          </el-form-item>          
          
          <el-form-item prop="code" v-if="captchaEnabled">
            <div class="code-wrapper">
              <el-input
                size="large" 
                v-model="registerForm.code"
                auto-complete="off"
                placeholder="验证码"
                class="custom-input code-input"
                @keyup.enter="handleRegister"
              />
              <div class="register-code">
                <img :src="codeUrl" @click="getCode" class="register-code-img"/>
              </div>
            </div>
          </el-form-item>
          
          <el-form-item class="btn-group">
            <el-button
              :loading="loading"
              size="large"
              class="register-btn"
              @click.prevent="handleRegister"
            >
              <span v-if="!loading">注 册</span>
              <span v-else>注 册 中...</span>
            </el-button>
          </el-form-item>
          
          <div class="login-link">
            <router-link class="link-type" :to="'/login'">
              使用已有账户登录
            </router-link>
          </div>
        </el-form>
      </div>
    </div>
    
    <!--  底部  -->
    <div class="el-register-footer">
      <span>Copyright © 2018-2025 ruoyi.vip All Rights Reserved.</span>
    </div>
  </div>
</template>

<script setup>
import { ElMessageBox } from "element-plus"
import { getCodeImg, register } from "@/api/login"

const title = import.meta.env.VITE_APP_TITLE
const router = useRouter()
const { proxy } = getCurrentInstance()

const registerForm = ref({
  companyCode: "",
  username: "",
  password: "",
  confirmPassword: "",
  code: "",
  uuid: ""
})

const equalToPassword = (rule, value, callback) => {
  if (registerForm.value.password !== value) {
    callback(new Error("两次输入的密码不一致"))
  } else {
    callback()
  }
}

const registerRules = {
  companyCode: [
    { required: true, trigger: "blur", message: "请输入公司编号" },
    { min: 2, max: 20, message: "公司编号长度必须介于 2 和 20 之间", trigger: "blur" }
  ],
  username: [
    { required: true, trigger: "blur", message: "请输入您的账号" },
    { min: 2, max: 20, message: "用户账号长度必须介于 2 和 20 之间", trigger: "blur" }
  ],
  password: [
    { required: true, trigger: "blur", message: "请输入您的密码" },
    { min: 5, max: 20, message: "用户密码长度必须介于 5 和 20 之间", trigger: "blur" },
    { pattern: /^[^<>"'|\\]+$/, message: "不能包含非法字符：< > \" ' \\\ |", trigger: "blur" }
  ],
  confirmPassword: [
    { required: true, trigger: "blur", message: "请再次输入您的密码" },
    { required: true, validator: equalToPassword, trigger: "blur" }
  ],
  code: [{ required: true, trigger: "change", message: "请输入验证码" }]
}

const codeUrl = ref("")
const loading = ref(false)
const captchaEnabled = ref(true)

function handleRegister() {
  proxy.$refs.registerRef.validate(valid => {
    if (valid) {
      loading.value = true
      register(registerForm.value).then(res => {
        const username = registerForm.value.username
        ElMessageBox.alert("<font color='red'>恭喜你，您的账号 " + username + " 注册成功！</font>", "系统提示", {
          dangerouslyUseHTMLString: true,
          type: "success",
        }).then(() => {
          router.push("/login")
        }).catch(() => {})
      }).catch(() => {
        loading.value = false
        if (captchaEnabled.value) {
          getCode()
        }
      })
    }
  })
}

function getCode() {
  getCodeImg().then(res => {
    captchaEnabled.value = res.captchaEnabled === undefined ? true : res.captchaEnabled
    if (captchaEnabled.value) {
      codeUrl.value = "data:image/gif;base64," + res.img
      registerForm.value.uuid = res.uuid
    }
  })
}

getCode()
</script>

<style lang='scss' scoped>
.register {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: linear-gradient(135deg, rgba(82, 196, 26, 0.1) 0%, rgba(24, 144, 255, 0.1) 100%),
              url('@/assets/images/login-background.jpg') center/cover no-repeat;
  position: relative;
  
  // 添加深色遮罩层，提高文字可读性
  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(255, 255, 255, 0.5);
    z-index: 0;
  }
}

.register-container {
  width: 100%;
  max-width: 400px;
  padding: 20px;
  position: relative;
  z-index: 1;
}

.register-header {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 40px;
  
  .logo {
    font-size: 36px;
    margin-right: 12px;
  }
  
  .system-title {
    font-size: 24px;
    font-weight: 600;
    color: #1890ff;
    margin: 0;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }
}

.register-form-wrapper {
  background: rgba(255, 255, 255, 0.95);
  padding: 40px 30px;
  border-radius: 12px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  
  .form-title {
    text-align: center;
    font-size: 18px;
    color: #333;
    margin-bottom: 30px;
    font-weight: 600;
  }
}

.register-form {
  .el-form-item {
    margin-bottom: 20px;
  }
  
  .custom-input {
    :deep(.el-input__wrapper) {
      background: #f8f9fa;
      border: 1px solid #e9ecef;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
      padding: 8px 15px;
      transition: all 0.3s ease;
      
      &:hover {
        border-color: #1890ff;
        box-shadow: 0 2px 8px rgba(24, 144, 255, 0.1);
      }
      
      &.is-focus {
        border-color: #1890ff;
        box-shadow: 0 2px 12px rgba(24, 144, 255, 0.2);
      }
    }
    
    :deep(.el-input__inner) {
      height: 44px;
      line-height: 44px;
      font-size: 14px;
      background: transparent;
      
      &::placeholder {
        color: #adb5bd;
      }
    }
  }
}

.code-wrapper {
  display: flex;
  width: 100%;
  
  .code-input {
    flex: 1;
  }
  
  .register-code {
    width: 120px;
    height: 44px;
    margin-left: 10px;
    
    img {
      width: 100%;
      height: 100%;
      cursor: pointer;
      border-radius: 8px;
      border: 1px solid #e9ecef;
      transition: all 0.3s ease;
      
      &:hover {
        border-color: #1890ff;
      }
    }
  }
}

.btn-group {
  width: 100%;
  margin-bottom: 15px;
  
  .el-button {
    width: 100%;
    height: 48px;
    font-size: 16px;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
    border: none;
  }
  
  .register-btn {
    background: linear-gradient(135deg, #52c41a 0%, #389e0d 100%);
    color: #fff;
    box-shadow: 0 4px 12px rgba(82, 196, 26, 0.3);
    
    &:hover {
      background: linear-gradient(135deg, #73d13d 0%, #52c41a 100%);
      box-shadow: 0 6px 16px rgba(82, 196, 26, 0.4);
      transform: translateY(-2px);
    }
    
    &:active {
      transform: translateY(0);
      box-shadow: 0 2px 8px rgba(82, 196, 26, 0.3);
    }
  }
}

.login-link {
  text-align: center;
  margin-top: 20px;
  
  .link-type {
    color: #1890ff;
    text-decoration: none;
    font-size: 14px;
    transition: all 0.3s ease;
    
    &:hover {
      color: #40a9ff;
      text-decoration: underline;
    }
  }
}

.el-register-footer {
  position: fixed;
  bottom: 0;
  width: 100%;
  height: 40px;
  line-height: 40px;
  text-align: center;
  color: rgba(0, 0, 0, 0.6);
  font-family: Arial, sans-serif;
  font-size: 12px;
  letter-spacing: 1px;
  z-index: 1;
}

// 移除默认的图标样式
:deep(.el-input__prefix) {
  display: none;
}

// 加载状态样式
:deep(.el-button.is-loading) {
  opacity: 0.8;
}
</style>