<%@ page import="com.godric.lms.common.po.UserPO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="../common/user_header.jsp" />
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
</body>
</html>
