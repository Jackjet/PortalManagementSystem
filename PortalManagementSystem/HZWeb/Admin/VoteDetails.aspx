<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VoteDetails.aspx.cs" Inherits="PMSWeb.Admin.VoteDetails" %>

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
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/onlinetest.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>

    <script src="/Scripts/layer/layer.js"></script>
</head>
<body>
    <form id="form1" runat="server">
   <asp:HiddenField ID="hidId" runat="server" />
        <asp:HiddenField ID="VoteId" runat="server" />
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="course_form_div clearfix">
                        <label for="">选项：</label>
                        <input type="text" placeholder="选项" class="text" id="Title" value="" />
                        <i class="stars"></i>
                    </div>
                    <div style="clear: both"></div>

                    <div class="course_form_select clearfix tc">
                        <a class="course_btn confirm_btn" onclick="saveData()" id="btnCreate" style="display: inline-block;">确定</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            initData();
        })

        function initData() {
            if ($("#hidId").val() != "") {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/AdminManagerHandler.ashx",
                        "func": "GetVoteDetailsInfo",
                        "Id": $("#hidId").val()
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            var item = json.result.retData;
                            if (item != null) {
                                $("#Title").val(item.Title);
                            }
                        }
                    },
                    error: OnError
                });
            }
        }

        function saveData() {
            var title = $("#Title").val();

            if ($.trim($("#Title").val('')) || $.trim($("#Title").val().length==0)) {
                layer.msg('请填写选项内容')
            }
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "EditVoteDetail",
                    "Title": title,
                    "VoteId": $("#VoteId").val(),
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        parent.layer.msg("操作成功！");
                        parent.getData(1, 10);
                        parent.CloseIFrameWindow();
                    } else {
                        layer.msg("操作失败！");
                    }
                },
                error: OnError
            });
        }
    </script>
</body>
</html>
