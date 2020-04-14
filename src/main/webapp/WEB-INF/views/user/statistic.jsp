<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://sargue.net/jsptags/time" prefix="javatime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <jsp:include page="../common/user_header.jsp" />
    <link rel="stylesheet" href="${staticWebsite}css/table.css">
  </head>
  <body>
    <!--导航栏-->
    <jsp:include page="../common/user_navigator.jsp" />
    <div class="container">
        <h1>数据统计列表</h1>
        <table id="table"></table>
        <div class="page" id="page"></div>
    </div>

    <jsp:include page="../common/user_footer.jsp" />
    <script src="${staticWebsite}js/table.js"></script>
    <script>
      new Table({
        el: "#table", //装载Table的容器的id
        ajaxData: { //ajax请求的参数
          url: '${website}reservation/countReservationByDate',
          method: 'post',
          queryParams: { //提交给后端的数据
            pageNum: 1, //当前页
            pageSize: 10, //每一页显示的内容条数
            startDate: '2020-04-13',
            endDate: '2020-04-14'
          }
        },
        stripe: true,//表格是否条纹状样式
        pagination: true,//表格是否分页
        paginOpt: {//分页参数
          id: 'page',//装载分页的容器的id
          curPage: 1, //当前页
          pagelistcount: 10,//每一页显示的内容条数
          maxshowpageitem: 3,//最多显示的页码个数
        },
        sort:[0, 2],//静态排序的列
        col: [//表的列，name：表头名称，value：数据对应后端的字段，link：是否有链接
          { name: '日期', value: 'date'},
          { name: '8:00-12:00预约数', value: 'amNum' },
          { name: '12:00-17:00预约数', value: 'pmNum' },
          { name: '17:00-22:00预约数', value: 'nightNum' }
        ]
      });
    </script>
  </body>
</html>