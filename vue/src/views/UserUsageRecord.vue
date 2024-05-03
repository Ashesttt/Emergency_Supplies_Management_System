<template>
  <div>
    <div style="margin-bottom: 30px"></div>

    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入用户名" suffix-icon="el-icon-search"
                v-model="username"></el-input>
      <el-select clearable v-model="userRole" placeholder="请选择用户身份" style="width: 200px"
                 suffix-icon="el-icon-user" class="ml-5">
        <el-option
            v-for="item in options_userRole"
            :key="item.rolename"
            :label="item.description"
            :value="item.rolename">
          {{ item.description }}({{ item.rolename }})
        </el-option>
      </el-select>
      <el-input style="width: 200px" placeholder="请输入物资名字" suffix-icon="el-icon-search" class="ml-5"
                v-model="materialName"></el-input>
      <el-select clearable v-model="materialType" placeholder="请选择物资种类" style="width: 200px"
                 suffix-icon="el-icon-user" class="ml-5">
        <el-option
            v-for="item in options_materialType"
            :key="item"
            :label="item"
            :value="item">
          <div style="display: flex; align-items: center;">
            <i :class="icon_materialType(item)" style="font-size: 25px"></i>
            {{ item }}
            <!--            <i :class="icon_materialType(item)" style="font-size: 25px"></i>-->
          </div>
        </el-option>
      </el-select>

      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button class="ml-5" type="warning" @click="reset">重置</el-button>
    </div>

    <div style="margin: 10px 0">
      <el-popconfirm
          class="ml-5"
          confirm-button-text='确定'
          cancel-button-text='取消'
          icon="el-icon-warning"
          icon-color="red"
          title="您确定批量删除这些用户使用记录吗？"
          @confirm="delBatch"
      >
        <el-button type="danger" slot="reference">批量删除 <i class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>

    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="userUsageRecordId" label="用户使用记录id">
      </el-table-column>

      <el-table-column prop="recordTime" label="出库时间" width="150">
      </el-table-column>
      <el-table-column prop="avatarurl" label="使用人">
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
            {{ scope.row.userName }}
          </div>
        </template>
      </el-table-column>

      <el-table-column prop="userRole" label="使用人角色">
      </el-table-column>

      <el-table-column prop="usageReason" label="使用原因">
      </el-table-column>

      <el-table-column prop="materialUrl" label="使用物资名称">
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

      <el-table-column prop="materialType" label="使用物资类型">
        <template slot-scope="scope">
          <div style="display: flex; align-items: center;">
            <i :class="icon_materialType(scope.row.materialType)" style="font-size: 25px"></i>
            {{ scope.row.materialType }}
            <!--            <i :class="icon_materialType(scope.row.materialType)" style="font-size: 25px"></i>-->
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="quantityBeforeUse" label="使用前拥有物资总量">
      </el-table-column>
      <el-table-column prop="userUsageQuantity" label="使用数量">
      </el-table-column>


      <el-table-column label="操作" width="300" align="center">
        <template slot-scope="scope">
          <el-popconfirm
              class="ml-5"
              confirm-button-text='确定'
              cancel-button-text='取消'
              icon="el-icon-warning"
              icon-color="red"
              title="您确定删除这个用户信息吗？"
              @confirm="del(scope.row.userUsageRecordId)"
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
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "UserUsageRecord",
  data() {
    return {
      tableData: [],
      code: "",
      total: 0,
      pageNum: 1,
      pageSize: 10,
      usageRecordId: "",
      userUsageRecordId: "",
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
      options_userRole: [],
      options_materialType: [],
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
      request.get("/userusagerecord/page", {
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
        this.$message.success("查询成功")
        this.tableData = res.data.records;
        this.total = res.data.total;
      })


      /**
       * 获取物资类型
       * */
      request.get("/material/materialType").then(res => {
        console.log("res:", res)
        if (res.code !== "200") {
          this.$message.error("获取失败,原因：" + res.msg)
        } else {
          this.options_materialType = res.data;
        }
      })

      /**
       * 获取搜索栏的role身份选择
       * */
      request.get("/role").then(res => {
        console.log(res)
        if (res.code === "200") {
          this.options_userRole = res.data;
          console.log("this.options：" + this.options)
        }
      })
    },

    /**
     * 物资类型图标
     * */
    icon_materialType(materialType) {
      if (materialType === "Medical") {
        return "icon_Medical"
      } else if (materialType === "Fire_Rescue") {
        return "icon_Fire_Rescue"
      } else if (materialType === "Protection") {
        return "icon_Protection"
      } else if (materialType === "Communication") {
        return "icon_Communication"
      } else if (materialType === "Alarm") {
        return "icon_Alarm"
      } else if (materialType === "Engineering_Rescue") {
        return "icon_Engineering_Rescue"
      } else {
        return "el-icon-loading"
      }
    },


    /**
     * 重置查询条件
     * */
    async reset() {
      try {
        await this.handle_reset();
        this.userName = "";
        this.userRole = "";
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
     * 批量删除
     * */
    delBatch() {
      let ids = this.multipleSelection.map(v => v.userUsageRecordId)  // [{}, {}, {}] => [1,2,3]
      console.log("ids:", ids)
      request.post("/userusagerecord/del/batch", ids).then(res => {
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
     * 删除用户信息
     * */
    del(id) {
      console.log("id:", id)
      request.delete("/userusagerecord/" + id).then(res => {
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
