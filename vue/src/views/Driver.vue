<template>
  <div>
    <div style="margin-bottom: 30px">
    </div>

    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入订单号" suffix-icon="el-icon-search"
                v-model="transportId"></el-input>
      <el-input style="width: 200px" placeholder="请输入接收用户名" suffix-icon="el-icon-search" class="ml-5"
                v-model="username"></el-input>
      <el-input style="width: 200px" placeholder="请输入物资名字" suffix-icon="el-icon-search" class="ml-5"
                v-model="materialName"></el-input>
      <el-select clearable v-model="transportStatus" placeholder="请选择运输状态" style="width: 200px"
                 suffix-icon="el-icon-user" class="ml-5">
        <el-option
            v-for="item in options_transportStatus"
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

    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="transportId" label="运输id" sortable>
      </el-table-column>
      <el-table-column prop="avatarurl" label="接收人">
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
      <el-table-column prop="materialUrl" label="运送的物资">
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
      <el-table-column prop="quantity" label="物资数量">
      </el-table-column>
      <el-table-column prop="transportStatus" label="运输状态">
      </el-table-column>
      <el-table-column prop="destination" label="目的地">
      </el-table-column>
      <el-table-column prop="startTime" label="订单开始时间">
      </el-table-column>
      <el-table-column prop="endTime" label="订单结束时间" width="150px">
      </el-table-column>


      <el-table-column label="操作" align="center" width="200px">
        <template slot-scope="scope">
          <el-button type="success" slot="reference" @click="Arrive(scope.row)">已到达 <i
              class="el-icon-circle-check"></i>
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
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Driver",
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
      driverAvatarurl: "",
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
      AssignDriverFormVisible: false, //分配司机弹窗可视化
      options_transportStatus: [],
      transportStatus: "",
      driverName: "",
      transportId: "",
      Assignform: {},
      options_driver: [],
      driver: "",
      driverId: "",
    }
  },
  created() {
    // 请求分页查询数据
    let user = localStorage.getItem('user') ? JSON.parse(localStorage.getItem('user')) : {};
    this.load(user)
  },


  methods: {
    /**
     * 查询数据方法
     * */
    load(user) {
      request.get("/transport/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          transportId: this.transportId,
          username: this.username,
          materialName: this.materialName,
          driverName: user.username,
          transportStatus: this.transportStatus
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
      request.get("/transport/transportStatus").then(res => {
        console.log("res:", res)
        if (res.code !== "200") {
          this.$message.error("获取失败,原因：" + res.msg)
        } else {
          this.options_transportStatus = res.data;
        }
      })
    },


    /**
     * 重置查询条件
     * */
    async reset() {
      try {
        await this.handle_reset();
        this.transportId = "";
        this.username = "";
        this.materialName = "";
        this.transportStatus = "";
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
     * 已到达
     * */
    Arrive(row) {
      console.log("row:", row)
      this.$confirm('确认已到达？')
          .then(_ => {
            request.put("/transport/arrive", {
              transportId: row.transportId
            }).then(res => {
              if (res.code !== "200") {
                this.$message.error("操作失败,原因：" + res.msg)
              } else {
                this.$message.success("操作成功")
              }
            })
          })
          .catch(_ => {
            this.$message.info('已取消操作');
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
