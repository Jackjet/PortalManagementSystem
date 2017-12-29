<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RoleInfoEdit.aspx.cs" Inherits="PMSWeb.Admin.RoleInfoEdit" %>

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
</head>
<body>
    <form id="form1" runat="server">
    <asp:HiddenField ID="hId" runat="server" />
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">

                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">角色名称：</label>
                            <input type="text" placeholder="角色名称" class="text" id="RoleName" value="" />
                            <i class="stars"></i>
                        </div>
                        
                        <div style="clear: both"></div>

                        <div class="course_form_select clearfix tc">
                            <a  class="course_btn confirm_btn" onclick="saveData()" id="btnCreate">确定</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
        <script  type="text/javascript">
            $(function () {
                initRole();
                loadRoles();
            })

            var RoleNames = [];

            function initRole() {
                if ($("#hId").val() != "") {
                    $.ajax({
                        type: "Post",
                        url: "/Common.ashx",
                        async: false,
                        dataType: "json",
                        data: {
                            "PageName": "DYYX/RoleHandler.ashx",
                            "func": "GetRoleInfo",
                            "Id": $("#hId").val()
                        },
                        success: function (json) {
                            if (json.result.errNum == 0) {
                                var item = json.result.retData;
                                if (item != null) {
                                    $("#RoleName").val(item.RoleName);
                                }

                            }
                        },
                        error: OnError
                    });
                }

            }

            function saveData() {
                if ($.trim($("#RoleName").val()) == "" || $.trim($("#RoleName").val()).length == 0) {
                    layer.msg("请输入角色名称！");
                    return false;
                }
                if (isHasRoleName($("#RoleName").val())) {
                    layer.msg("角色名称已存在！");
                    return false;
                }
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/RoleHandler.ashx",
                        "func": "EditRoleInfo",
                        "RoleName": $("#RoleName").val(),
                        "Id": $("#hId").val()
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            parent.layer.msg('操作成功!');
                            parent.getData(1, 20);
                            parent.CloseIFrameWindow();
                        }
                    },
                    error: OnError
                });
            }

            function loadRoles() {
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
                                RoleNames.push(items[i].RoleName);
                            }
                            initUser();
                        }
                    },
                    error: OnError
                });
            }

            function isHasRoleName(rName) {
                var isResult = false;
                for (var i = 0; i < RoleNames.length; i++) {
                    if (rName==RoleNames[i]) {
                        isResult = true;
                        break;
                    }
                }
                return isResult;
            }
        
         </script>
</body>
</html>
