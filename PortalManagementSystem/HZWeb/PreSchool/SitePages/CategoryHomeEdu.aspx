<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryHomeEdu.aspx.cs" Inherits="PMSWeb.PreSchool.SitePages.CategoryHomeEdu" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
        <li><a href="/PreSchool/SitePages/NoticeView.aspx?id=${MenuId}&advId=${Id}&bgname=HomeEdu_bg" target="_blank" title="${Title}">${Title}</a></li>
    </script>
    <!--(教育理念、家长学校、家园互动)-图片滚动-->
    <script id="li_img_71" type="text/x-jquery-tmpl">
        <li><a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=HomeEdu_bg">
            <img src="${ImageUrl.split(',')[0]}" alt="" /><p class="detail">${NameLengthUpdate(Description,20)}</p>
        </a></li>
    </script>
    <!--与您相约(家长学校)-->
    <script id="li_71" type="text/x-jquery-tmpl">
        <li>
            <i></i>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=HomeEdu_bg" title="${Description}">${Description}</a>
            <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
        </li>
    </script>
    <!--点亮精彩(特色活动)-->
    <script id="li_72" type="text/x-jquery-tmpl">
        <li>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=HomeEdu_bg">
                <div class="img">
                    <img src="${ImageUrl.split(',')[0]}" alt="" />
                </div>
                <p>${Description}<span>${DateTimeConvert(CreateTime)}</span></p>
            </a>
        </li>
    </script>
    <!--育儿分享(家园互动)-->
    <script id="li_74" type="text/x-jquery-tmpl">
        {{if rowNum==1}}
        <li class="first clearfix">
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=HomeEdu_bg">
                <dl>
                    <dt>
                        <img src="${ImageUrl.split(',')[0]}">
                    </dt>
                    <dd>
                        <h2>${Description}</h2>
                        <p>${CreativeHTML.replace(/<[^>]+>/g,'')}</p>
                    </dd>
                </dl>
            </a>
        </li>
        {{else}}
        <li>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=HomeEdu_bg" title="${Description}">${Description}</a>
            <span>${DateTimeConvert(CreateTime)}</span>
        </li>
        {{/if}}
    </script>
    <!--生活广角(教育策略)-->
    <script id="li_70" type="text/x-jquery-tmpl">
        <li>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=HomeEdu_bg">
                <div class="img">
                    <img src="${ImageUrl.split(',')[0]}" alt="" />
                </div>
                <p>${Description}</p>
            </a>
        </li>
    </script>
    <!--家委会人员介绍(家长委员)-->
    <script id="li_73" type="text/x-jquery-tmpl">
        <li>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=HomeEdu_bg">
                <div class="img">
                    <img src="${ImageUrl.split(',')[0]}" alt="" />
                </div>
                <p>${Description}</p>
            </a>
        </li>
    </script>
    <!--友情链接-->
    <script id="li_75" type="text/x-jquery-tmpl">
        <li>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=HomeEdu_bg">
                <div class="img">
                    <img src="${ImageUrl.split(',')[0]}" />
                </div>
                <div class="content">
                    <h2>${Description}</h2>
                    <div>${CreativeHTML.replace(/<[^>]+>/g,'')}</div>
                </div>
            </a>
        </li>
    </script>
    <!--信箱-->
    <script id="li_76" type="text/x-jquery-tmpl">
        <h2>${Description}</h2>
        <p>
            {{html CreativeHTML}}
        </p>
    </script>
    <script>
        $(function () {
            $('#nav').load('/PreSchool/nav.html');
            $('#footer').load('/PreSchool/footer.html');
            $('#survey_wrap').load('/PreSchool/Survey.html');
        })
    </script>
