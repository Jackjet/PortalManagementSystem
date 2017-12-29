<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoticeView.aspx.cs" Inherits="PMSWeb.DYYX.SitePages.NoticeView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <link href="/DYYX/css/reset.css" rel="stylesheet" />
    <link href="/DYYX/css/layout.css" rel="stylesheet" id="mystylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/DYYX/js/layout.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script>
        $(function () {
            $('#header').load('/DYYX/Header.aspx');
            $('#footer').load('/DYYX/bottom.aspx');
        })
    </script>
    <script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
        <li>{{if Id!=$("#HMenuId").val()}}
            <a href="${BeforeUrl}" target="_self" class="">${Name}</a>
            {{else}}
            <a href="${BeforeUrl}" target="_self" class="visited">${Name}</a>
            {{/if}}
        </li>
        {{/if}}
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input id="NoticeId" runat="server" type="hidden" />
        <asp:HiddenField ID="HMenuId" runat="server" />
        

        <div class="ADs">
            <div class="cs_close">
                <a href="javascript:;" onclick="$('.ADs').fadeOut()"><span>关闭</span></a>
            </div>
            <img src="/DYYX/images/ads.jpg">
        </div>
                 <div id="header" style="height:400px;"></div>


        <div class="clear"></div>
        <div class="center">
            <div class="centercontent">
                <div class="center_con main" id="initheight">
                    <div class="maintopLeft" style="float: left;">
                        <div class="left_nav">
                            <h2 id="hTitle"></h2>
                            <div class="left_navcon">
                                <ul class="con_wenzi" id="div_leftTree">
                                </ul>
                            </div>
                            <div class="footer"></div>
                        </div>
                    </div>
                    <div class="maintopRight">
                        <div id="crumb">
                            <div><a href="/DYYXIndex.aspx">首页</a> &gt;&gt;<a href="#" id="menuPNav"></a>&gt;&gt;<a href="#" id="menuNav"></a></div>
                        </div>
                        <div class="sy_xxk_cy_bg">
                            <div class="con_details">
                                <h2 class="tit_con" id="noticeTitle"></h2>
                                <h3 class="time">发布时间:<span id="timespan"></span>    点击次数:<span id="clickspan"></span></h3>
                                <div class="content_text" id="Contents">
                                </div>
                                <div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--footer-->

            <div id="footer" style="height:68px;"></div>

            <div id="top"></div>
    </form>
    <script type="text/javascript">
        
        $(function () {
            initData();
            addClickNumer();
            leftTree();
        })

        function initData() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/NoticesHandler.ashx",
                    "func": "GetNoticeInfo",
                    "Id": $("#NoticeId").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var item = json.result.retData;
                        if (item != null) {
                            $("#noticeTitle").html(item.Title);
                            $("#Contents").html(item.Contents);
                            $("#aTitleMenu").html(item.Title);
                            $("#timespan").html(DateTimeConvert(item.CreateTime));
                            $("#clickspan").html(item.ClickNum);
                            if (item.FileName != null && item.FileName != "" && item.FileName.length > 0) {
                                $("#file").html("附件：");
                                var hz = item.FilePath.lastIndexOf(".") + 1;
                                if (".swf.flv.mp4.rar.zip".toLowerCase().indexOf(hz.toLowerCase()) > -1)
                                    $("#filePath").html("<a href=\"" + item.FilePath + "\" download=\"" + item.FileName + "\">" + item.FileName + "</a>");
                                else
                                    $("#filePath").html("<a href=\"javascript:FolderClick('" + item.FilePath + "');\">" + item.FileName + "</a>");
                            }
                        }
                    }
                },
                error: OnError
            });
        }

        function addClickNumer() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "DYYX/NoticesHandler.ashx", Func: "UpdateNotice", Id: $("#NoticeId").val(), ClickNum: "1" },
                success: function (json) {

                },
                error: function (errMsg) {

                }
            });
        }

        function leftTree() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: "GetPortalTreeDataForChildId",
                    MenuId: $("#HMenuId").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#div_leftTree").html('');
                        var items = json.result.retData;
                        $("#tr_leftTree").tmpl(items).appendTo("#div_leftTree");
                        if (items != null) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].PId == "0") {
                                    $("#hTitle").html(items[i].Name);
                                    $("#menuPNav").html(items[i].Name);
                                    $('#menuPNav').attr('href', items[i].BeforeUrl)
                                }
                                if (items[i].Id == $("#HMenuId").val()) {
                                    $("#menuNav").html(items[i].Name);
                                    $('#menuNav').attr('href', items[i].BeforeUrl)
                                    $(".tit").html(items[i].Name);
                                    $(".english").html(items[i].EnName);
                                }
                            }
                        }
                    }
                    else {
                        $("#div_leftTree").html("暂无数据！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    </script>
</body>
</html>
