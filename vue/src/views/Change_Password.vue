<template>
  <div style="display: flex; justify-content: space-between; padding: 20px;">
    <!--    <el-card style="width: 500px; padding: 20px; border: 1px solid #ccc">-->
    <el-card style="width: calc(50% - 10px); padding: 20px; border: 1px solid #ccc" header="用户密码修改">

      <el-form label-width="150px" size="small" :model="changepassword" :rules="rules" ref="userForm">

        <el-form-item prop="username" label="输入旧密码">
          <el-input placeholder="输入旧密码" size="medium" style="margin: 5px 0" prefix-icon="el-icon-user"
                    v-model="changepassword.old_password"></el-input>
        </el-form-item>
        <el-form-item prop="password" label="输入新密码">
          <el-input placeholder="输入新密码" size="medium" style="margin: 5px 0" prefix-icon="el-icon-lock"
                    show-password v-model="changepassword.new_password"></el-input>
        </el-form-item>
        <el-form-item prop="confirmPassword" label="再次输入新密码">
          <el-input placeholder="再次输入新密码" size="medium" style="margin: 5px 0" prefix-icon="el-icon-lock"
                    show-password v-model="changepassword.confirmPassword"></el-input>
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
  name: "Change_Password",
  data() {
    return {
      form: {},
      changepassword: {},
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},//获取用户信息
      rules: {
        old_password: [
          {required: true, message: '请输入旧密码', trigger: 'blur'},
          {min: 1, max: 10, message: '长度在 2 到 10 个字符', trigger: 'blur'}
        ],
        new_password: [
          {required: true, message: '请输入新密码', trigger: 'blur'},
          {min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur'}
        ],
        confirmPassword: [
          {required: true, message: '再次输入新密码', trigger: 'blur'},
          {min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur'}
        ],
      }
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
      this.$refs['userForm'].validate((valid) => {
        if (valid) {  // 表单校验合法
          //表单合法的情况下，旧密码正确
          if (this.form.password === this.changepassword.old_password) {//旧密码正确
            //新密码不能与旧密码相同
            if (this.changepassword.old_password === this.changepassword.new_password) {
              this.$message.error("新密码不能与旧密码相同")
              return false
            }
            //两次输入的密码不一致
            if (this.changepassword.new_password !== this.changepassword.confirmPassword) {
              this.$message.error("两次输入的密码不一致")
              return false
            }
            
            //将新密码赋值给form (改密码)
            this.form.password = this.changepassword.new_password
            this.request.post("/user", this.form).then(res => {
              if (res.code === '200') {
                this.$message.success("保存成功")

                // 更新浏览器存储的用户信息
                this.getUser().then(res => {
                  res.token = JSON.parse(localStorage.getItem("user")).token
                  localStorage.setItem("user", JSON.stringify(res))
                })
                
                //重新登录
                this.$store.commit("logout")
                
              } else {
                this.$message.error("保存失败")
              }
            })
          } else {
            this.$message.error("旧密码输入错误")
            return false
          }

        } else {
          this.$message.error("请检查输入是否正确")
          return false
        }
      });
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
