<template>
  <el-menu :default-openeds="opens" style="min-height: 100%; overflow-x: hidden"
           background-color="rgb(48, 65, 86)"
           text-color="#fff"
           active-text-color="#ffd04b"
           :collapse-transition="false"
           :collapse="isCollapse"
           router
  >
    <div style="height: 60px; line-height: 60px; text-align: center">
      <img src="../assets/logo.png" alt="" style="width: 20px; position: relative; top: 5px; right: 5px">
      <b style="color: white" v-show="logoTextShow">应急救援装备管理系统</b>
    </div>

    <div v-for="item in menus" :key="item.menuId">
      <div v-if="item.path">
        <el-menu-item :index="item.path">
          <i :class="item.icon"></i>
          <span slot="title">{{ item.menuname }}</span>
        </el-menu-item>
      </div>
      <div v-else>
        <el-submenu :index="item.menuId + ''">
          <template slot="title">
            <i :class="item.icon"></i>
            <span slot="title">{{ item.menuname }}</span>
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

</style>
