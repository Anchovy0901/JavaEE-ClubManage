<template>
  <el-container style="position: fixed;width: 85%;height: 100%;top: 0;right: 0; border: 1px solid #eee">
    <el-header
      style="text-align: center; font-size: 20px; height: 50px;line-height: 50px; background-color: lightsteelblue">
      <span id=assName style="letter-spacing: 20px; ">XX社团</span>
    </el-header>
    <el-main>
      <el-row style="height: 30%">
        <el-button plain type="primary" icon="el-icon-message-solid"
                   style="width: 20% ;height: 70%;font-size: 30px"
                   v-on:click="tonotice">
          公告
        </el-button>
        <el-button plain type="success" icon="el-icon-s-order" style="width: 20% ;height: 70%;font-size: 30px"
                   v-on:click="toactivity">活动
        </el-button>
        <el-button plain type="warning" icon="el-icon-s-custom" style="width: 20% ;height: 70%;font-size: 30px"
                   v-on:click="totacts">通讯录
        </el-button>
        <el-button plain type="danger" icon="el-icon-s-tools" style="width: 20% ;height: 70%;font-size: 30px"
                   @click="operation = true">社团操作
        </el-button>
        <el-dialog title="社团操作" :visible.sync="operation" style="width:1200px;margin-left: 250px"
                   :modal-append-to-body="false">
          <el-row>
            <el-button type="primary" plain @click="announcement = true">公告发布</el-button>
            <el-button type="success" plain @click="activityreleased = true">活动发布</el-button>
