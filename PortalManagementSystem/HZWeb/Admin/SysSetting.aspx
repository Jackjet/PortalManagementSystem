<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SysSetting.aspx.cs" Inherits="PMSWeb.Admin.SysSetting" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>




    <link href="/Admin/AdminCss/font-awesome.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/common.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/repository.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/onlinetest.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>

    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <%--  <asp:HiddenField ID="NoticeDisplayType" runat="server" />
        <asp:HiddenField ID="IsShowNotiecRoll" runat="server" />--%>
        <div>
            <div class="newcourse_dialog_detail clearfix">
                <script type="text/javascript">
         
                </script>
                <div class="clearfix">
                    <div class="course_form_div clearfix">
                        <label for="">展示方式：</label>
                        <select class="select" id="dislpayT" style="min-width: 100px; margin: 0;">
                            <option value="1" selected>弹窗展示</option>
                            <option value="2">列表展示</option>
                        </select>
                    </div>
                    <div class="course_form_div clearfix">
                        <label for="">滚动播放是否展示：</label>
                        <div class="fl" style="line-height: 30px;">
                            <input type="radio" name="Display" id="radioYes" value="0" checked />是<input type="radio" id="raidoNo" name="Display" value="1" />否
                        </div>
                    </div>
                    <div class="course_form_select clearfix">
                        <%--<a class="course_btn confirm_btn" id="btnCreate" onclick="saveData();" style="display: inline-block;">确定</a>--%>

                        <input class="course_btn confirm_btn" style="width: 100px; height: 36px;" type="button" onclick="saveData();" value="确定" />
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">

            //初始化
            $(function () {

                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/AdminManagerHandler.ashx",
                        "func": "ReadXmlPage"
                    },
                    success: function (json) {
                        if (json.result != null) {
                            if (json.result.errMsg == "success") {
                                var dtJson = json.result.retData;

                                $('select option[value=' + dtJson.NoticeDisplayType + ']').prop('selected', true);

                                $('input[name=Display][value=' + dtJson.IsShowNotiecRoll + ']').prop('checked', true);
                            }
                        }
                    },
                    error: function (textStatus) {
                        layer.msg("获取设置信息失败!");
                    }
                });
            });


            //设置存储
            function saveData() {

                var IsShowNotiecRoll;
                var NoticeDisplayType;
                var radioYes = $("#radioYes").is(':checked');
                var raidoNo = $("#raidoNo").is(':checked');

                if (radioYes == true && raidoNo == false) {
                    IsShowNotiecRoll = 0;
                }
                else if (radioYes == false && raidoNo == true) {
                    IsShowNotiecRoll = 1;
                }

                NoticeDisplayType = $("#dislpayT").prop('selected', true).val();


                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/AdminManagerHandler.ashx",
                        "func": "SetSystemSetting",
                        "NoticeDisplayType": NoticeDisplayType,
                        "IsShowNotiecRoll": IsShowNotiecRoll
                    },
                    success: function (json) {
                        if (json.result != null) {
                            if (json.result.errMsg == "success") {
                                layer.msg('操作成功!');
                            }
                        }
                    },
                    error: function (textStatus) {
                        layer.msg("设置失败!");
                    }
                });
            }

        </script>
    </form>
</body>
</html>
