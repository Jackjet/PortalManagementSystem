<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeView.aspx.cs" Inherits="PMSWeb.ZZMH.Sitepages.BeforeView" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" />
    <meta name="keywords" content="北京市门头沟区中等职业学校,门头沟中职,城子职高,职成教集团,门职,门头沟职业教育" /> 
    <title>中职门户</title>
    <link href="/ZZMH/css/reset.css" rel="stylesheet" type="text/css">
    <link href="/ZZMH/css/layout.css" rel="stylesheet" type="text/css">
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="../js/common.js"></script>

</head>
<%--<script id="tr_leftTree" type="text/x-jquery-tmpl">
    {{if PId!=0}}
            {{if Id!=$("#HMenuId").val()}}
                <li><a href="${BeforeUrl}" target="_self" title="${Name}">${Name}</a></li>
    {{else}}
                <li class="visited"><a href="${BeforeUrl}" target="_self" title="${Name}">${Name}</a>
                    {{/if}}
                </li>
    {{/if}}
</script>--%>

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

<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HMenuId" runat="server" />
        <%--<asp:HiddenField ID="selectPid" runat="server" />--%>
        <asp:HiddenField ID="HAdvId" runat="server" />
        <asp:HiddenField ID="HSSId" runat="server" />
        <div id="Header" style="min-height: 282px;"></div>
        <div class="centercontent">
            <div class="center_con main" id="initheight">
                <div class="maintopLeft">
                    <div class="left_nav">
                        <h2 id="hTitle"></h2>
                        <div class="left_navcon">
                            <ul class="con_wenzi" id="div_leftTree">
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="maintopRight">
                    <div id="crumb"></div>
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
        <div id="footer" style="min-height: 80px;"></div>
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
        <script>
            var advIdForMenuId;
            $(function () {              
                $('#Header').load('/ZZMH/Header.aspx');
                $('#footer').load('/ZZMH/footer.html');
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
                                    $("#timespan").html(DateTimeConvert(item.CreateTime));
                                    $("#clickspan").html(item.ClickNum);
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
                                            $("#filePath").html("<a href=\"" + item.FilePath + "\" download=\"" + item.FileName + "\">" + item.FileName + "</a>");
                                            //if (".swf.flv.mp4.rar.zip".toLowerCase().indexOf(hz.toLowerCase()) > -1)
                                            //    $("#filePath").html("<a href=\"" + item.FilePath + "\" download=\"" + item.FileName + "\">" + item.FileName + "</a>");
                                            //else
                                            //    $("#filePath").html("<a href=\"javascript:FolderClick('" + item.FilePath + "');\">" + item.FileName + "</a>");
                                          
                                        }

                                        advIdForMenuId = item.Id;
                                    }

                                }
                            }
                        },
                        error: OnError
                    });

                } else if ($("#HSSId").val().length > 0) {
                    $.ajax({
                        type: "Post",
                        url: "/Common.ashx",
                        async: false,
                        dataType: "json",
                        data: {
                            "PageName": "DYYX/SchoolStyleHandler.ashx",
                            "func": "GetDataInfo",
                            "Id": $("#HSSId").val()
                        },
                        success: function (json) {
                            if (json.result.errMsg == "success") {
                                var item = json.result.retData;
                                if (item != null) {
                                    $("#timespan").html(DateTimeConvert(item.CreateTime));
                                    $("#clickspan").html(item.ClickNum);
                                    if (item.ModelType == 1) {
                                        if (item.FilePath != null && item.FilePath != "" && item.FilePath.length > 0) {
                                            FolderOpend(item.FilePath);
                                        }
                                    } else {
                                        $("#noticeTitle").html(item.Title);
                                        $("#Contents").html(item.Description);
                                        if (item.FileName != null && item.FileName != "" && item.FileName.length > 0) {
                                            $("#file").html("附件：");
                                            var hzindex = item.FilePath.lastIndexOf(".");
                                            var hz = item.FilePath.substring(hzindex);
                                            $("#filePath").html("<a href=\"" + item.FilePath + "\" download=\"" + item.FileName + "\">" + item.FileName + "</a>");
                                            //if (".swf.flv.mp4.rar.zip".toLowerCase().indexOf(hz.toLowerCase()) > -1)
                                            //    $("#filePath").html("<a href=\"" + item.FilePath + "\" download=\"" + item.FileName + "\">" + item.FileName + "</a>");
                                            //else
                                            //    $("#filePath").html("<a href=\"javascript:FolderClick('" + item.FilePath + "');\">" + item.FileName + "</a>");
                                        }

                                        advIdForMenuId = item.Id;
                                    }
                                }
                            }
                        },
                        error: OnError
                    });
                } else if ($("#HMenuId").val().length > 0) {
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
                                    $("#timespan").html(DateTimeConvert(item[0].CreateTime));
                                    $("#clickspan").html(item[0].ClickNum);
                                    if (item[0].ModelType == 1) {
                                        if (item[0].FilePath != null && item[0].FilePath != "" && item[0].FilePath.length > 0) {
                                            FolderOpend(item[0].FilePath);
                                        }
                                    } else {
                                        $("#noticeTitle").html(item[0].Description);
                                        $("#Contents").html(item[0].CreativeHTML);

                                        advIdForMenuId = item[0].Id;
                                        if (item[0].FileName != null && item[0].FileName != "" && item[0].FileName.length > 0) {
                                            $("#file").html("附件：");
                                            var hzindex = item[0].FilePath.lastIndexOf(".");
                                            var hz = item[0].FilePath.substring(hzindex);
                                            $("#filePath").html("<a href=\"" + item.FilePath + "\" download=\"" + item.FileName + "\">" + item.FileName + "</a>");
                                            //if (".swf.flv.mp4.rar.zip".toLowerCase().indexOf(hz.toLowerCase()) > -1)
                                            //    $("#filePath").html("<a href=\"" + item[0].FilePath + "\" download=\"" + item[0].FilePath + "\">" + item[0].FileName + "</a>");
                                            //else
                                            //    $("#filePath").html("<a href=\"javascript:FolderClick('" + item[0].FilePath + "');\">" + item[0].FileName + "</a>");
                                         
                                        }
                                    }
                                }
                            }
                        },
                        error: OnError
                    });
                }
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
                        NotItem: enumSystemType("咨询电话") + "," + enumSystemType("友情链接") + "," + enumSystemType("横幅图片"),
                        MenuId: $("#HMenuId").val()
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            $("#div_leftTree").html('');
                            var items = json.result.retData;
                            $("#hTitle").html(items[0].Name);
                            $("#menuPNav").html(items[0].Name);
                            var ary = [];
                            for (var i = 1; i < items.length; i++) {
                                ary.push(items[i]);
                            }
                            $("#tr_leftTree").tmpl(ary).appendTo("#div_leftTree");
                            if (ary != null) {
                                for (var i = 0; i < ary.length; i++) {
                                    if (ary[i].Id == $("#HMenuId").val()) {
                                        $("#menuNav").html(ary[i].Name);
                                        $(".tit").html(ary[i].Name);
                                        $(".english").html(ary[i].EnName);
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
                            //$("#Contents").load(result);
                            //var iframe = document.createElement("iframe");
                            //iframe.scrolling = "no";
                            //iframe.src = result;
                            //document.getElementById("Contents").appendChild(iframe);
                            var iframe = '<iframe id="contentFrame" name="contentFrame" scrolling="no" src="' + result + '" frameborder="0" style=" width: 100%;"></iframe>';
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
    </form>
</body>
</html>
