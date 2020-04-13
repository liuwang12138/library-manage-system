<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Sidebar -->
<nav class="navbar navbar-inverse navbar-fixed-top" id="sidebar-wrapper" role="navigation">
    <ul class="nav sidebar-nav">
        <li class="sidebar-brand">
            <a href="#">
               欢迎您，<br><%=session.getAttribute("username")%>
            </a>
        </li>
        <c:if test="${sessionScope.user == 'admin'}">
        <li>
            <a href="${website}admin/user"><i class="fa fa-fw fa-home"></i>账户管理</a>
        </li>
        </c:if>
        <li>
            <a href="${website}admin/signApprove"><i class="fa fa-fw fa-folder"></i>签到审核</a>
        </li>
        <li>
            <a href="#"><i class="fa fa-fw fa-file-o"></i>座位管理</a>
        </li>
        <li>
            <a href="${website}admin/notice"><i class="fa fa-fw fa-cog"></i>公告管理</a>
        </li>
        <li>
            <a href="${website}admin/blacklist"><i class="fa fa-fw fa-cog"></i>查看黑名单</a>
        </li>
<%--        <li class="dropdown">--%>
<%--            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-fw fa-plus"></i> Dropdown <span class="caret"></span></a>--%>
<%--            <ul class="dropdown-menu" role="menu">--%>
<%--                <li class="dropdown-header">Dropdown heading</li>--%>
<%--                <li><a href="#">Action</a></li>--%>
<%--                <li><a href="#">Another action</a></li>--%>
<%--                <li><a href="#">Something else here</a></li>--%>
<%--                <li><a href="#">Separated link</a></li>--%>
<%--                <li><a href="#">One more separated link</a></li>--%>
<%--            </ul>--%>
<%--        </li>--%>
<%--        <li>--%>
<%--            <a href="#"><i class="fa fa-fw fa-bank"></i> Page four</a>--%>
<%--        </li>--%>
<%--        <li>--%>
<%--            <a href="#"><i class="fa fa-fw fa-dropbox"></i> Page 5</a>--%>
<%--        </li>--%>
<%--        <li>--%>
<%--            <a href="#"><i class="fa fa-fw fa-twitter"></i> Last page</a>--%>
<%--        </li>--%>
    </ul>
</nav>
