<template>
  <div style="line-height: 60px; display: flex">
    <div style="flex: 1;">
      <span :class="collapseBtnClass" style="cursor: pointer; font-size: 18px" @click="collapse"></span>

      <el-breadcrumb separator="/" style="display: inline-block; margin-left: 10px">
        <el-breadcrumb-item :to="'/'">首页</el-breadcrumb-item>
        <el-breadcrumb-item>{{ currentPathName }}</el-breadcrumb-item>
      </el-breadcrumb>

    </div>


    <button style="padding: 0; border: none; background: none; cursor: pointer; margin-right: 20px;"
            @click="drawer = true">
      <i class="el-icon-message"
         :style="{ 'font-size': hasNewMessage ? '40px' : '30px', color: hasNewMessage ? 'red' : 'black' }">
      </i>
    </button>


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

    <el-drawer
        title="信息"
        :visible.sync="drawer"
        :direction="direction"
        :modal="false"
    >
      <div style="padding: 10px">
        <el-collapse accordion :data="messageData">
          <el-collapse-item v-for="message in messageData.slice(0,10)" :key="message.messageId"
                            :class="style(message.type)" style="padding: 5px;margin-bottom: 5px;">
            <template slot="title">
              <!--TODO:根据message.type展示不同的图标-->
              <div class="title" style="margin-left: 10px">{{ message.title }}<i class="header-icon el-icon-info"></i>
              </div>
              <div class="sendTime" style="margin-left: 18%">{{ message.sendTime }}</div>
            </template>
            <div class="content" style="margin-left: 10px; position: relative;">
              {{ message.content }}
              <div style="position: absolute; right: 15px; top: 25px;">
                <el-button type="primary" size="small" round @click="handleRead(message.messageId)">已 读</el-button>
              </div>
            </div>
          </el-collapse-item>
        </el-collapse>
      </div>
    </el-drawer>

  </div>
</template>


<script>
import user from "../views/User.vue";
import request from "@/utils/request";

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
  created() {
    this.getMessages()
    //   TODO：写一个定时器，每隔一段时间获取一次消息，或者监听消息的变化
  },
  data() {
    return {
      user_info: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},//获取用户信息
      drawer: false,
      direction: 'rtl',
      messageData: [],
      messageId: "",
      sendTime: "",
      hasNewMessage: false
    }
  },
  methods: {
    logout() {
      this.$store.commit("logout")
      this.$message.success("退出成功")
    },


    /**
     * 标记为已读
     * */
    handleRead(messageId) {
      console.log("messageId", messageId)
      request.post("/message/handleRead", null, {
        params: {
          messageId: messageId
        }
      }).then(res => {
        this.consoleLog(res)
        if (res.code !== "200") {
          this.$message.error(res.msg)
        }
        this.getMessages()
      })
    },


    /**
     * 获取接收者为这个用户的message
     * */
    getMessages() {
      request.get("/message/getMessages", {
        params: {
          username: this.user_info.username
        }
      }).then(res => {
        this.consoleLog(res)
        if (res.code !== "200") {
          this.$message.error(res.msg)
        }
        this.messageData = res.data;
        if (this.messageData.length !== 0) {
          this.hasNewMessage = true; // 设置有新消息
        }
        if (this.messageData.length === 0) {
          this.$message.info("暂无消息")
        }
      })
    },

    /**
     * 根据消息的类型，设置不同的样式
     * */
    style(type) {
      if (type === "Emergency") {
        return "Emergency-style"
      } else if (type === "Info") {
        return "Info-style"
      } else if (type === "Warning") {
        return "Warning-style"
      } else if (type === "Error") {
        return "Error-style"
      } else if (type === "Success") {
        return "Success-style"
      }
    },

  }
}
</script>


<style scoped>
.title {
  font-size: 20px; /* 标题字体大小 */
  position: fixed;
  color: #121212; /* 标题字体颜色 */
}

.sendTime {
  font-size: 15px; /* 发送时间字体大小 */
  color: #121212; /* 发送时间字体颜色 */
  position: fixed;
}

.content {
  font-size: 16px; /* 内容字体大小 */
  color: #121212; /* 内容字体颜色 */
  margin-bottom: 10px; /* 内容与发送时间的间距 */
}


.Info-style {
  background-color: #909399;
}

.Emergency-style {
  background-color: #9215a4;
}

.Warning-style {
  background-color: #E6A23C;
}

.Error-style {
  background-color: #F56C6C;
}

.Success-style {
  background-color: #67C23A;
}


</style>
