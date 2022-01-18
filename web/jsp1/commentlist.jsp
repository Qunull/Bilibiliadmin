<%--
  Created by IntelliJ IDEA.
  User: deku
  Date: 2019/11/2
  Time: 13:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                <form class="layui-form layui-form-pane" action="/comment/getCommList.html">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">用户ID</label>
                            <div class="layui-input-inline">
                                <input type="text" name="userId" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">视频编号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="videoId" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn" lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
                            <%--<input	value="查 询" type="submit" id="searchbutton">--%>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>
        <%--<table class="layui-table">
            <thead>
            <tr>
                <th>发送者ID</th>
                <th>视频编号</th>
                <th>内容</th>
                <th>备注</th>
                <div class="noprint">
                    <th	class="noprint">操     作</th>
                </div>
            </tr>
            </thead>
            <c:forEach var="comment" items="${commentList}" varStatus="status">
                <tr>
                    <td>${comment.userId}</td>
                    <td>${comment.videoId}</td>
                    <td>${comment.content}</td>
                    <td>${comment.memo}</td>
                    <td class="td-manage">
                        <a title="修改" onclick="">
                            <i class="layui-icon">&#xe63c;</i>
                        </a>
                        <a title="删除" onclick="member_del(this,'要删除的id')" href="/comment/delComm?id=${comment.id}">
                            <i class="layui-icon">&#xe640;</i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </table>--%>
    </div>
</div>
<script src="../css/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script>

    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        var tableContent = new Array();
        <c:forEach items="${commentList}" var= "comment">
        var module = {"id":"${comment.id}",
            "userId":"${comment.userId}",
            "videoId":"${comment.videoId}",
            "content":"${comment.content}",
            "memo":"${comment.memo}"}
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
                {field: 'userId', title: '发送者ID', sort: true},
                {field: 'videoId',  title: '视频编号'},
                {field: 'content',  title: '评论内容'},
                {field: 'memo',  title: '备注'},
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


            /*else if(layEvent === 'edit'){
              layer.msg('编辑操作');
             }*/
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {
                layer.alert('编辑行：<br>' + JSON.stringify(data))
            } else if (obj.event === 'delete') {
                layer.confirm('确定要删除吗？？？', function() {
                    $.ajax({
                        type:"post",//请求类型
                        url:"/comment/delComm",//请求的url
                        data:{"id":data.id},//请求参数
                        dataType:"json",//ajax接口（请求url）返回的数据类型
                        success:function(data){//data：返回数据（json对象）
                            if (data==true) {
                                //配置一个透明的提示框,0.8s后自动关闭
                                layer.msg('删除成功=_=！', {time: 800},function(){
                                    //刷新父级窗体
                                    parent.window.location.reload();
                                    // 获得frame索引
                                    var index = parent.layer.getFrameIndex(window.name);
                                    //关闭当前frame
                                    parent.layer.close(index);
                                });
                            }else{
                                //配置一个透明的提示框,0.8s后自动关闭
                                layer.msg('删除失败=_=！', {time: 800},function(){
                                    //刷新父级窗体
                                    parent.window.location.reload();
                                    // 获得frame索引
                                    var index = parent.layer.getFrameIndex(window.name);
                                    //关闭当前frame
                                    parent.layer.close(index);
                                });
                            };
                        },
                        error:function(data){//当访问时候，404，500 等非200的错误状态码
                            layer.alert("请重试！！！！")
                        }
                    });
                });
            }
        });

    });
</script>
</body>
</html>
