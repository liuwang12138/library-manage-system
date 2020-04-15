<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员登陆</title>
    <link href="${staticWebsite}css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<h1>Admin Login</h1>
<div>
    <div class="form-group">
        <label for="username">username</label>
        <input type="text" class="form-control" id="username" aria-describedby="emailHelp">
    </div>
    <div class="form-group">
        <label for="password">Password</label>
        <input type="password" class="form-control" id="password">
    </div>
    <button class="btn btn-primary" onclick="adminLogin()">登陆</button>
</div>
</body>
<script src="${staticWebsite}js/jquery-1.11.1.min.js"></script>
<script src="${staticWebsite}js/bootstrap.min.js"></script>

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
