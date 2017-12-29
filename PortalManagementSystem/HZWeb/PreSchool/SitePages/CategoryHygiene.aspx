<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryHygiene.aspx.cs" Inherits="PMSWeb.PreSchool.SitePages.CategoryHygiene" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" />
    <title>北京市昌平区财贸幼儿园</title>
    <link rel="stylesheet" href="/PreSchool/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/PreSchool/css/style.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <!--[if lt IE 9]><script src="/PreSchool/js/html5shiv.min.js"></script><![endif]-->
    <!--[if lte IE 8]><script src="/PreSchool/js/selectivizr-min.js"></script><![endif]-->
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="TwoLevelCommon.js"></script>
    <script src="/PreSchool/js/jquery.SuperSlide.2.1.1.js"></script>
    <script src="/PreSchool/js/common.js"></script>
    <!--通知公告-->
    <script id="item_data" type="text/x-jquery-tmpl">
        <li><a href="/PreSchool/SitePages/NoticeView.aspx?id=${MenuId}&advId=${Id}&bgname=hygiene_bg" target="_blank" title="${Title}">${Title}</a></li>
    </script>
    <!--卫生保健工作动态-->
    <script id="li_68" type="text/x-jquery-tmpl">
        <li>
            <i></i>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=hygiene_bg" title="${Description}">${Description}</a>
        </li>
    </script>
    <!--活动剪影-->
    <script id="li_69" type="text/x-jquery-tmpl">
        <li>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=hygiene_bg">
                <div class="img">
                    <img src="${ImageUrl.split(',')[0]}" alt="" />
                </div>
                <p>${Description}</p>
            </a>
        </li>
    </script>
    <script>
        $(function () {
            $('#nav').load('/PreSchool/nav.html');
            $('#footer').load('/PreSchool/footer.html');
            $('#survey_wrap').load('/PreSchool/Survey.html');
        })
    </script>
</head>
<body id="hygiene_bg">
    <div id="hygiene_bgwrap">
        <header id="header">
            <div class="motto_logo clearfix center">
                <a class="logo fl" href="/PreschoolIndex.aspx">
                    <img src="/PreSchool/images/logo.png" />
                </a>
            </div>
            <nav id="nav"></nav>
        </header>
        <div class="hygiene_content">
            <div class="notice_wrap">
                <span class="fl label">通知公告</span>
                <div class="notice">
                    <ul id="list_data"></ul>
                </div>
            </div>
            <div class="module clearfix">
                <div class="recipe fl">
                    <h1 class="title">宝宝食谱</h1>
                    <div class="content clearfix">
                        <a href="/PreSchool/SitePages/BeforeList.aspx?id=31&bgname=hygiene_bg" class="hygiene-01"  target="_blank">
                            <span>宝宝食谱</span>
                        </a>
                        <a href="/PreSchool/SitePages/BeforeList.aspx?id=64&bgname=hygiene_bg" class="hygiene-02"  target="_blank">
                            <span>特色菜品</span>
                        </a>
                        <a href="/PreSchool/SitePages/BeforeList.aspx?id=65&bgname=hygiene_bg" class="hygiene-03"  target="_blank">
                            <span>饮食指南</span>
                        </a>
                    </div>
                </div>
                <div class="knowledge fl">
                    <h1 class="title">育儿知识
                        
                    </h1>
                    <div class="content">
                        <a href="/PreSchool/SitePages/BeforeList.aspx?id=67&bgname=hygiene_bg" class="knowledge-01"  target="_blank">防病知识</a>
                        <a href="/PreSchool/SitePages/BeforeList.aspx?id=66&bgname=hygiene_bg" class="knowledge-02"  target="_blank">日常护理</a>
                    </div>
                </div>
                <div class="hygiene_news fr">
                    <h1 class="title">卫生保健工作动态</h1>
                    <div class="content">
                        <ul id="ul_68" psize="9" class="lists TwoLevelC"></ul>

                    </div>
                </div>
            </div>
            <div class="module caipin clearfix">
                <div class="lists_img">
                    <div class="lists_img_wrap">
                        <div class="lists_img_inner">
                            <h2 class="title3">
                                <span>活动剪影</span>
                                <a href="/PreSchool/SitePages/BeforeList.aspx?id=69&bgname=hygiene_bg"  target="_blank">更多
										<img src="/PreSchool/images/mao.png" alt="" />
                                </a>
                            </h2>
                            <div class="slider" id="scroll_69">
                                <ul id="ul_69" psize="15" imgstr="yes" class="clearfix scroll TwoLevelC"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer id="footer"></footer>
        <!--在线调查-->
        <div id="survey_wrap">
        </div>
    </div>
</body>

</html>

