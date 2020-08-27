<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <title>登录</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/js/layui/css/layui.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/loginCss.css">
    <script src="${pageContext.request.contextPath}/js/layui/layui.all.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery1.10.2.min.js"></script>
    <style type="text/css">
        .formdiv {
            padding: 120px 500px;
        }

        /*解决Chrome下表单自动填充后背景色为黄色*/
        input:-webkit-autofill {
            -webkit-box-shadow: 0 0 0px 1000px white inset;
        }
    </style>
</head>
<body>
<div class="formdiv">
    <form id="contact" action="<%=basePath%>loginCon" method="post">
        <h3>这里是SWCTOOLS哦\(°-°)/</h3>
        <h4 style="color:red;">${msg}</h4>
        <fieldset>
            <input placeholder="请输入用户名" type="text" name="userName"
                   id="userName" tabindex="1" required autofocus>
        </fieldset>
        <fieldset>
            <input placeholder="请输入密码" type="password" name="userPwd"
                   id="userPwd" tabindex="2" required>
        </fieldset>
        <fieldset>
            <input name="sub" type="button" id="contact-submit" value="登录"/> <input
                name="sub" type="button" id="contact-register" value="注册"/>
        </fieldset>
    </form>
    <script>
        $(function () {
            $("#contact-register").click(function () {
                window.location.href = "register";
            });
            $("#contact-submit").click(function () {
                var userName = $('#userName').val();
                var userPwd = $('#userPwd').val();

                if (!$.trim(userName)) { //用户框value值为空

                    layer.msg("用户名不能为空", {
                        icon: 2,
                        time: 1000
                    }, function () {

                    });
                    return;
                }
                if (!$.trim(userPwd)) { //密码框value值为空

                    layer.msg("密码不能为空", {
                        icon: 2,
                        time: 1000
                    }, function () {

                    });
                    return;
                }
                $.ajax({
                    url: 'loginCon', //换成自己的url
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        'username': userName,
                        'password': userPwd
                    },
                    success: function (res) {
                        if (res.msg == 0) {
                            window.location.href = "main";
                        } else if (res.msg == 1) {
                            window.location.href = "home";
                        } else {
                            layer.msg("登录失败,用户名,密码 或 错误", {
                                icon: 2,
                                time: 2000
                            }, function () {

                            });
                        }
                    },
                    error: function (e) {
                        layer.msg("登录失败,用户名 或 密码 错误", {
                            icon: 2,
                            time: 2000
                        }, function () {

                        });
                    }
                });
            });
        });
    </script>
</div>
</body>
</html>
