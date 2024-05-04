<template>
  <div>
    <div style="margin-bottom: 30px">
    </div>

    <div style="margin: 10px 0">

    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="headerBg">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="messageId" label="日志id" sortable width="100px">
      </el-table-column>
      <el-table-column prop="sendTime" label="日志时间">
      </el-table-column>
      <el-table-column prop="avatarurl" label="接收者">
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
      <el-table-column prop="title" label="标题">
      </el-table-column>
      <el-table-column prop="content" label="信息" width="500px">
      </el-table-column>
      <el-table-column prop="type" label="信息重要程度">
      </el-table-column>
      <el-table-column prop="readStatus" label="是否已读">
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
  name: "PersonMessage",
  data() {
    return {
      tableData: [],
      code: "",
      total: 0,
      pageNum: 1,
      pageSize: 10,
      username: "",
      msg: "hello mxy",
      collapseBtnClass: "el-icon-s-fold",
      isCollapse: false, // 是否收缩
      sideWidth: 200,
      logoTextShow: true, // logo文字是否显示
      headerBg: "headerBg",
    }
  },
  created() {
    // 请求分页查询数据
    let user = JSON.parse(localStorage.getItem("user"));
    this.username = user.username;
    this.load()
  },


  methods: {
    /**
     * 查询数据方法
     * */
    load() {
      request.get("/message/getMessagesByPage", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          username: this.username,
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
