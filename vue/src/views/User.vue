<template>
  <div class="home" style="padding:10px">
    <!-- 功能区域 -->
    <div style="margin:10px 0">
      <el-button type="primary" @click="add">新增</el-button>
      <el-button type="success" @click="">导入</el-button>
      <el-button type="danger" @click="">导出</el-button>

    </div>

<!-- 搜索区域 -->
    <div style="margin:10px 0">
      <el-input v-model="search" placeholder="请输入关键字" style="width:20%" clearable />
      <el-button type="primary" style="margin:0 10px" @click="load">搜索</el-button>
    </div>

    <el-table :data="tableData" border stripe style="width: 99%">
      <el-table-column prop="id" label="ID" width="180" sortable />
      <el-table-column prop="username" label="用户名" width="180"/>
      <el-table-column prop="nickName" label="昵称" width="180"/>
      <el-table-column prop="age" label="年龄" width="180"/>
      <el-table-column prop="sex" label="性别" width="180"/>
      <el-table-column prop="address" label="地址" width="160"/>
      <el-table-column label="Operations" >
        <template #default="scope">
          <el-button @click="handleEdit(scope.row)"
            >编辑</el-button
          >
          <!-- <el-button
            size="small"
            type="danger"
            @click="handleDelete(scope.$index, scope.row)"
            >删除</el-button> -->
          <el-popconfirm title="确认删除?" type="danger" @confirm="handleDelete(scope.row.id)">
            <template #reference>
              <el-button type="danger">删除</el-button> 
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <div style="margin:10px 0">
      <el-pagination
      v-model:currentPage="currentPage4"
      v-model:page-size="pageSize4"
      :page-sizes="[10, 20, 30, 40]"
      :small="small"
      :disabled="disabled"
      :background="background"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />


      <el-dialog v-model="dialogVisible"
        title="新增数据"
        width="30%"
      >
      <el-form :model="form" label-width="120px">
        <el-form-item label="用户名">
          <el-input v-model="form.username" style="width:80%"></el-input>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="form.nickName" style="width:80%"></el-input>
        </el-form-item>
        <el-form-item label="年龄">
          <el-input v-model="form.age" style="width:80%"></el-input>
        </el-form-item>
        <el-form-item label="性别">
          <el-radio-group v-model="form.sex" class="ml-5">
            <el-radio label="男" size="large">男</el-radio>
            <el-radio label="女" size="large">女</el-radio>
            <el-radio label="保密" size="large">保密</el-radio>
          
          </el-radio-group>
        </el-form-item>
        <el-form-item label="地址">
          <el-input type="textarea" v-model="form.address" style="width:80%"></el-input>
        </el-form-item>
      </el-form>
        <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">取消</el-button>
            <el-button type="primary" @click="save"
              >确认</el-button
            >
          </span>
        </template>
      </el-dialog>

    </div>
  </div>
</template>

<script>
import { assertExpressionStatement } from '@babel/types'
import  request  from '@/utils/request'


export default {
  name: 'User',
  components: {
    
  },
  data() {
    return {
      form:{},
      dialogVisible: false,
      search:'',
      currentPage4:1,
      pageSize4:10,
      total:0,
      tableData:[
        
      ]
    }
  },
  created() {
    this.load()
  },
  methods: {
    load(){
      request.get("/user",{
        params:{
          pageNum:this.currentPage4,
          pageSize:this.pageSize4,
          search:this.search
        }
      }).then(res => {
        console.log(res);
        this.tableData = res.data.records
        this.total = res.data.total
      })
    },
    add(){
      this.dialogVisible = true
      this.form = {}
    },
    save(){
      if(this.form.id){
        request.put("/user",this.form).then(res => {
          console.log(res)
          if(res.code == 0 ){
            this.$message.success("更新成功")
          }else{
            this.$message.error(res.msg)
          }
          this.load()
        this.dialogVisible = false
        })
      } else{
        request.post("/user",this.form).then(res => {
          console.log(res)
          if(res.code == 0 ){
            this.$message.success("新增成功")
          }else{
            this.$message.error(res.msg)
          }
          this.load()
        this.dialogVisible = false
        })
      }
    },
    handleEdit(row){
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true

    },
    handleDelete(id){
      console.log(id);
      request.delete("/user/" + id).then(res => {
        if(res.code == 0 ){
            this.$message.success("删除成功")
          }else{
            this.$message.error(res.msg)
          }
        this.load()
      })

    },
    handleSizeChange(pageSize){     //改变每页数量触发
      this.pageSize4 = pageSize
      this.load()
    },
    handleCurrentChange(pageNum){  //改变当前页码触发
      this.currentPage4 = pageNum
      this.load()
    },
    pageSize4(){

    }
  },
}
</script>
