<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnnounceNotice.aspx.cs" Inherits="PMSWeb.YQYZ.SitePages.AnnounceNotice" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title>延庆区第一中学</title>
    <link href="/YQYZ/css/reset.css" rel="stylesheet" />
    <link href="/YQYZ/css/layout2.css" rel="stylesheet" id="mystylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/YQYZ/js/layout.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/YQYZ/js/layer/layer.js"></script>
</head>
<body>
    <form id="form1" runat="server">
          <asp:HiddenField ID="HMenuId" runat="server" />
        <asp:HiddenField ID="HAdvId" runat="server" />
        <asp:HiddenField ID="HSSId" runat="server" />
        
    <div style="padding:20px;">
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
    </form>
    <script>
        var browserVersion = window.navigator.userAgent.toUpperCase();
        var isOpera = browserVersion.indexOf("OPERA") > -1 ? true : false;
        var isFireFox = browserVersion.indexOf("FIREFOX") > -1 ? true : false;
        var isChrome = browserVersion.indexOf("CHROME") > -1 ? true : false;
        var isSafari = browserVersion.indexOf("SAFARI") > -1 ? true : false;
        var isIE = (!!window.ActiveXObject || "ActiveXObject" in window);
        var isIE9More = (! -[1, ] == false);
        function reinitIframe(iframeId, minHeight) {
            try {
                var iframe = document.getElementById(iframeId);
                var bHeight = 0;
                if (isChrome == false && isSafari == false)
                    bHeight = iframe.contentWindow.document.body.scrollHeight;

                var dHeight = 0;
                if (isFireFox == true)
                    dHeight = iframe.contentWindow.document.documentElement.offsetHeight + 2;
                else if (isIE == false && isOpera == false)
                    dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                else if (isIE == true && isIE9More) {//ie9+
                    var heightDeviation = bHeight - eval("window.IE9MoreRealHeight" + iframeId);
                    if (heightDeviation == 0) {
                        bHeight += 3;
                    } else if (heightDeviation != 3) {
                        eval("window.IE9MoreRealHeight" + iframeId + "=" + bHeight);
                        bHeight += 3;
                    }
                }
                else//ie[6-8]、OPERA
                    bHeight += 3;

                var height = Math.max(bHeight, dHeight);
                if (height < minHeight) height = minHeight;
                iframe.style.height = height + "px";
            } catch (ex) { }
        }
        function startInit(iframeId, minHeight) {
            eval("window.IE9MoreRealHeight" + iframeId + "=0");
            window.setInterval("reinitIframe('" + iframeId + "'," + minHeight + ")", 100);
        }
        </script>
    <script type="text/javascript">
        var advIdForMenuId;
        $(function () {
            initData();
            addClickNumer();
        })

        function initData() {
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
                                    var hzindex = item.FilePath.lastIndexOf(".");
                                    var hz = item.FilePath.substring(hzindex);
                                    if (".swf.flv.mp4.rar.zip".toLowerCase().indexOf(hz.toLowerCase()) > -1)
                                        $("#filePath").html("<a href=\"" + item.FilePath + "\" download=\"" + item.FileName + "\">" + item.FileName + "</a>");
                                    else
                                        $("#filePath").html("<a href=\"javascript:FolderClick('" + item.FilePath + "');\">" + item.FileName + "</a>");
                                    //$("#filePath").html("<a href=\"javascript:FolderClick('" + item.FilePath + "');\">" + item.FileName + "</a>");
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
        }

        //function leftTree() {
        //    $.ajax({
        //        url: "/Common.ashx",
        //        type: "post",
        //        async: false,
        //        dataType: "json",
        //        data: {
        //            PageName: "DYYX/AdminManagerHandler.ashx",
        //            Func: "GetPortalTreeDataForChildId",
        //            MenuId: $("#HMenuId").val()
        //        },
        //        success: function (json) {
        //            if (json.result.errMsg == "success") {
        //                $("#div_leftTree").html('');
        //                var items = json.result.retData;
        //                $("#tr_leftTree").tmpl(items).appendTo("#div_leftTree");
        //                if (items != null) {
        //                    for (var i = 0; i < items.length; i++) {
        //                        if (items[i].PId == "0") {
        //                            $("#hTitle").html(items[i].Name);
        //                            $("#menuPNav").html(items[i].Name);
        //                        }
        //                        if (items[i].Id == $("#HMenuId").val()) {
        //                            $("#menuNav").html(items[i].Name);
        //                        }
        //                    }
        //                }
        //            }
        //            else {
        //                $("#div_leftTree").html("暂无数据！");
        //            }
        //        },
        //        error: function (XMLHttpRequest, textStatus, errorThrown) {

        //        }
        //    });
        //}


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
                        //$("#Contents").load(result);
                        //var iframe = document.createElement("iframe");
                        //iframe.scrolling = "no";
                        //iframe.src = result;
                        //document.getElementById("Contents").appendChild(iframe);
                        var iframe = '<iframe id="contentFrame" name="contentFrame" scrolling="no" src="' + result + '" frameborder="0" style="padding: 0px; width: 100%; height: 1000px;"></iframe>';
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
            if (FileExt == "ppt" || FileExt == "pptx" || FileExt == "doc" || FileExt == "docx" || FileExt == "xls" || FileExt == "xlsx") {
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
