<template>
  <el-menu :default-openeds="opens" style="min-height: 100%; overflow-x: hidden; overflow-y: hidden;"
           background-color="#5870a1"
           text-color="#f0faf5"
           active-text-color="#a2ca8c"
           :collapse-transition="true"
           :collapse="isCollapse"
           router
  >
    <!--TODO:美化滚动条    -->
    <router-link to="/">
      <div style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 60px;">
        <!--        <img src="../assets/images/shuzai.jpg" alt="" style="width: 25px;">-->
        <b v-show="logoTextShow"
           style="color: #ff6347; font-size: 20px; font-weight: bold; text-shadow: 2px 2px 4px #000000;">应急装备管理系统</b>
      </div>
    </router-link>
    <div v-for="item in menus" :key="item.menuId">
      <div v-if="item.path">
        <el-menu-item :index="item.path" class="el-menu-item">
          <i :class="item.icon"></i>
          <span slot="title">{{ item.menuname }}</span>
        </el-menu-item>
      </div>
      <div v-else>
        <el-submenu :index="item.menuId + ''">
          <template slot="title">
            <i :class="item.icon"></i>
            <span slot="title" v-show="logoTextShow">{{ item.menuname }}</span>
          </template>
          <div v-for="subItem in item.children" :key="subItem.menuId">
            <el-menu-item :index="subItem.path">
              <i :class="subItem.icon"></i>
              <span slot="title">{{ subItem.menuname }}</span>
            </el-menu-item>
          </div>
        </el-submenu>
      </div>
    </div>
  </el-menu>
</template>

<script>
export default {
  name: "Aside",
  props: {
    isCollapse: Boolean,
    logoTextShow: Boolean,
  },
  data() {
    return {
      menus: localStorage.getItem("menus") ? JSON.parse(localStorage.getItem("menus")) : [],
      opens: localStorage.getItem("menus") ? JSON.parse(localStorage.getItem("menus")).map(v => v.menuId + '') : []
    }
  },
}
</script>

<style scoped>
.el-aside {
  position: fixed;
  overflow: hidden;
  height: 100vh;
}

</style>
