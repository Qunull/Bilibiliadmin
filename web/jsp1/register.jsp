<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/5
  Time: 9:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>注册</title>
</head>
<body>
    <form id="userForm" action="/user/adduser" method="post">
        <div>
            <label >昵称</label>
            <div >
                <input type="text" id="userAuthor" name="userAuthor">
            </div>
        </div><br>
        <div >
            <label >密码</label>
            <div >
                <input type="text" id="password" name="password">
            </div>
        </div><br>
        <div >
            <label >电话</label>
            <div >
                <input type="text" id="phone" name="phone">
            </div>
        </div>
        <div>
            <input type="submit" name="add" id="add" value="保存">
            <input type="button" id="back" name="back" value="返回" >
        </div>
    </form>
</body>
</html>
