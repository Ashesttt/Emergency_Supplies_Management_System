<template>
  <div>
    <div style="text-align: center; font-size: 40px; margin-top: 20px; margin-bottom: 40px">
      欢迎使用应急救援装备管理系统
    </div>
    
    <el-row :gutter="10" style="margin-bottom: 40px">
      <el-col :span="6">
        <el-card>
          <div style="color: #409EFF">
            <i class="el-icon-user-solid"></i>
            用户总数
          </div>
          <div style="padding: 10px 0; text-align:center; font-weight:bold">
            9999
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
          <div style="color: #67C23A">
            应急装备总数
          </div>
          <div style="padding: 10px 0; text-align:center; font-weight:bold">
            5000
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
          <div style="color: #E6A23C">
            应急救援人员总数
          </div>
          <div style="padding: 10px 0; text-align:center; font-weight:bold">
            6000
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
          <div style="color: #F56C6C">
            应急救援车辆总数
          </div>
          <div style="padding: 10px 0; text-align:center; font-weight:bold">
            100
          </div>
        </el-card>
      </el-col>
    </el-row>
    
    
    <el-row>
      <el-col :span="12">
        <div id="pie" style="width: 500px; height: 400px"></div>
      </el-col>
      <el-col :span="12">
        <div id="main" style="width: 500px; height: 400px"></div>
      </el-col>
    </el-row>
    
    <el-row>
      <el-col :span="12">
        <el-card>
          <div slot="header">
            <span>系统信息</span>
          </div>
          <div>
            <p>系统版本：V1.0.0</p>
            <p>系统时间：{{ new Date().toLocaleString() }}</p>
            <p>系统开发：马秀影</p>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import * as echarts from 'echarts'


export default {
  name: "Home",
  data() {
    return {}
  },

  mounted() {
    // 饼图

    var pieOption = {
      title: {
        text: '各季度管理员数量统计',
        subtext: '比例图',
        left: 'center'
      },
      tooltip: {
        trigger: 'item'
      },
      legend: {
        orient: 'vertical',
        left: 'right'
      },
      series: [
        {
          type: 'pie',
          radius: '60%',
          label: {            //饼图图形上的文本标签
            normal: {
              show: true,
              position: 'inner', //标签的位置
              textStyle: {
                fontWeight: 300,
                fontSize: 14,    //文字的字体大小
                color: "#fff"
              },
              formatter: '{d}%'
            }
          },
          data: [],  // 填空
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          }
        }
      ]
    };

    var pieDom = document.getElementById('pie');
    var pieChart = echarts.init(pieDom);

    this.request.get("/echarts/members").then(res => {
      console.log(res)
      pieOption.series[0].data = [
        {name: "第一季度", value: res.data[0]},
        {name: "第二季度", value: res.data[1]},
        {name: "第三季度", value: res.data[2]},
        {name: "第四季度", value: res.data[3]},
      ]
      pieChart.setOption(pieOption)
    })


    // 折线图
    var option = {
      title: {
        text: '各季度管理员数量统计',
        subtext: '趋势图',
        left: 'center'
      },
      xAxis: {
        type: 'category',
        data: ["第一季度", "第二季度", "第三季度", "第四季度"]
      },
      yAxis: {
        type: 'value'
      },
      series: [
        {
          data: [],
          type: 'line'
        },
        {
          data: [],
          type: 'bar'
        }
      ]
    };

    var chartDom = document.getElementById('main');
    var myChart = echarts.init(chartDom);

    this.request.get("/echarts/members").then(res => {

      // option.xAxis.data = res.data.x//横坐标
      option.series[0].data = res.data//折线
      option.series[1].data = res.data//柱状
      // 数据准备完毕之后再set
      myChart.setOption(option);

    })
  }
}
</script>

<style scoped>

</style>
