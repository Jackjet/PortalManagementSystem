<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeView.aspx.cs" Inherits="PMSWeb.DYYX.SitePages.BeforeView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title>大峪第一小学</title>
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
        <asp:HiddenField ID="HMenuId" runat="server" />
        <asp:HiddenField ID="HAdvId" runat="server" />
        <asp:HiddenField ID="HSSId" runat="server" />
        

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
                                    <span id="file"></span><span id="filePath"></span>
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
        var advIdForMenuId;
        $(function () {
            initData();
            leftTree();
            addClickNumer();
        })

        function initData() {
            if ($("#HAdvId").val().length > 0) {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/AdvertisingHandler.ashx",
                        "func": "GetAdvertisingForId",
                        "AdvId": $("#HAdvId").val()
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            var item = json.result.retData;
                            if (item != null) {
                                if (item.ModelType == 1) {
                                    if (item.FilePath != null && item.FilePath != "" && item.FilePath.length > 0) {
                                        FolderOpend(item.FilePath);
                                    }
                                } else {
                                    $("#noticeTitle").html(item.Description);
                                    $("#Contents").html(item.CreativeHTML);
                                    if (item.FileName != null && item.FileName != "" && item.FileName.length > 0) {
                                        $("#file").html("附件：");
                                        var hz = item.FilePath.lastIndexOf(".") + 1;
                                        if (".swf.flv.mp4.rar.zip".toLowerCase().indexOf(hz.toLowerCase()) > -1)
                                            $("#filePath").html("<a href=\"" + item.FilePath + "\" download=\"" + item.FileName + "\">" + item.FileName + "</a>");
                                        else
                                            $("#filePath").html("<a href=\"javascript:FolderClick('" + item.FilePath + "');\">" + item.FileName + "</a>");
                                    }
                                    $("#timespan").html(DateTimeConvert(item.CreateTime));
                                    $("#clickspan").html(item.ClickNum);
                                    advIdForMenuId = item.Id;
                                }
                                
                            }
                        }
                    },
                    error: OnError
                });

            }  else if ($("#HMenuId").val().length > 0) {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/AdvertisingHandler.ashx",
                        "func": "GetAdvertising",
                        "MenuId": $("#HMenuId").val(),
                        "IsDelete": 0
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            var item = json.result.retData;
                            if (item != null && item.length > 0) {
                                if (item[0].ModelType == 1) {
                                    if (item[0].FilePath != null && item[0].FilePath != "" && item[0].FilePath.length > 0) {
                                        FolderOpend(item[0].FilePath);
                                    }
                                } else {
                                    $("#noticeTitle").html(item[0].Description);
                                    $("#Contents").html(item[0].CreativeHTML);
                                    $("#timespan").html(DateTimeConvert(item[0].CreateTime));
                                    $("#clickspan").html(item[0].ClickNum);
                                    advIdForMenuId = item[0].Id;
                                    if (item[0].FileName != null && item[0].FileName != "" && item[0].FileName.length > 0) {
                                        $("#file").html("附件：");
                                        var hz = item[0].FilePath.lastIndexOf(".") + 1;
                                        if (".swf.flv.mp4.rar.zip".toLowerCase().indexOf(hz.toLowerCase()) > -1)
                                            $("#filePath").html("<a href=\"" + item[0].FilePath + "\" download=\"" + item[0].FileName + "\">" + item[0].FileName + "</a>");
                                        else
                                            $("#filePath").html("<a href=\"javascript:FolderClick('" + item[0].FilePath + "');\">" + item[0].FileName + "</a>");
                                    }
                                }
                                
                            }
                        }
                    },
                    error: OnError
                });
            }
        }
        /*else if ($("#HSSId").val().length > 0) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetDataInfo",
                    "Id": $("#HSSId").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var item = json.result.retData;
                        if (item != null) {
                            if (item.ModelType == 1) {
                                if (item.FilePath != null && item.FilePath != "" && item.FilePath.length > 0) {
                                    FolderOpend(item.FilePath);
                                }
                            } else {
                                $("#noticeTitle").html(item.Title);
                                $("#Contents").html(item.Description);
                                if (item.FileName != null && item.FileName != "" && item.FileName.length > 0) {
                                    $("#file").html("附件：");
                                    var hz = item.FilePath.lastIndexOf(".") + 1;
                                    if (".swf.flv.mp4.rar.zip".toLowerCase().indexOf(hz.toLowerCase()) > -1)
                                        $("#filePath").html("<a href=\"" + item.FilePath + "\" download=\"" + item.FileName + "\">" + item.FileName + "</a>");
                                    else
                                        $("#filePath").html("<a href=\"javascript:FolderClick('" + item.FilePath + "');\">" + item.FileName + "</a>");
                                }
                                $("#timespan").html(DateTimeConvert(item.CreateTime));
                                $("#clickspan").html(item.ClickNum);
                                advIdForMenuId = item.Id;
                            }
                               
                        }
                    }
                },
                error: OnError
            });
        }*/
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


        function addClickNumer() {
            if ($("#HMenuId").val().length > 0) {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { PageName: "DYYX/AdvertisingHandler.ashx", Func: "UpdateAdvertising", Id: advIdForMenuId, ClickNum: "1" },
                    success: function (json) {

                    },
                    error: function (errMsg) {

                    }
                });
            }
        }

        function FolderOpend(FoldUrl) {
            var FileExt = getFileName(FoldUrl);
            if (FileExt == "ppt" || FileExt == "pptx" || FileExt == "doc" || FileExt == "docx" || FileExt == "xls" || FileExt == "xlsx" || FileExt == "pdf") {
                $.ajax({
                    url: "/Handler/WordOpenHTML.ashx",
                    type: "post",
                    async: false,
                    dataType: "text",
                    data: {
                        "Func": "Wopi_Proxy", filepath: FoldUrl
                    },
                    success: function (result) {
                        var iframe = '<iframe id="contentFrame" name="contentFrame" scrolling="no" src="' + result + '" frameborder="0" style="padding: 0px; width: 100%;"></iframe>';
                        $('#Contents').append(iframe);
                        startInit('contentFrame', 200);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        layer.msg("附件不存在！");
                    }
                });
            }
        }


        function FolderClick(FoldUrl) {
            var FileExt = getFileName(FoldUrl);
            if (FileExt == "ppt" || FileExt == "pptx" || FileExt == "doc" || FileExt == "docx" || FileExt == "xls" || FileExt == "xlsx" || FileExt == "pdf") {
                $.ajax({
                    url: "/Handler/WordOpenHTML.ashx",
                    type: "post",
                    async: false,
                    dataType: "text",
                    data: {
                        "Func": "Wopi_Proxy", filepath: FoldUrl
                    },
                    success: function (result) {
                        window.open(result);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        layer.msg("附件不存在！");
                    }
                });
            }
        }

        function getFileName(o) {
            //通过第一种方式获取文件名
            var pos = o.lastIndexOf(".");
            //查找最后一个\的位置
            return o.substring(pos + 1);
        }
    </script>
</body>
</html>