</head>
<body id="HomeEdu_bg">
    <div id="HomeEdu_bgwrap">
        <header id="header">
            <div class="motto_logo clearfix center">
                <a class="logo fl" href="/PreschoolIndex.aspx">
                    <img src="/PreSchool/images/logo.png" />
                </a>
            </div>
            <nav id="nav"></nav>
        </header>
        <div id="content">
            <div class="notice_wrap">
                <span class="fl label">通知公告
                </span>
                <div class="notice">
                    <ul id="list_data"></ul>
                </div>
            </div>
            <div class="module clearfix">
                <div class="meet_banner fl">
                    <div class="slides">
                        <ul id="ul_img_71" psize="5" menuids="37,71,74" imgstr="yes" class="slide TwoLevelC"></ul>
                        <div class="num"><ul></ul></div>
                    </div>
                </div>
                <div class="meet_lists_wrap fr">
                    <div class="meet_lists">
                        <h1 class="title clearfix">
                            <div class="clear"></div>
                            <span></span>
                            <a href="/PreSchool/SitePages/BeforeItemList.aspx?id=71&bgname=HomeEdu_bg" target="_blank">更多</a>
                        </h1>
                        <div class="content">
                            <ul id="ul_71" psize="9" class="lists TwoLevelC"></ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="module clearfix pr" style="margin-top: 10px;">
                <div class="Brighten_wrap fl">
                    <div class="Brighten">
                        <div class="lists_img_wrap">
                            <h1 class="title">
                                <span></span>
                                <a href="/PreSchool/SitePages/BeforeList.aspx?id=72&bgname=HomeEdu_bg"  target="_blank">更多</a>
                            </h1>
                            <div class="lists_img_inner">
                                <div class="slider" id="scroll_72">
                                    <ul id="ul_72" psize="12" imgstr="yes" class="clearfix scroll TwoLevelC"></ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="email">
                    <h1 class="title">信箱</h1>
                    <div class="content TwoLevelC" id="ul_76"></div>
                </div>
            </div>
            <div class="module clearfix" style="margin-top: 10px;">
                <div class="module1 fl module2" style="margin-left: 10px;">
                    <h2 class="title">
                        <span class="fl title4">育儿分享</span>
                        <a href="/PreSchool/SitePages/BeforeItemList.aspx?id=74&bgname=HomeEdu_bg" class="fr"  target="_blank">更多</a>
                    </h2>
                    <div class="content">
                        <ul id="ul_74" psize="4" imgstr="yes" class="lists1 TwoLevelC"></ul>
                    </div>
                </div>
                <div class="lifewide fr">
                    <div class="lists_img">
                        <div class="lists_img_wrap">
                            <div class="lists_img_inner">
                                <h2 class="title7 pr">
                                    <span>生活广角
                                    </span>
                                    <a href="/PreSchool/SitePages/BeforeList.aspx?id=70&bgname=HomeEdu_bg"  target="_blank">更多</a>
                                </h2>
                                <div class="slider" id="scroll_70">
                                    <ul id="ul_70" psize="12" imgstr="yes" class="clearfix scroll TwoLevelC"></ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="module">
                <div class="pta_wrap">
                    <div class="pta">
                        <h1 class="title">
                            <span></span>
                            <a href="/PreSchool/SitePages/BeforeList.aspx?id=73&bgname=HomeEdu_bg"  target="_blank">更多</a>
                        </h1>
                        <div class="slider" id="scroll_73">
                            <ul id="ul_73" psize="24" imgstr="yes" class="clearfix scroll TwoLevelC"></ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="module mt15 lifewide linknew" style="width: auto;">
                <div class="lists_img">
                    <div class="lists_img_wrap">
                        <div class="lists_img_inner">
                            <h2 class="title7 pr">
                                <span>友情链接
                                </span>
                            </h2>
                            <div class="linkwrap">
                                <ul id="ul_75" psize="2" imgstr="yes" class="clearfix TwoLevelC"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer id="footer"></footer>
        <!--在线调查-->
        <div id="survey_wrap"></div>
    </div>
</body>

</html>



