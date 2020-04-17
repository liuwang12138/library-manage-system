<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>黑名单管理</title>
	<link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/bootstrap-3.3.4.css">
	<link rel="stylesheet" href="${staticWebsite}css/style.css">
    <link rel="stylesheet" href="${staticWebsite}css/table.css">
</head>
<body>
<%
    if (request.getAttribute("blackOpt") != null) {
%>
<script>
    alert("${blackOpt}");
</script>
<%
    }
%>
	<div id="wrapper">
        <div class="overlay"></div>
        <jsp:include page="../common/admin_navigator.jsp" />
        <!-- Page Content -->
        <div id="page-content-wrapper">
          <button type="button" class="hamburger is-closed animated fadeInLeft" data-toggle="offcanvas">
            <span class="hamb-top"></span>
            <span class="hamb-middle"></span>
            <span class="hamb-bottom"></span>
          </button>
            <div class="container">
                <h1>黑名单列表</h1>
                <table id="table"></table>
                <div class="page" id="page"></div>
            </div>
        </div>
        <!-- /#page-content-wrapper -->

    </div>
    <!-- /#wrapper -->
	
	<script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
	<script src="http://www.jq22.com/jquery/bootstrap-3.3.4.js"></script>
    <script src="${staticWebsite}js/table.js"></script>
	<script type="text/javascript">
		$(document).ready(function () {
		  var trigger = $('.hamburger'),
		      overlay = $('.overlay'),
		     isClosed = false;

		    trigger.click(function () {
		      hamburger_cross();      
		    });

		    function hamburger_cross() {

		      if (isClosed == true) {          
		        overlay.hide();
		        trigger.removeClass('is-open');
		        trigger.addClass('is-closed');
		        isClosed = false;
		      } else {   
		        overlay.show();
		        trigger.removeClass('is-closed');
		        trigger.addClass('is-open');
		        isClosed = true;
		      }
		  }
		  
		  $('[data-toggle="offcanvas"]').click(function () {
		        $('#wrapper').toggleClass('toggled');
		  });  
		});
    </script>
    <script>
        new Table({
            el: "#table", //装载Table的容器的id
            ajaxData: { //ajax请求的参数
                url: '${website}admin/listBlack',
                method: 'post',
                queryParams: { //提交给后端的数据
                    pageNum: 1, //当前页
                    pageSize: 10 //每一页显示的内容条数
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
                { name: '用户名', value: 'username'},
                { name: '截止时间', value: 'deadline'},
                { name: '创建时间', value: 'createTime'},
                { name: '操作', value: 'opt'}
            ]
        });
	</script>
</body>
</html>