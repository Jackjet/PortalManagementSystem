<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserInfoEdit.aspx.cs" Inherits="PMSWeb.Admin.UserInfoEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/common.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/repository.css" />
    <link href="/Admin/AdminCss/onlinetest.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <style>
         .course_form_div label,.course_form_diva label{
            width:70px;display:block;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:HiddenField ID="hId" runat="server" />
        <asp:HiddenField ID="hRoleId" runat="server" />
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="course_form_div clearfix">
                        <label for="">用户名：</label>
                        <input type="text" placeholder="用户名" class="text" id="LoginName" value="" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_div clearfix">
                        <label for="" class="fl">密码：</label>
                        <input type="password" placeholder="密码" class="text" id="LoginPassword" value="" />
                    </div>
                    <div class="course_form_div clearfix">
                        <label for="">角色：</label>
                        <select id="selRole" class="select"></select>
                    </div>
                    <div style="clear: both"></div>

                    <div class="course_form_select clearfix tc">
                        <a class="course_btn confirm_btn" onclick="saveData()" id="btnCreate">确定</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script  type="text/javascript">
        $(function () {
            initRole();
        })

        function initRole() {
            var opt = document.getElementById('selRole');
            opt.options.length = 0;
            opt.options.add(new Option("请选择", ""));
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/RoleHandler.ashx",
                    "func": "GetPageList",
                    "isPage": false
                },
                success: function (json) {
                    var items = json.result.retData;
                    if (items != null && items.length > 0) {
                        for (var i = 0; i < items.length; i++) {
                            var option = new Option(items[i].RoleName, items[i].Id);
                            opt.options.add(option);

                        }
                        initUser();
                    }
                },
                error: OnError
            });
        }

        function initUser() {
            if ($("#hId").val() != "") {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/UserManagerHandler.ashx",
                        "func": "GetUserInfo",
                        "Id": $("#hId").val()
                    },
                    success: function (json) {
                        if (json.result.errNum == 0) {
                            var item = json.result.retData;
                            if (item != null) {

                                $("#LoginName").val(item.LoginName);
                                //$("#LoginPassword").val(item.LoginPassword);
                                $("#selRole").val(item.RoleId);
                                $("#LoginName").attr("disabled", "disabled");
                            }

                        }
                    },
                    error: OnError
                });
            } else {
                $("#selRole").val($("#hRoleId").val());
            }
        }

        function saveData() {
            if ($.trim($("#LoginName").val()) == '' || $.trim($("#LoginName").val()).length == 0) {
                layer.msg("用户名不能为空！");
                return false;
            }
            if ($("#selRole").val() == "" || $("#selRole").val().length == 0) {
                layer.msg("请选择角色！");
                return false;
            }
            if ($("#hId").val() == "" && ($("#LoginPassword").val() == "" || $("#LoginPassword").val().length == 0)) {
                layer.msg("请输入密码！");
                return false;
            }
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/UserManagerHandler.ashx",
                    "func": "EditUserInfo",
                    "LoginName": $("#LoginName").val(),
                    "LoginPassword": $("#LoginPassword").val(),
                    "RoleId": $("#selRole").val(),
                    "Id": $("#hId").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        parent.layer.msg('操作成功！');
                        parent.getData(1, 20);
                        parent.CloseIFrameWindow();
                    } else if (json.result.errMsg == "exist") {
                        parent.layer.msg('用户名已存在！');
                        parent.getData(1, 20);
                        parent.CloseIFrameWindow();
                    } else {
                        parent.layer.msg('操作失败！');
                        parent.getData(1, 20);
                        parent.CloseIFrameWindow();
                    }
                },
                error: OnError
            });
        }

        
    </script>
</body>
</html>
