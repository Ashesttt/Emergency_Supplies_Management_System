<template>
  <el-container style="min-height: 100vh">

    <el-aside :width="sideWidth + 'px'" style="box-shadow: 2px 0 6px rgb(0 21 41 / 35%);">
      <Aside :isCollapse="isCollapse" :logoTextShow="logoTextShow"/>
    </el-aside>

    <el-container>
      <el-header style="border-bottom: 1px solid #ccc;">
        <Header :collapseBtnClass="collapseBtnClass" :collapse="collapse"/>
      </el-header>

      <el-main>
        <!--当前页面   -->
        <router-view/>
      </el-main>

    </el-container>
  </el-container>
</template>

<script>

import request from "@/utils/request";
import Aside from "@/components/Aside";
import Header from "@/components/Header";
import User from "@/views/User.vue";

export default {
  name: 'Home',
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
      dialogVisible: false// 弹窗可视化
    }
  },

  created() {

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
