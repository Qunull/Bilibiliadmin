<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>审核</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath }../css/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="../css/public.css" media="all">
    <style>
        .layui-form-item .layui-input-company {width: auto;padding-right: 10px;line-height: 38px;}
    </style>
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
    <div class="layui-form layuimini-form">
        <div class="layui-card">
            <div class="layui-card-header">视频详细信息</div>
            <div class="layui-card-body">
                视频av号：${audit.videoId}<br>
                视频标题：${audit.videoTitle}<br>
                视频简介：${audit.videoIntrbriefing}<br>
                视频上传人：${audit.userName}
            </div>
        </div>

        <div class="layui-card">
            <div class="layui-card-header">视频内容</div>
            <div class="layui-card-body">
                <video controls width="300px" height="200px">
                    <source src="../..${audit.videoPath}" type="video/mp4" />
                </video>
            </div>
        </div>

        <div class="layui-card">
            <div class="layui-card-header">审核操作</div>
            <div class="layui-card-body">
                <blockquote class="layui-elem-quote">
                    审核请严格按照“bilibili审核规范进行审核”
                    <br> <a href="../Audit/rule.html" target="_blank">>>点我查看规范</a>
                </blockquote>
                <br>
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="tgBtn">通过</button>
                    <button class="layui-btn" lay-submit lay-filter="wgBtn">违规</button>
                </div>
            </div>
        </div>
    </div>
<script src="${pageContext.request.contextPath }../css/jquery-3.4.1/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath }../css/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form
            , layer = layui.layer;

        //监听提交
        form.on('submit(tgBtn)', function () {
            $.ajax({
                //几个参数需要注意一下
                type: "POST",//方法类型
                url:"/Audit/doAudit.html",//url
                data:{"videoId":"${audit.videoId}","auditingID":"7","grounding":"8"},
                dataType:"json",
                async:false,
                traditional: true,
                success: function (data) {
                    if (data) {
                        //配置一个透明的提示框,0.8s后自动关闭
                        layer.msg('审核成功！', {time: 800},function(){
                            //刷新父级窗体
                            parent.window.location.reload();
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                        });
                    }else{
                        //配置一个透明的提示框,0.8s后自动关闭
                        layer.msg('审核失败！', {time: 800});
                        location.reload();
                    };
                },
                error : function() {
                    layer.alert("失败！出现不可解决问题请尽快联系管理员！")
                }
            })
        });
        //监听提交
        form.on('submit(wgBtn)', function () {
            $.ajax({
                //几个参数需要注意一下
                type: "POST",//方法类型
                url:"/Audit/doAudit.html",//url
                data:{"videoId":"${audit.videoId}","auditingID":"6","grounding":"9"},
                dataType:"json",
                async:false,
                traditional: true,
                success: function (data) {
                    if (data) {
                        //配置一个透明的提示框,0.8s后自动关闭
                        layer.msg('审核-违规成功！', {time: 800},function(){
                            //刷新父级窗体
                            parent.window.location.reload();
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                        });

                    }else{
                        //配置一个透明的提示框,0.8s后自动关闭
                        layer.msg('审核失败！', {time: 800});
                    };
                },
                error : function() {
                    layer.alert("失败！出现不可解决问题请尽快联系管理员！")
                }
            })
        });
    });
</script>
</body>
</html>
