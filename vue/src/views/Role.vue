<template>
  <div>
    <div style="margin-bottom: 30px">
    </div>

    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入角色名称" suffix-icon="el-icon-search"
                v-model="rolename"></el-input>

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
          title="您确定批量删除这些角色信息吗？"
          @confirm="delBatch"
      >
        <el-button type="danger" slot="reference">批量删除 <i class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="角色ID" width="200">
      </el-table-column>
      <el-table-column prop="rolename" label="角色名称">
      </el-table-column>
      <el-table-column prop="description" label="描述">
      </el-table-column>
      <el-table-column label="操作" width="300" align="center">
        <template slot-scope="scope">
          <el-button type="info" @click="selectMenu(scope.row)">分配菜单 <i class="el-icon-menu"></i></el-button>
          <el-button type="success" @click="handleEdit(scope.row)">编辑 <i class="el-icon-edit"></i></el-button>
          <el-popconfirm
              class="ml-5"
              confirm-button-text='确定'
              cancel-button-text='取消'
              icon="el-icon-warning"
              icon-color="red"
              title="您确定删除这个用户信息吗？"
              @confirm="del(scope.row.id)"
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

    <el-dialog title="角色信息" :visible.sync="dialogFormVisible" width="30%">
      <el-form label-width="80px" size="small">
        <el-form-item label="角色名称">
          <el-input v-model="form.rolename" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="form.description" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="菜单分配" :visible.sync="menuDialogVisible" width="30%">
      <el-tree
          node-key="menuId"
          ref="tree"
          :props="{label: 'menuname',}"
          :data="menuData"
          show-checkbox
          :default-expanded-keys="expends"
          :default-checked-keys="checks">
          <span class="custom-tree-node" slot-scope="{ node, data }">
            <span><i :class="data.icon"></i>{{ data.menuname }}</span>
          </span>
      </el-tree>

      <div slot="footer" class="dialog-footer">
        <el-button @click="menuDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveRoleMenu">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Role",
  data() {
    return {
      tableData: [],
      code: "",
      total: 0,
      pageNum: 1,
      pageSize: 10,
      id: "",
      rolename: "",
      description: "",
      form: {},
      dialogFormVisible: false,
      menuDialogVisible: false,
      multipleSelection: [],
      msg: "hello mxy",
      collapseBtnClass: "el-icon-s-fold",
      isCollapse: false, // 是否收缩
      sideWidth: 200,
      logoTextShow: true, // logo文字是否显示
      headerBg: "headerBg",
      dialogVisible: false, // 弹窗可视化
      menuData: [],// 菜单分配数据
      expends: [],// 默认展开的节点
      checks: [], // 默认选中的节点
      roleId: 0, // 角色id
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
      request.get("/role/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          rolename: this.rolename,
        }
      }).then(res => {
        console.log(res)
        if (res.code !== "200") {
          this.$message.error(res.msg)
        }
        this.$message.success("查询成功")
        this.tableData = res.data.records;
        this.total = res.data.total;
      })
    },

    /**
     * 重置查询条件
     * */
    async reset() {
      try {
        await this.handle_reset();
        this.rolename = "";
        this.load();
      } catch (error) {
        // 用户点击了取消，所以不执行任何操作
      }
    },

    /**
     * 是否重置弹窗弹窗
     * */
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
     * 新增角色信息
     * */
    handleAdd() {
      this.dialogFormVisible = true
      this.form = {}
    },

    /**
     * 批量删除
     * */
    delBatch() {
      let ids = this.multipleSelection.map(v => v.id)  // [{}, {}, {}] => [1,2,3]
      console.log("ids:", ids)
      request.post("/role/del/batch", ids).then(res => {
        if (res.code === "200") {
          this.$message.success("批量删除成功")
          this.load()
        } else {
          this.$message.error("批量删除失败,原因：" + res.msg)
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
     * 分配菜单
     * */
    selectMenu(role) {
      this.roleId = role.id
      this.rolename = role.rolename
      this.menuDialogVisible = true

      // 查询菜单信息
      request.get("/menu").then(res => {
        if (res.code !== "200") {
          this.$message.error(res.msg)
        }
        this.menuData = res.data;
        console.log("menuData:", this.menuData)
        this.expends = this.menuData.map(v => v.menuId)// 默认展开所有节点
        console.log("expends:", this.expends)
      })

      // 根据角色id查询对应的菜单信息 默认选中
      request.get("/role/roleMenu/" + this.roleId).then(res => {
        if (res.code === "200") {
          this.checks = res.data
          console.log("checks:", this.checks)
        } else {
          this.$message.error("查询失败")
        }
      })


    },

    /**
     * 编辑用户信息
     * */
    handleEdit(row) {
      this.form = row
      this.dialogFormVisible = true
    },

    /**
     * 删除用户信息
     * */
    del(id) {
      console.log("id:", id)
      request.delete("/role/" + id).then(res => {
        console.log("是否删除:", res)
        if (res.data) {
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
      console.log("form:", this.form)
      request.post("/role", this.form).then(res => {
        if (res.data) {
          this.$message.success("保存成功")
          this.dialogFormVisible = false
          this.load()
        } else {
          this.$message.error("保存失败")
        }
      })
    },

    /**
     * 保存角色菜单信息
     * */
    saveRoleMenu() {
      let checks = this.$refs.tree.getCheckedKeys()
      console.log(this.tableData)
      request.post("/role/roleMenu/" + this.roleId, checks).then(res => {
        // 只有管理员才有权限分配菜单，如果当前用户是管理员，那么需要重新登录
        if (this.rolename === "Admin" && res.code === "200") {
          this.$message.success("绑定成功，您的角色信息已经发生变化，请重新登录")
          this.$store.commit("logout")
          return
        } 
        if (res.code === "200") {
          this.$message.success("绑定成功")
          this.menuDialogVisible = false
          console.log("form.id:", this.roleId)
          console.log("checks:", checks)
        } else {
          this.$message.error("保存失败")
        }
      })
    }
  }
}
</script>

<style>
.headerBg {
  background: #eee !important;
}
</style>
