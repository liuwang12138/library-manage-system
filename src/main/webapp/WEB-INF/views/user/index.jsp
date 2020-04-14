<%@ page import="com.godric.lms.common.po.UserPO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <jsp:include page="../common/user_header.jsp" />
  </head>
  <body>
  <%
    if (request.getAttribute("indexInfo") != null) {
  %>
  <script>
    alert("${indexInfo}");
  </script>
  <%
  }
  %>
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
      <h1>欢迎使用图书馆管理系统！</h1>
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
    <jsp:include page="../common/user_footer.jsp" />
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
  </body>
</html>