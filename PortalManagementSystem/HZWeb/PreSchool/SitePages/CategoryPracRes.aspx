<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryPracRes.aspx.cs" Inherits="PMSWeb.PreSchool.SitePages.CategoryPracRes" %>

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
            <li><a href="/PreSchool/SitePages/NoticeView.aspx?id=${MenuId}&advId=${Id}&bgname=PracRes_bg" target="_blank" title="${Title}">${Title}</a></li>
        </script>
        <!--教学活动-->
        <script id="li_107" type="text/x-jquery-tmpl">
            <li>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=PracRes_bg" target="_blank" title="${Description}">
                    <img src="${ImageUrl.split(',')[0]}" alt="" /><p class="detail">${Description}</p>
                </a>
            </li>
        </script>
        <!--课件资源(经典教案、课例研究)-->
        <script id="li_103" type="text/x-jquery-tmpl">
            <li>
                <i></i>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=PracRes_bg" title="${Description}">${Description}</a>
                {{if rowNum<3}}<em>new</em>{{/if}}
			    <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
            </li>
        </script>
        <!--<!--启迪智慧(活动研究)-图片滚动-->
        <script id="li_img_106" type="text/x-jquery-tmpl">
            <li><a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=PracRes_bg">
                <img src="${ImageUrl.split(',')[0]}" alt="" /><p class="detail"></p>
            </a>
            </li>
        </script>
        <!--<!--启迪智慧(活动研究)-图片滚动-->
        <script id="li_106" type="text/x-jquery-tmpl">
             <li>
                <i></i>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=PracRes_bg">${Description}</a>
                <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
            </li>
        </script>
        <!--<!--文章欣赏(教师心语)-图片滚动-->
        <script id="li_102" type="text/x-jquery-tmpl">
            <li>                 
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}bgname=PracRes_bg">${Description}</a><span>${DateTimeConvert(CreateTime,'MM-dd')}</span></li>
        </script>
		<script>
		    $(function () {
		        $('#nav').load('/PreSchool/nav.html');
		        $('#footer').load('/PreSchool/footer.html');
		        $('#survey_wrap').load('/PreSchool/Survey.html');
		    })
		</script>
	</head>
	<body id="PracRes_bg">
        <div id="PracRes_bgwrap">

       
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
                    <ul id="list_data">
                    	 
                    </ul>
                </div>
			</div>
            <div class="module clearfix">
                <div class="wareres_banner fl">
                    <div class="slides">
						<ul class="slide TwoLevelC" id="ul_107" psize="15" imgstr="yes" >
							
	                    </ul>
	                    <div class="num">
	                        <ul>
	                                   
	                        </ul>
	                    </div>
					</div>
                </div>
                <div class="wareres_lists fr">
                    <h1 class="title">
						<span class="fl">
							课件资源
						</span>
						<a href="/PreSchool/SitePages/BeforeItemList.aspx?id=103&bgname=PracRes_bg" class="fr" target="_blank">
							更多
						</a>
					</h1>
                    <div class="content">
						<ul class="lists TwoLevelC"  id="ul_103" psize="9" menuids="103,104">
							
						</ul>
					</div>
                </div>
            </div>
		    <div class="module clearfix mt25">
                <div class="Enlightenwisdom fl">
                    <h1 class="title">
                        <span class="fl">启迪智慧</span>
                        <a href="/PreSchool/SitePages/BeforeItemList.aspx?id=106&bgname=PracRes_bg" class="fr" target="_blank">
                            更多
                        </a>
                    </h1>
                    <div class="content">
                        <div class="slides fl">
                            <ul class="slide TwoLevelC" id="ul_img_106" psize="15" imgstr="yes" >
							    
	                        </ul>
	                        <div class="num">
	                            <ul>
	                                   
	                            </ul>
	                        </div>
                        </div>
                        <ul class="lists TwoLevelC fr"  id="ul_106" psize="8" >
							
						</ul>
                    </div>
                </div>
                <div class="fr  Article">
                    <h1 class="title">
                        文章赏析
                        <a href="/PreSchool/SitePages/BeforeItemList.aspx?id=102&bgname=PracRes_bg" class="fr" target="_blank">更多</a>
                    </h1>
                    <div class="content">
                        <div class="clear"></div>
                        <ul id="ul_102" psize="9" class="lists1 TwoLevelC"></ul>
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



