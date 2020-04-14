<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="../common/user_header.jsp" />
    <link rel="stylesheet" href="${staticWebsite}css/table.css">
</head>
<body>
<%
    if (request.getAttribute("reserveInfo") != null) {
%>
<script>
    alert("${reserveInfo}");
</script>
<%
    }
%>
<jsp:include page="../common/user_navigator.jsp" />

<div class="container">

    <!-- 查询条件 -->
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
            <div class="form-group col-md-4">
                <label for="date">日期：</label>
                <input type="date" class="form-control" id="date">
            </div>
            <div class="form-group col-md-4">
                <label for="timeQuantum">时间段：</label>
                <select id="timeQuantum" class="form-control">
                    <option value="1" selected>8:00-12:00</option>
                    <option value="2">12:00-17:00</option>
                    <option value="3">17:00-22:00</option>
                </select>
            </div>
            <div class="form-group col-md-4">
                <button class="btn btn-primary" onclick="selectSeat()">查询</button>
                <button class="btn btn-primary" type="reset">重置</button>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>

    <!-- 查询结果 -->
    <h3>查询结果</h3>
    <table id="table"></table>
    <div class="page" id="page"></div>

</div>
<jsp:include page="../common/user_footer.jsp" />
<script src="${staticWebsite}js/table.js"></script>
<script>
    $(document).ready(function () {
        let time = new Date();
        let day = ("0" + time.getDate()).slice(-2);
        let month = ("0" + (time.getMonth() + 1)).slice(-2);
        let today = time.getFullYear() + "-" + (month) + "-" + (day);
        $('#date').val(today);
    })
</script>
<script>
    selectSeat();
    <%--let storey = $('#storey').val();--%>
    <%--let roomNum = $('#roomNum').val();--%>
    <%--let seatNum = $('#seatNum').val();--%>
    <%--let date = $('#date').val();--%>
    <%--let timeQuantum = $('#timeQuantum').val();--%>
    <%--new Table({--%>
    <%--    el: "#table", //装载Table的容器的id--%>
    <%--    ajaxData: { //ajax请求的参数--%>
    <%--        url: '${website}seat/listByCondition',--%>
    <%--        method: 'post',--%>
    <%--        queryParams: { //提交给后端的数据--%>
    <%--            pageNum: 1, //当前页--%>
    <%--            pageSize: 10, //每一页显示的内容条数--%>
    <%--            storey: storey,--%>
    <%--            roomNum: roomNum,--%>
    <%--            seatNum: seatNum,--%>
    <%--            date: date,--%>
    <%--            timeQuantum: timeQuantum--%>
    <%--        }--%>
    <%--    },--%>
    <%--    stripe: true,//表格是否条纹状样式--%>
    <%--    pagination: true,//表格是否分页--%>
    <%--    paginOpt: {//分页参数--%>
    <%--        id: 'page',//装载分页的容器的id--%>
    <%--        curPage: 1, //当前页--%>
    <%--        pagelistcount: 10,//每一页显示的内容条数--%>
    <%--        maxshowpageitem: 5,//最多显示的页码个数--%>
    <%--    },--%>
    <%--    sort:[0, 2],//静态排序的列--%>
    <%--    col: [//表的列，name：表头名称，value：数据对应后端的字段，link：是否有链接--%>
    <%--        { name: '楼层', value: 'storey' },--%>
    <%--        { name: '房间号', value: 'roomNum' },--%>
    <%--        { name: '座位号', value: 'seatNum' },--%>
    <%--        { name: '预约日期', value: 'date'},--%>
    <%--        { name: '时间段', value: 'timeQuantum'},--%>
    <%--        { name: '操作', value: 'opt' }--%>
    <%--    ]--%>
    <%--});--%>


    function selectSeat() {

        console.log('aaaaaaaaaaaaaaaaa')
        let storey = $('#storey').val();
        let roomNum = $('#roomNum').val();
        let seatNum = $('#seatNum').val();
        let date = $('#date').val();
        let timeQuantum = $('#timeQuantum').val();

        new Table({
            el: "#table", //装载Table的容器的id
            ajaxData: { //ajax请求的参数
                url: '${website}seat/listByCondition',
                method: 'post',
                queryParams: { //提交给后端的数据
                    pageNum: 1, //当前页
                    pageSize: 10, //每一页显示的内容条数
                    storey: storey,
                    roomNum: roomNum,
                    seatNum: seatNum,
                    date: date,
                    timeQuantum: timeQuantum
                }
            },
            stripe: true,//表格是否条纹状样式
            pagination: true,//表格是否分页
            paginOpt: {//分页参数
                id: 'page',//装载分页的容器的id
                curPage: 1, //当前页
                pagelistcount: 10,//每一页显示的内容条数
                maxshowpageitem: 5,//最多显示的页码个数
            },
            sort:[0, 2],//静态排序的列
            col: [//表的列，name：表头名称，value：数据对应后端的字段，link：是否有链接
                { name: '楼层', value: 'storey' },
                { name: '房间号', value: 'roomNum' },
                { name: '座位号', value: 'seatNum' },
                { name: '预约日期', value: 'date'},
                { name: '时间段', value: 'timeQuantum'},
                { name: '操作', value: 'opt' }
            ]
        });
    }
</script>
</body>
</html>
