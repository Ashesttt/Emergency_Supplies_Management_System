<template>
  <div style="display: flex; justify-content: space-between; padding: 20px;">
    <!--    <el-card style="width: 500px; padding: 20px; border: 1px solid #ccc">-->
    <el-card style="width: calc(50% - 10px); padding: 20px; border: 1px solid #ccc" header="用户信息修改">

      <el-form label-width="80px" size="small">
        <el-form-item label="用户名">
          <el-input v-model="form.username" autocomplete="off" disabled></el-input>
        </el-form-item>
        <!--TODO: 输入用户身份变成选择用户身份        -->
        <el-form-item label="用户身份">
          <el-input v-model="form.role" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="邮箱">
          <el-input v-model="form.email" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="电话">
          <el-input v-model="form.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="地址">
          <el-input v-model="form.address" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="创建时间">
          <el-date-picker v-model="form.createTime" type="date" placeholder="选择日期"
                          value-format="yyyy-MM-dd"></el-date-picker>
        </el-form-item>
      </el-form>
      <div style="text-align: center">
        <el-button type="primary" @click="save">保存</el-button>
      </div>
    </el-card>
  </div>
</template>
<script>

export default {
  name: "Person",
  data() {
    return {
      form: {},
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}//获取用户信息
    };
  },
  created() {
    this.getUser().then(res => {
      console.log(res)
      this.form = res
    })
  },
  methods: {
    async getUser() {
      return (await this.request.get("/user/username/" + this.user.username)).data
    },
    save() {
      this.request.post("/user", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("保存成功")

          // 更新浏览器存储的用户信息
          this.getUser().then(res => {
            res.token = JSON.parse(localStorage.getItem("user")).token
            localStorage.setItem("user", JSON.stringify(res))
          })
        } else {
          this.$message.error("保存失败")
        }
      })
    },
    handleAvatarSuccess(res) {
      this.form.avatarurl = res
    },
  }
}
</script>

<style>
.avatar-uploader {
  text-align: center;
  padding-bottom: 10px;
}

.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 138px;
  height: 138px;
  line-height: 138px;
  text-align: center;
}

.avatar {
  width: 138px;
  height: 138px;
  display: block;
}
</style>
