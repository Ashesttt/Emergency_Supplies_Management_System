import Vue from 'vue'
import VueRouter from 'vue-router'
import store from "@/store";

Vue.use(VueRouter)

const routes = [
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
    },
    {
        path: '/404',
        name: '404',
        component: () => import('../views/404.vue')
    },
]

const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
})


// 注意：刷新页面会导致页面路由重置
export const setRoutes = () => {
    const storeMenus = localStorage.getItem("menus");
    if (storeMenus) {
        // 拼装动态路由
        const manageRoute = {
            path: '/',
            name: 'Manage',
            component: () => import('../views/Manage.vue'),
            redirect: "/home",
            children: [
                {
                    path: 'person',
                    name: '个人信息',
                    component: () => import('../views/Person.vue')
                },
            ]
        }
        const menus = JSON.parse(storeMenus)
        menus.forEach(item => {
            if (item.path) {  // 当且仅当path不为空的时候才去设置路由，因为有些父 级菜单没有path
                let itemMenu = {
                    path: item.path.replace("/", ""),
                    name: item.menuname,
                    component: () => import('../views/' + item.pagePath + '.vue')
                }
                manageRoute.children.push(itemMenu)
            } else if (item.children.length) {
                item.children.forEach(item => {
                    if (item.path) {
                        let itemMenu = {
                            path: item.path.replace("/", ""),
                            name: item.menuname,
                            component: () => import('../views/' + item.pagePath + '.vue')
                        }
                        manageRoute.children.push(itemMenu)
                        //看了就懂了
                        // console.log("itemMenu：" + JSON.stringify(itemMenu))
                        // console.log("manageRoute：" + JSON.stringify(manageRoute))
                    }
                })
            }
        })

        // 获取当前的路由对象名称数组
        const currentRouteNames = router.getRoutes().map(v => v.name)
        console.log("currentRouteNames：" + currentRouteNames)
        if (!currentRouteNames.includes('Manage')) {// 如果当前的路由对象中没有Manage这个路由对象，就添加,原因：刷新页面会导致页面路由重置
            // 动态添加到现在的路由对象中去
            router.addRoute(manageRoute)
        }

    }
}

// 重置我就再set一次路由
setRoutes()


// 路由守卫
router.beforeEach((to, from, next) => {
    localStorage.setItem("currentPathName", to.name)  // 设置当前的路由名称，为了在Header组件中去使用
    store.commit("setPath")  // 触发store的数据更新

    if (!to.matched.length) {// 如果没有匹配到路由，就跳转到404页面
        const storeMenus = localStorage.getItem("menus");// 获取本地存储的菜单
        if (storeMenus) {// 如果本地存储有菜单，就放行
            next("/404")
        } else {
            next("/login")// 否则就跳转到登录页面
        }
    }
    next()// 放行
})

export default router
