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
      <el-input style="width: 200px" placeholder="请输入司机名字" suffix-icon="el-icon-search" class="ml-5"
                v-model="driverName"></el-input>
      <el-select clearable v-model="transportStatus" placeholder="请选择运输状态" style="width: 200px"
                 suffix-icon="el-icon-user" class="ml-5">
        <el-option
            v-for="item in options_transportStatus"
            :key="item"
            :label="item"
            :value="item">
          <div style="display: flex; align-items: center;">
            <i :class="icon_transportStatus(item)" style="font-size: 25px"></i>
            {{ item }}
            <!--            <i :class="icon_transportStatus(item)" style="font-size: 25px"></i>-->
          </div>
        </el-option>
      </el-select>

      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button class="ml-5" type="warning" @click="reset">重置</el-button>
    </div>

    <div style="margin: 10px 0">

    </div>

    <el-table :data="tableData" border :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange" :row-class-name="tableRowClassName">
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
      <el-table-column prop="driverAvatarurl" label="司机">
        <template slot-scope="scope">
          <div style="display: flex; justify-content: center; align-items: center;">
            <el-image
                v-if="scope.row.driverAvatarurl"
                style="width: 30px; height: 30px; border-radius:50%;"
                :src="scope.row.driverAvatarurl ? scope.row.driverAvatarurl : 'https://img2.baidu.com/it/u=1917387172,3574852173&fm=253&fmt=auto&app=120&f=JPEG?w=607&h=342'"
                :preview-src-list="[scope.row.driverAvatarurl]"
                fit="cover"
            ></el-image>
          </div>
          <div v-if="scope.row.driverName" style="display: flex; justify-content: center; align-items: center;">
            {{ scope.row.driverName }}
          </div>
          <div v-else="" style="display: flex; justify-content: center; align-items: center;">
            未分配司机，请分配司机
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="transportStatus" label="运输状态">
        <template slot-scope="scope">
          <div style="display: flex; align-items: center;">
            <i :class="icon_transportStatus(scope.row.transportStatus)" style="font-size: 25px"></i>
            {{ scope.row.transportStatus }}
            <!--            <i :class="icon_transportStatus(scope.row.transportStatus)" style="font-size: 25px"></i>-->
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="destination" label="目的地">
      </el-table-column>
      <el-table-column prop="startTime" label="订单开始时间" sortable>
      </el-table-column>
      <el-table-column prop="endTime" label="订单结束时间" width="150px">
      </el-table-column>


      <el-table-column label="操作" align="center" width="200px">
        <template slot-scope="scope">
          <el-button type="success" slot="reference" @click="handleAssign(scope.row)">分配司机 <i
              class="el-icon-circle-check"></i>
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog title="分配司机" :visible.sync="AssignDriverFormVisible" width="30%">
      <el-form label-width="80px" size="small">
        <el-form-item label="选择司机">
          <el-select clearable v-model="Assignform.driver" placeholder="请选择司机名字" style="width: 100%">
            <el-option
                v-for="item in options_driver"
                :key="item.userId"
                :value="item">
              {{ item.username }}
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="司机头像" v-if="Assignform.driver">
          <div style="display: flex; justify-content: center; align-items: center;">
            <el-image
                style="width: 50px; height: 50px; border-radius:50%;"
                :src="Assignform.driver.avatarurl ? Assignform.driver.avatarurl : 'https://img2.baidu.com/it/u=1917387172,3574852173&fm=253&fmt=auto&app=120&f=JPEG?w=607&h=342'"
                :preview-src-list="[Assignform.driver.avatarurl]"
                fit="cover"
            ></el-image>
          </div>
        </el-form-item>
        <el-form-item label="司机名字" v-if="Assignform.driver">
          <el-input v-model="Assignform.driver.username" disabled></el-input>
        </el-form-item>
        <el-form-item label="司机电话" v-if="Assignform.driver">
          <el-input v-model="Assignform.driver.phone" disabled></el-input>
        </el-form-item>
        <el-form-item label="司机email" v-if="Assignform.driver">
          <el-input v-model="Assignform.driver.email" disabled></el-input>
        </el-form-item>


      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="AssignDriverFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="Assign(Assignform.driver)">确 定 分 配</el-button>
      </div>
    </el-dialog>


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
      userId: "99999",
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
    // 获取查询参数
    const transportId = this.$route.query.transportId;

    // 如果有 materialName 参数，使用它来过滤出库记录
    if (transportId) {
      this.transportId = transportId;
    }
    this.load();
  },


  methods: {
    /**
     * 查询数据方法
     * */
    load() {
      request.get("/transport/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          transportId: this.transportId,
          username: this.username,
          materialName: this.materialName,
          driverName: this.driverName,
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
        if (res.code !== "200") {
          this.$message.error("获取失败,原因：" + res.msg)
        } else {
          this.options_transportStatus = res.data;
        }
      })

      /**
       *  获取全部司机信息
       * */
      request.get("/user/driver").then(res => {
        if (res.code !== "200") {
          this.$message.error("获取失败,原因：" + res.msg)
        } else {
          this.options_driver = res.data
          console.log("this.options_driver:", this.options_driver)
        }
      })
    },

    /**
     * 根据icon_transportStatus返回不同的图标
     * */
    icon_transportStatus(transportStatus) {
      if (transportStatus === "Transporting") {
        return "icon_Transporting"
      } else if (transportStatus === "Arrived") {
        return "icon_Arrived"
      } else if (transportStatus === "Assign") {
        return "icon_Assign"
      } else {
        return "icon_Unknow"
      }
    },
    
    /**
     * 根据transportStatus返回不同的table样式
     * */
    tableRowClassName({row}) {
      if (row.transportStatus === "Transporting") {
        return "Transporting-row"
      } else if (row.transportStatus === "Arrived") {
        return "Arrived-row"
      } else if (row.transportStatus === "Assign") {
        return "Assign-row"
      } else {
        return ""
      }
      
      
      
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
        this.driverName = "";
        this.transportStatus = "";
        this.load();
        // 清除 URL 中的 materialName 参数
        this.$router.push({path: '/transport'});
      } catch (error) {
        // 用户点击了取消，所以不执行任何操作
      }
    },
    
    /**
     * 重置，纯享版
     * */
    resett() {
      this.transportId = "";
      this.username = "";
      this.materialName = "";
      this.driverName = "";
      this.transportStatus = "";
      this.load();

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
     * 处理分配司机
     * */
    handleAssign(row) {
      this.AssignDriverFormVisible = true
      this.transportId = row.transportId
    },

    /**
     * 分配司机
     * */
    Assign(driver) {
      console.log("driver:", driver)
      if (driver === "" || driver === undefined) {
        this.$message.error("请选择司机")
        return
      }
      if (driver.userId) {
        let driverId = driver.userId
        let transportId = this.transportId
        console.log("this.Assignform:", this.Assignform)
        request.post("/transport/assign", {
          transportId: transportId,
          driverId: driverId
        }).then(res => {
          if (res.code !== "200") {
            this.$message.error(res.msg)
          } else {
            this.$message.success("分配成功")
            this.AssignDriverFormVisible = false
            this.resett()
          }
        })
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
  }
}
</script>

<style>
.headerBg {
  background: #eee !important;
}


.el-table .Transporting-row {
  background-color: rgba(0, 255, 255, 0.1); /* Or any other style you want */
}

.el-table .Arrived-row {
  background-color: rgba(0, 255, 0, 0.1); /* Or any other style you want */
}

.el-table .Assign-row {
  background-color: rgba(255, 255, 0, 0.5); /* Or any other style you want */
}
</style>
