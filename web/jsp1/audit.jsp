<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>查看所有待审视频</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath }../css/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="../css/public.css" media="all">
</head>
<body>
<%response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
    response.flushBuffer();%>
<%
    Cookie killMyCookie = new Cookie("mycookie", null);
    killMyCookie.setMaxAge(0);
    killMyCookie.setPath("/");
    response.addCookie(killMyCookie);
%>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="layui-elem-field layuimini-search">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form" action="/Audit/selectAudit.html" method="post">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">视频av号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="videoId" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">视频标题</label>
                            <div class="layui-input-inline">
                                <input type="text" name="videoTitle" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">上传者id</label>
                            <div class="layui-input-inline">
                                <input type="text" name="uploaderId" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <input type="submit" class="layui-btn" lay-submit="" value="搜索"/>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit">审核</a>
        </script>
    </div>
</div>
<script src="${pageContext.request.contextPath }../css/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        var tableContent = new Array();
        <c:forEach items="${auditList}" var= "module">
        var module = {"videoId":"${module.videoId}",
                    "videoTitle":"${module.videoTitle}",
            "videoIntrbriefing":"${module.videoIntrbriefing}",
            "uploadtime":"${module.uploadtime}",
            "userName":"${module.userName}"}
        tableContent.push(module)
        </c:forEach>

        table.render({
            elem: '#currentTableId',
            data: tableContent,
            cols: [[
                {type: "checkbox", width: 50, fixed: "left"},
                {field: 'videoId', title: 'av号', sort: true},
                {field: 'videoTitle',  title: '视频标题'},
                {field: 'videoIntrbriefing',  title: '视频简介'},
                {field: 'uploadtime', title: '上传时间', sort: true},
                {field: 'userName', title: '上传者姓名'},
                {title: '操作', minWidth: 50, templet: '#currentTableBar', fixed: "right", align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 5,
            page: true
        });
        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
             var data = obj.data;
            // if (obj.event === 'edit') {
            //     layer.alert('审核：<br>' + JSON.stringify(data))
            // }
            layer.open({
                type: 2 //此处以iframe举例
                ,title: '审核'
                ,area: ['500px', '600px']
                ,content: '../Audit/toAudit.html?videoId='+data.videoId
            });
        });

    });
</script>
<script>

</script>

</body>
</html>