<!--            <el-button type="info" plain @click="createdepartment = true">部门创建</el-button>-->
            <el-button type="warning" plain @click="audit = true">招新审核</el-button>
            <el-button type="danger" plain @click="RecruitNotice = true">招新发布</el-button>
          </el-row>
        </el-dialog>
        <!--公告发布-->
        <el-dialog title="公告发布" :visible.sync="announcement" style="width:1000px;margin-left: 250px"
                   :modal-append-to-body="false">
          <el-form :model="form">
            <el-form-item label="活动区域">
              <el-select v-model="form.noticeRange" placeholder="公告范围">
                <el-option label="全校" value="全校"></el-option>
                <el-option label="全社" value="全社"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="公告名称" style="width: 400px">
              <el-input v-model="form.noticeName" placeholder="请输入内容 10字以内" maxlength="10" show-word-limit></el-input>
            </el-form-item>
            <el-form-item label="公告内容">
              <el-input type="textarea" v-model="form.noticeContent" :autosize="{ minRows: 5, maxRows: 10}"
                        placeholder="请输入内容,200字以内" maxlength="200" show-word-limit>>
              </el-input>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="announcement = false">取 消</el-button>
            <el-button type="primary" @click="createNotice">确 定</el-button>
          </div>
        </el-dialog>
        <!--活动发布-->
        <el-dialog title="活动发布" :visible.sync="activityreleased"
                   style="height:800px; width:1000px;margin-left: 250px;margin-top: -100px"
                   :modal-append-to-body="false">
          <el-form :model="form2">
            <el-form-item label="活动名称" style="width: 400px">
              <el-input v-model="createActivity.name" placeholder="请输入内容 10字以内" maxlength="10"
                        show-word-limit></el-input>
            </el-form-item>
            <el-form-item label="活动范围" style="width: 400px">
              <el-select v-model="createActivity.range" placeholder="请选择" style="width: 400px">
                <el-option
                  v-for="item in rangeoption"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="活动地点" style="width: 400px">
              <el-select v-model="createActivity.palaceid" placeholder="请选择" style="width: 400px">
                <el-option
                  v-for="item in place"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="活动开始时间" style="width: 400px">
              <el-date-picker
                v-model="createActivity.startTime"
                type="datetime"
                placeholder="选择日期时间"
                align="right"
                :picker-options="pickerOptions"
                style="width: 400px"
                value-format="yyyy-MM-dd HH:mm:ss">
              </el-date-picker>
            </el-form-item>
            <el-form-item label="活动结束时间" style="width: 400px">
              <el-date-picker
                v-model="createActivity.endTime"
                type="datetime"
                placeholder="选择日期时间"
                align="right"
                :picker-options="pickerOptions"
                style="width: 400px"
                value-format="yyyy-MM-dd HH:mm:ss">
              </el-date-picker>
            </el-form-item>
            <el-form-item label="活动报名截止时间" style="width: 400px">
              <el-date-picker
                v-model="createActivity.deadLine"
                type="datetime"
                placeholder="选择日期时间"
                align="right"
                :picker-options="pickerOptions"
                style="width: 400px"
                value-format="yyyy-MM-dd HH:mm:ss">
              </el-date-picker>
            </el-form-item>

            <el-form-item label="活动内容">
              <el-input type="textarea" v-model="createActivity.introduction" :autosize="{ minRows: 5, maxRows: 10}"
                        placeholder="请输入内容,200字以内" maxlength="200" show-word-limit>>
              </el-input>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="activityreleased = false">取 消</el-button>
            <el-button type="primary" v-on:click="createactivity">确 定</el-button>
          </div>
        </el-dialog>
        <!--招新审核-->
        <el-dialog title="招新审核" :visible.sync="audit" style="width:1000px;margin-left: 250px"
                   :modal-append-to-body="false">
          <el-table :data="gridData">
            <el-table-column property="userId" label="学号" width="150"></el-table-column>
            <el-table-column property="username" label="姓名" width="150"></el-table-column>
            <el-table-column label="操作">
              <template slot-scope="scope">
                <el-button
                  size="mini"
                  type="success"
                  @click="reurcitSignSuccess(scope.$index, scope.row)">通过
                </el-button>
                <el-button
                  size="mini"
                  type="danger"
                  @click="reurcitSignError(scope.$index, scope.row)">不通过
                </el-button>
              </template>
            </el-table-column>
          </el-table>
          <div slot="footer" class="dialog-footer">
            <el-button @click="audit = false">取 消</el-button>
          </div>
        </el-dialog>
        <!--招新发布-->
        <el-dialog title="招新发布" :visible.sync="RecruitNotice"
                   style="height:800px; width:1000px;margin-left: 250px;margin-top: -100px"
                   :modal-append-to-body="false">
          <el-form :model="form4">
            <el-form-item label="招新开始时间" style="width: 400px">
              <el-date-picker
                v-model="recruitnotice.recruitNoticeStartTime"
                type="datetime"
                placeholder="选择日期时间"
                align="right"
                :picker-options="pickerOptions"
                style="width: 400px"
                value-format="yyyy-MM-dd HH:mm:ss">
              </el-date-picker>
            </el-form-item>
            <el-form-item label="招新结束时间" style="width: 400px">
              <el-date-picker
                v-model="recruitnotice.recruitNoticeEndTime"
                type="datetime"
                placeholder="选择日期时间"
                align="right"
                :picker-options="pickerOptions"
                style="width: 400px"
                value-format="yyyy-MM-dd HH:mm:ss">
              </el-date-picker>
            </el-form-item>
            <el-form-item label="招新内容">
              <el-input type="textarea" v-model="recruitnotice.recruitNoticeContent" :autosize="{ minRows: 5, maxRows: 10}"
                        placeholder="请输入内容,200字以内" maxlength="200" show-word-limit>>
              </el-input>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="RecruitNotice = false">取 消</el-button>
            <el-button type="primary" v-on:click="createrecuritenotice">确 定</el-button>
          </div>
        </el-dialog>
      </el-row>
      <el-card style="font-size: 20px;text-align: left">
        <div slot="header" style="font-size: 30px;text-align: center">
          <span>社团介绍</span>
        </div>
        <div id=introduction>
          UTALK 友谈协会，下方是一个笑脸，表明我们社团十分有爱，是一个很欢乐的大家庭，同时笑脸里面表明了社团名称和社团创建时间。最后是我们社团的口号，激励大家积极勇敢说英语。
        </div>
      </el-card>
    </el-main>

  </el-container>
</template>

<script>
import qs from 'qs'

