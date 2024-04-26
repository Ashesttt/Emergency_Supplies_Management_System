<template>
  <div style="line-height: 60px; display: flex">
    <div style="flex: 1;">
      <span :class="collapseBtnClass" style="cursor: pointer; font-size: 18px" @click="collapse"></span>

      <el-breadcrumb separator="/" style="display: inline-block; margin-left: 10px">
        <el-breadcrumb-item :to="'/'">首页</el-breadcrumb-item>
        <el-breadcrumb-item>{{ currentPathName }}</el-breadcrumb-item>
      </el-breadcrumb>

    </div>

    <el-image
        style="width: 50px; height: 50px; border-radius:50%; margin-right: 20px; align-self: center;"
        :src="user_info.avatarurl"
        :preview-src-list="[user_info.avatarurl]"
        fit="cover"
    ></el-image>
    
    <el-dropdown style="width: auto; cursor: pointer">
      <span>{{ user_info.username }}</span><i class="el-icon-arrow-down" style="margin-left: 5px"></i>
      <el-dropdown-menu slot="dropdown" style="width: 100px; text-align: center">
        <el-dropdown-item style="font-size: 14px; padding: 5px 0">
          <router-link to="/person" style="text-decoration: none">个人信息</router-link>
        </el-dropdown-item>
        <el-dropdown-item style="font-size: 14px; padding: 5px 0">
          <router-link to="/change_password" style="text-decoration: none">修改密码</router-link>
        </el-dropdown-item>
        <el-dropdown-item style="font-size: 14px; padding: 5px 0">
          <span style="text-decoration: none" @click="logout">退出</span>
        </el-dropdown-item>
      </el-dropdown-menu>
    </el-dropdown>
  </div>
</template>


<script>
import user from "../views/User.vue";

export default {
  name: "Header",
  props: {
    collapseBtnClass: String,
    collapse: Function
  },
  computed: {
    user() {
      return user
    },
    currentPathName() {
      return this.$store.state.currentPathName;　　//需要监听的数据
    }
  },
  watch: {
    currentPathName(newVal, oldVal) {
      console.log(newVal)
    }
  },
  data() {
    return {
      user_info: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}//获取用户信息
    }
  },
  methods: {
    logout() {
      this.$router.push("/login")//跳转到登录页面
      localStorage.removeItem("user")//清除用户信息
      this.$message.success("退出成功")
    }
  }

}
</script>


<style scoped>

</style>
