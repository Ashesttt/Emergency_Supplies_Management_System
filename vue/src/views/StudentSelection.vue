<template>
  <div>
    <div style="margin-bottom: 30px">

    </div>

    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入课程名称" suffix-icon="el-icon-user"
                v-model="coursename"></el-input>
      <el-input style="width: 200px" placeholder="请输入老师名字" suffix-icon="el-icon-search" class="ml-5"
                v-model="username"></el-input>


      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button class="ml-5" type="warning" @click="reset">重置</el-button>
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="courseId" label="课程id">
      </el-table-column>
      <el-table-column prop="coursename" label="课程名字">
      </el-table-column>
      <el-table-column prop="username" label="老师名字">
      </el-table-column>
      <el-table-column prop="courseTime" label="课时">
      </el-table-column>
      <el-table-column prop="description" label="课程描述">
      </el-table-column>
      <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">
          <el-button type="primary" @click="handleEdit(scope.row)">选这个课 <i class="el-icon-edit"></i></el-button>
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

    <el-dialog title="请确定选择这个课程" :visible.sync="dialogFormVisible" width="30%">
      <el-form label-width="90px" size="small">
        <el-form-item label="课程名字">
          <el-input v-model="form.coursename" autocomplete="off" disabled></el-input>
        </el-form-item>
        <el-form-item label="请分配老师">
          <el-select clearable v-model="form.userId" placeholder="请选择老师" style="width: 100%" disabled>
            <el-option
                v-for="item in options"
                :key="item.userId"
                :label="item.username"
                :value="item.userId">
              {{ item.username }}
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="课时">
          <el-input v-model="form.courseTime" autocomplete="off" disabled></el-input>
        </el-form-item>
        <el-form-item label="课程描述">
          <el-input v-model="form.description" autocomplete="off" disabled></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消 选 择</el-button>
        <el-button type="primary" @click="save">确 定 选 择</el-button>
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
      username: "",
      courseId: "",
      coursename: "",
      studentId: "",
      courseTime: "",
      form: {},
      dialogFormVisible: false,
      multipleSelection: [],
      msg: "hello hjh",
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
    let user = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}//获取用户信息
    console.log("user:", user)
    this.userRole = user.userRole
    this.StudentName = user.username
    this.load()
    /**
     * 获取所有角色为老师的用户
     * */
    request.get("/user/getTeacher").then(res => {
      console.log(res)
      if (res.code === "200") {
        this.options = res.data;
      }
    })
  },


  methods: {
    /**
     * 查询数据方法
     * */
    load() {
      request.get("/course/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          coursename: this.coursename,
          username: this.username,
        }
      }).then(res => {
        console.log(res)
        if (res.code !== "200") {
          this.$message.error(res.msg)
        }
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
        this.username = "";
        this.coursename = "";
        this.load();
      } catch (error) {
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
     * 处理选中的数据
     * */
    handleSelectionChange(val) {
      console.log("val:", val)
      this.multipleSelection = val
    },

    /**
     * 编辑课程信息
     * */
    handleEdit(row) {
      this.form = row
      this.dialogFormVisible = true
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
      console.log("userRole:", this.userRole)
      if ( this.userRole !== "Student") {
        this.$message.error("只有学生才能选课")
        return
      }
      this.form.StudentName = this.StudentName
      console.log("form:", this.form)
      request.post("/courseSelections/select", this.form).then(res => {
        if (res.code === "200") {
          this.$message.success(res.msg)
          this.dialogFormVisible = false
        } else {
          this.$message.error(res.msg)
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
