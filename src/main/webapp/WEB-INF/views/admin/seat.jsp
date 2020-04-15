<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>座位管理</title>
	<link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/bootstrap-3.3.4.css">
	<link rel="stylesheet" href="${staticWebsite}css/style.css">
    <link rel="stylesheet" href="${staticWebsite}css/table.css">
</head>
<body>
<%
    if (request.getAttribute("seatOptInfo") != null) {
%>
<script>
    alert("${seatOptInfo}");
</script>
<%
    }
%>

    <h1>新增座位</h1>
    <jsp:include page="../common/admin_navigator.jsp" />
    <!-- 新增座位 -->
    <div class="query-condition form-inline">
        <div class="tab-row query-row">
            <div class="form-group col-md-4 ">
                <label for="storey">楼层：</label>
                <input type="text" class="form-control" id="storey" aria-describedby="emailHelp">
            </div>
            <div class="form-group col-md-4">
                <label for="roomNum">房间号：</label>
                <input type="text" class="form-control" id="roomNum" aria-describedby="emailHelp">
            </div>
            <div class="form-group col-md-4">
                <label for="seatNum">座位号：</label>
                <input type="text" class="form-control" id="seatNum" aria-describedby="emailHelp">
            </div>
            <div class="clearfix"></div>
        </div>
        <div class="tab-row query-row">
            <div class="form-group col-md-4 ">
            </div>
            <div class="form-group col-md-4">
            </div>
            <div class="form-group col-md-4">
                <button class="btn btn-primary" onclick="insertSeat()">新增</button>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
    <hr>
    <h1>查询座位</h1>
    <!-- 查询条件 -->
    <div class="query-condition form-inline">
        <div class="tab-row query-row">
            <div class="form-group col-md-4 ">
                <label for="storey">楼层：</label>
                <input type="text" class="form-control" id="selectStorey" aria-describedby="emailHelp">
            </div>
            <div class="form-group col-md-4">
                <label for="roomNum">房间号：</label>
                <input type="text" class="form-control" id="selectRoomNum" aria-describedby="emailHelp">
            </div>
            <div class="form-group col-md-4">
                <label for="seatNum">座位号：</label>
                <input type="text" class="form-control" id="selectSeatNum" aria-describedby="emailHelp">
            </div>
            <div class="clearfix"></div>
        </div>
        <div class="tab-row query-row">
            <div class="form-group col-md-4">
            </div>
            <div class="form-group col-md-4">
            </div>
            <div class="form-group col-md-4">
                <button class="btn btn-primary" onclick="adminSelectSeat()">查询</button>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
	<div id="wrapper">
        <div class="overlay"></div>
        <div id="page-content-wrapper">
            <div class="container">
                <h1>座位列表</h1>
                <table id="table"></table>
                <div class="page" id="page"></div>
            </div>
        </div>
    </div>

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
        adminSelectSeat();
        function adminSelectSeat() {
            let selectStorey = $('#selectStorey').val();
            let selectRoomNum = $('#selectRoomNum').val();
            let selectSeatNum = $('#selectSeatNum').val();

            new Table({
                el: "#table", //装载Table的容器的id
                ajaxData: { //ajax请求的参数
                    url: '${website}admin/listSeatInfoByCondition',
                    method: 'post',
                    queryParams: { //提交给后端的数据
                        pageNum: 1, //当前页
                        pageSize: 10, //每一页显示的内容条数
                        storey: selectStorey,
                        roomNum: selectRoomNum,
                        seatNum: selectSeatNum
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
                    { name: '楼层', value: 'storey'},
                    { name: '房间号', value: 'roomNum' },
                    { name: '座位号', value: 'seatNum' },
                    { name: '创建时间', value: 'createTime'},
                    { name: '操作', value: 'opt'}
                ]
            });
        }
	</script>
<script>
    function insertSeat() {
        let storey = $('#storey').val();
        let roomNum = $('#roomNum').val();
        let seatNum = $('#seatNum').val();
        $.ajax({
            type: 'post',
            url: "${website}admin/insertSeat",
            dataType: "text",
            data:{
                storey: storey,
                roomNum: roomNum,
                seatNum: seatNum
            },
            success: function (msg) {
                console.log(msg);
                msg = JSON.parse(msg);
                if (msg.code == 201) {
                    alert(msg.message);
                    window.location = "${website}admin/seat"
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
</body>
</html>