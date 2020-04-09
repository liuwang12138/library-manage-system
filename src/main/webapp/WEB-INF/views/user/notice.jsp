<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://sargue.net/jsptags/time" prefix="javatime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <jsp:include page="../common/user_header.jsp" />
  </head>
  <body>
    <!--导航栏-->
    <jsp:include page="../common/user_navigator.jsp" />
    <br><br><br>

    <table class="table">
      <thead>
      <tr>
        <th scope="col">#</th>
        <th scope="col">title</th>
        <th scope="col">content</th>
        <th scope="col">create time</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach items="${noticeList.records}" var="notice" varStatus="noticeStatus">
      <tr>
        <th scope="row">${noticeStatus.count}</th>
        <td>${notice.title}</td>
        <td>${notice.content}</td>
        <td><javatime:format value="${notice.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
      </tr>
      </c:forEach>
      </tbody>
    </table>

      </tr>
    </table>

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
  </body>
</html>