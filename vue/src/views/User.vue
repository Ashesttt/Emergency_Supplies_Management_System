<template>
  <div>
    <div style="margin-bottom: 30px">

    </div>

    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入用户名" suffix-icon="el-icon-search"
                v-model="username"></el-input>
      <el-select clearable v-model="userRole" placeholder="请选择用户身份" style="width: 200px"
                 suffix-icon="el-icon-user" class="ml-5">
        <el-option
            v-for="item in options"
            :key="item.rolename"
            :label="item.description"
            :value="item.rolename">
          {{ item.description }}({{ item.rolename }})
        </el-option>
      </el-select>


      <el-input style="width: 200px" placeholder="请输入邮箱" suffix-icon="el-icon-message" class="ml-5"
                v-model="email"></el-input>
      <el-input style="width: 200px" placeholder="请输入电话" suffix-icon="el-icon-phone" class="ml-5"
                v-model="phone"></el-input>
      <el-input style="width: 200px" placeholder="请输入地址" suffix-icon="el-icon-position" class="ml-5"
                v-model="address"></el-input>
      <el-date-picker style="width: 200px" placeholder="选择日期" type="date"
                      value-format="yyyy-MM-dd" class="ml-5" v-model="createTime"></el-date-picker>

      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button class="ml-5" type="warning" @click="reset">重置</el-button>
    </div>

    <div style="margin: 10px 0">
      <el-button type="primary" @click="handleAdd">新增 <i class="el-icon-circle-plus-outline"></i></el-button>
      <el-popconfirm
          class="ml-5"
          confirm-button-text='确定'
          cancel-button-text='取消'
          icon="el-icon-warning"
          icon-color="red"
          title="您确定批量删除这些用户信息吗？"
          @confirm="delBatch"
      >
        <el-button type="danger" slot="reference">批量删除 <i class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>
      <el-upload action="http://localhost:9090/user/import" :show-file-list="false" accept="xlsx"
                 :on-success="handleExcelImportSuccess" style="display: inline-block">
        <el-button type="primary" class="ml-5">导入 <i class="el-icon-bottom"></i></el-button>
      </el-upload>
      <el-button type="primary" @click="exp" class="ml-5">导出 <i class="el-icon-top"></i></el-button>
    </div>

    <!--TODO: 排序:userId和createTime -->
    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="userId" label="用户ID" width="100">
      </el-table-column>
      <el-table-column prop="avatarurl" label="头像">
        <template slot-scope="scope">
          <div style="display: flex; justify-content: center; align-items: center;">
            <el-image
                style="width: 50px; height: 50px; border-radius:50%;"
                :src="scope.row.avatarurl ? scope.row.avatarurl : 'https://img2.baidu.com/it/u=1917387172,3574852173&fm=253&fmt=auto&app=120&f=JPEG?w=607&h=342'"
                :preview-src-list="[scope.row.avatarurl]"
                fit="cover"
            ></el-image>
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="username" label="用户名" width="140">
      </el-table-column>
      <el-table-column prop="password" label="密码" width="140">
      </el-table-column>
      <el-table-column prop="userRole" label="用户身份" width="120">
      </el-table-column>
      <el-table-column prop="email" label="邮箱" width="140">
      </el-table-column>
      <el-table-column prop="phone" label="电话" width="140">
      </el-table-column>
      <el-table-column prop="address" label="地址">
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" width="220">
      </el-table-column>
      <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">
          <el-button type="success" @click="handleEdit(scope.row)">编辑 <i class="el-icon-edit"></i></el-button>
          <el-popconfirm
              class="ml-5"
              confirm-button-text='确定'
              cancel-button-text='取消'
              icon="el-icon-warning"
              icon-color="red"
              title="您确定删除这个用户信息吗？"
              @confirm="del(scope.row.userId)"
          >
            <el-button type="danger" slot="reference">删除 <i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <div style="padding: 10px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[2, 5, 10, 15]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </div>

    <el-dialog title="用户信息" :visible.sync="dialogFormVisible" width="30%">
      <el-form label-width="80px" size="small">
        <el-form-item label="用户名">
          <el-input v-model="form.username" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="用户身份">
          <el-select clearable v-model="form.userRole" placeholder="请选择用户身份" style="width: 100%">
            <el-option
                v-for="item in options"
                :key="item.rolename"
                :label="item.description"
                :value="item.rolename">
              {{ item.description }}({{ item.rolename }})
            </el-option>
          </el-select>
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
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "User",
  data() {
    return {
      tableData: [],
      code: "",
      total: 0,
      pageNum: 1,
      pageSize: 10,
      userId: "",
      avatarurl: "",
      username: "",
      userRole: "",
      email: "",
      phone: "",
      address: "",
      createTime: "",
      form: {},
      dialogFormVisible: false,
      multipleSelection: [],
      msg: "hello mxy",
      collapseBtnClass: "el-icon-s-fold",
      isCollapse: false, // 是否收缩
      sideWidth: 200,
      logoTextShow: true, // logo文字是否显示
      headerBg: "headerBg",
      dialogVisible: false, // 弹窗可视化
      options: [],
    }
  },
  created() {
    // 请求分页查询数据
    this.load()
  },


  methods: {
    /**
     * 查询数据方法
     * */
    load() {
      request.get("/user/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          username: this.username,
          userRole: this.userRole,
          email: this.email,
          phone: this.phone,
          address: this.address,
          createTime: this.createTime
        }
      }).then(res => {
        console.log(res)
        // if (res.code !== "200") {
        //   this.$message.error(res.msg)
        // }
        this.tableData = res.data.records;
        this.total = res.data.total;
      })

      /**
       * 获取搜索栏的role身份选择
       * */
      request.get("/role").then(res => {
        console.log(res)
        if (res.code === "200") {
          this.options = res.data;
          console.log("this.options：" + this.options)
        }
      })

    },

    /**
     * 重置查询条件
     * */
    // reset() {
    //   this.handleClose()
    //   this.username = "";
    //   this.userRole = "";
    //   this.email = "";
    //   this.phone = "";
    //   this.address = "";
    //   this.createTime = "";
    //   this.load()
    // },
    async reset() {
      try {
        await this.handle_reset();
        this.username = "";
        this.userRole = "";
        this.email = "";
        this.phone = "";
        this.address = "";
        this.createTime = "";
        this.load();
      } catch (error) {
        // 用户点击了取消，所以不执行任何操作
      }
    },

    /**
     * 是否重置弹窗弹窗
     * */
    // handleClose(done) {
    //   this.$confirm('确认关闭？')
    //       .then(_ => {
    //         done();
    //       })
    //       .catch(_ => {});
    // }
    handle_reset() {
      return new Promise((resolve, reject) => {
        this.$confirm('确认重置？')
            .then(_ => {
              resolve();
            })
            .catch(_ => {
              reject();
            });
      });
    },

    /**
     * 新增用户信息
     * */
    handleAdd() {
      this.dialogFormVisible = true
      this.form = {}
    },

    /**
     * 批量删除
     * */
    delBatch() {
      let ids = this.multipleSelection.map(v => v.userId)  // [{}, {}, {}] => [1,2,3]
      console.log("ids:", ids)
      request.post("/user/del/batch", ids).then(res => {
        if (res.code === "200") {
          this.$message.success("批量删除成功")
          this.load()
        } else {
          this.$message.error("批量删除失败,原因：" + res.msg)
        }
      })
    },

    /**
     * 导入成功
     * */
    handleExcelImportSuccess() {
      this.$message.success("导入成功")
      this.load()
    },

    /**
     * 导出
     * */
    exp() {
      window.open("http://localhost:9090/user/export")
    },

    /**
     * 处理选中的数据
     * */
    handleSelectionChange(val) {
      console.log("val:", val)
      this.multipleSelection = val
    },

    /**
     * 编辑用户信息
     * */
    handleEdit(row) {
      this.form = row
      this.dialogFormVisible = true
      /**
       * 获取所有角色信息
       * */
      request.get("/role").then(res => {
        console.log(res)
        if (res.code === "200") {
          this.options = res.data;
          console.log("this.options：" + this.options)
        }
      })

    },

    /**
     * 删除用户信息
     * */
    del(id) {
      console.log("id:", id)
      request.delete("/user/" + id).then(res => {
        console.log("是否删除:", res)
        if (res.code === "200") {
          this.$message.success("删除成功")
          this.load()
        } else {
          this.$message.error("删除失败")
        }
      })
    },

    /**
     * 处理分页大小改变
     **/
    handleSizeChange(pageSize) {
      console.log(pageSize)
      this.pageSize = pageSize;
      this.load()
    },

    /**
     * 处理页码改变
     * */
    handleCurrentChange(pageNum) {
      console.log(pageNum)
      this.pageNum = pageNum;
      this.load()
    },

    /**
     * 保存用户信息
     * */
    save() {
      console.log("this.form:", this.form)
      request.post("/user", this.form).then(res => {
        if (res.data) {
          this.$message.success("保存成功")
          this.dialogFormVisible = false
          this.load()
        } else {
          this.$message.error("保存失败")
        }
      })
    },

  }
}
</script>

<style>
.headerBg {
  background: #eee !important;
}
</style>
