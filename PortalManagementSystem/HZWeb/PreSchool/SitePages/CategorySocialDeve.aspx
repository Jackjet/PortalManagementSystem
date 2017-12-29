<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategorySocialDeve.aspx.cs" Inherits="PMSWeb.PreSchool.SitePages.CategorySocialDeve" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta name="renderer" content="webkit" /> 
		<title>北京市昌平区财贸幼儿园</title>
		<link rel="stylesheet" href="/PreSchool/css/reset.css" />
		<link rel="stylesheet" type="text/css" href="/PreSchool/css/style.css"/>
		<script src="/Scripts/jquery-1.11.2.min.js"></script>
		 <script src="/Scripts/Common.js"></script>
		<!--[if lt IE 9]><script src="/PreSchool/js/html5shiv.min.js"></script><![endif]-->
		<!--[if lte IE 8]><script src="/PreSchool/js/selectivizr-min.js"></script><![endif]-->
		<script src="/PreSchool/js/jquery.SuperSlide.2.1.1.js"></script>
        <script src="/PreSchool/js/common.js"></script>
        <script src="/Scripts/layer/layer.js"></script>
        <script src="/Scripts/jquery.tmpl.js"></script>
        <script src="TwoLevelCommon.js"></script>
        <!--通知公告-->
        <script id="item_data" type="text/x-jquery-tmpl">
            <li><a href="/PreSchool/SitePages/NoticeView.aspx?id=${MenuId}&advId=${Id}&bgname=SocialDeve_bg" target="_blank" title="${Title}">${Title}</a></li>
        </script>
        <!--精彩活动-图片滚动-->
        <script id="li_img_98" type="text/x-jquery-tmpl">
            <li><a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=SocialDeve_bg">
                <img src="${ImageUrl.split(',')[0]}" alt="" /><p class="detail">${NameLengthUpdate(Description,20)}</p>
            </a></li>
        </script>
        <!--通知公告-->
        <script id="li_100" type="text/x-jquery-tmpl">
            <li>
                <i></i>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=SocialDeve_bg" title="${Description}">${Description}</a>
                {{if rowNum<3}}<em>new</em>{{/if}}
				<span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
            </li>
        </script>
        <!--亲子瞬间-->
        <script id="li_101" type="text/x-jquery-tmpl">
            <li>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=SocialDeve_bg">
                    <div class="img">
                        <img src="${ImageUrl.split(',')[0]}" alt="" />
                    </div>
                    <p>${Description}</p>
                </a>
            </li>
        </script>
        <!--早教基地介绍(早教介绍)-->
        <script id="li_36" type="text/x-jquery-tmpl">
            <h1 class="title">
                早教基地介绍
				<a class="more fr" href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&bgname=SocialDeve_bg">更多</a>
            </h1>
            <div class="content">
                <p>${CreativeHTML.replace(/<[^>]+>/g,'')}</p>
            </div>
        </script>
        <!--新闻动态(精彩活动)-->
        <script id="li_98" type="text/x-jquery-tmpl">
            {{if rowNum==1}}
            <li class="first clearfix">
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=SocialDeve_bg">
                    <dl>
                        <dt>
                            <img src="${ImageUrl.split(',')[0]}"></dt>
                        <dd>
                            <h2>${Description}</h2>
                            <p>${CreativeHTML.replace(/<[^>]+>/g,'')}</p>
                        </dd>
                    </dl>
                </a>
            </li>
            {{else}}
				<li>
                    <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=SocialDeve_bg" title="${Description}">${Description}</a>
                    <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
                </li>
            {{/if}}
        </script>
        <!--育儿小百科(卫生保健)-->
        <script id="li_96" type="text/x-jquery-tmpl">
            {{if rowNum==1}}
            <li class="first clearfix">
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=SocialDeve_bg">
                    <dl>
                        <dt>
                            <img src="${ImageUrl.split(',')[0]}"></dt>
                        <dd>
                            <h2>${Description}</h2>
                            <p>${CreativeHTML.replace(/<[^>]+>/g,'')}</p>
                        </dd>
                    </dl>
                </a>
            </li>
            {{else}}
				<li>
                    <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=SocialDeve_bg" title="${Description}">${Description}</a>
                    <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
                </li>
            {{/if}}
        </script>
		<script>
		    $(function () {
		        $('#nav').load('/PreSchool/nav.html');
		        $('#footer').load('/PreSchool/footer.html');
		        $('#survey_wrap').load('/PreSchool/Survey.html');
		    })
		</script>
	</head>
	<body id="SocialDeve_bg">
        <div id="SocialDeve_bgwrap">
		<header id="header">
			<div class="motto_logo clearfix center">
				<a class="logo fl" href="/PreschoolIndex.aspx">
					<img src="/PreSchool/images/logo.png"/>
				</a>
			</div>
			<nav id="nav"></nav>
		</header>
		<div id="content">
			<div class="notice_wrap">
				<span class="fl label">
					通知公告
				</span>
				<div class="notice">
                    <ul id="list_data"></ul>
                </div>
			</div>
            <div class="module clearfix">
                <div class="edunew_banner fl social_banner">
                    <div class="slides">
						<ul id="ul_img_98" psize="5" imgstr="yes" class="slide TwoLevelC"></ul>
	                    <div class="num">
	                        <ul></ul>
	                    </div>
					</div>
                </div>
                <div class="edunew_lists fr social_lists">
                    <h1 class="title">
						<span class="fl">
							通知公告
						</span>
						<a href="/PreSchool/SitePages/BeforeItemList.aspx?id=100&bgname=SocialDeve_bg" class="fr" target="_blank">更多</a>
					</h1>
                    <div class="content">
						<ul id="ul_100" psize="10" class="lists TwoLevelC"></ul>
					</div>
                </div>
            </div>
		    <div class="module clearfix mt25">
                <div class="Parentmoment_wrap fl">
                    <div class="Parentmoment">
                        <h1 class="title">
                            <span>亲子瞬间</span>
                            <a href="/PreSchool/SitePages/BeforeList.aspx?id=101&bgname=SocialDeve_bg" target="_blank">更多</a>
                        </h1>
                        <div class="lists_img_inner">
                            <div class="slider" id="scroll_101">
                                <ul id="ul_101" psize="12" imgstr="yes" class="clearfix scroll TwoLevelC"></ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="ul_36" psize="1" class="fr deve_intro TwoLevelC"></div>
            </div>
            <div class="module clearfix mt15">
                <div class="logion fl news_dontai">
                    <h1 class="title">
						新闻动态
						<a class="more fr" href="/PreSchool/SitePages/BeforeItemList.aspx?id=98&bgname=SocialDeve_bg"  target="_blank">更多</a>
					</h1>
                    <div class="content">
                        <ul id="ul_98" psize="6" imgstr="yes" class="lists1 TwoLevelC"></ul>
                    </div>
                </div>
                <div class="Train fr smallbai">
                    <h1 class="title">
						育儿小百科
					</h1>
                    <div class="content">
                        <ul id="ul_96" psize="5" imgstr="yes" class="lists1 TwoLevelC"></ul>
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


