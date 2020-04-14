<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="../common/user_header.jsp" />
</head>
<body>
<jsp:include page="../common/user_navigator.jsp" />
<div class="container">
    <h1>注册</h1>
    <div class="form-horizontal">
        <div class="form-group">
            <label for="nUsername" class="col-sm-2 control-label">用户名:</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="nUsername" placeholder="Username">
            </div>
        </div>
        <div class="form-group">
            <label for="nPassword" class="col-sm-2 control-label">密 &nbsp;&nbsp;&nbsp;码:</label>
            <div class="col-sm-6">
                <input type="password" class="form-control" id="nPassword" placeholder="Password">
            </div>
        </div>
        <div class="form-group">
            <label for="realName" class="col-sm-2 control-label">真实姓名:</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="realName" placeholder="RealName">
            </div>
        </div>
        <div class="form-group">
            <label for="phone" class="col-sm-2 control-label">手机号:</label>
            <div class="col-sm-6">
                <input type="text" class="form-control" id="phone" placeholder="Phone">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button class="btn btn-primary" data-dismiss="modal" onclick="register()">注册</button>
                <button class="btn btn-primary" type="reset">重置</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../common/user_footer.jsp" />
<script>
    function register() {
        console.log(1);
        let username = $('#nUsername').val();
        let password = $('#nPassword').val();
        let realName = $('#realName').val();
        let phone = $('#phone').val();
        $.ajax({
            type: 'post',
            url: "${website}user/register",
            dataType: "text",
            data:{
                username: username,
                password: password,
                realName: realName,
                phone: phone
            },
            success: function (msg) {
                msg = JSON.parse(msg);
                if (msg.code == 201) {
                    console.log("register success");
                    alert(msg.message);
                    window.location = "${website}";
                } else {
                    alert(msg.message);
                }
            },
            error: function (msg) {
                alert("error！");
            },
        });
    }
</script>
</body>
</html>
