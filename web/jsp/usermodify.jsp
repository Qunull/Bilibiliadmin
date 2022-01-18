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
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <fieldset class="layui-elem-field layuimini-search">
            <legend>修改信息</legend>
            <div style="margin: 10px 10px 10px 10px" >
                <form class="layui-form layui-form-pane" id="updateForm">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">用户姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" id="userName" name="userName"value="${user.userName}" autocomplete="off" class="layui-input">
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">电话</label>
                            <div class="layui-input-inline">
                                <input type="text" id="phone" name="phone" value="${user.phone}"autocomplete="off" class="layui-input">
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">性别</label>
                            <div class="layui-input-inline">
                                <c:if test="${user.gender ==1}">
                                    <input type="radio" name="gender" class="gender" value="1" checked>男
                                    <input type="radio" name="gender" class="gender" value="2">女
                                    <input type="radio" name="gender" class="gender" value="3">机器人
                                </c:if>
                                <c:if test="${user.gender ==2}">
                                    <input type="radio" name="gender" class="gender" value="1">男
                                    <input type="radio" name="gender" class="gender" value="2" checked>女
                                    <input type="radio" name="gender" class="gender" value="3">机器人
                                </c:if>
                                <c:if test="${user.gender ==null}">
                                    <input type="radio" name="gender" class="gender" value="1" >男
                                    <input type="radio" name="gender" class="gender" value="2">女
                                    <input type="radio" name="gender" class="gender" value="3" checked>机器人
                                </c:if>
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">生日</label>
                            <div class="layui-input-inline">
                                <input type="text" id="birthday" name="birthday" value="${user.birthday}"autocomplete="off" class="layui-input">
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">用户角色</label>
                            <div class="layui-input-inline">
                                <input type="text" id="userRole" name="userRole" value="${user.userRole}" autocomplete="off" class="layui-input">
                            </div>
                        </div><br>
                        <div class="layui-inline">
                        <label class="layui-form-label">签名</label>
                            <div class="layui-input-inline">
                            <input type="text" id="signature" name="signature" value="${user.signature}" autocomplete="off" class="layui-input">
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">粉丝数量</label>
                            <div class="layui-input-inline">
                                <input type="text" id="fans" name="fans"value="${user.fans}" autocomplete="off" class="layui-input">
                            </div>
                        </div><br>
                        </div><br>
                        <div class="layui-btn-group">
                            <input type="hidden" id="userId"  name="userId" value="${user.userId}">
                            <button class="layui-btn" type="button" lay-submit lay-filter="add">保存</button>
                            <button class="layui-btn layui-btn-danger data-delete-btn">返回</button>
                        </div>
                </form>
            </div>
        </fieldset>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath }../css/jquery-3.4.1/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath }../css/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer;
        //添加操作
        form.on('submit(add)',function () {
            var formObject = {};
            var formArray =$("#updateForm").serializeArray();//读取form表单的所有数据，做成JSON数组
            var userId='';
            var userName='';
            var phone='';
            var gender='';
            var birthday='';
            var userRole='';
            var signature='';
            var fans='';
            $.each(formArray,function(i,item){
                formObject[item.name] = item.value;
                userId=$("#userId").val();
                userName=$("#userName").val();
               /* userAuthor=$("#userAuthor").val();*/
                phone=$("#phone").val();
                gender=$(".gender:checked").val();
                birthday=$("#birthday").val();
                userRole=$("#userRole").val();
                signature=$("#signature").val();
                fans=$("#fans").val();
               /* var memo=$("#memo").val();*/

            });
            //发送ajax请求， 执行修改之后的 保存
            $.ajax({
                type: "POST",
                /* contentType: 'application/json; charset=UTF-8',*/
                url: "../user?opr=uModifySave",
                data: {
                    "userId": userId,
                    "userName": userName,
                    /* "userAuthor": userAuthor,*/
                    "phone": phone,
                    "gender": gender,
                    "birthday": birthday,
                    "userRole": userRole,
                    "signature": signature,
                    /*  "userAutograph": userAutograph,*/
                    "fans": fans,
                    /*  "memo": memo*/
                },
                dataType: "text",
                success: function (data) {
                    if (data != null) {
                        //配置一个透明的提示框,0.8s后自动关闭
                        layer.msg('修改成功啦=_=！', {time: 800}, function () {
                            //刷新父级窗体
                            parent.window.location.reload();
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                        });
                    } else {
                        //配置一个透明的提示框,0.8s后自动关闭
                        layer.msg('修改失败了呢0.0！', {time: 800}, function () {
                            //刷新父级窗体
                            parent.window.location.reload();
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                        });
                    }
                },
                error: function () {
                    layer.msg('失败！出现不可解决问题请尽快联系管理员！', {time: 800}, function () {
                        //刷新父级窗体
                        parent.window.location.reload();
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                    });
                }

            })
        });
    });
</script>
</html>
