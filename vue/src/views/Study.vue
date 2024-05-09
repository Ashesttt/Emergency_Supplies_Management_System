<template>
  <div>
    <div style="margin-bottom: 30px">

    </div>

    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入课程名称" suffix-icon="el-icon-user"
                v-model="courseName"></el-input>


      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button class="ml-5" type="warning" @click="reset">重置</el-button>
    </div>


    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="courseSelectionId" label="课程id">
      </el-table-column>
      <el-table-column prop="courseName" label="课程名字">
      </el-table-column>
      <el-table-column prop="userName" label="学生名字">
      </el-table-column>
      <el-table-column prop="studyTime" label="学生学习时长">
      </el-table-column>
      <el-table-column prop="score" label="教师评分">
      </el-table-column>
      <el-table-column prop="selectedTime" label="选课时间">
      </el-table-column>
      <el-table-column prop="updatedTime" label="更新时间">
      </el-table-column>
      <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">
          <el-button type="primary" @click="handleEdit(scope.row)">学习时长 <i class="el-icon-edit"></i></el-button>
          <el-button type="primary" @click="save">确 定</el-button>
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
    
    <el-dialog title="学习时长" :visible.sync="dialogFormVisible" width="30%">
      <el-form label-width="90px" size="small">
        <el-form-item label="课程名字">
          <el-input v-model="form.courseName" autocomplete="off" disabled></el-input>
        </el-form-item>
        <el-form-item label="课时">
          <el-input v-model="form.studyTime" autocomplete="off"></el-input>
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
      courseName: "",
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
    this.load(user.username)
  },
  methods: {
    /**
     * 查询数据方法
     * */
    load(username) {
      console.log("username:", username)
      request.get("/courseSelections/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          coursename: this.courseName,
          username: username,
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
    
    formatTooltip(val) {
      return val / 100;
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
      console.log("row:", row)
      this.form = row
      this.dialogFormVisible = true
    },

    /**
     * 删除用户信息
     * */
    del(id) {
      console.log("id:", id)
      request.delete("/courseSelections/" + id).then(res => {
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
      request.post("/courseSelections", this.form).then(res => {
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
