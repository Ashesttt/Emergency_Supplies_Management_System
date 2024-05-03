<template>
  <div>
    <div style="margin-bottom: 30px">
    </div>

    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入物资名字" suffix-icon="el-icon-search" class="ml-5"
                v-model="materialName"></el-input>
      <el-select clearable v-model="approvalStatus" placeholder="请选择审批状态" style="width: 200px"
                 suffix-icon="el-icon-user" class="ml-5">
        <el-option
            v-for="item in options_approvalStatus"
            :key="item"
            :label="item"
            :value="item">
          <div style="display: flex; align-items: center;">
            <i :class="icon_approvalStatus(item)" style="font-size: 25px"></i>
            {{ item }}
<!--            <i :class="icon_approvalStatus(item)" style="font-size: 25px"></i>-->
          </div>
        </el-option>
      </el-select>

      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button class="ml-5" type="warning" @click="reset">重置</el-button>
    </div>

    <div style="margin: 10px 0">

    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="applicationId" label="申请id" sortable>
      </el-table-column>
      <el-table-column prop="applyTime" label="申请时间" width="150px">
      </el-table-column>
      <el-table-column prop="applyReason" label="申请原因">
      </el-table-column>
      <el-table-column prop="avatarurl" label="申请人">
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
      <el-table-column prop="materialUrl" label="申请的物资">
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
      <el-table-column prop="applyQuantity" label="申请数量">
      </el-table-column>
      <el-table-column prop="approvalStatus" label="申请状态" width="180px">
        <template slot-scope="scope">
          <div style="display: flex; align-items: center;">
            <i :class="icon_approvalStatus(scope.row.approvalStatus)" style="font-size: 25px"></i>
            {{ scope.row.approvalStatus }}
<!--            <i :class="icon_approvalStatus(scope.row.approvalStatus)" style="font-size: 25px"></i>-->
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="transportId" label="运输单号">
      </el-table-column>
      <el-table-column prop="destination" label="目的地">
      </el-table-column>
      <el-table-column prop="approvalComment" label="审批备注" width="210px">
      </el-table-column>
      <el-table-column prop="approvalTime" label="审批时间" width="150px">
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
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "UserMaterial",
  data() {
    return {
      tableData: [],
      code: "",
      total: 0,
      pageNum: 1,
      pageSize: 10,
      usageRecordId: "",
      applicationId: "",
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
      approvalStatus: "",
      form: {},
      Rejectform: {},
      dialogFormVisible: false,
      multipleSelection: [],
      msg: "hello mxy",
      collapseBtnClass: "el-icon-s-fold",
      isCollapse: false, // 是否收缩
      sideWidth: 200,
      logoTextShow: true, // logo文字是否显示
      headerBg: "headerBg",
      dialogVisible: false, // 弹窗可视化
      RejectFormVisible: false, //拒绝弹窗可视化
      options_userRole: [],
      options_materialType: [],
      options_approvalStatus: [],
      approvalComment: "",
    }
  },
  created() {
    // 请求分页查询数据
    let user = JSON.parse(localStorage.getItem("user"));
    this.username = user.username;
    this.load()
  },


  methods: {
    formatter(row, column) {
      return row.address;
    },
    /**
     * 查询数据方法
     * */
    load() {
      request.get("/apply/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          username: this.username,
          materialName: this.materialName,
          approvalStatus: this.approvalStatus
        }
      }).then(res => {
        console.log(JSON.parse(JSON.stringify(res)))
        if (res.code !== "200") {
          this.$message.error(res.msg)
        }
        this.$message.success("查询成功")
        this.tableData = res.data.records;
        this.total = res.data.total;
      })

      /**
       * 获取所有申请状态
       * */
      request.get("/apply/approvalStatus").then(res => {
        console.log("res:", res)
        if (res.code !== "200") {
          this.$message.error("获取失败,原因：" + res.msg)
        } else {
          this.options_approvalStatus = res.data;
        }
      })

    },

    /**
     * 用approvalStatus来返回对应的图标
     * */
    icon_approvalStatus(approvalStatus) {
      if (approvalStatus === "Pending") {
        return "el-icon-loading"
      } else if (approvalStatus === "Approved") {
        return "icon_Approved"
      } else if (approvalStatus === "Rejected") {
        return "icon_Rejected"
      } else if (approvalStatus === "Canceled") {
        return "icon_Canceled"
      } else if (approvalStatus === "Completed") {
        return "icon_Completed"
      } else if (approvalStatus === "Processing") {
        return "icon_Processing"
      } else if (approvalStatus === "InsufficientStock") {
        return "icon_InsufficientStock"
      } else if (approvalStatus === "Transporting") {
        return "icon_Transporting"
      } else {
        return "icon_Unknow"
      }
    },


    /**
     * 重置查询条件
     * */
    async reset() {
      try {
        await this.handle_reset();
        this.materialName = "";
        this.approvalStatus = "";
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
