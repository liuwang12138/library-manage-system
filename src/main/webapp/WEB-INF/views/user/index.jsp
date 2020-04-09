<%@ page import="com.godric.lms.common.po.UserPO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <jsp:include page="../common/user_header.jsp" />
  </head>
  <body>
    <!--导航栏-->
    <jsp:include page="../common/user_navigator.jsp" />
    <!--图片轮播-->
    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
        <li data-target="#carousel-example-generic" data-slide-to="2"></li>
        <li data-target="#carousel-example-generic" data-slide-to="3"></li>
      </ol>
      <div class="carousel-inner" role="listbox">
        <div class="item active">
          <img src="${staticWebsite}img/tu1.jpg" alt="...">
          <div class="carousel-caption">
            <div class="welcome">
              <h2><strong>BIG</strong> Welcome Message</h2>
              <p>Ingenious marketing copy.And some <em>more</em> ingenious marketing copy.</p>
              <a href="" class="btn btn-lg btn-primary pull-right">Learn more</a>
            </div>
          </div>
        </div>
        <div class="item">
          <img src="${staticWebsite}img/tu2.jpg" alt="...">
          <div class="carousel-caption">
          </div>
        </div>
        <div class="item">
          <img src="${staticWebsite}img/tu3.jpg" alt="...">
          <div class="carousel-caption">
          </div>
        </div>
        <div class="item">
          <img src="${staticWebsite}img/tu4.jpg" alt="...">
          <div class="carousel-caption">
          </div>
        </div>
      </div>
      <!-- Controls -->
      <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">上一页</span>
      </a>
      <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">下一页</span>
      </a>
    </div>
    <!--内容-->
    <div class="container sda">
      <div class="row">
        <div class="col-md-4">
          <h2 class="text-center">Welcome!</h2>
          <p>Suspendisse et arcu felis, ac gravida turpis. Suspendisse potenti. Ut porta rhoncus ligula, sed fringilla felis feugiat eget. In non purus quis elit iaculis tincidunt. Donec at ultrices est.</p>
          <p><a class="btn btn-primary pull-right" href="#">See our portfolio <span class="glyphicon glyphicon-circle-arrow-right"></span></a></p>
        </div>
        <div class="col-md-4">
          <h2 class="text-center">Welcome!</h2>
          <p>Suspendisse et arcu felis, ac gravida turpis. Suspendisse potenti. Ut porta rhoncus ligula, sed fringilla felis feugiat eget. In non purus quis elit iaculis tincidunt. Donec at ultrices est.</p>
          <p><a class="btn btn-primary pull-right" href="#">See our portfolio <span class="glyphicon glyphicon-circle-arrow-right"></span></a></p>
        </div>
        <div class="col-md-4">
          <h2 class="text-center">Welcome!</h2>
          <p>Suspendisse et arcu felis, ac gravida turpis. Suspendisse potenti. Ut porta rhoncus ligula, sed fringilla felis feugiat eget. In non purus quis elit iaculis tincidunt. Donec at ultrices est.</p>
          <p><a class="btn btn-primary pull-right" href="#">See our portfolio <span class="glyphicon glyphicon-circle-arrow-right"></span></a></p>
        </div>
      </div>
      <hr>
      <!--标签页-->
      <ul class="nav nav-tabs" role="tablist">
        <li class="active"><a href="#tab-rabit" role="tab" data-toggle="tab">小兔子</a></li>
        <li><a href="#tab-cat" role="tab" data-toggle="tab">小猫咪</a></li>
        <li><a href="#tab-sit" role="tab" data-toggle="tab">躲起来</a></li>
        <li><a href="#tab-beauty" role="tab" data-toggle="tab">美女</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="tab-rabit">
          <div class="row feature">
            <div class="col-md-7">
              <h1 class="feature-heading">小兔子</h1>
              <p class="lead">Suspendisse et arcu felis, ac gravida turpis. Suspendisse potenti. Ut porta rhoncus ligula, sed fringilla felis feugiat eget. In non purus quis elit iaculis tincidunt. Donec at ultrices est.</p>
            </div>
            <div class="col-md-5">
              <img src="${staticWebsite}img/tu5.jpg" class="feature-image img-responsive" alt="小兔子">
            </div>
          </div>
        </div>
        <div class="tab-pane" id="tab-cat">
          <div class="row feature">
            <div class="col-md-5">
              <img src="${staticWebsite}img/tu6.jpg" class="feature-image img-responsive" alt="小兔子">
            </div>
            <div class="col-md-7">
              <h1 class="feature-heading">小猫咪</h1>
              <p class="lead">Suspendisse et arcu felis, ac gravida turpis. Suspendisse potenti. Ut porta rhoncus ligula, sed fringilla felis feugiat eget. In non purus quis elit iaculis tincidunt. Donec at ultrices est.</p>
            </div>
          </div>
        </div>
        <div class="tab-pane" id="tab-sit">
          <div class="row feature">
            <div class="col-md-7">
              <h1 class="feature-heading">躲起来</h1>
              <p class="lead">Suspendisse et arcu felis, ac gravida turpis. Suspendisse potenti. Ut porta rhoncus ligula, sed fringilla felis feugiat eget. In non purus quis elit iaculis tincidunt. Donec at ultrices est.</p>
            </div>
            <div class="col-md-5">
              <img src="${staticWebsite}img/tu7.jpg" class="feature-image img-responsive" alt="小兔子">
            </div>
          </div>
        </div>
        <div class="tab-pane" id="tab-beauty">
          <div class="row feature">
            <div class="col-md-5">
              <img src="${staticWebsite}img/tu8.jpg" class="feature-image img-responsive" alt="小兔子">
            </div>
            <div class="col-md-7">
              <h1 class="feature-heading">美女</h1>
              <p class="lead">Suspendisse et arcu felis, ac gravida turpis. Suspendisse potenti. Ut porta rhoncus ligula, sed fringilla felis feugiat eget. In non purus quis elit iaculis tincidunt. Donec at ultrices est.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--底部-->
    <footer role="contentinfo">
      <p class="pull-right"><a href="index.jsp">回到顶部</a></p>
      <p><img src="${staticWebsite}img/logo.png" width="80" alt="Bootstrappin'">  2017/7/20</p>
    </footer>
    <!--弹出框-->
    <!-- 关于 -->
    <div class="modal fade" id="about" tabindex="-1" role="dialog" aria-labelledby="modal-label"
         aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title">关于</h4>
          </div>
          <div class="modal-body">
            <p>Suspendisse et arcu felis, ac gravida turpis. Suspendisse potenti. Ut porta rhoncus ligula, sed fringilla felis feugiat eget. In non purus quis elit iaculis tincidunt. Donec at ultrices est.</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">了解了</button>
          </div>
        </div>
      </div>
    </div>
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
            </form>
          </div>
        </div>
      </div>
    </div>
    <div class="modal fade" id="register" tabindex="-1" role="dialog" aria-labelledby="modal-label"
         aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title">注册</h4>
          </div>
          <div class="modal-body">
            <!-- Login Form -->
            <form class="form-horizontal">
              <div class="form-group">
                <label for="username" class="col-sm-2 control-label">用户名:</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="rUsername" placeholder="Username">
                </div>
              </div>
              <div class="form-group">
                <label for="password" class="col-sm-2 control-label">密 &nbsp;&nbsp;&nbsp;码:</label>
                <div class="col-sm-10">
                  <input type="password" class="form-control" id="rPassword" placeholder="Password">
                </div>
              </div>
              <div class="form-group">
                <label for="realName" class="col-sm-2 control-label">真实姓名:</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="realName" placeholder="RealName">
                </div>
              </div>
              <div class="form-group">
                <label for="phone" class="col-sm-2 control-label">手机号:</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="phone" placeholder="Phone">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button class="btn btn-primary" data-dismiss="modal" onclick="register()">注册</button>
                  <button class="btn btn-primary" data-dismiss="modal" type="reset">重置</button>
                </div>
              </div>
            </form>

          </div>
        </div>
      </div>
    </div>
    <div class="modal fade" id="myInfo" tabindex="-1" role="dialog" aria-labelledby="modal-label"
         aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title">个人信息</h4>
          </div>
          <div class="modal-body">
            <form class="form-horizontal">
              <div class="form-group">
                <label for="username" class="col-sm-2 control-label">用户名:</label>
                <div class="col-sm-10">
                  <label class="form-control"><%=((UserPO)session.getAttribute("user")).getUsername()%></label>
                </div>
              </div>
              <div class="form-group">
                <label for="password" class="col-sm-2 control-label">真实姓名:</label>
                <div class="col-sm-10">
                  <label class="form-control"><%=((UserPO)session.getAttribute("user")).getRealName()%></label>
                </div>
              </div>
              <div class="form-group">
                <label for="phone" class="col-sm-2 control-label">手机号:</label>
                <div class="col-sm-10">
                  <label class="form-control"><%=((UserPO)session.getAttribute("user")).getPhone()%></label>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button class="btn btn-primary" data-dismiss="modal" data-target="#updatePassword">修改密码</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <div class="modal fade" id="updatePassword" tabindex="-1" role="dialog" aria-labelledby="modal-label"
         aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title">修改密码</h4>
          </div>
          <div class="modal-body">
            <form class="form-horizontal">
              <div class="form-group">
                <label for="originPassword" class="col-sm-2 control-label">原密码:</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="originPassword" placeholder="原密码">
                </div>
              </div>
              <div class="form-group">
                <label for="password" class="col-sm-2 control-label">新密码:</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="newPassword" placeholder="新密码">
                </div>
              </div>
              <div class="form-group">
                <label for="password" class="col-sm-2 control-label">确认密码:</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="confirmPassword" placeholder="确认密码">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button class="btn btn-primary" data-dismiss="modal">提交</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <script src="${staticWebsite}js/jquery-1.11.1.min.js"></script>
    <script src="${staticWebsite}js/bootstrap.min.js"></script>
    <script>
    $(function () {
        $('#ad-carousel').carousel();
        $('#menu-nav .navbar-collapse a').click(function (e) {
            var href = $(this).attr('href');
            var tabId = $(this).attr('data-tab');
            if ('#' !== href) {
                e.preventDefault();
                $(document).scrollTop($(href).offset().top - 70);
                if (tabId) {
                    $('#feature-tab a[href=#' + tabId + ']').tab('show');
                }
            }
        });
    });
  </script>
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
    function register() {
      let username = $('#rUsername').val();
      let password = $('#rPassword').val();
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
            window.location.reload();
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
  </body>
</html>