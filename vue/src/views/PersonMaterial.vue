<template>
  <div>
    <div style="margin-bottom: 30px">
    </div>

    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入物资名字" suffix-icon="el-icon-search" class="ml-5"
                v-model="materialName"></el-input>
      <el-select clearable v-model="materialType" placeholder="请选择物资种类" style="width: 200px"
                 suffix-icon="el-icon-user" class="ml-5">
        <el-option
            v-for="item in options_materialType"
            :key="item"
            :label="item"
            :value="item">
          {{ item }}
        </el-option>
      </el-select>

      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button class="ml-5" type="warning" @click="reset">重置</el-button>
    </div>

    <div style="margin: 10px 0">
      <el-button type="success" @click="handleApply">申请 <i class="el-icon-circle-plus-outline"></i></el-button>
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="avatarurl" label="用户名">
        <template slot-scope="scope">
          <div style="display: flex; justify-content: center; align-items: center;">
            <el-image
                style="width: 30px; height: 30px; border-radius:50%;"
                :src="scope.row.avatarurl ? scope.row.avatarurl : 'https://img2.baidu.com/it/u=1917387172,3574852173&fm=253&fmt=auto&app=120&f=JPEG?w=607&h=342'"
                :preview-src-list="[scope.row.avatarurl]"
                fit="cover"
            ></el-image>
          </div>
          <div style="display: flex; justify-content: center; align-items: center;">
            {{ scope.row.username }}
          </div>
        </template>
      </el-table-column>

      <el-table-column prop="userRole" label="用户角色">
      </el-table-column>

      <!--      <el-table-column prop="materialName" label="物资名称">-->
      <!--      </el-table-column>-->
      <el-table-column prop="materialUrl" label="物资名称">
        <template slot-scope="scope">
          <div style="display: flex; justify-content: center; align-items: center;">
            <el-image
                style="width: 30px; height: 30px; border-radius:50%;"
                :src="scope.row.materialUrl ? scope.row.materialUrl : 'https://img2.baidu.com/it/u=1917387172,3574852173&fm=253&fmt=auto&app=120&f=JPEG?w=607&h=342'"
                :preview-src-list="[scope.row.materialUrl]"
                fit="cover"
            ></el-image>
          </div>
          <div style="display: flex; justify-content: center; align-items: center;">
            {{ scope.row.materialName }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="materialType" label="物资类型">
      </el-table-column>

      <el-table-column prop="quantity" label="该用户的仓库总量">
      </el-table-column>


      <el-table-column label="操作" width="300" align="center">
        <template slot-scope="scope">
          <el-button type="primary" slot="reference" @click="handleUse(scope.row.materialId,scope.row.materialName)">使用
            <i class="el-icon-remove-outline"></i>
          </el-button>
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


      <el-dialog title="申请物资" :visible.sync="ApplyFormVisible" width="30%">
        <el-form label-width="80px" size="small">
          <el-form-item label="物资名字">
            <el-select clearable v-model="damn.materialName" placeholder="请选择物资名字" style="width: 100%">
              <el-option
                  v-for="item in options_materialName"
                  :key="item"
                  :label="item"
                  :value="item">
                {{ item }}
              </el-option>
            </el-select>
          </el-form-item>

          <el-form-item label="申请数量">
            <el-input v-model="form.applyQuantity" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="申请原因">
            <el-input v-model="form.applyReason" autocomplete="off"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="ApplyFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="apply(damn.materialName)">确 定</el-button>
        </div>
      </el-dialog>

      <el-dialog title="使用物资" :visible.sync="UseFormVisible" width="30%">
        <el-form label-width="80px" size="small">
          <el-form-item label="物资名字">
            <el-input v-model="Useform.materialName" autocomplete="off" disabled></el-input>
          </el-form-item>

          <el-form-item label="使用数量">
            <el-input v-model="Useform.usage_quantity" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="使用原因">
            <el-input v-model="Useform.usage_reason" autocomplete="off"></el-input>
          </el-form-item>


        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="UseFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="use()">确 定</el-button>
        </div>
      </el-dialog>


    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "PersonMaterial",
  data() {
    return {
      tableData: [],
      code: "",
      total: 0,
      pageNum: 1,
      pageSize: 10,
      usageRecordId: "",
      username: "",
      userRole: "",
      userId: "",
      materialId: "",
      materialName: "",
      materialType: "",
      quantity: "",
      materialUrl: "",
      productionDate: "",
      expiryDate: "",
      status: "",
      applyQuantity: "",
      applyReason: "",
      usage_quantity: "",
      usage_reason: "",
      form: {},
      damn: {},
      Useform: {},
      multipleSelection: [],
      msg: "hello mxy",
      collapseBtnClass: "el-icon-s-fold",
      isCollapse: false, // 是否收缩
      sideWidth: 200,
      logoTextShow: true, // logo文字是否显示
      headerBg: "headerBg",
      ApplyFormVisible: false, // 申请弹窗可视化
      UseFormVisible: false, // 使用弹窗可视化
      options_userRole: [],
      options_materialType: [],
      options_materialName: [],
    }
  },
  created() {
    // 获取当前用户姓名和角色
    let user = localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')) : {};
    this.username = user.username;
    this.userRole = user.userRole;
    // 获取当前用户id
    request.get("/user/username/" + this.username).then(res => {
      if (res.code !== "200") {
        this.$message.error("获取失败,原因：" + res.msg)
      } else {
        this.userId = res.data.userId;
      }
    })
    // 请求分页查询数据
    this.load()
  },


  methods: {
    /**
     * 查询数据方法
     * */
    load() {
      request.get("/user_material/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          username: this.username,
          userRole: this.userRole,
          materialName: this.materialName,
          materialType: this.materialType,
        }
      }).then(res => {
        console.log(res)
        if (res.code !== "200") {
          this.$message.error(res.msg)
        }
        this.tableData = res.data.records;
        this.total = res.data.total;
      })


      /**
       * 获取物资类型
       * */
      request.get("/material/materialType").then(res => {
        if (res.code !== "200") {
          this.$message.error("获取失败,原因：" + res.msg)
        } else {
          this.options_materialType = res.data;
        }
      })

      /**
       * 获取物资名字
       * */
      request.get("/material/materialName").then(res => {
        if (res.code !== "200") {
          this.$message.error("获取失败,原因：" + res.msg)
        } else {
          this.options_materialName = res.data;
        }
      })
    },

    /**
     * 申请物资弹窗
     * */
    handleApply() {
      this.ApplyFormVisible = true
      this.form = {}
      // 当前用户id放去申请表单form中
      this.form.userId = this.userId
    },

    /**
     * 申请物资
     * */
    apply(materialName) {
      if (!this.damn.materialName) {
        this.$message.error("请选择要申请的物资")
        return
      }
      if (!this.form.applyQuantity) {
        this.$message.error("申请数量不能为空")
        return
      }
      if (!this.form.applyReason) {
        this.$message.error("申请原因不能为空")
        return
      }
      // 通过materialName获取materialId
      // let materialName = this.damn.materialName;
      request.get("/material/materialId/", {
        params: {
          materialName
        }
      }).then(res => {
        if (res.code !== "200") {
          this.$message.error("获取失败,原因：" + res.msg)
        } else {
          this.materialId = res.data;
          this.form.materialId = this.materialId// 物资id放去申请表单form中

          //提交申请表单
          // form中只有userId，materialId，apply_quantity，apply_reason
          request.post("/apply", this.form).then(res => {
            if (res.code === "200") {
              this.$message.success("申请成功")
              this.ApplyFormVisible = false
              this.load()
            } else {
              this.$message.error("申请失败")
            }
          })

        }
      })
    },


    /**
     * 重置查询条件
     * */
    async reset() {
      try {
        await this.handle_reset();
        this.materialName = "";
        this.materialType = "";
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
     * 处理选中的数据
     * */
    handleSelectionChange(val) {
      console.log("val:", val)
      this.multipleSelection = val
    },

    /**
     * 申请物资弹窗
     * */
    handleUse(materialId, materialName) {
      this.UseFormVisible = true
      this.Useform = {}
      // 当前用户id放去使用表单Useform中
      this.Useform.userId = this.userId
      this.Useform.materialId = materialId
      this.Useform.materialName = materialName
    },


    /**
     * 使用
     * */
    use() {
      if (!this.Useform.usage_quantity) {
        this.$message.error("使用数量不能为空")
        return
      }
      if (!this.Useform.usage_reason) {
        this.$message.error("使用原因不能为空")
        return
      }
      request.post("/user_material/use", null, {
        params: {
          userId: this.Useform.userId,
          materialId: this.Useform.materialId,
          usage_quantity: this.Useform.usage_quantity,
          usage_reason: this.Useform.usage_reason
        }
      }).then(res => {
        if (res.code !== "200") {
          this.$message.error("使用失败,原因：" + res.msg)
        } else {
          this.$message.success("使用成功")
          this.UseFormVisible = false

          this.load()
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
    }
    ,

    /**
     * 处理页码改变
     * */
    handleCurrentChange(pageNum) {
      console.log(pageNum)
      this.pageNum = pageNum;
      this.load()
    }
    ,
  }
}
</script>

<style>
.headerBg {
  background: #eee !important;
}

.avatar {
  width: 138px;
  height: 138px;
  display: block;
}

.avatar-uploader {
  text-align: center;
  padding-bottom: 10px;
}
</style>
