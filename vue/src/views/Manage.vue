<template>
  <el-container style="min-height: 100vh">

    <!--    <el-aside :width="sideWidth + 'px'" style="box-shadow: 2px 0 6px rgb(0 21 41 / 35%);">-->
    <el-aside :width="sideWidth + 'px'" class="el-aside">
      <Aside :isCollapse="isCollapse" :logoTextShow="logoTextShow"/>
    </el-aside>

    <!--    <el-container style="margin-left: 200px">-->
    <el-container>
      <el-header :style="mainStyle" style="border-bottom: 1px solid #ccc;" class="el-header">
        <Header :collapseBtnClass="collapseBtnClass" :collapse="collapse"/>
      </el-header>

      <el-main :style="mainStyle">
        <router-view/>
      </el-main>

    </el-container>
  </el-container>
</template>
<script>

import Aside from "@/components/Aside";
import Header from "@/components/Header";
import User from "@/views/User.vue";
import user from "@/views/User.vue";

export default {
  name: "Manage",
  computed: {
    mainStyle() {
      return {
        marginLeft: this.sideWidth + 'px',
      };
    },
    user() {
      return user
    }
  },
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      userId: "",
      username: "",
      role: "",
      email: "",
      phone: "",
      address: "",
      createTime: "",
      form: {},
      dialogFormVisible: false,
      multipleSelection: [],
      msg: "hello mxy",
      collapseBtnClass: 'el-icon-s-fold',
      isCollapse: false,// 是否收缩
      sideWidth: 200,
      logoTextShow: true,// logo文字是否显示
      headerBg: 'headerBg',
      dialogVisible: false,// 弹窗可视化
      menus: [],// 菜单数据
      userinfo: {},
    }
  },

  created() {
    // 请求分页查询数据
    // this.getUser()
  },
  components: {
    Aside,
    Header,
    User
  },

  methods: {
    /**
     * 左边栏收缩方法
     * */
    collapse() {  // 点击收缩按钮触发
      this.isCollapse = !this.isCollapse
      if (this.isCollapse) {  // 收缩
        this.sideWidth = 64
        this.collapseBtnClass = 'el-icon-s-unfold'
        this.logoTextShow = false
      } else {   // 展开
        this.sideWidth = 200
        this.collapseBtnClass = 'el-icon-s-fold'
        this.logoTextShow = true
      }
    },
  }
}

</script>

<style scoped>
.el-aside {
  position: fixed;
  height: 100vh;
  overflow: auto;
}

.el-header {
  top: 0;
  z-index: 1000; /* 确保header始终在其他内容之上 */
  background-color: #fff;
}

</style>
