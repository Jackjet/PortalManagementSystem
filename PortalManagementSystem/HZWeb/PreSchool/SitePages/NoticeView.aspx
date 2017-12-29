<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoticeView.aspx.cs" Inherits="PMSWeb.PreSchool.SitePages.NoticeView" %>
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
    <script src="/PreSchool/js/common.js"></script>
    <!--[if lt IE 9]><script src="/PreSchool/js/html5shiv.min.js"></script><![endif]-->
    <!--[if lte IE 8]><script src="/PreSchool/js/selectivizr-min.js"></script><![endif]-->
    <script src="/PreSchool/js/jquery.SuperSlide.2.1.1.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
            {{if Id!=$("#HMenuId").val()}}
            <li>
            <a href="${BeforeUrl}" target="_self" class="">${Name}</a>
            </li>
            {{else}}
            <li class="visited">
            <a href="${BeforeUrl}" target="_self" >${Name}</a>
            </li>
            {{/if}}
        
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
                        </div>
                        <div class="content">
                             <h2 class="tit_con" id="noticeTitle"></h2>
                            <h3 class="time">发布时间:<span id="timespan"></span>点击次数:<span id="clickspan"></span></h3>
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
       <footer id="footer"></footer>
        <!--在线调查-->
        <div id="survey_wrap"></div>
    </form>
   </div>
    <script type="text/javascript">        
        $(function () {
            $('#nav').load('/PreSchool/nav.html');
            $('#footer').load('/PreSchool/footer.html');
            $('#survey_wrap').load('/PreSchool/Survey.html');            
            leftTree();
            addClickNumer();
        })

        function initData() {
            if ($("#HAdvId").val().length > 0) {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",                   
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/NoticesHandler.ashx",
                        "func": "GetNoticeInfo",
                        "Id": $("#HAdvId").val()
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            var item = json.result.retData;
                            if (item != null) {
                                $("#timespan").html(DateTimeConvert(item.CreateTime));
                                $("#clickspan").html(item.ClickNum);
                                $("#noticeTitle").html(item.Title);
                                $("#Contents").html(item.Contents);
                                if (item.FileName != null && item.FileName != "" && item.FileName.length > 0) {
                                    $("#file").html("附件：");
                                    var hzindex = item.FilePath.lastIndexOf(".");
                                    var hz = item.FilePath.substring(hzindex);
                                    $("#filePath").html("<a href=\"" + item.FilePath + "\" download=\"" + item.FileName + "\">" + item.FileName + "</a>");
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
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: "GetPortalTreeDataForChildId",
                    BeforeAfterNot: "1",
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
                                    $("#one_nav").html(items[i].Name);
                                    $('#one_nav').attr('href',items[i].BeforeUrl)
                                }
                                if (items[i].Id == $("#HMenuId").val()) {
                                    $("#second_nav").html(items[i].Name);
                                    $("#second_nav").attr('href',items[i].BeforeUrl);

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
                    dataType: "json",
                    data: { PageName: "DYYX/NoticesHandler.ashx", Func: "UpdateNotice", Id: $("#HAdvId").val(), ClickNum: "1" },
                    success: function (json) {
                        initData();
                    },
                    error: function (errMsg) {

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
    </script>    
</body>
</html>