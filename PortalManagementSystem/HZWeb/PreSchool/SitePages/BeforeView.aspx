<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeView.aspx.cs" Inherits="PMSWeb.PreSchool.SitePages.BeforeView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" />  
    <title>北京市昌平区财贸幼儿园</title>
    <link rel="stylesheet" href="/PreSchool/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/PreSchool/css/style.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/PreSchool/js/common.js"></script>
    <!--[if lt IE 9]><script src="/PreSchool/js/html5shiv.min.js"></script><![endif]-->
    <!--[if lte IE 8]><script src="/PreSchool/js/selectivizr-min.js"></script><![endif]-->
    <script src="/PreSchool/js/jquery.SuperSlide.2.1.1.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/PreSchool/js/sewise.player.min.js"></script>
    <script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
            {{if Id!=$("#HMenuId").val()}}
            <li>
                <a href="${BeforeUrl}" target="_self" class="">${Name}</a>
                <ul id="nav-${Id}"></ul>
            </li>
            {{else}}
            <li class="visited">
                <a href="${BeforeUrl}" target="_self" >${Name}</a>
                <ul id="nav-${Id}"></ul>
            </li>
            {{/if}}
        {{/if}}
    </script>
      <script type="text/x-jquery-tmpl" id="secnav_item">
	{{if Id!=$("#HMenuId").val()}}
        <li>
             <a href="${BeforeUrl}&loadid=${PId}" target="_self" class="">${Name}</a>
        </li>
	{{else}}
	<li class="visited">
            <a href="${BeforeUrl}&loadid=${PId}" target="_self" class="">${Name}</a>
        </li>
	{{/if}}
    </script>
    <script>
        $(function () {
            //获取地址栏背景图参数给页面赋值不同的参数
            var bgname = getQueryString("bgname");
            $('.bgname').attr('id', bgname);
            $('.wrap').attr('id', bgname + 'wrap');
            $('#hTitle').attr('class', bgname + 'h2');
            $('#div_leftTree').addClass(bgname + 'ul');
        })
       
    </script>
