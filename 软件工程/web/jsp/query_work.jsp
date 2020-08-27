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
    <title>作业查询</title>
</head>
<body class="layui-view-body">
<%
    if (user != null) {
%>
<div id="jc-work" style="display: none;">
    <form class="layui-form" id="jc-form" action="">
        <table id="jcTab" lay-filter="jcTab"></table>
    </form>
</div>
<div id="add-work" style="display: none;">
    <form class="layui-form" id="add-form" action="">
        <div class="layui-form-item center" style="margin-top: 30px;">
            <label class="layui-form-label" style="width: 100px">作业名称</label>
            <div class="layui-input-block">
                <input type="text" name="workName_add" id="workName_add" required
                       value="" style="width: 300px" lay-verify="required"
                       placeholder="请输入作业名称" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">作业内容</label>
            <div class="layui-input-block" style="padding-bottom:10px;">
					<textarea placeholder="请输入作业内容" autocomplete="off"
                              id="workAnswer_add" name="workAnswer_add" type="text/plain"
                              style="width:300px;height:100px"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">作业文件</label>
            <div class="layui-input-block">
                <input type="file" name="workFileName_add" id="workFileName_add"
                       value=""/>
            </div>
        </div>
        <div class="layui-form-item" style="margin-top:30px;">
            <button type="button" class="layui-btn layui-btn-normal"
                    onclick="addWork();" style="margin-left:130px;">提交
            </button>
            <button type="button" class="layui-btn layui-btn-normal"
                    onclick="qc_add();" style="margin-left:20px;">重置
            </button>
        </div>
    </form>
</div>

<div id="edit-work" style="display: none;">
    <form class="layui-form" id="edit-form" action="">
        <div class="layui-form-item center" style="margin-top: 30px;">
            <label class="layui-form-label" style="width: 100px">作业编号</label>
            <div class="layui-input-block">
                <input type="text" name="workNum_edit" id="workNum_edit" required
                       value="" style="width: 300px" lay-verify="required"
                       placeholder="作业编号" disabled="disabled" autocomplete="off"
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
                       placeholder="提交时间" disabled="disabled" autocomplete="off"
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
        <div class="layui-form-item" style="margin-top:30px;">
            <button type="button" class="layui-btn layui-btn-normal"
                    onclick="editWork();" style="margin-left:130px;">提交
            </button>
            <button type="button" class="layui-btn layui-btn-normal"
                    onclick="qc_edit();" style="margin-left:20px;">重置
            </button>
        </div>
    </form>
</div>

<div id="list-work" style="display: none;">
    <form class="layui-form" id="list-form" action="">
        <div class="layui-form-item center" style="margin-top: 30px;">
            <label class="layui-form-label" style="width: 100px">任务编号</label>
            <div class="layui-input-block">
                <input type="text" name="taskNum" id="taskNum" required value=""
                       style="width: 300px" lay-verify="required" placeholder="任务名称"
                       disabled="disabled" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center" style="margin-top: 30px;">
            <label class="layui-form-label" style="width: 100px">任务名称</label>
            <div class="layui-input-block">
                <input type="text" name="taskName" id="taskName" required value=""
                       style="width: 300px" lay-verify="required" placeholder="任务名称"
                       disabled="disabled" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center" style="margin-top: 30px;">
            <label class="layui-form-label" style="width: 100px">作业编号</label>
            <div class="layui-input-block">
                <input type="text" name="workNum" id="workNum" required value=""
                       style="width: 300px" lay-verify="required" placeholder="作业编号"
                       disabled="disabled" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">作业名称</label>
            <div class="layui-input-block">
                <input type="text" name="workName" id="workName" required value=""
                       style="width: 300px" lay-verify="required" placeholder="作业名称"
                       disabled="disabled" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">作业内容</label>
            <div class="layui-input-block" style="padding-bottom:10px;">
					<textarea placeholder="作业内容" autocomplete="off" id="workAnswer"
                              name="workAnswer" type="text/plain" disabled="disabled"
                              style="width:300px;height:100px"></textarea>
            </div>
        </div>
        <div class="layui-form-item center">
            <label class="layui-form-label" style="width: 100px">提交时间</label>
            <div class="layui-input-block">
                <input type="text" name="upTime" id="upTime" required value=""
                       style="width: 300px" lay-verify="required" placeholder="提交时间"
                       disabled="disabled" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" id="fileDiv">
            <label class="layui-form-label" style="width: 100px">作业文件</label> <input
                type="text" name="workFileName" id="workFileName" required value=""
                style="width: 300px" lay-verify="required" placeholder="作业文件"
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
<input type="hidden" value="" name="task_Num" id="task_Num"/>
<div class="layui-content">
    <div class="layui-page-header">
        <div class="pagewrap">
            <h2 class="title">作业查询</h2>
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

                        </div>
                    </div>

                    <table id="workTab" lay-filter="workTab"></table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="barDemo">
    <!--
    <a class="layui-btn layui-btn-sm layui-btn-danger layui-icon" lay-event="del" style="margin-top: -5px;">&#xe640;</a>
    -->
    <a class="layui-btn layui-btn layui-btn-normal layui-icon" lay-event="look"
       style="margin-top: -5px;">&#xe65b;</a>

    <a class="layui-btn layui-btn layui-btn-warm layui-icon" lay-event="jc"
       style="margin-top: -5px;">&#xe642;</a>

</script>
<script>
    function xz() {
        var fileName = $("#workFileName").val();
        if (!fileName) {
            layer.msg("该学生还未提交作业文件", {
                icon: 2,
                time: 2000
            }, function () {
            });
            return;
        }

        $.ajax({
            url: 'workDownLoad', //换成自己的url
            type: 'POST',
            responseType:'text/plain',
            data: {
                'fileName': fileName,
                'flag': 1
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
                    layer.msg("作业文件下载成功" + fileName, {
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

    var tableIns;
    layui.use(['layer', 'laydate', 'form', 'table'], function () {
        var layer = layui.layer;
        var element = layui.element;
        var table = layui.table;
        var form = layui.form;

        //展示已知数据
        tableIns = table.render({
            elem: '#workTab',
            url: 'queryWorkByLike',
            method: 'POST',
            dataType: 'json',
            where: {
                'teacherId':$("#user_id").val()
            },
            cols: [[ //标题栏
                {
                    field: 'taskNum',
                    title: '任务编号',
                    width: 280,
                    sort: true
                },
                {
                    field: 'taskName',
                    title: '任务名称',
                    width: 280,
                    sort: true
                }, {
                    field: 'workNum',
                    title: '作业编号',
                    width: 280,
                    sort: true
                }, {
                    field: 'workName',
                    title: '作业名称',
                    width: 120
                }, {
                    field: 'upTime',
                    title: '作业提交时间',
                    width: 250
                }, {
                    field: 'name',
                    title: '学生姓名',
                    width: 150
                }, {
                    fixed: 'right',
                    title: '操作(作业详情,重复率检测)',
                    toolbar: '#barDemo',
                    width: 250
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

        table.on('tool(workTab)', function (obj) {
            var data = obj.data;
            var id = data.workNum;
            $("#id").val(id);
            $("#task_Num").val(data.taskNum);
            if (obj.event === 'jc') {// 重复率检查
                table.render({
                    elem: '#jcTab',
                    url: 'checkRate',
                    method: 'POST',
                    dataType: 'json',
                    where: {
                        'name': $.trim($("#searchName").val()),
                        'workNum': $("#id").val(),
                        'taskNum': $("#task_Num").val()
                    },
                    cols: [[ //标题栏
                        {
                            field: 'name',
                            title: '学生姓名',
                            width: 120,
                            sort: true
                        },
                        {
                            field: 'fileName',
                            title: '学生文件',
                            width: 220,
                            sort: true
                        }, {
                            field: 'comName',
                            title: '对比学生姓名',
                            width: 180,
                            sort: true
                        }, {
                            field: 'comFileName',
                            title: '对比学生文件',
                            width: 220
                        }, {
                            field: 'xsd',
                            title: '相似度',
                            width: 120
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
                layer.open({
                    title: '检测详情',
                    // 如果是外部的html,type:2，内部，type:1
                    type: 1,
                    btnAlign: 'c',
                    area: ['550px', '450px'],
                    content: $("#jc-work")
                });
            } else if (obj.event === 'look') {
                $("#taskNum").val(data.taskNum);
                $("#taskName").val(data.taskName);
                $("#workNum").val(data.workNum);
                $("#workName").val(data.workName);
                $("#workAnswer").val(data.workAnswer);
                $("#workFileName").val(data.workFileName);
                $("#upTime").val(data.upTime);
                layer.open({
                    title: '作业详情',
                    // 如果是外部的html,type:2，内部，type:1
                    type: 1,
                    btnAlign: 'c',
                    area: ['550px', '450px'],
                    content: $("#list-work")
                });
            }
        });
    });

    function add() {
        layer.open({
            type: 1,
            title: '作业新建',
            area: ['550px', '450px'],
            btnAlign: 'c',
            content: $("#add-work")
        });
    }

    function editWork() {
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
        var formData = new FormData();
        formData.append("workNum", $("#id").val());
        formData.append("workName", workName);
        formData.append("workAnswer", workAnswer);
        formData.append("userId", $("#user_id").val());
        formData.append("taskNum", $("#task_Num").val());
        formData.append("file", file);
        $.ajax({
            url: 'editWork',
            type: 'post',
            data: formData,
            dataType: 'json',
            cache: false,
            processData: false,
            contentType: false,
            async: false
        }).done(function (res) {
            if (res.msg === '0') {
                layer.msg("作业编辑成功", {
                    icon: 1,
                    time: 1000
                }, function () {
                    query();
                });
            } else {
                layer.msg("作业编辑失败,请重新编辑", {
                    icon: 2,
                    time: 1000
                }, function () {

                });
            }

        }).fail(function (res) {
            layer.msg("作业编辑失败,请重新编辑", {
                icon: 2,
                time: 1000
            }, function () {

            });
        });
    }

    function addWork() {
        var workName = $.trim($('#workName_add').val());
        if (!workName) {
            layer.msg('请输入作业名称', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var workAnswer = $.trim($('#workAnswer_add').val());
        if (!workAnswer) {
            layer.msg('请输入作业内容', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var file = $('#workFileName_add')[0].files[0];
        if (!file) {
            layer.msg('请选择作业文件', {
                icon: 2,
                time: 1000
            }, function () {

            });
            return;
        }
        var formData = new FormData();
        formData.append("workName", workName);
        formData.append("workAnswer", workAnswer);
        formData.append("userId", $("#user_id").val());
        formData.append("taskNum", $("#task_Num").val());
        formData.append("file", file);
        $.ajax({
            url: 'addWork',
            type: 'post',
            data: formData,
            dataType: 'json',
            cache: false,
            processData: false,
            contentType: false,
            async: false
        }).done(function (res) {
            if (res.msg === '0') {
                layer.msg("作业新建成功", {
                    icon: 1,
                    time: 1000
                }, function () {
                    query();
                });
            } else {
                layer.msg("作业新建失败,请重新新建", {
                    icon: 2,
                    time: 1000
                }, function () {

                });
            }

        }).fail(function (res) {
            layer.msg("作业新建失败,请重新新建", {
                icon: 2,
                time: 1000
            }, function () {

            });
        });
    }

    function qc_add() {
        $("#workName_add").val("");
        $("#workAnswer_add").val("");
        $("#workFileName_add").val("");
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