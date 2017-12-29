<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryEduRes.aspx.cs" Inherits="PMSWeb.PreSchool.SitePages.CategoryEduRes" %>

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
            <li><a href="/PreSchool/SitePages/NoticeView.aspx?id=${MenuId}&advId=${Id}&bgname=EduRes_bg" target="_blank" title="${Title}">${Title}</a></li>
        </script>
        <!--教科研频道(经验推介、培训动态、培训资源)-图片滚动-->
        <script id="li_88" type="text/x-jquery-tmpl">
            <li><a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=EduRes_bg">
                <img src="${ImageUrl.split(',')[0]}" alt="" />
            </a>
            </li>
        </script>
        <!--教科研频道(经验推介、培训动态、培训资源)--> 
        <script id="li_87" type="text/x-jquery-tmpl">
            <li>
                <i></i>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=EduRes_bg" title="${Description}">${Description}</a>
                <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
            </li>
        </script>
        <!--向您推荐(通知公告)-->
        <script id="li_41" type="text/x-jquery-tmpl">
            <li>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=EduRes_bg" title="${Description}">${Description}</a>
                <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
            </li>
        </script>
        <!--成果展播(硕果累累)-->
        <script id="li_82" type="text/x-jquery-tmpl">
            <li>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=EduRes_bg">
                    <div class="img">
                        <img src="${ImageUrl.split(',')[0]}" alt="" />
                    </div>
                    <p>${Description}</p>
                </a>
            </li>
        </script>
        <!--专家资源-->
        <script id="li_91" type="text/x-jquery-tmpl">
            <li>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=EduRes_bg" target="_blank" style="width: auto;height: auto; overflow: hidden;display: block;">
                    <div class="img">
                        <img src="${ImageUrl.split(',')[0]}" alt="Alternate Text" />
                    </div>
                    <div class="con">
                        <h2>${Description}</h2>
                        <p>${CreativeHTML.replace(/<[^>]+>/g,'')}</p>
                    </div>
                </a>
            </li>
        </script>
       <!--信息链接-->
        <script id="li_6" type="text/x-jquery-tmpl">
            <a href="${Href}" target="_blank">${Title}</a>
        </script>        
		<script>
		    $(function () {
		        $('#nav').load('/PreSchool/nav.html');
		        $('#footer').load('/PreSchool/footer.html');
		        $('#survey_wrap').load('/PreSchool/Survey.html');
		    });
		</script>
	</head>
	<body id="EduRes_bg">
        <div id="EduRes_bgwrap">
		    <header id="header">
			    <div class="motto_logo clearfix center">
				    <a class="logo fl" href="/PreschoolIndex.aspx">
					    <img src="/PreSchool/images/logo.png"/>
				    </a>
			    </div>
			    <nav id="nav"></nav>
		    </header>
		     <div class="content" id="content">
                <div class="clear"></div>
                <div class="notice_wrap">
                    <span class="fl label">通知公告
                    </span>
                    <div class="notice">
                        <ul id="list_data"></ul>
                    </div>
                </div>
                 <div class="module clearfix">
                     <div class="fl edures_pin">
                         <h1 class="title">
                             教科研频道
                             <a href="/PreSchool/SitePages/BeforeItemList.aspx?id=87&bgname=EduRes_bg" class="fr"  target="_blank">更多</a>
                         </h1>
                         <div class="content">
                             <div class="edures_pin_banner fl">
                                 <div class="slides">
                                    <ul id="ul_88" menuids="87,88,89" psize="5" imgstr="yes" class="slide TwoLevelC"></ul>
                                    <div class="num">
                                        <ul></ul>
                                    </div>
                                </div>
                             </div>
                             <ul id="ul_87" menuids="87,88,89" psize="8" class="lists fr TwoLevelC"></ul>
                         </div>
                     </div>
                     <div class="fr  groom">
                         <h1 class="title">
                             向您推荐
                             <a href="/PreSchool/SitePages/BeforeItemList.aspx?id=41&bgname=EduRes_bg" class="fr"  target="_blank">更多</a>
                         </h1>
                         <div class="content">
                             <div class="clear"></div>
                             <ul id="ul_41" psize="9" class="lists1 TwoLevelC"></ul>
                          </div>
                     </div>
                 </div>
                 <div class="module clearfix mt15">
                     <div class="resultshow fl">
                         <h1 class="title">
                             成果展播
                         </h1>
                         <div class="content">
                             <div id="scroll_82" class="resultshowa">
                                 <ul id="ul_82" psize="12" imgstr="yes" class="clearfix TwoLevelC"></ul>
                             </div>
                         </div>
                     </div>
                     <div class="fr ExpertRes">
                         <h1 class="title">
                             专家资源
                             <a href="/PreSchool/SitePages/BeforeList.aspx?id=91&bgname=EduRes_bg" class="fr"  target="_blank">更多</a>
                         </h1>
                         <div class="content">
                             <div class="slides">
                                 <ul id="ul_91" psize="5" imgstr="yes" class="slide TwoLevelC"></ul>
                                 <div class="prev"><</div>
                                 <div class="next">></div>
                             </div>
                         </div>
                     </div>
                 </div>
                 <div class="module meshref mt15">
                     <h1 class="title">
                         <span>信息链接</span>                         
                     </h1>
                     <div id="ul_6" psize="6" btype="link" class="content clearfix TwoLevelC"></div>
                 </div>
                 <footer id="footer"></footer>
            </div>
		    <!--在线调查-->
            <div id="survey_wrap"></div>
        </div>
	</body>

</html>


