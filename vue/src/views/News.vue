<script>
export default {
  name: "News"
}
</script>

<template>
  <div>
    <el-card>
      <div slot="header">
        <span>新闻管理</span>
      </div>
      <div>
        <el-table :data="tableData" style="width: 100%">
          <el-table-column prop="id" label="ID" width="50"></el-table-column>
          <el-table-column prop="title" label="标题"></el-table-column>
          <el-table-column prop="content" label="内容"></el-table-column>
          <el-table-column prop="createTime" label="创建时间"></el-table-column>
          <el-table-column prop="updateTime" label="更新时间"></el-table-column>
          <el-table-column label="操作">
            <template slot-scope="scope">
              <el-button type="text" size="small">编辑</el-button>
              <el-button type="text" size="small">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </el-card>
  </div>
</template>

<style scoped>

</style>
