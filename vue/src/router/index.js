import Vue from 'vue'
import VueRouter from 'vue-router'
import store from "@/store";

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Manage',  
    component: () => import('../views/Manage.vue'),
    redirect: '/home',//重定向到home
    children: [
      {
        path: 'home',
        name: '主页',
        component: () => import('../views/Home.vue')
      },
      {
        path: 'user',
        name: '用户管理',
        component: () => import('../views/User.vue')
      },
      {
        path: 'person',
        name: '个人信息',
        component: () => import('../views/Person.vue')
      },
      {
        path: 'file',
        name: '文件管理',
        component: () => import('../views/File.vue')
      },
      {
        path: 'role',
        name: '角色管理',
        component: () => import('../views/Role.vue')
      },
      // {
      //   path: 'role',
      //   name: '角色管理',
      //   component: () => import('../views/Role.vue')
      // },
      // {
      //   path: 'menu',
      //   name: '菜单管理',
      //   component: () => import('../views/Menu.vue')
      // },
      // {
      //   path: 'dept',
      //   name: '部门管理',
      //   component: () => import('../views/Dept.vue')
      // },
      // {
      //   path: 'dict',
      //   name: '字典管理',
      //   component: () => import('../views/Dict.vue')
      // },
      // {
      //   path: 'config',
      //   name: '参数设置',
      //   component: () => import('../views/Config.vue')
      // },
      // {
      //   path: 'notice',
      //   name: '通知公告',
      //   component: () => import('../views/Notice.vue')
      // },
      // {
      //   path: 'log',
      //   name: '操作日志',
      //   component: () => import('../views/Log.vue')
      // },
      // {
      //   path: 'logininfor',
      //   name: '登录日志',
      //   component: () => import('../views/Logininfor.vue')
      // },
      // {
      //   path: 'online',
      //   name: '在线用户',
      //   component: () => import('../views/Online.vue')
      // },
      // {
      //   path: 'druid',
      //   name: '数据监控',
      //   component: () => import('../views/Druid.vue')
      // }
    ]
  },
  {
    path: '/about',
    name: 'About',
    component: () => import('../views/About.vue')
  },
  {
    path: '/login',
    name: '登录',
    component: () => import('../views/Login.vue')
  },
  {
    path: '/register',
    name: '注册',
    component: () => import('../views/Register.vue')
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

// 路由守卫
router.beforeEach((to, from, next) => {
  localStorage.setItem("currentPathName", to.name)  // 设置当前的路由名称，为了在Header组件中去使用
  store.commit("setPath")  // 触发store的数据更新
  next()  // 放行路由
})

export default router
