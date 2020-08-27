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
    <title>任务管理</title>
</head>
<body class="layui-view-body">
<%
    if (user != null) {
%>
<div id="add-task" style="display: none;">
    <form class="layui-form" id="add-form" action="">
        <div class="layui-form-item center" style="margin-top: 30px;">
            <label class="layui-form-label" style="width: 100px">任务名称</label>
            <div class="layui-input-block">
                <input type="text" name="taskName_add" id="taskName_add" required
                       value="" style="width: 300px" lay-verify="required"
                       placeholder="请输入任务名称" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">任务介绍</label>
            <div class="layui-input-block" style="padding-bottom:10px;">
					<textarea placeholder="请输入任务介绍" autocomplete="off"
                              id="taskDescribe_add" name="taskDescribe_add" type="text/plain"
                              style="width:300px;height:100px"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">任务附件</label>
            <div class="layui-input-block">
                <input type="file" name="taskFileName_add" id="taskFileName_add"
                       value=""/>
            </div>
        </div>
        <div class="layui-form-item" style="margin-top:30px;">
            <button type="button" class="layui-btn layui-btn-normal"
                    onclick="addTask();" style="margin-left:130px;">提交
            </button>
            <button type="button" class="layui-btn layui-btn-normal"
                    onclick="qc_add();" style="margin-left:20px;">重置
            </button>
        </div>
    </form>
</div>

<div id="edit-task" style="display: none;">
    <form class="layui-form" id="edit-form" action="">
        <div class="layui-form-item center" style="margin-top: 30px;">
            <label class="layui-form-label" style="width: 100px">任务编号</label>
            <div class="layui-input-block">
                <input type="text" name="taskNum_edit" id="taskNum_edit" required
                       value="" style="width: 300px" lay-verify="required"
                       placeholder="任务编号" disabled="disabled" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">任务名称</label>
            <div class="layui-input-block">
                <input type="text" name="taskName_edit" id="taskName_edit" required
                       value="" style="width: 300px" lay-verify="required"
                       placeholder="请输入任务名称" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">任务介绍</label>
            <div class="layui-input-block" style="padding-bottom:10px;">
					<textarea placeholder="请输入任务介绍" autocomplete="off"
                              id="taskDescribe_edit" name="taskDescribe_edit" type="text/plain"
                              style="width:300px;height:100px"></textarea>
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">发布时间</label>
            <div class="layui-input-block">
                <input type="text" name="startTime_edit" id="startTime_edit"
                       required value="" style="width: 300px" lay-verify="required"
                       placeholder="发布时间" disabled="disabled" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">任务附件</label>
            <div class="layui-input-block">
                <input type="file" name="taskFileName_edit" id="taskFileName_edit"
                       value=""/>
            </div>
        </div>
        <div class="layui-form-item" style="margin-top:30px;">
            <button type="button" class="layui-btn layui-btn-normal"
                    onclick="editTask();" style="margin-left:130px;">提交
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
                <button type="button" id="download" onclick="xz()"
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
            <h2 class="title">任务管理</h2>
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
    <a class="layui-btn layui-btn-sm layui-btn-danger layui-icon" lay-event="del" style="margin-top: -5px;">&#xe640;</a>
    <a class="layui-btn layui-btn-sm layui-btn-normal layui-icon" lay-event="look"
       style="margin-top: -5px;">&#xe65b;</a>
    <a class="layui-btn layui-btn-sm layui-btn-warm layui-icon" lay-event="edit" style="margin-top: -5px;">&#xe642;</a>
</script>
<script>
    function xz() {
        var fileName = $("#taskFileName").val();

        $.ajax({
            url: 'taskDownLoad', //换成自己的url
            type: 'POST',
            responseType:'text/plain',
            data: {
                'fileName': fileName,
                'flag': 1
            },
            success: function (res) {
                    var filename = fileName
                    var data = new Blob([res], {type: 'application/json'})
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
                    layer.msg("任务附件下载成功," + fileName, {
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
            where: {
                'userId':$("#user_id").val()
            },
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
                    title: '操作(删除,详情,编辑)',
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
            if (obj.event === 'del') {

                $.ajax({
                    url: 'deleteTaskById',
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        'id': id
                    },
                    success: function (res) {
                        if (res.msg == 0) {
                            layer.msg("任务删除成功", {
                                icon: 1,
                                time: 1000
                            }, function () {
                                query();
                            });
                        } else {
                            layer.msg("任务删除失败,请重新删除", {
                                icon: 2,
                                time: 1000
                            }, function () {

                            });
                        }
                    },
                    error: function (e) {
                        layer.msg("任务删除失败,请重新删除", {
                            icon: 2,
                            time: 1000
                        }, function () {

                        });
                    }
                });
            } else if (obj.event === 'edit') {
                $("#taskNum_edit").val(data.taskNum);
                $("#taskName_edit").val(data.taskName);
                $("#taskDescribe_edit").val(data.taskDescribe);
                $("#startTime_edit").val(data.startTime);
                layer.open({
                    title: '任务编辑',
                    // 如果是外部的html,type:2，内部，type:1
                    type: 1,
                    btnAlign: 'c',
                    area: ['550px', '450px'],
                    content: $("#edit-task")
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

    function add() {
        layer.open({
            type: 1,
            title: '任务新建',
            area: ['550px', '450px'],
            btnAlign: 'c',
            content: $("#add-task")
        });
    }

    function editTask() {
        var taskName = $.trim($('#taskName_edit').val());
        if (!taskName) {
            layer.msg('请输入任务名称', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var taskDescribe = $.trim($('#taskDescribe_edit').val());
        if (!taskDescribe) {
            layer.msg('请输入任务介绍', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var file = $('#taskFileName_edit')[0].files[0];
        if (!file) {
            layer.msg('请选择任务附件', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var formData = new FormData();
        formData.append("taskNum", $("#id").val());
        formData.append("taskName", taskName);
        formData.append("taskDescribe", taskDescribe);
        formData.append("userId", $("#user_id").val());
        formData.append("file", file);
        $.ajax({
            url: 'editTask',
            type: 'post',
            data: formData,
            dataType: 'json',
            cache: false,
            processData: false,
            contentType: false,
            async: false
        }).done(function (res) {
            if (res.msg === '0') {
                layer.msg("任务编辑成功", {
                    icon: 1,
                    time: 1000
                }, function () {
                    query();
                });
            } else {
                layer.msg("任务编辑失败,请重新编辑", {
                    icon: 2,
                    time: 1000
                }, function () {

                });
            }

        }).fail(function (res) {
            layer.msg("任务编辑失败,请重新编辑", {
                icon: 2,
                time: 1000
            }, function () {

            });
        });
    }

    function addTask() {
        var taskName = $.trim($('#taskName_add').val());
        if (!taskName) {
            layer.msg('请输入任务名称', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var taskDescribe = $.trim($('#taskDescribe_add').val());
        if (!taskDescribe) {
            layer.msg('请输入任务介绍', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var file = $('#taskFileName_add')[0].files[0];
        if (!file) {
            layer.msg('请选择任务附件', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var formData = new FormData();
        formData.append("taskName", taskName);
        formData.append("taskDescribe", taskDescribe);
        formData.append("userId", $("#user_id").val());
        formData.append("file", file);
        $.ajax({
            url: 'addTask',
            type: 'post',
            data: formData,
            dataType: 'json',
            cache: false,
            processData: false,
            contentType: false,
            async: false
        }).done(function (res) {
            if (res.msg === '0') {
                layer.msg("任务新建成功", {
                    icon: 1,
                    time: 1000
                }, function () {
                    query();
                });
            } else {
                layer.msg("任务新建失败,请重新新建", {
                    icon: 2,
                    time: 1000
                }, function () {

                });
            }

        }).fail(function (res) {
            layer.msg("任务新建失败,请重新新建", {
                icon: 2,
                time: 1000
            }, function () {

            });
        });
    }

    function qc_add() {
        $("#taskName_add").val("");
        $("#taskDescribe_add").val("");
        $("#taskFileName_add").val("");
    }

    function qc_edit() {
        $("#taskName_edit").val("");
        $("#taskDescribe_edit").val("");
        $("#taskFileName_edit").val("");
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