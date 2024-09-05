<template>
  <div>
    <div style="margin-bottom: 30px">

    </div>
    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入文件名字" suffix-icon="el-icon-search"
                v-model="filename"></el-input>
      <el-input style="width: 200px" placeholder="请输入文件类型" suffix-icon="el-icon-user" class="ml-5"
                v-model="type"></el-input>
      <el-select style="width: 200px" placeholder="请选择是否已经被删除" v-model="is_delete" class="ml-5">
        <el-option label="全部数据" value=""></el-option>
        <el-option label="已被(假)删除" value="1"></el-option>
        <el-option label="未被(假)删除" value="0"></el-option>
      </el-select>
      <el-select style="width: 200px" placeholder="请选择链接是否可用" v-model="enable" class="ml-5">
        <el-option label="全部数据" value=""></el-option>
        <el-option label="链接可用" value="1"></el-option>
        <el-option label="链接不可用" value="0"></el-option>
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
          title="您确定批量删除这些文件信息吗？"
          @confirm="delBatch"
      >
        <el-button type="danger" slot="reference">批量删除 <i class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>
      <el-upload :action=uploadAction :show-file-list="false"
                 :on-success="handleFileUploadSuccess" :on-error="handleFileUploadError" style="display: inline-block">
        <el-button type="primary" class="ml-5">上传文件 <i class="el-icon-top"></i></el-button>
      </el-upload>
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg"
              @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="fileId" label="文件ID" width="100">
      </el-table-column>
      <el-table-column prop="filename" label="文件名" width="140">
      </el-table-column>
      <el-table-column prop="type" label="文件类型" width="120">
      </el-table-column>
      <el-table-column prop="size" label="文件大小(kb)" width="140">
      </el-table-column>
      <el-table-column label="下载" align="center">
        <template slot-scope="scope">
          <el-button type="primary" @click="download(scope.row.url)">下载</el-button>
        </template>
      </el-table-column>
      <el-table-column label="是否已经被删除" align="center">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.isDelete" active-color="#13ce66" inactive-color="#ccc"
                     @change="changeis_delete(scope.row)"></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="链接是否可用" align="center">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.enable" active-color="#13ce66" inactive-color="#ccc"
                     @change="changeEnable(scope.row)"></el-switch>
        </template>
      </el-table-column>


<!--            <el-table-column prop="url" label="URL" width="140">-->
<!--            </el-table-column>-->
<!--            <el-table-column prop="is_delete" label="是否已经被删除">-->
<!--            </el-table-column>-->
<!--            <el-table-column prop="enable" label="链接是否可用" width="220">-->
<!--            </el-table-column>-->


      <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">
          <el-popconfirm
              class="ml-5"
              confirm-button-text='确定'
              cancel-button-text='取消'
              icon="el-icon-warning"
              icon-color="red"
              title="您确定删除这个用户信息吗？"
              @confirm="del(scope.row.fileId)"
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
  name: "File",
  data() {
    return {
      tableData: [],
      headerBg: "headerBg",
      code: "",
      total: 0,
      pageNum: 1,
      pageSize: 10,
      fileId: "",
      filename: "",
      type: "",
      size: "",
      url: "",
      is_delete: "",
      enable: "",
      isDelete: "",
      multipleSelection: [],
      msg: "hello mxy",
      collapseBtnClass: "el-icon-s-fold",
      isCollapse: false, // 是否收缩
      sideWidth: 200,
      logoTextShow: true, // logo文字是否显示
      dialogVisible: false, // 弹窗可视化
      
      // 动态构建上传文件的 URL，从环境变量中获取 VUE_APP_API_BASE_URL
      uploadAction: `${process.env.VUE_APP_API_BASE_URL}/file/upload`
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
      request.get("/file/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          filename: this.filename,
          type: this.type,
          is_delete: this.is_delete,
          enable: this.enable
        }
      }).then(res => {
        console.log(res)
        // if (res.code !== "200") {
        //   this.$message.error(res.msg)
        // }
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
        this.filename = "";
        this.type = "";
        this.is_delete = "";
        this.enable = "";
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
     * 批量(假)删除
     * */
    delBatch() {
      let ids = this.multipleSelection.map(v => v.fileId)  // [{}, {}, {}] => [1,2,3]
      console.log("ids:", ids)
      request.post("/file/del/batch", ids).then(res => {
        console.log("res:", res)
        if (res.code === "200") {
          this.$message.success("批量删除成功，" + res.msg)
          this.load()
        } else {
          this.$message.error("批量删除失败，原因：" + res.msg)
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
     * 下载文件
     * */
    download(url) {
      this.$message({
        message: "正在下载文件，请稍后...",
        type: 'success',
        center: true
      });
      window.open(url, '_blank');
      console.log("url:", url)
    },
    
    /**
     * 改变是否已经被删除
     * */
    changeis_delete(row) {
      this.request.post("/file/update", row).then(res => {
        if (res.code === '200') {
          console.log(row.is_delete)
          this.$message.success("操作成功")
        } else {
          this.$message.error("操作失败,原因：" + res.msg)
        }
      })
    },


    /**
     * 改变链接是否可用
     * */
    changeEnable(row) {
      this.request.post("/file/update", row).then(res => {
        if (res.code === '200') {
          console.log(row.enable)
          this.$message.success("操作成功")
        } else {
          this.$message.error("操作失败,原因：" + res.msg)
        }
      })
    },


    /**
     * (假)删除用户信息
     * */
    del(id) {
      console.log("id:", id)
      request.delete("/file/" + id).then(res => {
        console.log("是否删除:", res)
        if (res.code !== "200") {
          this.$message.error("(假)删除失败,原因：" + res.msg)
        } else {
          this.$message.success(res.msg)
          this.load()
        }
      })
    },

    /**
     * 处理文件上传成功
     * */
    handleFileUploadSuccess(res) {
      this.$message.success("上传成功")
      this.load()
    },

    /**
     * 处理文件上传失败
     * */
    handleFileUploadError() {
      this.$message.error("上传失败")
      this.load()
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

<style scoped>

</style>
