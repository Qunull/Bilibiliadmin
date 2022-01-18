<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta charset="utf-8">
    <title>BiliBili后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="${pageContext.request.contextPath }../images/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath }../css/layui-v2.5.4/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath }../css/layuimini.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath }../css/font-awesome-4.7.0/css/font-awesome.min.css"
          media="all">
    <link rel="stylesheet" href="../css/shouye.css">
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src=" "></script>
    <![endif]-->
    <style id="layuimini-bg-color">
    </style>
</head>
<body class="layui-layout-body layuimini-all">
<div class="layui-layout layui-layout-admin">

    <div class="layui-header header">
        <div class="layui-logo">
        </div>
        <a>
            <div class="layuimini-tool"><i title="展开" class="fa fa-outdent" data-side-fold="1"></i></div>
        </a>

        <ul class="layui-nav layui-layout-left layui-header-menu layui-header-pc-menu mobile layui-hide-xs">
        </ul>
        <ul class="layui-nav layui-layout-left layui-header-menu mobile layui-hide-sm">
            <li class="layui-nav-item">
                <a href="javascript:;"><i class="fa fa-list-ul"></i> 选择模块</a>
                <dl class="layui-nav-child layui-header-mini-menu">
                </dl>
            </li>
        </ul>

        <ul class="layui-nav layui-layout-right">
            <a href="../jsp/index1.jsp" target="_blank" data-refresh="前台首页" style="color: white">
                <i class="fa fa-credit-card"/>&nbsp;&nbsp;前台首页
            </a>
            <li class="layui-nav-item">
                <a href="javascript:;" data-refresh="刷新"><i class="fa fa-refresh"></i></a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;" data-clear="清理" class="layuimini-clear"><i class="fa fa-trash-o"></i></a>
            </li>






            <li class="layui-nav-item layuimini-select-bgcolor mobile layui-hide-xs">
                <a href="javascript:;" data-bgcolor="配色方案"><i class="fa fa-ellipsis-v"></i></a>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll layui-left-menu">
        </div>
    </div>

    <div class="layui-body">
        <div class="layui-tab" lay-filter="layuiminiTab" id="top_tabs_box">
            <ul class="layui-tab-title" id="top_tabs">
                <li class="layui-this" id="layuiminiHomeTabId" lay-id=""></li>
            </ul>
            <ul class="layui-nav closeBox">
                <li class="layui-nav-item">
                    <a href="javascript:;"> <i class="fa fa-dot-circle-o"></i> 页面操作</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" data-page-close="other"><i class="fa fa-window-close"></i> 关闭其他</a>
                        </dd>
                        <dd><a href="javascript:;" data-page-close="all"><i class="fa fa-window-close-o"></i> 关闭全部</a>
                        </dd>
                    </dl>
                </li>
            </ul>
            <div class="layui-tab-content clildFrame">
                <div id="layuiminiHomeTabIframe" class="layui-tab-item layui-show">
                </div>
            </div>
        </div>
    </div>

</div>
<script src="../css/jquery-3.4.1/jquery-3.4.1.min.js" charset="utf-8"></script>
<script src="../css/layui-v2.5.4/layui.js?v=1.0.4" charset="utf-8"></script>
<script src="../js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['element', 'layer', 'layuimini'], function () {
        var $ = layui.jquery,
            element = layui.element,
            layer = layui.layer;

        layuimini.init('../api/init.json');
        $(".csdn").append('<form id="uploadFileHiddenForm" method="post"><input type="file" name="file" id="updateFileInput" style="display:none;"/></form>');

        $("#updateFileInput").change(function () {
            var files = $("#updateFileInput").get(0).files[0]; //获取file控件中的内容
            var auditorId = $("#auditorId").val();
            var reader = new FileReader();
            reader.readAsDataURL(files);
            reader.onload = function (f) {
                //预览图片
                document.getElementById("photo").src = this.result;
            }

            var formData = new FormData();
            formData.append("fileObj", files);

            $.ajax({                        //发请求给接口
                cache: false,
                async: false,
                contentType: false,
                processData: false,
                url: "/Auditor/modifyAvatar?auditorId=" + auditorId,    //接口地址
                type: 'POST',
                enctype: 'multipart/form-data',
                data: formData,
                dataType: 'JSON',
                success: function (data) {
                    if (data == true) {
                        layer.alert("头像修改成功啦^_^")
                    }
                }, error: function () {
                    layer.alert("修改头像失败啦T_T")
                }
            });
        });
        $('.login-out').on("click", function () {
            layer.msg('退出登录成功', function () {
                window.location = '/Auditor/log.html';
            });
        });
    });
</script>
</body>
</html>