</head>
<body class="bgname">
    <div class="wrap">

    
    <form id="form1" runat="server">
        <asp:HiddenField ID="HMenuId" runat="server" />
        <asp:HiddenField ID="HAdvId" runat="server" />
        <asp:HiddenField ID="HSSId" runat="server" />
        
        
         <header id="header">
            <div class="motto_logo clearfix center">
                <a class="logo fl" href="/PreschoolIndex.aspx">
                    <img src="/PreSchool/images/logo.png" />
                </a>
            </div>
            <nav id="nav"></nav>
        </header>
        <div id="content" class="center clearfix">
            <div class="view_content clearfix">
                <div class="left_nav fl">
                    <div class="leftnav_inner">

                        <div class="clear"></div>
                    <h2 id="hTitle"></h2>
                    <div class="left_navcon">
                        <ul class="con_wenzi" id="div_leftTree">
                        </ul>
                    </div>
                        </div>
                </div>
                <div class="con_details fr">
                    <div class="entrancemore">
                        <div class="moretitle clearfix">
                            <a href="#" id="one_nav"></a>
                            <span>></span>
                            <a href="#" id="second_nav"></a>
                            <span>></span>
                            <a href="#" id="three_nav"></a>
                        </div>
                        <div class="content" style="padding-bottom:20px;">
                             <h2 class="tit_con" id="noticeTitle"></h2>
                            <h3 class="time">发布时间:<span id="timespan"></span>点击次数:<span id="clickspan"></span></h3>
                            <div class="content_text" id="Contents">
                
                            </div>
                            <div style="margin-top:10px;">
                                <span id="file"></span><span id="filePath"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
       <footer id="footer"></footer>
        <!--在线调查-->
        <div id="survey_wrap"></div>
    </form>
   </div>
    <script type="text/javascript">
        var advIdForMenuId;
        $(function () {            
            $('#nav').load('/PreSchool/nav.html');
            $('#footer').load('/PreSchool/footer.html');
            $('#survey_wrap').load('/PreSchool/Survey.html');            
            var loadid = getQueryString("loadid");
            if (loadid != null) {
                leftTree(loadid, "");
            }
            else {
                leftTree($("#HMenuId").val(),"");
            }
            initData();
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
                                    if (item.FilePath != null && item.FilePath != "" && item.FilePath.length > 0)
                                    {
                                        FolderOpend(item.FilePath);
                                    }
                                } else {
                                    $("#noticeTitle").html(item.Description);
                                    $("#Contents").html(item.CreativeHTML);
                                    
                                    var filepath = item.FilePath;
                                    if (filepath != null && filepath != "") {
                                        var extindex = filepath.lastIndexOf('.');
                                        var curtype = filepath.substring(extindex + 1).toLowerCase();
                                        if (curtype == "mp4" || curtype == "flv" || curtype == "ogg" || curtype == "webm")//视频文件
                                        {
                                            var isView = LimitView();
                                            if (isView == "ok") {
                                                var befurl = filepath.substring(0, extindex + 1);
                                                $("#Contents").append("<div style='width: 640px; height: 352px;margin:10px auto; ' id='playVideo'></div>");
                                                SewisePlayer.setup({
                                                    server: "vod",
                                                    type: curtype,
                                                    autostart: "false",
                                                    lang: 'zh_CN',
                                                    videourl: befurl + curtype,
                                                    skin: "vodFlowPlayer",
                                                    logo: "",
                                                    poster: befurl + "jpg",
                                                    claritybutton: "disable",
                                                    title: "",
                                                    fallbackurls: {
                                                        mp4: befurl + "mp4",
                                                        ogg: befurl + "ogg",
                                                        webm: befurl + "webm",
                                                    }
                                                }, "playVideo");
                                            }
                                        }
                                        else {
                                            if (item.FileName != null && item.FileName != "" && item.FileName.length > 0) {
                                                $("#file").html("附件：");
                                                var hzindex = item.FilePath.lastIndexOf(".");
                                                var hz = item.FilePath.substring(hzindex);
                                                $("#filePath").html("<a href=\"" + item.FilePath + "\" download=\"" + item.FileName + "\">" + item.FileName + "</a>");
                                                //if (".swf.flv.mp4.rar.zip".toLowerCase().indexOf(hz.toLowerCase()) > -1)
                                                //    $("#filePath").html("<a href=\"" + item.FilePath + "\" download=\"" + item.FileName + "\">" + item.FileName + "</a>");
                                                //else
                                                //    $("#filePath").html("<a href=\"javascript:FolderClick('" + item.FilePath + "');\">" + item.FileName + "</a>");
                                                //$("#filePath").html("<a href=\"javascript:FolderClick('" + item.FilePath + "');\">" + item.FileName + "</a>");
                                            }
                                        }
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
                                        $("#filePath").html("<a href=\"" + item[0].FilePath + "\" download=\"" + item[0].FilePath + "\">" + item[0].FileName + "</a>");
                                        //if (".swf.flv.mp4.rar.zip".toLowerCase().indexOf(hz.toLowerCase()) > -1)
                                        //    $("#filePath").html("<a href=\"" + item[0].FilePath + "\" download=\"" + item[0].FilePath + "\">" + item[0].FileName + "</a>");
                                        //else
                                        //    $("#filePath").html("<a href=\"javascript:FolderClick('" + item[0].FilePath + "');\">" + item[0].FileName + "</a>");
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


        function leftTree(menuid, pmenuid) {
            var func = "";
            if (menuid != "") func = "GetPortalTreeDataForChildId";
            if (pmenuid != "") func = "GetPortalTreeDataForParentId";
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: func,
                    BeforeAfterNot: "1",
                    MenuId: menuid

                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var isok = "";
                        $("#div_leftTree").html('');
                        var items = json.result.retData;
                        $("#tr_leftTree").tmpl(items).appendTo("#div_leftTree");
                        if (items != null) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].PId == "0") {
                                    $("#hTitle").html(items[i].Name);
                                    $("#one_nav").html(items[i].Name);
                                    $('#one_nav').attr('href', items[i].BeforeUrl)
                                }
                                if (items[i].Id == menuid) {
                                    $("#second_nav").html(items[i].Name);
                                    $("#second_nav").attr('href', items[i].BeforeUrl);
                                    isok = GetChildMenuForId(items[i].Id);
                                }

                                if (isok == "success") {
                                    $("#nav-" + items[i].Id).slideDown();
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
        function GetChildMenuForId(ID) {
            var isok = "";
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetChildMenuForId",
                    "Id": ID,
                    "IsDelete": 0,
                    "Display": 0
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#nav-" + ID).html();
                        var items = json.result.retData;
                        $('#three_nav').show();
                        $('#three_nav').prev().show();
                        if (items != null && items.length > 0) {
                            $("#secnav_item").tmpl(items).appendTo("#nav-" + ID);
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].Id == getQueryString('id')) {
                                    $("#three_nav").html(items[i].Name);
                                    $("#three_nav").attr('href', items[i].BeforeUrl);

                                }
                            }
                            isok = "success";
                        } 
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
            return isok;
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
            if (FileExt == "ppt" || FileExt == "pptx" || FileExt == "doc" || FileExt == "docx" || FileExt == "xls" || FileExt == "xlsx" || FileExt =="pdf") {
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
        function LimitView() {
            var isok = "";
            var LoginCookie_Cube = $.cookie('LoginCookie_Cube');
            if (LoginCookie_Cube != '' && LoginCookie_Cube != null && LoginCookie_Cube != undefined) {
                var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
                if (UserInfo != null) {
                    isok = "ok";
                }
            }
            return isok;
        }
    </script>    
</body>
</html>
