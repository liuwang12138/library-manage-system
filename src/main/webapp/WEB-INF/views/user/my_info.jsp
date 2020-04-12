<%@ page import="com.godric.lms.common.po.UserPO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="../common/user_header.jsp" />
    <link rel="stylesheet" href="${staticWebsite}css/table.css">
</head>
<body>
<jsp:include page="../common/user_navigator.jsp" />
<div class="container">
    <h3>个人资料</h3>
    <ul>
        <li class="common">用户名：<%=((UserPO)session.getAttribute("user")).getUsername()%></li>
        <li class="common">真实姓名：<%=((UserPO)session.getAttribute("user")).getRealName()%></li>
        <li class="common">手机号：<%=((UserPO)session.getAttribute("user")).getPhone()%></li>
    </ul>
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#updatePassword">
        修改密码
    </button>

    <!-- 我的预约记录 -->
    <h3>我的预约记录</h3>
    <table id="table"></table>
    <div class="page" id="page"></div>
</div>
<div class="modal fade" id="updatePassword" tabindex="-1" role="dialog" aria-labelledby="modal-label" aria-hidden="true">
    <div class="modal-dialog" role="document">
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
                        <label for="newPassword" class="col-sm-2 control-label">新密码:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="newPassword" placeholder="新密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword" class="col-sm-2 control-label">确认密码:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="confirmPassword" placeholder="确认密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button class="btn btn-primary" data-dismiss="modal" onclick="updatePassword()">提交</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/user_footer.jsp" />
<script>
    function updatePassword() {
        console.log(1);
        let originPassword = $('#originPassword').val();
        let newPassword = $('#newPassword').val();
        let confirmPassword = $('#confirmPassword').val();

        if (newPassword != confirmPassword) {
            alert("两次输入密码不一致，请检查后重试");
        }
        $.ajax({
            type: 'post',
            url: "${website}user/updatePassword",
            dataType: "text",
            data:{
                oldPassword: originPassword,
                newPassword: newPassword
            },
            success: function (msg) {
                msg = JSON.parse(msg);
                if (msg.code == 201) {
                    console.log("修改密码成功");
                    alert("修改密码成功！");
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

<!-- 预约记录 list -->
<script src="${staticWebsite}js/table.js"></script>
<script>
    new Table({
        el: "#table", //装载Table的容器的id
        ajaxData: { //ajax请求的参数
            url: '${website}reservation/getMyReservationInfo',
            method: 'post',
            queryParams: { //提交给后端的数据
                pageNum: 1, //当前页
                pageSize: 6 //每一页显示的内容条数
            }
        },
        stripe: true,//表格是否条纹状样式
        pagination: true,//表格是否分页
        paginOpt: {//分页参数
            id: 'page',//装载分页的容器的id
            curPage: 1, //当前页
            pagelistcount: 6,//每一页显示的内容条数
            maxshowpageitem: 3,//最多显示的页码个数
        },
        sort:[0, 2],//静态排序的列
        col: [//表的列，name：表头名称，value：数据对应后端的字段，link：是否有链接
            { name: '用户名', value: 'username'},
            { name: '楼层', value: 'storey' },
            { name: '房间号', value: 'roomNum' },
            { name: '座位号', value: 'seatNum' },
            { name: '预约日期', value: 'reservationDate' },
            { name: '时间段', value: 'timeQuantum' },
            { name: '操作', value: 'opt' },
        ]
    });
</script>

</body>
</html>
