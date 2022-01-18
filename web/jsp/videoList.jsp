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
    <link rel="stylesheet" href="../css/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="../css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <fieldset class="layui-elem-field layuimini-search">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="/video" method="post">
                    <input type="hidden" name="opr" value="videoList">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">视频AV号</label>
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
                        <label class="layui-form-label">审核状态</label>
                        <div class="layui-input-inline">
                            <select name="auditingID" >
                                <option value="">--请选择--</option>
                                <option value="5" ${auditingID == 5 ? "selected=\"selected\"":"" }>待审</option>
                                <option value="6" ${auditingID == 6 ? "selected=\"selected\"":"" }>违规</option>
                                <option value="7" ${auditingID == 7 ? "selected=\"selected\"":"" }>通过</option>
                            </select>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn" lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        <script type="text/html" id="currentTableBar">
            <%--<a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit">编辑</a>--%>
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

        var tableContent = new Array();
        <c:forEach items="${requestScope.videoList}" var= "vol">
        var module = {"id":"${vol.videoId}",
            "videoTitle":"${vol.likes}",
            "videoIntrbriefing":"${vol.uploadTime}",
            "thumbs":"${vol.uploaderId}",
            "collection":"${vol.path}",
           /* "coin":"${vol.coin}",
            "forwarding":"${vol.forwarding}",
            "bullet":"${vol.bullet}",
            "comment":"${vol.comment}",
            "uploadtime":"${vol.uploadtime}",
            "uploaderId":"${vol.uploaderId}",
            "videoPath":"${vol.videoPath}",
            "auditingID":"<c:if test='${vol.auditingID == 5}'>待审</c:if><c:if test='${vol.auditingID == 6}'>违规</c:if><c:if test='${vol.auditingID == 7}'>通过</c:if>",
            "memo":"${vol.memo}"*/}
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
                {field: 'videoId', title: '视频编号', sort: true},
                {field: 'videoTitle',  title: '视频标题'},
               /* {field: 'videoIntrbriefing',  title: '视频简介'},*/
                {field: 'thumbs',  title: '点赞数'},
              /*  {field: 'collection',  title: '收藏数'},
                {field: 'coin',  title: '硬币数'},
                {field: 'forwarding',  title: '转发数'},
                {field: 'bullet',  title: '弹幕数量'},
                {field: 'comment',  title: '评论数量'},*/
                {field: 'uploadtime',  title: '上传时间'},
                {field: 'uploaderId',  title: '上传人'},
                {field: 'videoPath',  title: '视频地址'},
             /*   {field: 'auditingID',  title: '状态'},
                {field: 'memo',  title: '备注'},*/
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
                        url:"/video/delVideo.html",//请求的url
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
