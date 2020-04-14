<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><img src="${staticWebsite}img/logo.png" width="120px" alt="bootstrap"></a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active">
                    <a href="${website}"><span class="glyphicon glyphicon-home"></span>首页</a>
                </li>
                <li><a href="${website}notice"><span class="glyphicon glyphicon-list-alt"></span>公告</a></li>
                <li><a href="${website}seat"><span class="glyphicon glyphicon-list-alt"></span>预约</a></li>
                <li><a href="${website}reservation/statistic"><span class="glyphicon glyphicon-list-alt"></span>预约信息统计</a></li>
                <li><a href="${website}admin/login"><span class="glyphicon glyphicon-list-alt"></span>我是管理员</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li>
                    <c:choose>
                        <c:when test="${sessionScope.username == null}">
                            <a href="#" data-toggle="modal" data-target="#login"><span class="glyphicon glyphicon-user"></span></a>
                        </c:when>
                        <c:otherwise>
                        <div class="dropdown">
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                欢迎您，<%=session.getAttribute("username")%>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <li><a href="${website}myInfo" data-target="#myInfo">个人信息</a></li>
                                <li><a href="#" onclick="logout()">退出登陆</a></li>
                            </ul>
                        </div>
                        </c:otherwise>
                    </c:choose>

                </li>
            </ul>
        </div>
    </div>
</nav>
<!-- 登录 -->
<div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="modal-label"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">登录</h4>
            </div>
            <div class="modal-body">
                <!-- Login Form -->
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="username" class="col-sm-2 control-label">用户名:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="username" placeholder="Username">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">密 &nbsp;&nbsp;&nbsp;码:</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="password" placeholder="Password">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button class="btn btn-primary" data-dismiss="modal" onclick="login()">登录</button>
                            <button class="btn btn-primary" data-dismiss="modal" type="reset">重置</button>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <a href="${website}register">没有账户？去注册。</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function login() {
      let username = $('#username').val();
      let password = $('#password').val();
      $.ajax({
        type: 'post',
        url: "${website}user/login",
        dataType: "text",
        data:{
          username: username,
          password: password
        },
        success: function (msg) {
          msg = JSON.parse(msg);
          if (msg.code == 201) {
            console.log("login success");
            alert('登陆成功');
            window.location.reload();
          } else {
            alert(msg.message);
          }
        },
        error: function (msg) {
          alert("error!");
        },
      });
    }
    function logout() {
        $.ajax({
            type: 'post',
            url: "${website}user/logout",
            dataType: "text",
            data:{
            },
            success: function (msg) {
                msg = JSON.parse(msg);
                if (msg.code == 201) {
                    console.log("logout success");
                    alert("退出登陆成功");
                    window.location = "${website}";
                } else {
                    alert("退出登陆失败");
                }
            },
            error: function (msg) {
                alert("error!");
            },
        });
    }
</script>