<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#"><img src="${staticWebsite}img/logo.png" width="120px" alt="bootstrap"></a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active">
                    <a href="${website}index"><span class="glyphicon glyphicon-home"></span>首页</a>
                </li>
                <li><a href="${website}/notice?pageNum=1&pageSize=5"><span class="glyphicon glyphicon-list-alt"></span>公告</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-send"></span>特点 <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">小兔子</a></li>
                        <li><a href="#">小猫咪</a></li>
                        <li><a href="#">躲起来</a></li>
                        <li><a href="#">美女</a></li>
                    </ul>
                </li>
                <li><a href="#" data-toggle="modal" data-target="#about"><span class="glyphicon glyphicon-bell"></span>关于</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li><a href="#"><span class="glyphicon glyphicon-shopping-cart"></span></a></li>
                <li>
                    <c:choose>
                        <c:when test="${sessionScope.username == null}">
                            <a href="#" data-toggle="modal" data-target="#login"><span class="glyphicon glyphicon-user"></span></a>
                            <a href="#" data-toggle="modal" data-target="#register"><span class="glyphicon glyphicon-user">register</span></a>
                        </c:when>
                        <c:otherwise>
                        <div class="dropdown">
                            <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                欢迎您，<%=session.getAttribute("username")%>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                                <li><a href="#" onclick="logout()">logout</a></li>
                                <li><a href="#" data-target="#myInfo">个人信息</a></li>
                            </ul>
                        </div>
                        </c:otherwise>
                    </c:choose>

                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>