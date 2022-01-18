<%--
  Created by IntelliJ IDEA.
  User: deku
  Date: 2019/10/31
  Time: 17:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath }../css/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="../css/public.css" media="all">

    <link rel="stylesheet" href="../css/layui-v2.5.4/css/layui.css"  media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <fieldset class="layui-elem-field layuimini-search">
            <legend>添加管理员信息</legend>
            <div style="margin: 20px 10px 10px 400px" >
                <form class="layui-form layui-form-pane" action="/Auditor/addsave.html" method="post" enctype="multipart/form-data">
                    <div class="layui-form-item" >
                        <div class="layui-inline">
                            <label class="layui-form-label">管理员姓名:</label>
                            <div class="layui-input-inline">
                                <input type="text" id="auditorName" name="auditorName" lay-verify="required"  autocomplete="off" class="layui-input"  placeholder="请输入真实姓名" >
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">密码:</label>
                            <div class="layui-input-inline">
                                <input type="password" id="password" name="password" lay-verify="required" autocomplete="off" class="layui-input" placeholder="请输入6位以上密码">
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">管理员昵称</label>
                            <div class="layui-input-inline">
                                <input type="text" id="auditorAuthor" name="auditorAuthor" lay-verify="required" autocomplete="off" class="layui-input" placeholder="用于登录及显示">
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">电话</label>
                            <div class="layui-input-inline">
                                <input type="text" id="phone" name="phone" autocomplete="off" lay-verify="phone" class="layui-input">
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">性别</label>
                            <div class="layui-input-inline">

                                <input type="radio" name="gender" value="1" title="男">
                                <input type="radio" name="gender" value="2" title="女">

                            </div>
                        </div>
                        <br>
                        <div class="layui-inline">
                            <label class="layui-form-label">生日</label>
                            <div class="layui-input-inline">
                                <input type="text" name="birthday" id="birthday" lay-verify="date" autocomplete="off" placeholder="yyyy-MM-dd" value="${admin.birthday}" class="layui-input">
                            </div>
                        </div>
                        <br>
                        <div class="layui-inline">
                            <label class="layui-form-label">员工角色</label>
                            <div class="layui-input-inline">
                                <select name="auditorRole" >
                                    <option value="">--请选择--</option>
                                    <option value="3">管理员</option>
                                    <option value="4">员工</option>
                                </select>
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">头像</label>
                            <div class="layui-input-inline">
                                <input type="file" id="auditorAvatar" name="FileName" autocomplete="off" class="layui-input">
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">备注</label>
                            <div class="layui-input-inline">
                                <input type="text" id="memo" name="memo" autocomplete="off" class="layui-input">
                            </div>
                        </div><br><br>
                        <div class="layui-btn-group">
                            <button class="layui-btn" lay-submit>保存</button>
                            <button class="layui-btn layui-btn-danger data-delete-btn">返回</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>
    </div>
</div>

<script src="../css/layui-v2.5.4/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['form','laydate'], function(){
        var form = layui.form;

        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#birthday' //指定元素
        });
    })
</script>

</body>
</html>