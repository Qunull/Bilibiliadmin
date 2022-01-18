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
<%
    //清楚缓存 注销后 点击后退 不会 再次进入 需要登录的页面
    response.setHeader("Cache-Control","no-cache,no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", -1);

    if(session.getAttribute("AuditorName")==null){
        response.sendRedirect("/Auditor/dologin.html");
    }
%>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <fieldset class="layui-elem-field layuimini-search">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="/Auditor/admin.html" method="post">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">员工编号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="auditorId" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">员工姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="auditorName" class="layui-input" id="test1-1" >
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">员工昵称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="auditorAuthor" class="layui-input" id="test1-2"  >
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


<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <a class="layui-btn data-add-btn" href="${pageContext.request.contextPath}/Auditor/saveadd.html">添加管理员</a>
 <button class="layui-btn layui-btn-danger data-delete-btn">删除</button>
    </div>
</script>

<script src="../css/layui-v2.5.4/layui.js" charset="utf-8"></script>
<script>

    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

    var tableContent = new Array();
    <c:forEach items="${auditorList}" var= "adt">
    var module = {"auditorId":"${adt.auditorId}",
        "auditorName":"${adt.auditorName}",
        "auditorAuthor":"${adt.auditorAuthor}",
        "phone":"${adt.phone}",
        "gender":"<c:if test="${adt.gender=='1'}">男</c:if><c:if test="${adt.gender=='2'}">女</c:if>",
        "birthday":"${adt.birthday}",
        "auditorRoleName":"${adt.auditorRoleName}",
        "memo":"${adt.memo}"}
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
            {field: 'auditorId', title: '员工编号', sort: true},
            {field: 'auditorName',  title: '员工姓名'},
            {field: 'auditorAuthor',  title: '员工昵称'},
            {field: 'phone',  title: '电    话'},
            {field: 'gender',  title: '性别'},
            {field: 'birthday',  title: '员工生日'},
            {field: 'auditorRoleName',  title: '员工角色'},
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
            /*/Auditor/saveadd.html*/

            $.ajax({
                //几个参数需要注意一下
                type: "GET",//方法类型
                url:"/Auditor/saveadd.html",//url
                error : function() {
                    layer.alert("请稍后重试！")
                }
            });
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
                layer.open({
                    type: 2 //此处以iframe举例
                    , title: '修改'
                    , area: ['600px', '600px']
                    , content: '../Auditor/getAuditorById?auditorId='+data.auditorId
                });
                //layer.close(index);
            }   else if (obj.event === 'delete') {
                layer.confirm('确定要删除吗？？？', function() {
                    $.ajax({
                        //几个参数需要注意一下
                        type: "POST",//方法类型
                        url:"/Auditor/Delect.html",//url
                        data:{"id":data.auditorId},
                        dataType:"json",
                        async:false,
                        traditional: true,
                        success: function (deat) {
                            if (deat==true) {
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
                        error : function() {
                            layer.alert("请稍后重试！")
                        }
                    });
                });
            }
        });
    });
</script>
</body>
</html>
