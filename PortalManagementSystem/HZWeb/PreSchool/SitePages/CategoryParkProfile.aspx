<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryParkProfile.aspx.cs" Inherits="PMSWeb.PreSchool.SitePages.CategoryParkProfile" %>

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
            <li><a href="/PreSchool/SitePages/NoticeView.aspx?id=${MenuId}&advId=${Id}&bgname=ParkProfile_bg" target="_blank" title="${Title}">${Title}</a></li>
        </script>
        <%--园徽介绍--%>
        <script id="li_57" type="text/x-jquery-tmpl">
            <div class="img fl">
                <img src="${ImageUrl.split(',')[0]}" onerror="javascript:this.src='/PreSchool/images/in.jpg'"/>
            </div>
            <div class="emblemintro_detail fr">
                ${CreativeHTML.replace(/<[^>]+>/g,'')}
            </div>
        </script>
        <!--园所环境-->
        <script id="li_59" type="text/x-jquery-tmpl">
            <li><a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=ParkProfile_bg">
                <img src="${ImageUrl.split(',')[0]}" alt="" />
            </a>
            </li>
        </script>
        <!--安全保卫-->
        <script id="li_62" type="text/x-jquery-tmpl">
            <li>
                <i></i>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=ParkProfile_bg" title="${Description}">${Description}</a>
				<span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
            </li>
        </script>
        <!--政策学习-->
        <script id="li_63" type="text/x-jquery-tmpl">
            <li>
                <i></i>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=ParkProfile_bg" title="${Description}">${Description}</a>
				<span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
            </li>
        </script>
         <!--园所文化-->
        <script type="text/x-jquery-tmpl" id="li_58">
            <span>${CreativeHTML.replace(/<[^>]+>/g,'')}</span>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=ParkProfile_bg" id="seedetail">查看详细+</a>
        </script>
         <!--教职工风采-->
         <script id="li_120" type="text/x-jquery-tmpl">
            <li>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=ParkProfile_bg">
                    <div class="img">
                        <img src="${ImageUrl.split(',')[0]}" alt="" />
                    </div>
                    <p>${Description}</p>
                </a>
            </li>
        </script>
        <!--园所荣誉-->
        <script id="li_60" type="text/x-jquery-tmpl">
            <li><a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=ParkProfile_bg">
                <img src="${ImageUrl.split(',')[0]}" alt="" />
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
	<body id="ParkProfile_bg">
        <div id="ParkProfile_bgwrap">

       
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
                <div class="emblemintro fl">
                    <h1 class="title">
						园徽介绍
						<a class="more fr" href="/PreSchool/SitePages/BeforeView.aspx?id=57&bgname=ParkProfile_bg" target="_blank">更多</a>
					</h1>
                    <div class="content clearfix TwoLevelC" id="ul_57" psize="1">
                        
                    </div>
                </div>
                <div class="environment fr ">
                    <div class="slides sliders1">
                        <ul class="slide TwoLevelC" id="ul_59" psize="20" imgstr="yes">
                            
                        </ul>
                        <div class="prev">&lt;</div>
                        <div class="next">&gt;</div>  
                    </div>
                </div>
            </div>
            <div class="module clearfix mt15">
                <div class="security fl">
                    <h1 class="title">安全保卫</h1>
                    <div class="content">
                        <ul id="ul_62" psize="6" class="lists TwoLevelC"></ul>
                    </div>
                </div>
                <div class="policylearn fl">
                     <h1 class="title">
						<span class="fl">
							政策学习
						</span>
						<a href="/PreSchool/SitePages/BeforeItemList.aspx?id=63&bgname=ParkProfile_bg" class="fr" target="_blank">更多</a>
					</h1>
                    <div class="content">
						<ul id="ul_63" psize="7" class="lists TwoLevelC"></ul>
					</div>
                </div>
                <div class="GardenCulture fr">
                    <h1 class="title">园所文化</h1>
                    <div class="content TwoLevelC" id="ul_58" psize="1">
                        
                    </div>
                </div>
            </div>
            <div class="module clearfix mt15">
                <div class="style_outer fl">
                    <div class="style_inner">
                        <div class="style">
                            <h1 class="title pr">
                                <span>教职工风采</span>
                                <a href="/PreSchool/SitePages/BeforeList.aspx?id=120&bgname=index_bg" target="_blank">更多</a>
                            </h1>
                            <div class="slider" id="scroll_120">
                                <ul id="ul_120" psize="24" imgstr="yes" class="clearfix scroll TwoLevelC">
                                    
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="honor fr ">
                    <h1 class="title">
						育儿小百科
					</h1>
                    <div class="slides">
                        <ul class="slide TwoLevelC" id="ul_60" psize="20" imgstr="yes">
                            
                        </ul>
                        <div class="prev">&lt;</div>
                        <div class="next">&gt;</div>  
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



