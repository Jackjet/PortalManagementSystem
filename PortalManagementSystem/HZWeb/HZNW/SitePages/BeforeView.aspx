<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeView.aspx.cs" Inherits="PMSWeb.HZNW.SitePages.BeforeView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title>黄庄职业高中</title>
    <link href="/HZNW/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="/HZNW/css/layout.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/HZNW/js/jquery.SuperSlide.2.1.1.js"></script>
    <style type="text/css">
        .game163 {
            position: relative;
            border: 1px solid #dcdddd;
            padding: 4px;
            overflow: hidden;
            width: 745px;
        }

            .game163 .bigImg {
                height: 350px;
                position: relative;
            }

                .game163 .bigImg li a {
                    vertical-align: middle;
                    width: 745px;
                    height: 450px;
                    overflow:hidden;
                    display:block;
                }
                .game163 .bigImg li a img{width:100%;}
                .game163 .bigImg h4 {
                    font-size: 14px;
                    font-weight: bold;
                    line-height: 33px;
                    height: 33px;
                    padding-right: 30px;
                    overflow: hidden;
                    text-align: left;
                }

            .game163 .smallScroll {
                height: 120px;
                margin-bottom: 6px;
            }

            .game163 .sPrev, .game163 .sNext {
                float: left;
                display: block;
                width: 14px;
                height: 47px;
                margin-top: 32px;
                text-indent: -9999px;
                background: url(/HZNW/images/sprites1008.png) no-repeat 0 -3046px;
            }

            .game163 .sNext {
                background-position: 0 -2698px;
            }

            .game163 .sPrev:hover {
                background-position: 0 -3133px;
            }

            .game163 .sNext:hover {
                background-position: 0 -2785px;
            }

            .game163 .smallImg {
                float: left;
                margin: 0 6px;
                display: inline;
                width: 705px;
                overflow: hidden;
            }

                .game163 .smallImg ul {
                    height: 123px;
                    width: 9999px;
                    overflow: hidden;
                }

                .game163 .smallImg li {
                    float: left;
                    padding: 0 4px 0 0;
                    width: 173px;
                    cursor: pointer;
                    display: inline;
                }

                .game163 .smallImg a {
                    border: 1px solid #dcdddd;
                    width: 173px;
                    height: 120px;
                    overflow:hidden;
                    display:block;
                }
                 .game163 .smallImg a img{width:100%;}
                .game163 .smallImg .on img {
                    border-color: #1e50a2;
                }

            .game163 .pageState {
                position: absolute;
                top: 450px;
                right: 5px;
                font-family: "Times New Roman", serif;
                letter-spacing: 1px;
            }

                .game163 .pageState span {
                    color: #f00;
                    font-size: 16px;
                }
    </style>
    <script>
        $(function () {
            $('#header').load('/HZNW/Header.aspx');

        })
    </script>
    <script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
       {{if Id!=$("#HMenuId").val()}}
           <li> <a href="${BeforeUrl}" target="_self" class="">${Name}</a></li>
            {{else}}
             <li class="visited"><a href="${BeforeUrl}" target="_self" >${Name}</a></li>
            {{/if}}
        
        {{/if}}
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HMenuId" runat="server" />
        <asp:HiddenField ID="HAdvId" runat="server" />
        <asp:HiddenField ID="HSSId" runat="server" />

        <div>
            <div id="header" style="min-height: 340px;"></div>
            <div class="clear"></div>
            <div class="center">
                <div class="centercontent">
                    <div class="center_con main" style="width: 1000px">
                        <div class="maintopLeft" style="float: left;">
                            <div class="left_nav">
                                <h2 id="hTitle">德育在线</h2>
                                <div class="left_navcon">
                                    <ul class="con_wenzi" id="div_leftTree">
                                    </ul>
                                </div>
                                <div class="footer"></div>
                            </div>
                        </div>
                        <div class="maintopRight">
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
            </div>
            <iframe name="htmlHeader" src="/HZNW/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="92px"></iframe>
            <div id="dialog_img" style="display:none;">
                 <div class="game163" style="margin: 0 auto">
                    <ul class="bigImg" id="ultop">
                    </ul>
                    <div class="smallScroll">
                        <a class="sPrev" href="javascript:void(0)">←</a>
                        <div class="smallImg">
                            <ul id="uldown">
                            </ul>
                        </div>
                        <a class="sNext" href="javascript:void(0)">→</a>
                    </div>
                    <div class="pageState"></div>
                </div>
            </div>
        </div>
    </form>
    <script>
        //如果发布内容里有图片,
        function ImgList() {
            var imgs = $('#Contents img');
            if (imgs.length > 0) {
                var  index = 0;
                $(imgs).each(function () {
                    var ImgLi = '<li><a href="javascript:;"><img  src="' + $(this).attr('src') + '"/></a></li>';
                    $('#ultop').append(ImgLi);
                    $('#uldown').append(ImgLi);
                    $(this).click(function () {
                        index = $(this).index();
                        layer.open({
                            type: 1,
                            area: ['800px', '650px'], //宽高
                            content: $('#dialog_img').html()
                        });
                        jQuery(".game163").slide({
                            titCell: ".smallImg li",
                            mainCell: ".bigImg",
                            effect: "fold",
                            defaultIndex: index,
                            autoPlay: true,
                            delayTime: 200,
                            startFun: function (i, p) {
                                //控制小图自动翻页
                                if (i == 0) { jQuery(".game163 .sPrev").click() } else if (i % 4 == 0) { jQuery(".game163 .sNext").click() }
                            }
                        });
                        //小图左滚动切换
                        jQuery(".game163 .smallScroll").slide({ defaultIndex: index, mainCell: "ul", delayTime: 100, vis: 4, scroll: 4, effect: "left", autoPage: true, prevCell: ".sPrev", nextCell: ".sNext", pnLoop: false });
                    })
                })            
            }
        }
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
            //$("#htmlHeader").load("/Portal/headerTop.html");
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
                                    ImgList();
                                    if (item.FileName != null && item.FileName != "" && item.FileName.length > 0) {
                                        $("#file").html("附件：");
                                        var hzindex = item.FilePath.lastIndexOf(".");
                                        var hz = item.FilePath.substring(hzindex);
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
                                if (item.ModelType == 1) {
                                    if (item.FilePath != null && item.FilePath != "" && item.FilePath.length > 0) {
                                        FolderOpend(item.FilePath);
                                    }
                                } else {
                                    $("#noticeTitle").html(item.Title);
                                    $("#Contents").html(item.Description);
                                    ImgList();
                                    if (item.FileName != null && item.FileName != "" && item.FileName.length > 0) {
                                        $("#file").html("附件：");
                                        var hzindex = item.FilePath.lastIndexOf(".");
                                        var hz = item.FilePath.substring(hzindex);
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
                                        var hzindex = item[0].FilePath.lastIndexOf(".");
                                        var hz = item[0].FilePath.substring(hzindex);
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
                                }
                                if (items[i].Id == $("#HMenuId").val()) {
                                    $("#menuNav").html(items[i].Name);
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
