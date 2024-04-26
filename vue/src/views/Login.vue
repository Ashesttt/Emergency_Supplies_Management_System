<template>
  <div class="wrapper">
    <div
        style="margin: 200px auto; background-color: #fff; width: 350px; height: 300px; padding: 20px; border-radius: 20px">
      <div style="margin: 20px 0; text-align: center; font-size: 24px"><b>登 录</b></div>
      <!-- :model="user"绑定数据,:rules="rules"绑定校验规则,ref="userForm"获取表单对象-->
      <el-form :model="user" :rules="rules" ref="userForm">
        <el-form-item prop="username">
          <el-input size="medium" style="margin: 10px 0" prefix-icon="el-icon-user" v-model="user.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input size="medium" style="margin: 10px 0" prefix-icon="el-icon-lock" show-password
                    v-model="user.password"></el-input>
        </el-form-item>
        <el-form-item style="margin: 10px 0; text-align: center">
          <el-button type="primary" size="medium" autocomplete="off" @click="login">登录</el-button>
          <el-button type="warning" size="medium" autocomplete="off" @click="register">注册</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import {setRoutes} from "@/router";

export default {
  name: "Login",
  data() {
    return {
      user: {},
      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'},//blur失去焦点时触发,change改变时触发
          {min: 1, max: 10, message: '长度在 1 到 10 个字符', trigger: 'blur'}
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
          {min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur'}
        ],
      }
    }
  },
  methods: {
    login() {
      this.$refs['userForm'].validate((valid) => {
        if (valid) {  // 表单校验合法
          this.request.post("/user/login", this.user).then(res => {
            console.log(res)
            if (res.code === "200") {
              console.log("code=200")
              localStorage.setItem("user", JSON.stringify(res.data))//将用户信息存储到localStorage,为了在其他页面获取用户信息。如Header.vue
              localStorage.setItem("menus", JSON.stringify(res.data.menus))
                
              
              //动态加载路由
              setRoutes()
              this.$router.push("/")//跳转到首页
              this.$message.success("登录成功,尊贵的" + res.data.username + "用户" + "您的身份是" + res.data.userRole)
              return true
            }
            if (res.code === "10001") {
              console.log("code=10001")
              this.$message.error("用户名或密码错误")
              return false;
            }
            if (res.code === "500") {
              console.log("code=500")
              this.$message.error("系统错误")
              return false;
            } else {
              this.$message.error(res.msg)
              return false;
            }
          })
        } else {
          this.$message.success("请检查输入是否正确")
          return false;
        }
      });
    },
    register() {
      this.$router.push("/register")//跳转到注册页面
    }
  }
}
</script>


<style>
.wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  background-image: url("../assets/images/login-background.jpg");
  //background-image: url("../assets/images/shuzai.jpg");
  background-size: cover;
}
</style>
