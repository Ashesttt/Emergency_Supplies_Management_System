<template>
  <el-card style="width: 500px; padding: 20px; border: 1px solid #ccc">
    <el-form label-width="80px" size="small">
      <el-form-item label="用户名">
        <el-input v-model="form.username" autocomplete="off"></el-input>
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
</template>
<script>
import request from "@/utils/request";

export default {
  name: "Person",
  data() {
    return {
      form: {},
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}//获取用户信息
    };
  },
  created() {
    this.request.get("/user/username/" + this.user.username).then(res => {
      if (res.code === "200") {
        this.form = res.data
      }
    });
  },
  methods: {
    /**
     * 保存用户信息
     * */
    save() {
      request.post("/user", this.form).then(res => {
        if (res) {
          this.$message.success("保存成功")
          this.load()
        } else {
          this.$message.error("保存失败")
        }
      })
    },
  },
}
</script>

<style scoped>

</style>
