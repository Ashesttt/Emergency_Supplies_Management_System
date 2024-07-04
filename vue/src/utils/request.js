import axios from 'axios'
import ElementUI from "element-ui";
import router, {resetRouter} from "@/router";

const request = axios.create({
    // baseURL: 'http://localhost:9091',
    baseURL: process.env.VUE_APP_BASE_API + "9091",
    timeout: 5000
})

// request 拦截器
// 可以自请求发送前对请求做一些处理
// 比如统一加token，对请求参数统一加密
request.interceptors.request.use(config => {
    config.headers['Content-Type'] = 'application/json;charset=utf-8';

    let user = localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')) : {};
    if (user) {// 如果有用户信息，则携带token
        console.log('user.token:', user.token)
        config.headers['token'] = user.token;  // 设置请求头
    }

    return config
}, error => {
    return Promise.reject(error)
});

// response 拦截器
// 可以在接口响应后统一处理结果  
request.interceptors.response.use(
    response => {
        let res = response.data;
        // 如果是返回的文件
        if (response.config.responseType === 'blob') {//blob表示二进制文件
            return res
        }
        // 兼容服务端返回的字符串数据
        if (typeof res === 'string') {
            res = res ? JSON.parse(res) : res
        }
        if (res.code === "401") {
            ElementUI.Message({
                message: res.msg,
                type: 'error'
            });
        }
        return res;
    },
    error => {
        console.log('err' + error) // for debug
        return Promise.reject(error)
    }
)


export default request

