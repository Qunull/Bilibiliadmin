<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/5
  Time: 8:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>前台登陆</title>
</head>
<body>
<form action="/user/doLogin" method="post">
<div >
    <div>
            <div>
                <input type="text" name="phone" id="phone" placeholder="用户名" value="">
            </div>
            <div >
                <input type="password" name="password" id="password" placeholder="密码" value="">
            </div>
            <div >
                <input type="submit"  value="登录">
            </div>

    </div>
</div>
</form>
<a href="/user/useradd">注册</a>
</body>
</html>
