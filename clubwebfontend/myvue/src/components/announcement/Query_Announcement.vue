<!--管理员查看所有公告-->
<template>
  <el-container style="position: fixed;width: 85%;height: 100%;top: 0;right: 0; border: 1px solid #eee">
    <el-header style="text-align: center; font-size: 20px; height: 50px;line-height: 50px; background-color: lightsteelblue">
      <span style="letter-spacing: 20px; ">所有公告</span>
    </el-header>
    <el-main>
      <el-table
        :data="tableData.filter(data => !search || data.username.toLowerCase().includes(search.toLowerCase()))"
        ref="filterTable"
        stripe
        style="width: 100%">
        <el-table-column
          label="公告名称"
          prop="noticename">
        </el-table-column>
        <el-table-column
          label="公告内容"
          prop="noticetcontent">
        </el-table-column>
        <el-table-column
          label="发布时间"
          prop="noticetime"
          sortable>
        </el-table-column>
        <el-table-column
          label="活动范围"
          prop="noticerange"
          :filters="[{text: '全校', value: '全校'}, {text: '全社', value: '全社'}]"
          :filter-method="filterRange">
        </el-table-column>

        <el-table-column
          label="社团名称"
          prop="associationsname">
        </el-table-column>
        <el-table-column
          label="审核状态"
          prop="noticestate"
          :filters="[{text: '等待审核', value: '等待审核'}, {text: '审核通过', value: '审核通过'}, {text: '审核未通过', value: '审核未通过'}]"
          :filter-method="filterState"
          filter-placement="bottom-end">
          <template slot-scope="scope">
            <el-tag
              :type="scope.row.noticestate === '等待审核' ? 'danger' : 'success'"
              disable-transitions>{{scope.row.noticestate}}</el-tag>
          </template>
        </el-table-column>
        <el-table-column
          align="right">
          <template slot-scope="scope" class="handlebutton" v-if="scope.row.noticestate==='等待审核'">
            <el-button
              size="middle"
              type="primary" plain
              @click="handleSuccess(scope.row)">同意</el-button>
            <el-button
              size="middle"
              type="danger" plain
              @click="handleError(scope.row)">拒绝</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-main>
  </el-container>
</template>

<script>
import qs from 'qs'
export default {
  name: 'Query_Announcement',
  data () {
    return {
      tableData: [ ]
    }
  },
  mounted () {
    this.$axios.get('/allnotice')
      .then(response => {
        this.tableData = response.data.allnotice
        console.log(this.tableData)
      })
  },
  methods: {
    filterState (value, row) {
      return row.noticestate === value
    },
    filterRange (value, row, column) {
      const property = column['property']
      return row[property] === value
    },
    handleSuccess (row) {
      var sd = qs.stringify({noticeid: row.noticeid, answer: true})
      this.$axios({
        method: 'post',
        url: '/examinenotice',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        data: sd // 直接提交转换后的数据即可
      }
      ).then(successResponse => {
        this.$message({
          message: '审核通过',
          type: 'success'
        })
        setTimeout(function () { // 使用  setTimeout（）方法设定定时2000毫秒
          window.location.reload()// 页面刷新
        }, 1000)
      })
    },
    handleError (row) {
      var sd = qs.stringify({noticeid: row.noticeid, answer: false})
      this.$axios({
        method: 'post',
        url: '/examinenotice',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        data: sd // 直接提交转换后的数据即可
      }
      ).then(successResponse => {
        this.$message({
          message: '审核未通过',
          type: 'success'
        })
        setTimeout(function () { // 使用  setTimeout（）方法设定定时2000毫秒
          window.location.reload()// 页面刷新
        }, 1000)
      })
    }
  }
}
</script>

<style scoped>

</style>
