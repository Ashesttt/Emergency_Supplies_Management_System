<template>
  <div>
    <div style="margin-bottom: 30px">

    </div>

    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入物资名字" suffix-icon="el-icon-search"
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
      <el-select clearable v-model="status" placeholder="请选择物资状态" style="width: 200px"
                 suffix-icon="el-icon-user" class="ml-5">
        <el-option
            v-for="item in options_status"
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
      <el-button type="primary" @click="handleAdd">新增 <i class="el-icon-circle-plus-outline"></i></el-button>
      <el-popconfirm
          class="ml-5"
          confirm-button-text='确定'
          cancel-button-text='取消'
          icon="el-icon-warning"
          icon-color="red"
          title="您确定批量删除这些物资信息吗？"
          @confirm="delBatch"
      >
        <el-button type="danger" slot="reference">批量删除 <i class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>

    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="materialId" label="物资ID" width="100">
      </el-table-column>
      <el-table-column prop="materialUrl" label="物资的照片" width="100">
        <template slot-scope="scope">
          <div style="display: flex; justify-content: center; align-items: center;">
            <el-image
                style="width: 50px; height: 50px; border-radius:50%;"
                :src="scope.row.materialUrl ? scope.row.materialUrl : 'https://th.bing.com/th/id/R.7b1a08b9cad671ec7cd3f40a937cf90c?rik=bscFCAJCax1ZJg&riu=http%3a%2f%2fbpic.588ku.com%2felement_pic%2f19%2f03%2f29%2f32fd5b5d10ca51980988fedeb9ecd694.jpg&ehk=EBfBi6AGEGxpmzZ4S6BvITM75dU67ZEekiA%2bh0bxbtc%3d&risl=&pid=ImgRaw&r=0'"
                :preview-src-list="[scope.row.materialUrl]"
                fit="cover"
            ></el-image>
          </div>
        </template>
      </el-table-column>

      <el-table-column prop="materialName" label="物资名字">
      </el-table-column>
      <el-table-column prop="materialType" label="物资类型" width="180px">
        <template slot-scope="scope">
          <div style="display: flex; align-items: center;">
            <i :class="icon_materialType(scope.row.materialType)" style="font-size: 25px"></i>
            {{ scope.row.materialType }}
            <!--            <i :class="icon_materialType(scope.row.materialType)" style="font-size: 25px"></i>-->
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="quantity" label="数量">
      </el-table-column>
      <el-table-column prop="productionDate" label="生产日期">
      </el-table-column>
      <!--TODO: 查看今日日期，对比到期日期，再判断这个物资是否到期，是的话就把status改成expired(过期）     -->
      <el-table-column prop="expiryDate" label="到期日期">
      </el-table-column>
      <el-table-column prop="status" label="物资状态">
      </el-table-column>
      <el-table-column prop="threshold" label="预警阈值">
      </el-table-column>

      <el-table-column label="操作" width="300" align="center">
        <template slot-scope="scope">
          <el-button type="primary" @click="viewRecord(scope.row.materialName)">出库记录 <i
              class="el-icon-receiving"></i></el-button>
          <el-button type="success" @click="handleEdit(scope.row)">编辑 <i class="el-icon-edit"></i></el-button>
          <el-popconfirm
              class="ml-5"
              confirm-button-text='确定'
              cancel-button-text='取消'
              icon="el-icon-warning"
              icon-color="red"
              title="您确定删除这个物资信息吗？"
              @confirm="del(scope.row.materialId)"
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

    <el-dialog title="物资信息" :visible.sync="dialogFormVisible" width="30%">
      <el-form label-width="80px" size="small">
        <el-form-item label="物资照片">
          <el-upload
              class="avatar-uploader"
              :action=uploadAction
              :show-file-list="true"
              :on-success="handlematerialUrlSuccess"
          >
            <img v-if="form.materialUrl" :src="form.materialUrl" class="avatar" style="object-fit: cover" alt="">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="物资名字">
          <el-input v-model="form.materialName" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="物资类型">
          <el-select clearable v-model="form.materialType" placeholder="请选择物资类型" style="width: 100%">
            <el-option
                v-for="item in options_materialType"
                :key="item"
                :label="item"
                :value="item">
              {{ item }}
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="数量">
          <el-input v-model="form.quantity" autocomplete="off"></el-input>
        </el-form-item>

        <el-form-item label="生产日期">
          <el-date-picker v-model="form.productionDate" type="date" placeholder="选择日期" style="width: 100%"
                          value-format="yyyy-MM-dd"></el-date-picker>
        </el-form-item>
        <el-form-item label="到期日期">
          <el-date-picker v-model="form.expiryDate" type="date" placeholder="选择日期" style="width: 100%"
                          value-format="yyyy-MM-dd"></el-date-picker>
        </el-form-item>
        <el-form-item label="目前状态">
          <el-select clearable v-model="form.status" placeholder="请选择物资种类" style="width: 100%"
                     suffix-icon="el-icon-user">
            <el-option
                v-for="item in options_status"
                :key="item"
                :label="item"
                :value="item">
              {{ item }}
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="设置阈值">
          <el-input v-model="form.threshold" autocomplete="off"></el-input>
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
  name: "Material.vue",
  data() {
    return {
      tableData: [],
      code: "",
      total: 0,
      pageNum: 1,
      pageSize: 10,
      materialId: "",
      materialName: "",
      materialType: "",
      quantity: "",
      materialUrl: "",
      productionDate: "",
      expiryDate: "",
      status: "",
      threshold: "",
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
      options_materialType: [],
      options_status: [],

      // 动态构建上传文件的 URL，从环境变量中获取 VUE_APP_API_BASE_URL
      uploadAction: `${process.env.VUE_APP_API_BASE_URL}/file/upload`,
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
      request.get("/material/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          materialName: this.materialName,
          materialType: this.materialType,
          status: this.status,
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
       * 获取物资状态
       * */
      request.get("/material/status").then(res => {
        console.log("res:", res)
        if (res.code !== "200") {
          this.$message.error("获取失败,原因：" + res.msg)
        } else {
          this.options_status = res.data;
        }
      })

    },

    /**
     * 处理物资图片上传成功
     * */
    handlematerialUrlSuccess(res) {
      this.form.materialUrl = res
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
        this.materialName = "";
        this.materialType = "";
        this.status = "";
        this.load();
      } catch (error) {
        // 用户点击了取消，所以不执行任何操作
      }
    }
    ,

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
    }
    ,

    /**
     * 新增物资信息
     * */
    handleAdd() {
      this.dialogFormVisible = true
      this.form = {}
    }
    ,

    /**
     * 批量删除
     * */
    delBatch() {
      let ids = this.multipleSelection.map(v => v.materialId)  // [{}, {}, {}] => [1,2,3]
      console.log("ids:", ids)
      request.post("/material/del/batch", ids).then(res => {
        if (res.code === "200") {
          this.$message.success("批量删除成功")
          this.load()
        } else {
          this.$message.error("批量删除失败,原因：" + res.msg)
        }
      })
    }
    ,

    /**
     * 处理选中的数据
     * */
    handleSelectionChange(val) {
      console.log("val:", val)
      this.multipleSelection = val
    },


    /**
     * 跳转到物资出库记录页面
     * */
    viewRecord(materialName) {
      this.$router.push({path: '/usage_record', query: {materialName: materialName}});
    },


    /**
     * 编辑物资信息
     * */
    handleEdit(row) {
      this.form = row
      this.dialogFormVisible = true
    }
    ,


    /**
     * 删除用户信息
     * */
    del(id) {
      console.log("id:", id)
      request.delete("/material/" + id).then(res => {
        console.log("是否删除:", res)
        if (res.code === "200") {
          this.$message.success("删除成功")
          this.load()
        } else {
          this.$message.error("删除失败")
        }
      })
    }
    ,

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

    /**
     * 保存用户信息
     * */
    save() {
      request.post("/material", this.form).then(res => {
        if (res.code !== "200") {
          this.$message.error("保存失败")
        } else {
          this.$message.success("保存成功")
          this.dialogFormVisible = false
        }
        this.load()
      })
    }
    ,

  }
}
</script>

<style>
.headerBg {
  background: #eee !important;
}

.avatar-uploader {
  text-align: center;
  padding-bottom: 10px;
}

.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 138px;
  height: 138px;
  line-height: 138px;
  text-align: center;
}

.avatar {
  width: 138px;
  height: 138px;
  display: block;
}
</style>
