<template>
  <div class="login">
    <div class="login-container">
      <!-- 顶部标题区域 -->
      <div class="login-header">
        <div class="logo">😊</div>
        <h1 class="system-title">先锋互联管理系统</h1>
      </div>

      <!-- 登录表单区域 -->
      <div class="login-form-wrapper">
        <h3 class="form-title">账号密码登录</h3>
        
        <el-form ref="loginRef" :model="loginForm" :rules="loginRules" class="login-form">
          <el-form-item prop="username">
            <el-input
              v-model="loginForm.username"
              type="text"
              size="large"
              auto-complete="off"
              placeholder="用户名"
              class="custom-input"
            />
          </el-form-item>
          
          <el-form-item prop="password">
            <el-input
              v-model="loginForm.password"
              type="password"
              size="large"
              auto-complete="off"
              placeholder="密码"
              class="custom-input"
              @keyup.enter="handleLogin"
            />
          </el-form-item>
          
          <el-form-item prop="code" v-if="captchaEnabled">
            <div class="code-wrapper">
              <el-input
                v-model="loginForm.code"
                size="large"
                auto-complete="off"
                placeholder="验证码"
                class="custom-input code-input"
                @keyup.enter="handleLogin"
              />
              <div class="login-code">
                <img :src="codeUrl" @click="getCode" class="login-code-img"/>
              </div>
            </div>
          </el-form-item>
          
          <el-checkbox v-model="loginForm.rememberMe" class="remember-checkbox">记住密码</el-checkbox>
          
          <el-form-item class="btn-group">
            <el-button
              :loading="loading"
              size="large"
              class="login-btn"
              @click.prevent="handleLogin"
            >
              <span v-if="!loading">登录</span>
              <span v-else>登 录 中...</span>
            </el-button>
          </el-form-item>
          
          <el-form-item class="btn-group" v-if="register">
            <el-button
              size="large"
              class="register-btn"
              @click="$router.push('/register')"
            >
              注册
            </el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
    
    <!--  底部  -->
    <div class="el-login-footer">
      <span>Copyright © 2018-2025 ruoyi.vip All Rights Reserved.</span>
    </div>
  </div>
</template>

<script setup>
import { getCodeImg } from "@/api/login"
import Cookies from "js-cookie"
import { encrypt, decrypt } from "@/utils/jsencrypt"
import useUserStore from '@/store/modules/user'

const title = import.meta.env.VITE_APP_TITLE
const userStore = useUserStore()
const route = useRoute()
const router = useRouter()
const { proxy } = getCurrentInstance()

const loginForm = ref({
  username: "",
  password: "",
  rememberMe: false,
  code: "",
  uuid: ""
})

const loginRules = {
  username: [{ required: true, trigger: "blur", message: "请输入您的账号" }],
  password: [{ required: true, trigger: "blur", message: "请输入您的密码" }],
  code: [{ required: true, trigger: "change", message: "请输入验证码" }]
}

const codeUrl = ref("")
const loading = ref(false)
// 验证码开关
const captchaEnabled = ref(true)
// 注册开关
const register = ref(true)
const redirect = ref(undefined)

watch(route, (newRoute) => {
    redirect.value = newRoute.query && newRoute.query.redirect
}, { immediate: true })

function handleLogin() {
  proxy.$refs.loginRef.validate(valid => {
    if (valid) {
      loading.value = true
      // 勾选了需要记住密码设置在 cookie 中设置记住用户名和密码
      if (loginForm.value.rememberMe) {
        Cookies.set("username", loginForm.value.username, { expires: 30 })
        Cookies.set("password", encrypt(loginForm.value.password), { expires: 30 })
        Cookies.set("rememberMe", loginForm.value.rememberMe, { expires: 30 })
      } else {
        // 否则移除
        Cookies.remove("username")
        Cookies.remove("password")
        Cookies.remove("rememberMe")
      }
      // 调用action的登录方法
      userStore.login(loginForm.value).then(() => {
        const query = route.query
        const otherQueryParams = Object.keys(query).reduce((acc, cur) => {
          if (cur !== "redirect") {
            acc[cur] = query[cur]
          }
          return acc
        }, {})
        router.push({ path: redirect.value || "/", query: otherQueryParams })
      }).catch(() => {
        loading.value = false
        // 重新获取验证码
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
      loginForm.value.uuid = res.uuid
    }
  })
}

function getCookie() {
  const username = Cookies.get("username")
  const password = Cookies.get("password")
  const rememberMe = Cookies.get("rememberMe")
  loginForm.value = {
    username: username === undefined ? loginForm.value.username : username,
    password: password === undefined ? loginForm.value.password : decrypt(password),
    rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
  }
}

getCode()
getCookie()
</script>

<style lang='scss' scoped>
.login {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: linear-gradient(135deg, rgba(24, 144, 255, 0.1) 0%, rgba(47, 84, 235, 0.1) 100%),
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

.login-container {
  width: 100%;
  max-width: 400px;
  padding: 20px;
  position: relative;
  z-index: 1;
}

.login-header {
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

.login-form-wrapper {
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

.login-form {
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
  
  .login-code {
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

.remember-checkbox {
  margin-bottom: 25px;
  
  :deep(.el-checkbox__label) {
    color: #666;
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
  
  .login-btn {
    background: linear-gradient(135deg, #1890ff 0%, #096dd9 100%);
    color: #fff;
    box-shadow: 0 4px 12px rgba(24, 144, 255, 0.3);
    
    &:hover {
      background: linear-gradient(135deg, #40a9ff 0%, #1890ff 100%);
      box-shadow: 0 6px 16px rgba(24, 144, 255, 0.4);
      transform: translateY(-2px);
    }
    
    &:active {
      transform: translateY(0);
      box-shadow: 0 2px 8px rgba(24, 144, 255, 0.3);
    }
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

.el-login-footer {
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