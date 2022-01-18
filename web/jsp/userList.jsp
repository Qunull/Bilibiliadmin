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
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="/user" method="post">
                    <input type="hidden" name="opr" value="userList">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">用户编号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="userId" autocomplete="off" class="layui-input" value="${userId}">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">用户姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" id="userName" name="userName" autocomplete="off" value="${userName}" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn" lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>
        <div class="layui-btn-group">

        </div>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>
    </div>
</div>
<script src="../css/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        var tableContent = [];
        <c:forEach items="${userList}" var= "user">
        var module = {"userId":"${user.userId}",
            "userName":"${user.userName}",
            "userAuthor":"${user.phone}",
            "phone":"${user.phone}",
            "gender":"<c:if test="${user.gender=='1'}">男</c:if><c:if test="${user.gender=='2'}">女</c:if><c:if test="${user.gender=='3'}">机械人</c:if>",
            "birthday":"${user.birthday}",
            "userRole":"${user.userRole}",
            "userAutograph":"${user.signature}",
            "fans":"${user.fans}",
            "memo":"${user.notice}"}
        tableContent.push(module)
        </c:forEach>
        table.render({
            elem: '#currentTableId',
            data: tableContent,
            toolbar: '#toolbarDemo', //开启头部工具栏，并为其绑定左侧模板
            defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            title: '提示'
            ,layEvent: 'LAYTABLE_TIPS'
            ,icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50, fixed: "left"},
                {field: 'userId', title: '用户编号', sort: true},
                {field: 'userName',  title: '用户姓名'},
                {field: 'phone',  title: '电    话'},
                {field: 'gender',  title: '性    别'},
                {field: 'birthday',  title: '用户生日'},
                {field: 'userRole',  title: '用户角色'},
                {field: 'userAutograph',  title: '签    名'},
                {field: 'fans',  title: '粉丝数量'},
                {field: 'memo',  title: '备    注'},
                {title: '操作', minWidth: 50, templet: '#currentTableBar', fixed: "right", align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 5,
            page: true
        });


        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            var result = JSON.stringify(data.field);
            layer.alert(result, {
                title: '最终的搜索信息'
            });

            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    searchParams: result
                }
            }, 'data');

            return false;
        });

        // 监听添加操作
        $(".data-add-btn").on("click", function () {
            layer.msg('添加数据');
        });

        // 监听删除操作
        $(".data-delete-btn").on("click", function () {
            var checkStatus = table.checkStatus('currentTableId')
                , data = checkStatus.data;
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {
                layer.open({
                    type: 2 //此处以iframe举例
                    , title: '修改'
                    , area: ['600px', '600px']
                    , content: '../user?opr=toUserModify&userId='+data.userId
                });
                //layer.close(index);
            } else if (obj.event === 'delete') {
                layer.confirm('确定要删除吗？？？', function() {
                    $.ajax({
                        type:"post",//请求类型
                        url:"../user?opr=delete&userId="+data.userId,//请求的url
                        data:{userId:data.userId},//请求参数
                        dataType:"text",//ajax接口（请求url）返回的数据类型
                        success:function(data){//data：返回数据（json对象）
                            if (data==true) {
                                layer.alert("删除成功！")
                                location.reload();
                            }else{
                                layer.alert("删除失败！")
                                location.reload();
                            };
                        },
                        error:function(data){//当访问时候，404，500 等非200的错误状态码
                            //validateTip(userCode.next(),{"color":"red"},imgNo+" 您访问的页面不存在",false);
                        }
                    });
                });
            }
        });

    });
</script>
</body>
</html>
