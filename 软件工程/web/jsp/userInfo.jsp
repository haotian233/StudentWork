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
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>个人信息修改</title>
    <link rel="stylesheet" href="js/layui/css/layui.css" media="all">
    <script src="js/jquery1.10.2.min.js"></script>
<body>
<%
    if (user != null) {
        String status = user.getStatus();
%>
<div
        style="position:absolute;width:100%;left:50%;margin-left:-250px;margin-top:100px;">
    <input type="hidden" value="${sessionScope.user.id}" name="user_id"
           id="user_id"/>
    <div class="layui-form-item">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-inline" style="width:250px;">
            <input type="text" name="username" id="username"
                   value="${sessionScope.user.username}"
                   lay-verify="required" placeholder="请输入用户名" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">密码</label>
        <div class="layui-input-inline" style="width:250px;">
            <input type="text" name="password" id="password"
                   value="${sessionScope.user.password}" lay-verify="required"
                   placeholder="请输入密码" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-inline" style="width:250px;">
            <input type="text" name="name" id="name"
                   value="${sessionScope.user.name}" lay-verify="required"
                   placeholder="请输入姓名" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">账号类型</label>
        <div class="layui-input-inline" style="width:250px;">
            <input type="text" name="type" id="type" value=""
                   lay-verify="required" placeholder="账号类型" autocomplete="off"
                   disabled="disabled" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" style="margin-top:30px;">
        <button type="button" class="layui-btn layui-btn-normal"
                onclick="qc();" style="margin-left:100px;">清空
        </button>
        <button type="button" class="layui-btn layui-btn-normal"
                onclick="edit();" style="margin-left:80px;">修改
        </button>
    </div>
</div>
<script src="js/layui/layui.js" charset="utf-8"></script>
<script>
    $.ajax({
        url: 'queryUserById', //换成自己的url
        type: 'POST',
        dataType: 'json',
        data: {
            'id': $('#user_id').val()
        },
        success: function (res) {
            if (res.msg == 0) {
                var data = res.data;
                $('#username').val(data.username);
                $('#password').val(data.password);
                $('#name').val(data.name);
                $('#type').val(data.status);
            }
        },
        error: function (e) {

        }
    });

    // 清除
    function qc() {
        $('#username').val('');
        $('#password').val('');
        $('#name').val('');
    }

    // 修改
    function edit() {
        var username = $.trim($('#username').val());
        if (!username) {
            layer.msg('请输入用户名', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var password = $.trim($('#password').val());
        if (!password) {
            layer.msg('请输入密码', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var name = $.trim($('#name').val());
        if (!name) {
            layer.msg('请输入姓名', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }

        $.ajax({
            url: 'editUser', //换成自己的url
            type: 'POST',
            dataType: 'json',
            data: {
                'id': $('#user_id').val(),
                'username': username,
                'password': password,
                'name': name
            },
            success: function (res) {
                if (res.msg == 0) {
                    layer.msg("修改个人信息成功", {
                        icon: 1,
                        time: 2000
                    }, function () {

                    });
                } else {
                    layer.msg("修改个人信息失败,请重新修改", {
                        icon: 2,
                        time: 2000
                    }, function () {

                    });
                }
            },
            error: function (e) {
                layer.msg("修改个人信息失败,请重新修改", {
                    icon: 2,
                    time: 2000
                }, function () {

                });
            }
        });
    }

    layui.use(['layer', 'laydate', 'form', 'table'], function () {
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;

    });
</script>
<%
} else {
%>
<script>
    window.location.href = 'login';
</script>
</body>
<%
    }
%>
</html>