<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html><head>
    <meta charset="UTF-8">
    <title>员工操作记录</title>
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
                <form class="layui-form layui-form-pane" action="/Jnime/JournalList" method="post">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">操作员工</label>
                            <div class="layui-input-inline">
                                <input type="text" name="userName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">操作内容</label>
                            <div class="layui-input-inline">
                                <input type="text" name="matter" class="layui-input" id="test1-1" >
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
        </script>
    </div>
</div>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
    </div>
</script>

<script src="../css/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script>

    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;
        var tableContent = new Array();
        <c:forEach items="${journaList}" var= "jua">
        var module = {"userId":"${jua.userId}",
            "userName":"${jua.userName}",
            "matter":"${jua.matter}",
            "optime":"${jua.optime}",
            }
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
                {field: 'userId', title: '员工编号', sort: true},
                {field: 'userName',  title: '员工姓名'},
                {field: 'matter',  title: '操作内容'},
                {field: 'optime',  title: '操作时间'},
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 5,
            page: true
        });
    });

</script>
</body>
</html>
