<%--
  Created by IntelliJ IDEA.
  User: deku
  Date: 2019/11/7
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <form class="layui-form layui-form-pane" id="updateForm" <%--action="/Auditor/modafySave?auditorId=${auditor.auditorId}"--%>>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">用户姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" id="auditorName" name="auditorName"value="${staff.auditorName}" autocomplete="off" class="layui-input">
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">昵称</label>
                            <div class="layui-input-inline">
                                <input type="text" id="auditorAuthor" name="auditorAuthor"value="${staff.auditorAuthor}" autocomplete="off" class="layui-input">
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">电话</label>
                            <div class="layui-input-inline">
                                <input type="text" id="phone" name="phone" value="${staff.phone}"autocomplete="off" class="layui-input">
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">性别</label>
                            <div class="layui-input-inline">
                                <c:if test="${staff.gender ==1}">
                                    <input type="radio" name="gender" class="gender" value="1" checked>男
                                    <input type="radio" name="gender" class="gender" value="2">女
                                </c:if>
                                <c:if test="${staff.gender ==2}">
                                    <input type="radio" name="gender" class="gender" value="1">男
                                    <input type="radio" name="gender" class="gender" value="2" checked>女
                                </c:if>
                            </div>
                        </div><br>
                        <div class="layui-inline">
                            <label class="layui-form-label">生日</label>
                            <div class="layui-input-inline">
                                <input type="text" id="birthday" name="birthday" value="${staff.birthday}"autocomplete="off" class="layui-input">
                            </div>
                        </div><br>
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
                            <label class="layui-form-label">备注</label>
                            <div class="layui-input-inline">
                                <input type="text" id="memo" name="memo"value="${staff.memo}" autocomplete="off" class="layui-input">
                            </div>
                        </div><br>
                        <div class="layui-btn-group">
                            <input type="hidden" id="auditorId" value="${staff.auditorId}">
                            <button class="layui-btn" type="button" lay-submit lay-filter="add">保存</button>
                            <button class="layui-btn layui-btn-danger data-delete-btn">返回</button>
                        </div>
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

        form.on('submit(add)',function () {
            var formObject = {};
            var formArray =$("#updateForm").serializeArray();
            $.each(formArray,function(i,item){
                formObject[item.name] = item.value;

                var auditorId=$("#auditorId").val();
                var auditorName=$("#auditorName").val();
                var auditorAuthor=$("#auditorAuthor").val();
                var phone=$("#phone").val();
                var gender=$(".gender:checked").val();
                var birthday=$("#birthday").val();
                var auditorRole=$("#auditorRole").val();
                var memo=$("#memo").val();
                $.ajax({
                    type: "POST",
                    /* contentType: 'application/json; charset=UTF-8',*/
                    url: "/staff/modifySave",
                    data:{"auditorId":auditorId,
                        "auditorName":auditorName,
                        "auditorAuthor":auditorAuthor,
                        "phone":phone,"gender":gender,
                        "birthday":birthday,
                        "auditorRole":auditorRole,
                        "memo":memo},
                    dataType: "html",
                    success: function(data){
                        if(data!=null) {
                            //配置一个透明的提示框,0.8s后自动关闭
                            layer.msg('修改成功啦=_=！', {time: 800},function(){
                                //刷新父级窗体
                                parent.window.location.reload();
                                // 获得frame索引
                                var index = parent.layer.getFrameIndex(window.name);
                                //关闭当前frame
                                parent.layer.close(index);
                            });
                        }else{
                            //配置一个透明的提示框,0.8s后自动关闭
                            layer.msg('修改失败了呢0.0！', {time: 800});
                            location.reload();
                        }
                    },
                    error : function() {
                        layer.alert("失败！出现不可解决问题请尽快联系管理员！")
                    }
                })
            });
        });
    });
</script>
</html>
