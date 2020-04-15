<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员登陆</title>
    <link href="${staticWebsite}css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${staticWebsite}css/main.css">
</head>
<body>
<section class="material-half-bg">
    <div class="cover"></div>
</section>
<section class="login-content">
    <div class="logo">
        <h1>图书馆后台管理系统</h1>
    </div>
    <div class="login-box">
        <div class="login-form">
            <h2 class="login-head">登陆</h2>
            <div class="form-group">
                <label class="control-label">用户名</label>
                <input class="form-control" type="text" id="username" placeholder="username" autofocus>
            </div>
            <div class="form-group">
                <label class="control-label">密码</label>
                <input class="form-control" type="password" id="password" placeholder="Password">
            </div>
            <div class="form-group btn-container">
                <button class="btn btn-primary btn-block" onclick="adminLogin()">登录</button>
            </div>
        </div>
    </div>
</section>
<script src="${staticWebsite}js/jquery-1.11.1.min.js"></script>
<script src="${staticWebsite}js/bootstrap.min.js"></script>
<script src="${staticWebsite}js/popper.min.js"></script>
<script src="${staticWebsite}js/main.js"></script>
<script src="${staticWebsite}js/pace.min.js"></script>
<script type="text/javascript">
    $('.login-content [data-toggle="flip"]').click(function() {
        $('.login-box').toggleClass('flipped');
        return false;
    });
</script>
</body>
<%--<body>--%>
<%--<h1>Admin Login</h1>--%>
<%--<div>--%>
<%--    <div class="form-group">--%>
<%--        <label for="username">username</label>--%>
<%--        <input type="text" class="form-control" id="username" aria-describedby="emailHelp">--%>
<%--    </div>--%>
<%--    <div class="form-group">--%>
<%--        <label for="password">Password</label>--%>
<%--        <input type="password" class="form-control" id="password">--%>
<%--    </div>--%>
<%--    <button class="btn btn-primary" onclick="adminLogin()">登陆</button>--%>
<%--</div>--%>
<%--</body>--%>
<script>
    function adminLogin() {
        let username = $('#username').val();
        let password = $('#password').val();
        $.ajax({
            type: 'post',
            url: "${website}admin/login",
            dataType: "text",
            data:{
                username: username,
                password: password
            },
            success: function (msg) {
                console.log(msg);
                msg = JSON.parse(msg);
                if (msg.code == 201) {
                    alert(msg.message);
                    window.location = "${website}admin/index"
                } else {
                    alert(msg.message);
                }
            },
            error: function (msg) {
                alert("error!");
            },
        });
    }
</script>
</html>
