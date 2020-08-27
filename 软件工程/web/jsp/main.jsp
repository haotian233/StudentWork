<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page language="java" import="com.itcast.entity.User" %>
<!-- 引入el标识所需要的标签 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";

    User user = (User) session.getAttribute("user");// 取登录用户信息

    String userStatus = "";
    if (user != null) {
        userStatus = user.getStatus();
    }

%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="js/layui/css/layui.css">
    <link rel="stylesheet" href="css/main.css">
    <title>这里是SWCTOOLS工具!!</title>
</head>
<body class="layui-layout-body">
<%
    if (user != null) {
%>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header custom-header">

        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="userInfo"
                                          target="rightframe">个人信息修改</a>
            </li>
        </ul>

        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item"><a href="javascript:;">欢迎您&nbsp;&nbsp;<%=userStatus%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img
                    src="img/face.jpg"
                    style="width:35px;height:35px;"
                    class="layui-nav-img">&nbsp;${sessionScope.user.name}</a>
            </li>
            <li class="layui-nav-item"><a href="outLogin">退出</a></li>
        </ul>
    </div>

    <div class="layui-side custom-admin">
        <div class="layui-side-scroll">

            <div class="custom-logo">
                <img src="img/logo.png" alt=""/>
                <h1>来快乐的学习吧</h1>
            </div>
            <ul id="Nav" class="layui-nav layui-nav-tree">
                <%
                    if (userStatus.equals("教师")) {
                %>
                <li class="layui-nav-item layui-nav-itemed" id="li1"><a
                        href="javascript:;" onclick="setStatus('li1');"> <i
                        class="layui-icon">&#xe609;</i> <em>我要留作业了!</em> </a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="add_task" target="rightframe">任务管理</a>
                        </dd>
                        <dd>
                            <a href="query_work" target="rightframe">作业查询</a>
                        </dd>
                    </dl>
                </li>
                <%
                } else {
                %>
                <li class="layui-nav-item layui-nav-itemed" id="li1"><a
                        href="javascript:;" onclick="setStatus('li1');"> <i
                        class="layui-icon">&#xe609;</i> <em>我要写作业了!</em> </a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="query_task" target="rightframe">任务查询</a>
                        </dd>
                    </dl>
                </li>
                <%
                    }
                %>
            </ul>

        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <iframe name="rightframe" src=""
                style="padding: 15px;width: 100%;height: 100%;scrolling=auto;">

        </iframe>

    </div>

    <div class="layui-footer">
        <p>
            © 2020 12349089<a href="http://www.mycodes.net/" target="_blank"></a>
        </p>
    </div>

    <div class="mobile-mask"></div>
</div>
<script src="js/layui/layui.js"></script>
<script src="js/jquery1.10.2.min.js"></script>
<script>
    function setStatus(id) {
        var classVal = $('#' + id).attr('class');
        if (classVal === 'layui-nav-item') {
            $('#' + id).attr("class", "layui-nav-item layui-nav-itemed");// 展开
        } else {
            $('#' + id).attr("class", "layui-nav-item");// 收缩
        }
    }

    layui.use(['layer', 'laydate', 'form'], function () {

    });
</script>
<%
} else {
%>
<script>
    window.location.href = "login";
</script>
<%
    }
%>
</body>
</html>