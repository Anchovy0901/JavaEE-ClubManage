/* eslint-disable no-undef */
<template>
  <!--  <el-container>-->
  <!--    <el-aside>-->
  <el-menu
    :default-active="'/admin'"
    router
    class="el-menu-vertical-demo"
    @open="handleOpen"
    @close="handleClose"
    background-color="#486586"
    text-color="#fff"
    active-text-color="#1890ff"
    :default-openeds="openeds">
    <el-avatar src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"></el-avatar>
    <el-menu-item index="usermanager">
      <template slot="title">
        <i class="el-icon-user-solid"></i>
        <span>人员管理</span>
      </template>
    </el-menu-item>
    <el-submenu index="5">
      <template slot="title">
        <i class="el-icon-menu"></i>
        <span>社团管理</span>
      </template>
      <el-menu-item index="clubManagement">查看社团</el-menu-item>
      <el-menu-item index="applyClub">审核社团申请</el-menu-item>
<!--      <el-menu-item index="5-2">查看社团成员</el-menu-item>-->
<!--      <el-menu-item index="5-3">删除社团</el-menu-item>-->
    </el-submenu>
    <el-submenu index="6">
      <template slot="title">
        <i class="el-icon-menu"></i>
        <span>活动管理</span>
      </template>
      <el-menu-item index="Audit_Activity">审核活动申请</el-menu-item>

<!--      <el-menu-item index="Modify_Activity">审核活动修改</el-menu-item>-->
      <el-menu-item index="ViewActivityAdmin">查看活动</el-menu-item>
    </el-submenu>
    <el-submenu index="7">
      <template slot="title">
        <i class="el-icon-menu"></i>
        <span>公告管理</span>
      </template>
      <el-menu-item index="Create_Announcement">发布公告</el-menu-item>
      <el-menu-item index="Query_Announcement">查看公告</el-menu-item>
    </el-submenu>
<!--    <el-submenu index="8">-->
<!--      <template slot="title">-->
<!--        <i class="el-icon-menu"></i>-->
<!--        <span>财务场地管理</span>-->
<!--      </template>-->
<!--      <el-menu-item index="8-1">管理财务报销</el-menu-item>-->
<!--      <el-menu-item index="8-2">管理场地使用</el-menu-item>-->
<!--    </el-submenu>-->
  <el-button id="back" type="primary" icon="el-icon-back" v-on:click="back">退出登录</el-button>
  </el-menu>
  <!--    </el-aside>-->
  <!--  </el-container>-->
</template>
<script>
export default {
  name: `AdminNavMenu`,
  data () {
    return {
      openeds: ['usermanager', '5', '6', '7']
    }
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
      // eslint-disable-next-line no-undef
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
</style>