export default {
  name: 'clubIndex',
  data () {
    return {
      createdepartment: false,
      // 公告数据
      form: {
        noticeName: '',
        noticeContent: '',
        noticeRange: '',
        // associationId: this.$store.state.associationId
        associationId: sessionStorage.getItem('associationId')
      },
      formLabelWidth: '120px',
      operation: false,
      announcement: false,
      activityreleased: false,
      RecruitNotice: false,
      // 招新表
      recruitnotice: {
        recruitNoticeContent: '',
        recruitNoticeStartTime: '',
        recruitNoticeEndTime: ''

      },
      // form2: {
      //     name: '',
      //     date: '',
      //     place: '',
      //     content: ''
      // },
      departmentuser: {
        departmentName: '',
        departmentLeader: ''
      },
      form4: {
        startTime: '',
        endTime: '',
        introduction: ''
      },
      audit: false,
      gridData: [],
      createActivity: {
        name: '',
        introduction: '',
        startTime: '',
        endTime: '',
        deadLine: '',
        range: '',
        palaceid: ''
      },
      rangeoption: [{
        value: '全校',
        label: '全校'
      }, {
        value: '社团',
        label: '社团'
      }],
      place: [
        {
          value: '1',
          label: '理四1楼大教室'
        }, {
          value: '2',
          label: '南校操场'
        }, {
          value: '3',
          label: '北校操场'
        }, {
          value: '4',
          label: '风雨操场'
        }, {
          value: '5',
          label: '科技楼'
        }, {
          value: '6',
          label: '篮球场'
        }, {
          value: '7',
          label: '网球场'
        }, {
          value: '8',
          label: '教3'
        }, {
          value: '9',
          label: '教5'
        }
      ],
      pickerOptions: {
        shortcuts: [{
          text: '今天',
          onClick (picker) {
            picker.$emit('pick', new Date())
          }
        }, {
          text: '明天',
          onClick (picker) {
            const date = new Date()
            date.setTime(date.getTime() + 3600 * 1000 * 24)
            picker.$emit('pick', date)
          }
        }, {
          text: '三天后',
          onClick (picker) {
            const date = new Date()
            date.setTime(date.getTime() + 3600 * 1000 * (24 * 3))
            picker.$emit('pick', date)
          }
        }, {
          text: '一周后',
          onClick (picker) {
            const date = new Date()
            date.setTime(date.getTime() + 3600 * 1000 * (24 * 7))
            picker.$emit('pick', date)
          }
        }]
      }
    }
  },
  methods: {
    tonotice () {
      this.$router.replace({path: '/clubnotice'})
    },
    totacts () {
      this.$router.replace({path: '/contacts'})
    },
    toactivity () {
      this.$router.replace({path: '/ClubActivity'})
    },
    // 发布活动
    createactivity () {
      // this.createActivity.associationid = this.$store.state.associationId
      var that = this
      that.createActivity.associationid = sessionStorage.getItem('associationId')
      that.createActivity.departmentid = this.$store.state.departmentId
      // that.createActivity.startTime+=3600*1000*8
      // that.createActivity.endTime+=3600*1000*8
      // that.createActivity.deadLine+=3600*1000*8
      // this.createActivity.departmentid = 999999
      var ca = qs.stringify(that.createActivity)
      console.log(ca)
      this.$axios({
        method: 'post',
        url: '/createActivity',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        data: ca // 直接提交转换后的数据即可
      }
      ).then(successResponse => {
        // console.log(successResponse.data);
        if (successResponse.data.port === 200) {
          // eslint-disable-next-line eqeqeq
          if (this.createActivity.range == '社团') {
            this.$message({
              message: '审核通过',
              type: 'success'
            })
          } else {
            this.$message({
              message: '等待管理员审核',
              type: 'success'
            })
          }
          setTimeout(function () { // 使用  setTimeout（）方法设定定时2000毫秒
            window.location.reload()// 页面刷新
          }, 1000)
        } else if (successResponse.data.port === 401) {
          this.$message({
            message: '审核未通过,' + successResponse.data.ErrorResult,
            type: 'error'
          })
        }
      })
    },
    createDepartment () {
      // this.departmentuser.associationId = this.$store.state.associationId
      this.departmentuser.associationId = sessionStorage.getItem('associationId')
      // console.log(this.createActivity)
      var cd = qs.stringify(this.departmentuser)
      // console.log(ca)
      this.$axios({
        method: 'post',
        url: '/createdepartment',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        data: cd // 直接提交转换后的数据即可
      }
      ).then(successResponse => {
        // console.log(successResponse.data);
        if (successResponse.data.port === 200) {
          this.$message({
            message: '审核通过',
            type: 'success'
          })
        }
        if (successResponse.data.port === 401) {

        }
        setTimeout(function () { // 使用  setTimeout（）方法设定定时2000毫秒
          window.location.reload()// 页面刷新
        }, 1000)
      })
    },
    createrecuritenotice () {
      this.recruitnotice.userId = this.$store.state.user.userId
      // this.recruitnotice.associationsId = this.$store.state.associationId
      this.recruitnotice.associationsId = sessionStorage.getItem('associationId')

      // console.log(this.createActivity)
      var cr = qs.stringify(this.recruitnotice)
      // console.log(ca)
      this.$axios({
        method: 'post',
        url: '/createrecruitnotice',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        data: cr // 直接提交转换后的数据即可
      }
      ).then(successResponse => {
        // console.log(successResponse.data);
        if (successResponse.data.port === 200) {
          this.$message({
            message: '发布成功',
            type: 'success'
          })
        }
        if (successResponse.data.port === 401) {

        }
        setTimeout(function () { // 使用  setTimeout（）方法设定定时2000毫秒
          window.location.reload()// 页面刷新
        }, 1000)
      })
    },
    // 发布公告
    createNotice () {
      var that = this
      var cn = qs.stringify(that.form)
      // alert(cn)
      this.$axios({
        method: 'post',
        url: '/noticecreate',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        data: cn // 直接提交转换后的数据即可
      }
      ).then(successResponse => {
        // alert(successResponse.data)

        if (successResponse.data.port === 200) {
          // eslint-disable-next-line eqeqeq
          if (that.noticeRange == '全校') {
            this.$message({
              message: '发布成功,等待管理员审核',
              type: 'success'
            })
          } else {
            this.$message({
              message: '发布成功',
              type: 'success'
            })
          }
        }
        if (successResponse.data.port === 401) {
          this.$message({
            message: '发布失败',
            type: 'error'
          })
        }
        setTimeout(function () { // 使用  setTimeout（）方法设定定时2000毫秒
          window.location.reload()// 页面刷新
        }, 1000)
      })
    },
    reurcitSignSuccess (index, row) {
      var recruitNoticePass = qs.stringify({recruitSignId: row.recruitSignId, recruitSignApplicationState: '审核通过'})
      this.$axios({
        method: 'post',
        url: '/changerecruitnotice',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        data: recruitNoticePass // 直接提交转换后的数据即可
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
    reurcitSignError (index, row) {
      var recruitNoticePass = qs.stringify({recruitSignId: row.recruitSignId, recruitSignApplicationState: '审核拒绝'})
      this.$axios({
        method: 'post',
        url: '/changerecruitnotice',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        data: recruitNoticePass // 直接提交转换后的数据即可
      }
      ).then(successResponse => {
        this.$message({
          message: '审核拒绝',
          type: 'error'
        })
        setTimeout(function () { // 使用  setTimeout（）方法设定定时2000毫秒
          window.location.reload()// 页面刷新
        }, 1000)
      })
    }

  },
  mounted () {
    // document.getElementById("assName").innerHTML = this.$store.state.associationName;
    document.getElementById('assName').innerHTML = sessionStorage.getItem('associationName')
    // document.getElementById("introduction").innerHTML = this.$store.state.associationsIntroduction;
    document.getElementById('introduction').innerHTML = sessionStorage.getItem('associationsIntroduction')
    var rn = qs.stringify({associationId: sessionStorage.getItem('associationId')})
    this.$axios({
      method: 'post',
      url: '/allassociationrecruit',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      data: rn // 直接提交转换后的数据即可
    }
    ).then(successResponse => {
      // console.log(successResponse.data)
      this.gridData = successResponse.data.allassociationrecruit
    })
  }
}
</script>

<style scoped>

</style>
