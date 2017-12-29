<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryTeachEdu.aspx.cs" Inherits="PMSWeb.PreSchool.SitePages.CategoryTeachEdu" %>

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
        <li><a href="/PreSchool/SitePages/NoticeView.aspx?id=${MenuId}&advId=${Id}&bgname=TeachEdu_bg" target="_blank" title="${Title}">${Title}</a></li>
    </script>
    <!--新闻之窗(师德培训、理论培训、外出学习、艺术培训)-图片滚动-->
    <script id="li_78" type="text/x-jquery-tmpl">
        <li><a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=TeachEdu_bg">
            <img src="${ImageUrl.split(',')[0]}" alt="" /><p class="detail">${Description}</p>
            </a>
        </li>
    </script>
    <!--新闻之窗(师德培训、理论培训、外出学习、艺术培训)-->
    <script id="li_77" type="text/x-jquery-tmpl">
        <li>
            <i></i>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=TeachEdu_bg" title="${Description}">${Description}</a>
            {{if rowNum<3}}<em>new</em>{{/if}}
			<span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
        </li>
    </script>
    <!--教您一招(技能展示)-图片滚动-->
    <script id="li_img_81" type="text/x-jquery-tmpl">
        <li><a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=TeachEdu_bg">
            <img src="${ImageUrl.split(',')[0]}" alt="" /><p class="detail"></p>
            </a>
        </li>
    </script>
    <!--教您一招(技能展示)-->
    <script id="li_81" type="text/x-jquery-tmpl">
        <li>
            <i></i>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=TeachEdu_bg" title="${Description}">${Description}</a>
            <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
        </li>
    </script>
    <!--热点推送-->
    <script id="li_84" type="text/x-jquery-tmpl">
        {{if rowNum==1}}
           <li class="first clearfix">
               <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=TeachEdu_bg">
                   <dl>
                       <dt>
                           <img src="${ImageUrl.split(',')[0]}" />
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
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=TeachEdu_bg" title="${Description}">${Description}
                </a>
                <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
            </li>
        {{/if}}
    </script>
    <!--至理名言-->
    <script id="li_86" type="text/x-jquery-tmpl">
        <li>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=TeachEdu_bg" title="${Description}">${Description}</a>
            <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
        </li>
    </script>
    <!--培训预告-->
    <script id="li_85" type="text/x-jquery-tmpl">
        <li>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=TeachEdu_bg" title="${Description}">${Description}</a>
            <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
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
<body id="TeachEdu_bg">
    <div id="TeachEdu_bgwrap">

   
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
            <div class="edunew_banner fl">
                <div class="slides">
                    <ul id="ul_78" psize="5" menuids="77,78,79,80" imgstr="yes" class="slide TwoLevelC"></ul>
                    <div class="num">
                        <ul></ul>
                    </div>
                </div>
            </div>
            <div class="edunew_lists fr">
                <h1 class="title">
                    <span class="fl">新闻之窗</span>
                    
                </h1>
                <div class="content">
                    <ul id="ul_77" psize="10" menuids="77,78,79,80" class="lists TwoLevelC"></ul>
                </div>
            </div>
        </div>
        <div class="module clearfix mt15">
            <div class="teached fl">
                <h1 class="title">
                    <span class="fl">教您一招</span>
                    <a href="/PreSchool/SitePages/BeforeItemList.aspx?id=81&bgname=TeachEdu_bg" class="fr" target="_blank">更多</a>
                </h1>
                <div class="content clearfix">
                    <div class="teached_banner fl">
                        <div class="slides">
                            <ul id="ul_img_81" psize="5" imgstr="yes" class="slide TwoLevelC"></ul>
                            <div class="num">
                                <ul></ul>
                            </div>
                        </div>
                    </div>
                    <ul id="ul_81" psize="8" class="lists fr TwoLevelC"></ul>
                </div>
            </div>
            <div class="fr hot">
                <h2 class="title">热点推送
                </h2>
                <div class="content">
                    <ul id="ul_84" psize="4" class="lists1 TwoLevelC"></ul>
                </div>
            </div>
        </div>
        <div class="module clearfix mt15">
            <div class="logion fl">
                <h1 class="title">至理名言
					<a class="more fr" href="/PreSchool/SitePages/BeforeItemList.aspx?id=86&bgname=TeachEdu_bg">更多</a>
                </h1>
                <div class="content">
                    <ul id="ul_86" psize="6" class="lists TwoLevelC"></ul>
                </div>
            </div>
            <div class="Train fr">
                <h1 class="title">培训预告
                </h1>
                <div class="content">
                    <ul id="ul_85" psize="6" class="lists1 TwoLevelC"></ul>
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


