<template>
  <el-container style="min-height: 100vh">

    <el-aside :width="sideWidth + 'px'" style="box-shadow: 2px 0 6px rgb(0 21 41 / 35%);">
      <el-menu :default-openeds="['1', '3']" style="min-height: 100%; overflow-x: hidden"
               background-color="rgb(48, 65, 86)"
               text-color="#fff"
               active-text-color="#ffd04b"
               :collapse-transition="false"
               :collapse="isCollapse"
      >
        <div style="height: 60px; line-height: 60px; text-align: center">
          <img src="../assets/logo.png" alt="" style="width: 20px; position: relative; top: 5px; right: 5px">
          <b style="color: white" v-show="logoTextShow">应急救援装备管理系统</b>
        </div>
        <el-submenu index="1">
          <template slot="title">
            <i class="el-icon-message"></i>
            <span slot="title">导航一</span>
          </template>
          <el-menu-item-group title="分组2">
            <el-menu-item index="1-3">选项3</el-menu-item>
          </el-menu-item-group>
          <el-submenu index="1-4">
            <template slot="title">选项4</template>
            <el-menu-item index="1-4-1">选项4-1</el-menu-item>
          </el-submenu>
        </el-submenu>
        <el-submenu index="2">
          <template slot="title">
            <i class="el-icon-menu"></i>
            <span slot="title">导航二</span>
          </template>
          <el-submenu index="2-4">
            <template slot="title">选项4</template>
            <el-menu-item index="2-4-1">选项4-1</el-menu-item>
          </el-submenu>
        </el-submenu>
        <el-submenu index="3">
          <template slot="title">
            <i class="el-icon-setting"></i>
            <span slot="title">导航三</span>
          </template>
          <el-submenu index="3-4">
            <template slot="title">选项4</template>
            <el-menu-item index="3-4-1">选项4-1</el-menu-item>
          </el-submenu>
        </el-submenu>
      </el-menu>
    </el-aside>

    <el-container>
      <el-header style="font-size: 12px; border-bottom: 1px solid #ccc; line-height: 60px; display: flex">
        <div style="flex: 1; font-size: 20px">
          <span :class="collapseBtnClass" style="cursor: pointer" @click="collapse"></span>
        </div>
        <el-dropdown style="width: 70px; cursor: pointer">
          <span>王小虎</span><i class="el-icon-arrow-down" style="margin-left: 5px"></i>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item style="font-size: 14px; padding: 5px 0">个人信息</el-dropdown-item>
            <el-dropdown-item style="font-size: 14px; padding: 5px 0">退出</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>

      </el-header>

      <el-main>
        <div style="margin-bottom: 30px">
          <el-breadcrumb separator="/">
            <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>用户管理</el-breadcrumb-item>
          </el-breadcrumb>
        </div>

        <div style="margin: 10px 0">
          <el-input style="width: 200px" placeholder="请输入用户名" suffix-icon="el-icon-search"
                    v-model="username"></el-input>
          <el-input style="width: 200px" placeholder="请输入用户身份" suffix-icon="el-icon-user" class="ml-5"
                    v-model="role"></el-input>
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
          <el-button type="primary" class="ml-5">导入 <i class="el-icon-bottom"></i></el-button>
          <el-button type="primary">导出 <i class="el-icon-top"></i></el-button>
        </div>

        <!--TODO: 排序:userId和createTime -->
        <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
                  @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="55"></el-table-column>
          <el-table-column prop="userId" label="用户ID" width="100" @click="collapse">
          </el-table-column>
          <el-table-column prop="username" label="用户名" width="140">
          </el-table-column>
          <el-table-column prop="role" label="用户身份" width="120">
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
          <div slot="footer" class="dialog-footer">
            <el-button @click="dialogFormVisible = false">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
          </div>
        </el-dialog>

      </el-main>

    </el-container>
  </el-container>
</template>

<script>

import request from "@/utils/request";

export default {
  name: 'Home',
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      userId: "",
      username: "",
      role: "",
      email: "",
      phone: "",
      address: "",
      createTime: "",
      form: {},
      dialogFormVisible: false,
      multipleSelection: [],
      msg: "hello mxy",
      collapseBtnClass: 'el-icon-s-fold',
      isCollapse: false,
      sideWidth: 200,
      logoTextShow: true,
      headerBg: 'headerBg',
      dialogVisible: false// 弹窗可视化
    }
  },

  created() {
    // 请求分页查询数据
    this.load()
  },
  methods: {
    /**
     * 左边栏收缩方法
     * */
    collapse() {  // 点击收缩按钮触发
      this.isCollapse = !this.isCollapse
      if (this.isCollapse) {  // 收缩
        this.sideWidth = 64
        this.collapseBtnClass = 'el-icon-s-unfold'
        this.logoTextShow = false
      } else {   // 展开
        this.sideWidth = 200
        this.collapseBtnClass = 'el-icon-s-fold'
        this.logoTextShow = true
      }
    },

    /**
     * 查询数据方法
     * */
    load() {
      request.get("/user/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          username: this.username,
          role: this.role,
          email: this.email,
          phone: this.phone,
          address: this.address,
          createTime: this.createTime
        }
      }).then(res => {
        console.log(res)
        this.tableData = res.records;
        this.total = res.total;
      })
    },

    /**
     * 新增用户信息
     * */
    handleAdd() {
      this.dialogFormVisible = true
      this.form = {}
    },

    /**
     * 编辑用户信息
     * */
    handleEdit(row) {
      this.form = row
      this.dialogFormVisible = true
    },

    /**
     * 保存用户信息
     * */
    save() {
      request.post("/user", this.form).then(res => {
        if (res) {
          this.$message.success("保存成功")
          this.dialogFormVisible = false
          this.load()
        } else {
          this.$message.error("保存失败")
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
        if (res) {
          this.$message.success("删除成功")
          this.load()
        } else {
          this.$message.error("删除失败")
        }
      })
    },

    /**
     * 处理选中的数据
     * */
    handleSelectionChange(val) {
      console.log("val:", val)
      this.multipleSelection = val
    },

    /**
     * 批量删除
     * */
    delBatch() {
      let ids = this.multipleSelection.map(v => v.userId)  // [{}, {}, {}] => [1,2,3]
      console.log("ids:", ids)
      request.post("/user/del/batch", ids).then(res => {
        if (res) {
          this.$message.success("批量删除成功")
          this.load()
        } else {
          this.$message.error("批量删除失败")
        }
      })
    },

    /**
     * 重置查询条件
     * */
    // reset() {
    //   this.handleClose()
    //   this.username = "";
    //   this.role = "";
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
        this.role = "";
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
  }
}

</script>

<style>
.headerBg {
  background: #eee !important;
}
</style>
