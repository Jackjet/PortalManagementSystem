<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeView.aspx.cs" Inherits="PMSWeb.YQZJ.Sitepages.BeforeView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
		<title>延庆县职业技术教育中心</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
		<link rel="stylesheet" href="/YQZJ/css/reset.css" />
		<link rel="stylesheet" href="/YQZJ/css/layout.css" />
		<script src="/Scripts/jquery-1.11.2.min.js"></script>
        <script src="/Scripts/Common.js"></script>
        <script src="/YQZJ/js/common.js"></script>
        <script src="/Scripts/jquery.tmpl.js"></script>
        <script src="/Scripts/layer/layer.js"></script>
		<script type="text/javascript">
		    $(function () {
		        $("#header").load('/YQZJ/Header.aspx');
		        $('#footer').load('/YQZJ/bottom.aspx');
		    });
		</script>
        <script id="tr_leftTree" type="text/x-jquery-tmpl">
            {{if PId!=0}}
            {{if Id!=$("#HMenuId").val()}}
                <li><a href="${BeforeUrl}" target="_self" title="${Name}">${Name}</a></li>
                {{else}}
                <li class="visited"><a href="${BeforeUrl}" target="_self" title="${Name}">${Name}</a>
                {{/if}}
            </li>
            {{/if}}
        </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HiddenField ID="HMenuId" runat="server" />
        <asp:HiddenField ID="HAdvId" runat="server" />
        <asp:HiddenField ID="HSSId" runat="server" />
         <div id="header" style="min-height:242px;"></div>
        <div class="wrap_center">
		<div class="centercontent">
  			<div class="center_con main clearfix" id="initheight">
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
					<div class="sy_xxk_cy_bg">
						<div class="con_details">
                            <h2 class="tit_con" id="noticeTitle"></h2>
                            <h3 class="time">发布时间:<span id="timespan"></span>    点击次数:<span id="clickspan"></span></h3>
                            <div class="content_text" id="Contents">
                            </div>
                            <div style="margin:10px 0px;">
                                <span id="file"></span><span id="filePath"></span>
                            </div>
                        </div> 
    				</div>					
				</div>
			</div>
		</div>
        </div>
		<div id="footer"  style="height:44px;"></div>
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
                                        $("#filePath").html("<a href=\"" + item.FilePath.replace(",", "") + "\" download=\"" + item.FileName.replace(",", "") + "\">" + item.FileName.replace(",", "") + "</a>");



                                        //if (".swf.flv.mp4.rar.zip".toLowerCase().indexOf(hz.toLowerCase()) > -1)
                                        //    $("#filePath").html("<a href=\"" + item.FilePath.replace(",", "") + "\" download=\"" + item.FileName.replace(",", "") + "\">" + item.FileName + "</a>");
                                        //else
                                        //    $("#filePath").html("<a href=\"javascript:FolderClick('" + item.FilePath.replace(",", "") + "');\">" + item.FileName.replace(",", "") + "</a>");
                                        //$("#filePath").html("<a href=\"javascript:FolderClick('" + item.FilePath + "');\">" + item.FileName + "</a>");
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
                                        if (".swf.flv.mp4.rar.zip".toLowerCase().indexOf(hz.toLowerCase()) > -1)
                                            $("#filePath").html("<a href=\"" + item.FilePath + "\" download=\"" + item.FileName + "\">" + item.FileName + "</a>");
                                        else
                                            $("#filePath").html("<a href=\"javascript:FolderClick('" + item.FilePath + "');\">" + item.FileName + "</a>");
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
                                        if (".swf.flv.mp4.rar.zip".toLowerCase().indexOf(hz.toLowerCase()) > -1)
                                            $("#filePath").html("<a href=\"" + item[0].FilePath + "\" download=\"" + item[0].FilePath + "\">" + item[0].FileName + "</a>");
                                        else
                                            $("#filePath").html("<a href=\"javascript:FolderClick('" + item[0].FilePath + "');\">" + item[0].FileName + "</a>");
                                        //$("#filePath").html("<a href=\"javascript:FolderClick('" + item[0].FilePath + "');\">" + item[0].FileName + "</a>");
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
                    MenuId: $("#HMenuId").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#div_leftTree").html('');
                        var items = json.result.retData;
                        $("#hTitle").html(items[0].Name);
                        $("#menuPNav").html(items[0].Name);
                        var ary = items.slice(1);
                        $("#tr_leftTree").tmpl(ary).appendTo("#div_leftTree");
                        if (items != null && items != '') {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].Id == $("#HMenuId").val()) {
                                    $("#menuNav").html(items[i].Name);
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
</body>
</html>
