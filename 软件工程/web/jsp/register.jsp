<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page language="java" import="com.itcast.entity.User" %>
<!-- 引入el标识所需要的标签 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>注册</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/registerCss.css">
    <link rel="stylesheet" href="js/layui/css/layui.css" media="all">
    <script src="js/layui/layui.js" charset="utf-8"></script>
    <script src="js/jquery1.10.2.min.js"></script>
    <style>
        .layui-form {
            padding-top: 20px !important;
            width: 90% !important;
        }
    </style>
</head>
<body class="childrenBody">
<div>
    <form class="layui-form">
        <div class="layui-form-item layui-row layui-col-xs4"
             style="left:35%;margin-top:5%;">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="number" class="layui-input username"
                       lay-verify="required" placeholder="用户名为11位学号">
            </div>
        </div>
        <div class="layui-form-item layui-row layui-col-xs4"
             style="left:35%;">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input password"
                       lay-verify="required" placeholder="请输入密码">
            </div>
        </div>
        <div class="layui-form-item layui-row layui-col-xs4"
             style="left:35%;">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input name" lay-verify="required"
                       placeholder="请输入姓名">
            </div>
        </div>
        <div class="layui-form-item" style="margin-top:23%;margin-left:38%;">
            <button type="button" class="layui-btn layui-btn-normal"
                    onclick="addUser();" style="margin-left:130px;">提交
            </button>
            <button type="button" class="layui-btn layui-btn-normal"
                    onclick="qc_add();" style="margin-left:20px;">重置
            </button>
        </div>
    </form>
</div>
<script>
    layui.use(['table', 'upload', 'form'], function () {
        var form = layui.form;
        var upload = layui.upload;

    });

    function qc_add() {
        $('.username').val('');
        $('.password').val('');
        $('.name').val('');
    }

    function addUser() {
        var username = $.trim($('.username').val());
        if (!username || username.length != 11) {
            layer.msg('请输入11位学号', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var password = $.trim($('.password').val());
        if (!password) {
            layer.msg('请输入密码', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var name = $.trim($('.name').val());
        if (!name) {
            layer.msg('请输入姓名', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        $.ajax({
            url: 'registerCon',
            type: 'POST',
            dataType: 'json',
            data: {
                'username': username,
                'password': password,
                'name': name,
                'status': '学生'
            },
            success: function (res) {
                if (res.msg == 0) {
                    layer.msg("用户注册成功", {
                        icon: 1,
                        time: 1000
                    }, function () {
                        window.location.href = "login";
                    });
                } else if (res.msg == 1) {
                    layer.msg("注册失败,该用户名已经被注册", {
                        icon: 2,
                        time: 1000
                    }, function () {

                    });
                } else {
                    layer.msg("用户注册失败,请重新注册", {
                        icon: 2,
                        time: 1000
                    }, function () {

                    });
                }
            },
            error: function (e) {
                layer.msg("用户注册失败,请重新注册", {
                    icon: 2,
                    time: 1000
                }, function () {

                });
            }
        });
    }
</script>
</body>
</html>
