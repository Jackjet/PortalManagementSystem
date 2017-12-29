<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryDeveEdu.aspx.cs" Inherits="PMSWeb.PreSchool.SitePages.CategoryDeveEdu" %>

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
        <script src="/Scripts/layer/layer.js"></script>
        <script src="/PreSchool/js/common.js"></script>
        <script src="/Scripts/jquery.tmpl.js"></script>
         <script src="TwoLevelCommon.js"></script>
        <!--通知公告-->
        <script id="item_data" type="text/x-jquery-tmpl">
            <li><a href="/PreSchool/SitePages/NoticeView.aspx?id=${MenuId}&advId=${Id}&bgname=DeveEdu_bg" target="_blank" title="${Title}">${Title}</a></li>
        </script>
        <!--运动小明星-->
        <script id="li_114" type="text/x-jquery-tmpl">
             <li>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=DeveEdu_bg" target="_blank">
                    <div class="img">
                        <img src="${ImageUrl.split(',')[0]}" alt="" />
                    </div>
                    <p>${Description}</p>
                </a>
            </li>
        </script>
        <!--故事大王-->
        <script id="li_116" type="text/x-jquery-tmpl">
            <li>
                <i></i>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=DeveEdu_bg" title="${Description}">${Description}</a>
                {{if rowNum<3}}<em>new</em>{{/if}}
				<span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
            </li>
        </script>
         <!--小小音乐家-->
        <script id="li_118" type="text/x-jquery-tmpl">
            {{if rowNum==1}}
            <li class="first clearfix">
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=DeveEdu_bg">
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
                    <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=DeveEdu_bg" title="${Description}">${Description}</a>
                    <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
                </li>
            {{/if}}
        </script>
         <!--小手这能干-->
        <script id="li_117" type="text/x-jquery-tmpl">
            <li>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=DeveEdu_bg">
                    <div class="img">
                        <img src="${ImageUrl.split(',')[0]}" alt="" />
                    </div>
                    <p>${Description}</p>
                </a>
            </li>
        </script>
        <%-- 小小接待员 --%>
        <script id="li_115" type="text/x-jquery-tmpl">
            <li>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=DeveEdu_bg" target="_blank">
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
	<body id="DeveEdu_bg">
        <div id="DeveEdu_bgwrap">
		<header id="header">
			<div class="motto_logo clearfix center">
				<a class="logo fl" href="/PreschoolIndex.aspx">
					<img src="/PreSchool/images/logo.png"/>
				</a>
			</div>
			<nav id="nav"></nav>
		</header>
		<div id="content" style="padding-top:15px;">
			<div class="notice_wrap">
				<span class="fl label">
					通知公告
				</span>
				<div class="notice">
                    <ul id="list_data">
                    	 
                    </ul>
                </div>
			</div>
            <div class="module clearfix mt25">
                <div class="sport_starswrap fl">
                    <div class="sport_stars">
                        <h1 class="title">
                            <span class="fl">
                                <i></i>
                            </span>
                            <a href="/PreSchool/SitePages/BeforeList.aspx?id=114&bgname=DeveEdu_bg" class="fr"  target="_blank">
                                <i>更多</i>
                            </a>
                        </h1>
                        <div class="content" id="scroll_114">
                            <ul class="clearfix scroll TwoLevelC" id="ul_114" psize="24" imgstr="yes">
                                
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="StoryKing fr">
                    <h1 class="title clearfix">
                        <span class="fl">
							故事大王
						</span>
                        <div></div>
                        <a href="/PreSchool/SitePages/BeforeItemList.aspx?id=116&bgname=DeveEdu_bg" class="fr"  target="_blank">
                            更多
                        </a>
                    </h1>
                    <div class="content">
                        <ul class="lists TwoLevelC" id="ul_116" psize="7">
							
						</ul>
					</div>
                </div>
            </div>
		    <div class="module clearfix mt15">
                <div class="musician fl">
                    <h1 class="title">
                        小小音乐家
                        <a class="more fr" href="/PreSchool/SitePages/BeforeItemList.aspx?id=118&bgname=DeveEdu_bg" target="_blank">更多</a>
                    </h1>
                    <div class="content">
                        <ul class="lists1 TwoLevelC" id="ul_118" psize="5" imgstr="yes">
                            
						</ul>
                    </div>
                </div>
                <div class="shou_wrap fr">
                    <div class="shou">
                        <div class="lists_img_wrap">
                            <h1 class="title">
                                <span></span>
                                <a href="/PreSchool/SitePages/BeforeList.aspx?id=117&bgname=DeveEdu_bg">更多</a>
                            </h1>
                            <div class="clear"></div>
                            <div class="lists_img_inner">
                                <div class="slider" id="scroll_117">
                                    <ul class="clearfix scroll TwoLevelC" psize="12" imgstr="yes"  id="ul_117">
                                        
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="hu"></div>
                </div>
            </div>
            <div class="module clearfix mt15">
                <div class="destclerk_wrap">
                    <div class="destclerk">
                        <h1 class="title">
                            <span class="fl">
                                <i>小小接待员</i>
                            </span>
                            <a href="/PreSchool/SitePages/BeforeList.aspx?id=115&bgname=DeveEdu_bg" class="fr"  target="_blank">
                                <i>更多</i>
                            </a>
                        </h1>
                        <div class="content" id="scroll_115">
                            <ul class="clearfix scroll TwoLevelC" psize="24" imgstr="yes"  id="ul_115">
                               
                            </ul>
                        </div>
                    </div>
                    <div class="panada"></div>
                </div>
            </div>
        </div>
        <footer id="footer"></footer>
		<!--在线调查-->
        <div id="survey_wrap"></div>
            </div>
	</body>
	<script>
	    
	</script>
</html>



