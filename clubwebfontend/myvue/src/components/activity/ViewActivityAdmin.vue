<!--管理员查看所有活动-->
<template>
  <div id="app" style="position: fixed;width: 85%;height: 100%;top: 0;right: 0; border: 1px solid #eee">
    <el-table
      :data="tableData"
      style="width: 100%">
      <el-table-column type="expand">
        <template slot-scope="props">
          <el-form label-position="left" inline class="demo-table-expand">
            <el-form-item label="活动编号">
              <span>{{ props.row.activityid }}</span>
            </el-form-item>
            <el-form-item label="活动名称">
              <span>{{ props.row.activityname }}</span>
            </el-form-item>
            <el-form-item label="活动内容">
              <span>{{ props.row.activityintroduction }}</span>
            </el-form-item>
            <el-form-item label="活动地点">
              <span>{{ props.row.activitypalce}}</span>
            </el-form-item>
            <el-form-item label="申请社团">
              <span>{{ props.row.associationsname }}</span>
            </el-form-item>
<!--            <el-form-item label="申请部门">-->
<!--              <span>{{ props.row.departmentid }}</span>-->
<!--            </el-form-item>-->
            <el-form-item label="开始时间">
              <span>{{ props.row.activitystarttime }}</span>
            </el-form-item>
            <el-form-item label="结束时间">
              <span>{{ props.row.activityendtime }}</span>
            </el-form-item>
            <el-form-item label="发布时间">
              <span>{{ props.row.activitiesapplicationtime }}</span>
            </el-form-item>
            <el-form-item label="截止时间">
              <span>{{ props.row.activitydeadline }}</span>
            </el-form-item>
          </el-form>
        </template>

      </el-table-column>
      <el-table-column
        label="活动编号"
        prop="activityid">
      </el-table-column>
      <el-table-column
        label="活动名称"
        prop="activityname">
      </el-table-column>
      <el-table-column
        label="申请社团"
        prop="associationsname">
      </el-table-column>
      <el-table-column
        label="审核状态"
        prop="activitiesapplicationstate"
        :filters="[{text: '等待审核', value: '等待审核'}, {text: '审核通过', value: '审核通过'}, {text: '审核拒绝', value: '审核拒绝'}]"
        :filter-method="filterState"
        filter-placement="bottom-end">
        <template slot-scope="scope">
          <el-tag
            :type="scope.row.activitiesapplicationstate === '审核拒绝' ? 'danger' : 'success'"
            disable-transitions>{{scope.row.activitiesapplicationstate}}</el-tag>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import qs from 'qs'
export default {
  name: 'ViewActivityAdmin',
  data () {
    return {
      data: {

      },
      tableData: []
    }
  },
  mounted () {
    this.data.type = 2
    var dataObj = qs.stringify(this.data)
    console.log(dataObj)
    this.$axios({
      method: 'post',
      url: '/allactivity',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      data: dataObj // 直接提交转换后的数据即可
    }
    ).then(successResponse => {
      // console.log(successResponse.data.allactivity[0].port)
      if (successResponse.data.allactivity[0].port === 200) {
        this.tableData = successResponse.data.allactivity
        this.$message({
          message: '获取数据成功',
          type: 'success'
        })
      }
      if (successResponse.data.port === 401) {
        this.$message.error({
          message: '获取数据失败'
        })
      }
    })
  },
  methods: {
  }
}
</script>
<style>
  .demo-table-expand {
    font-size: 0;
  }
  .demo-table-expand label {
    width: 90px;
    color: #99a9bf;
  }
  .demo-table-expand .el-form-item {
    margin-right: 0;
    margin-bottom: 0;
    width: 50%;
  }
</style>
