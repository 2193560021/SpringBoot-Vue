<template>
  <div style="height:50px;line-height:50px;border-bottom:1px solid #ccc;display:flex">
      <div style="width:200px;padding-left:30px;font-weight:bold;color:dodgerblue;font-size:20px">后台管理系统</div>
      <div style="flex:1"></div>
      <div style="width:100px;padding-right:30px;padding-top:18px">
        <el-dropdown>
          <span class="el-dropdown-link">
            <div style="width:100%;height:100%;cursor: pointer">
              lyy
            </div>
            <el-icon class="el-icon--right">
              <arrow-down />
            </el-icon>
          </span>
          <template #dropdown>
            <el-dropdown-menu>
              <el-dropdown-item @click="$router.push('/person')">个人信息</el-dropdown-item>
              <el-dropdown-item @click="logout">退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
      </div>
  </div>
</template>

<script>
export default {
  name: "Header",
  props: ['user'],
  data() {
    return {

    }
  },
  created() {
  },
  methods:{
    logout(){
      this.$router.push('/login')
      sessionStorage.clear()
    },
  }
}
</script>

<style scoped>

</style>