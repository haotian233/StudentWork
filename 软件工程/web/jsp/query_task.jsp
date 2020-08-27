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
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="js/layui/css/layui.css">
    <link rel="stylesheet" href="css/view.css"/>

    <script src="js/layui/layui.js"></script>
    <script src="js/jquery1.10.2.min.js"></script>
    <title>任务查询</title>
</head>
<body class="layui-view-body">
<%
    if (user != null) {
%>

<div id="edit-work" style="display: none;">
    <form class="layui-form" id="edit-form" action="">
        <div class="layui-form-item center" style="margin-top: 30px;">
            <label class="layui-form-label" style="width: 100px">作业编号</label>
            <div class="layui-input-block">
                <input type="text" name="workNum_edit" id="workNum_edit" required
                       value="" style="width: 300px" lay-verify="required"
                       placeholder="作业编号不用填下,系统自动生成" disabled="disabled" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">作业名称</label>
            <div class="layui-input-block">
                <input type="text" name="workName_edit" id="workName_edit" required
                       value="" style="width: 300px" lay-verify="required"
                       placeholder="请输入作业名称" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">作业内容</label>
            <div class="layui-input-block" style="padding-bottom:10px;">
					<textarea placeholder="请输入作业内容" autocomplete="off"
                              id="workAnswer_edit" name="workAnswer_edit" type="text/plain"
                              style="width:300px;height:100px"></textarea>
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">提交时间</label>
            <div class="layui-input-block">
                <input type="text" name="upTime_edit" id="upTime_edit" required
                       value="" style="width: 300px" lay-verify="required"
                       placeholder="提交时间不用填写,系统自动记录" disabled="disabled" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">作业文件名称</label>
            <div class="layui-input-block">
                <input type="text" name="workFileName" id="workFileName" required
                       value="" style="width: 300px" lay-verify="required"
                       placeholder="作业文件名称不用填写" disabled="disabled" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">作业文件</label>
            <div class="layui-input-block">
                <input type="file" name="workFileName_edit" id="workFileName_edit"
                       value=""/>
            </div>
        </div>
        <div class="layui-input-block">
            <button type="button" id="workDownload" onclick="xzWork()"
                    class="layui-btn layui-btn-normal">点击下载
            </button>
        </div>
        <div class="layui-form-item" style="margin-top:30px;">
            <button type="button" class="layui-btn layui-btn-normal"
                    onclick="addWork();" style="margin-left:130px;">提交
            </button>
            <button type="button" class="layui-btn layui-btn-normal"
                    onclick="qc_edit();" style="margin-left:20px;">重置
            </button>
        </div>
    </form>
</div>

<div id="list-task" style="display: none;">
    <form class="layui-form" id="list-form" action="">
        <div class="layui-form-item center" style="margin-top: 30px;">
            <label class="layui-form-label" style="width: 100px">任务编号</label>
            <div class="layui-input-block">
                <input type="text" name="taskNum" id="taskNum" required value=""
                       style="width: 300px" lay-verify="required" placeholder="任务编号"
                       disabled="disabled" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">任务名称</label>
            <div class="layui-input-block">
                <input type="text" name="taskName" id="taskName" required value=""
                       style="width: 300px" lay-verify="required" placeholder="任务名称"
                       disabled="disabled" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">任务介绍</label>
            <div class="layui-input-block" style="padding-bottom:10px;">
					<textarea placeholder="任务介绍" autocomplete="off" id="taskDescribe"
                              name="taskDescribe" type="text/plain" disabled="disabled"
                              style="width:300px;height:100px"></textarea>
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">教师姓名</label>
            <div class="layui-input-block">
                <input type="text" name="teachName" id="teacherName" required
                       value="" style="width: 300px" lay-verify="required"
                       placeholder="teacherName" disabled="disabled" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">发布时间</label>
            <div class="layui-input-block">
                <input type="text" name="startTime" id="startTime" required
                       value="" style="width: 300px" lay-verify="required"
                       placeholder="发布时间" disabled="disabled" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" id="fileDiv">
            <label class="layui-form-label" style="width: 100px">任务附件</label> <input
                type="text" name="taskFileName" id="taskFileName" required value=""
                style="width: 300px" lay-verify="required" placeholder="任务附件"
                disabled="disabled" autocomplete="off" class="layui-input">
            <div class="layui-input-block">
                <button type="button" id="taskDownload" onclick="xzTask()"
                        class="layui-btn layui-btn-normal">点击下载
                </button>
            </div>
        </div>
    </form>
</div>
<input type="hidden" value="${sessionScope.user.id}" name="user_id"
       id="user_id"/>
<input type="hidden" value="" name="id" id="id"/>
<div class="layui-content">
    <div class="layui-page-header">
        <div class="pagewrap">
            <h2 class="title">任务查询</h2>
        </div>
    </div>
    <div class="layui-row">
        <div class="layui-card">
            <div class="layui-card-body">
                <div class="form-box">
                    <div class="layui-form layui-form-item">
                        <div class="layui-inline">
                            <div class="layui-form-mid">内容:</div>
                            <div class="layui-input-inline" style="width: 300px;">
                                <input type="text" name="searchName" id="searchName"
                                       autocomplete="off" class="layui-input">
                            </div>

                            <button class="layui-btn layui-btn-blue" onclick="query();">查询</button>
                            <button class="layui-btn layui-btn-blue" onclick="add();">
                                <i class="layui-icon">&#xe654;</i>新增
                            </button>
                        </div>
                    </div>

                    <table id="taskTab" lay-filter="taskTab"></table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn layui-btn-normal layui-icon" lay-event="look"
       style="margin-top: -5px;">&#xe65b;</a>
    <a class="layui-btn layui-btn layui-btn-warm layui-icon" lay-event="tj" style="margin-top: -5px;">&#xe642;</a>
</script>
<script>

    function xzWork() {
        var fileName = $("#workFileName").val();
        if (!fileName) {
            layer.msg("你还未提交作业文件", {
                icon: 2,
                time: 2000
            }, function () {
            });
            return;
        }

        $.ajax({
            url: 'workDownLoad', //换成自己的url
            type: 'POST',
            responseType: 'blob',
            data: {
                'fileName': fileName,
                'flag': 2
            },
            success: function (res) {
                    var filename = fileName
                    var data = new Blob([res], {type: 'text/plain'})
                    if (typeof window.chrome !== 'undefined') {
                        // Chrome version
                        var link = document.createElement('a');
                        link.href = window.URL.createObjectURL(data);
                        link.download = filename;
                        link.click();
                    } else if (typeof window.navigator.msSaveBlob !== 'undefined') {
                        // IE version
                        var blob = new Blob([data], { type: 'application/force-download' });
                        window.navigator.msSaveBlob(blob, filename);
                    } else {
                        // Firefox version
                        var file = new File([data], filename, { type: 'application/force-download' });
                        window.open(URL.createObjectURL(file));
                    }
                    layer.msg("作业文件下载成功,保存路径为：" + fileName, {
                        icon: 1,
                        time: 2000
                    }, function () {
                        query();
                    });
            },
            error: function (e) {
                console.log(e)
                layer.msg("作业文件下载失败,请重新操作", {
                    icon: 2,
                    time: 2000
                }, function () {
                });
            }
        });
    }

    function xzTask() {
        var fileName = $("#taskFileName").val();
        if (!fileName) {
            layer.msg("教师还未提交任务附件", {
                icon: 2,
                time: 2000
            }, function () {
            });
            return;
        }
        $.ajax({
            url: 'taskDownLoad', //换成自己的url
            type: 'POST',
            responseType:'text/plain',
            data: {
                'fileName': fileName,
                'flag': 2
            },
            success: function (res) {
                console.log(res)
                var filename = fileName
                var data = new Blob([res], {type: 'text/plain'})
                console.log(data.toString())
                if (typeof window.chrome !== 'undefined') {
                    // Chrome version
                    var link = document.createElement('a');
                    link.href = window.URL.createObjectURL(data);
                    link.download = filename;
                    link.click();
                } else if (typeof window.navigator.msSaveBlob !== 'undefined') {
                    // IE version
                    var blob = new Blob([data], { type: 'application/force-download' });
                    window.navigator.msSaveBlob(blob, filename);
                } else {
                    // Firefox version
                    var file = new File([data], filename, { type: 'application/force-download' });
                    window.open(URL.createObjectURL(file));
                }
                    layer.msg("任务附件下载成功" + fileName, {
                        icon: 1,
                        time: 2000
                    }, function () {
                        query();
                    });
            },
            error: function (e) {
                console.log(e)
                layer.msg("任务附件下载失败,请重新操作", {
                    icon: 2,
                    time: 2000
                }, function () {
                });
            }
        });
    }
    var tableIns;
    layui.use(['layer', 'laydate', 'form', 'table'], function () {
        var layer = layui.layer;
        var element = layui.element;
        var table = layui.table;
        var form = layui.form;

        //展示已知数据
        tableIns = table.render({
            elem: '#taskTab',
            url: 'queryTaskByLike',
            method: 'POST',
            dataType: 'json',
            where: {},
            cols: [[ //标题栏
                {
                    field: 'taskNum',
                    title: '任务编号',
                    width: 180,
                    sort: true
                }, {
                    field: 'taskName',
                    title: '任务名称',
                    width: 120
                }, {
                    field: 'startTime',
                    title: '任务发布时间',
                    width: 220
                }, {
                    field: 'name',
                    title: '教师姓名',
                    width: 150
                }, {
                    fixed: 'right',
                    title: '操作(任务详情,作业提交)',
                    toolbar: '#barDemo',
                    width: 200
                }]],
            parseData: function (res) {
                return {
                    "code": res.code,
                    "msg": res.msg,
                    "count": res.count,
                    "data": res.data
                }
            },
            skin: 'line', //表格风格
            even: true,
            page: true, //是否显示分页
            limits: [5, 7, 10, 15],
            limit: 7
            //每页默认显示的数量
        });

        table.on('tool(taskTab)', function (obj) {
            var data = obj.data;
            var id = data.taskNum;
            $("#id").val(id);
            if (obj.event === 'tj') {
                $.ajax({
                    url: 'queryWorkByLike', //换成自己的url
                    type: 'POST',
                    dataType: 'json',
                    async: false,
                    data: {
                        'userId': $("#user_id").val(),
                        'taskNum': id,
                        'page':1,
                        'limit':100
                    },
                    success: function (res) {

                        if (res.count > 0) {
                            var data = res.data[0];
                            $("#workNum_edit").val(data.workNum);
                            $("#workName_edit").val(data.workName);
                            $("#workAnswer_edit").val(data.workAnswer);
                            $("#upTime_edit").val(data.upTime);
                            $("#workFileName").val(data.workFileName);
                        }
                    }
                });

                layer.open({
                    title: '作业提交',
                    // 如果是外部的html,type:2，内部，type:1
                    type: 1,
                    btnAlign: 'c',
                    area: ['550px', '450px'],
                    content: $("#edit-work")
                });
            } else if (obj.event === 'look') {
                $("#taskNum").val(data.taskNum);
                $("#taskName").val(data.taskName);
                $("#taskDescribe").val(data.taskDescribe);
                $("#taskFileName").val(data.taskFileName);
                $("#startTime").val(data.startTime);
                $("#teacherName").val(data.name);
                layer.open({
                    title: '任务详情',
                    // 如果是外部的html,type:2，内部，type:1
                    type: 1,
                    btnAlign: 'c',
                    area: ['550px', '450px'],
                    content: $("#list-task")
                });
            }
        });
    });


    function addWork() {
        var workName = $.trim($('#workName_edit').val());
        if (!workName) {
            layer.msg('请输入作业名称', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var workAnswer = $.trim($('#workAnswer_edit').val());
        if (!workAnswer) {
            layer.msg('请输入作业内容', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var file = $('#workFileName_edit')[0].files[0];
        if (!file) {
            layer.msg('请选择作业文件', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var workNum = $.trim($('#workNum_edit').val());
        var formData = new FormData();
        var url = "addWork";
        if(workNum){
            formData.append("workNum", workNum);
            url = "editWork"
        }
        formData.append("workName", workName);
        formData.append("workAnswer", workAnswer);
        formData.append("userId", $("#user_id").val());
        formData.append("taskNum", $("#id").val());
        formData.append("file", file);
        $.ajax({
            url: url,
            type: 'post',
            data: formData,
            dataType: 'json',
            cache: false,
            processData: false,
            contentType: false,
            async: false
        }).done(function (res) {

            if (res.msg === '0') {
                layer.msg("作业提交成功", {
                    icon: 1,
                    time: 1000
                }, function () {
                    query();
                });
            } else {
                layer.msg("作业提交失败,请重新提交", {
                    icon: 2,
                    time: 1000
                }, function () {

                });
            }

        }).fail(function (res) {

            layer.msg("作业提交失败,请重新提交", {
                icon: 2,
                time: 1000
            }, function () {

            });
        });
    }

    function qc_edit() {
        $("#workName_edit").val("");
        $("#workAnswer_edit").val("");
        $("#workFileName_edit").val("");
    }

    function query() {
        var name = $.trim($("#searchName").val());

        tableIns.reload({
            page: {
                curr: 1
                //重新从第 1 页开始
            },
            where: {
                name: name
            }
        });
    }
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