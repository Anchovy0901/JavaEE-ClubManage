/* eslint-disable standard/object-curly-even-spacing */
<template>
  <!--  <el-container>-->
  <!--    <el-aside>-->
  <el-menu
    :default-active="'/index'"
    router
    class="el-menu-vertical-demo"
    @open="handleOpen"
    @close="handleClose"
    background-color="#486586"
    text-color="#fff"
    active-text-color="#1890ff"
    :default-openeds="openeds"
  >
    <el-avatar src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"></el-avatar>
    <el-submenu index="1">
      <template slot="title">
        <i class="el-icon-menu"></i>
        <span>基本功能</span>
      </template>
      <el-menu-item index="recruitnotice">社团招新</el-menu-item>
      <el-menu-item index="createAssociation">社团创建</el-menu-item>
      <el-menu-item index="viewActivityUser">全校活动</el-menu-item>
      <el-menu-item index="SignedActivity">已报名的活动</el-menu-item>
      <el-menu-item index="ViewAnnouncementUser">全校公告</el-menu-item>
      <el-menu-item index="changePwd">修改密码</el-menu-item>
    </el-submenu>
    <el-submenu index="association">
      <template slot="title">
        <i class="el-icon-s-custom"></i>
        <span>我的社团</span>
      </template>
      <template v-for="ass in association">
       <el-menu-item v-on:click="get(ass.associationname,ass.associationid,ass.associationsIntroduction)" >{{ass.associationname}}</el-menu-item>
      </template>
    </el-submenu>
    <el-button id="back" type="primary" icon="el-icon-back" v-on:click="back">退出登录</el-button>
  </el-menu>
</template>

<script>
import qs from 'qs'

export default {
  name: 'UserNavMenu',
  data () {
    return {
      user: {
        userId: ''
      },
      openeds: ['1', 'association'],
      association: []
    }
  },
  mounted () {
    this.user.userId = this.$store.state.user.userId
    var dataObj = qs.stringify(this.user)
    this.$axios({
      method: 'post',
      url: '/allassociationbyuserid',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      data: dataObj // 直接提交转换后的数据即可
    }
    ).then(successResponse => {
      for (var i = 0; i < successResponse.data.allassociationbyuserid.length; i++) {
        this.association.push({
          associationname: successResponse.data.allassociationbyuserid[i].associationsName,
          associationid: successResponse.data.allassociationbyuserid[i].associationsId,
          associationsIntroduction: successResponse.data.allassociationbyuserid[i].associationsIntroduction
        })
      }
    })
  },
  methods: {
    back () {
      this.$router.replace({path: '/login'})
    },
    get (name, id, introduction) {
      // console.log(name)
      // console.log(id)
      // console.log(introduction)
      this.$store.commit('associationName', name)
      this.$store.commit('associationId', id)
      this.$store.commit('associationsIntroduction', introduction)
      sessionStorage.setItem('associationName', name)
      sessionStorage.setItem('associationId', id)
      sessionStorage.setItem('associationsIntroduction', introduction)
      // console.log(sessionStorage.getItem("associationName"))
      // console.log(sessionStorage.getItem("associationId"))
      // console.log(sessionStorage.getItem("associationsIntroduction"))
      var dataobj = qs.stringify({userId: this.$store.state.user.userId,
        associationId: this.$store.state.associationId})
      this.$axios({
        method: 'post',
        url: '/member',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        data: dataobj // 直接提交转换后的数据即可
      }
      ).then(successResponse => {
        this.$store.commit('departmentId', successResponse.data.member[0].departmentid)
        sessionStorage.setItem('departmentId', successResponse.data.member[0].departmentid)

        this.$store.commit('memberPost', successResponse.data.member[0].memberpost)
        sessionStorage.setItem('memberPost', successResponse.data.member[0].memberpost)
      })
      console.log(this.$store.state.memberPost)
      // eslint-disable-next-line standard/object-curly-even-spacing
      this.$router.replace({path: '/clubindex' })
      window.location.reload()
    }
  }

}
</script>

<style scoped>
  .el-menu-vertical-demo {
    position: fixed;
    /*margin-left: 50%;*/
    left: 0px;
    top: 0px;
    width: 15%;
    height: 100%;
    overflow: scroll;
  }

  #back {
    position: fixed;
    left: 55px;
    top: 90%
  }
</style>
