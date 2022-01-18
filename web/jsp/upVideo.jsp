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
    <link rel="stylesheet" href="../css/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="../css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="layui-elem-field layuimini-search">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form" action="/video" method="post">
                    <input type="hidden" name="opr" value="videoList">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">视频av号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="videoId" autocomplete="off" class="layui-input" value="${videoId}">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">视频标题</label>
                            <div class="layui-input-inline">
                                <input type="text" name="videoTitle" autocomplete="off" class="layui-input" value="${videoTitle}">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">上传者id</label>
                            <div class="layui-input-inline">
                                <input type="text" name="uploaderId" autocomplete="off" class="layui-input" value="${upLoaderId}">
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
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit">上架</a>
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
        <c:forEach items="${videoList}" var= "video">
        var module = {"videoId":"${video.videoId}",
            "videoTitle":"${video.videoTitle}",
            "likes":"${video.likes}",
            "uploadTime":"${video.uploadTime}",
            "uploaderId":"${video.uploaderId}",
            "path":"${video.path}"
        }
        tableContent.push(module)
        </c:forEach>
        table.render({
            elem: '#currentTableId',
            data: tableContent,
            cols: [[
                {type: "checkbox", width: 50, fixed: "left"},
                {field: 'videoId', title: 'av号', sort: true},
                {field: 'videoTitle',  title: '视频标题'},
                {field: 'likes',  title: '点赞数'},
                {field: 'uploadTime', title: '上传时间', sort: true},
                {field: 'uploaderId', title: '上传者姓名'},
                {field: 'path', title: '视频路径'}
               /* {field: 'auditingID', title: '审核状态'},
                {title: '操作', minWidth: 50, templet: '#currentTableBar', fixed: "right", align: "center"}*/
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
            var v = obj.data;
            $.ajax({
                type: "POST",//方法类型
                url:"../Audit/upUpdate.html",
                data:{"videoId":v.videoId,"grounding":"8"},
                dataType:"json",
                async:false,
                traditional: true,
                success: function (data) {
                    if (data) {
                        //配置一个透明的提示框,0.8s后自动关闭
                        layer.msg('上架成功！', {time: 800},function(){
                            //刷新窗体
                            window.location.reload();
                        });

                    }else{
                        //配置一个透明的提示框,0.8s后自动关闭
                        layer.msg('上架失败！', {time: 800});
                    };
                },
                error : function() {
                    layer.alert("失败！出现不可解决问题请尽快联系管理员！")
                }
            })
        });

    });
</script>
<script>

</script>

</body>
</html>
