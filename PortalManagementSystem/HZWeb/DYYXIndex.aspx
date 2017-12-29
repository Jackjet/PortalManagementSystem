<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DYYXIndex.aspx.cs" Inherits="PMSWeb.DYYXIndex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <link rel="shortcut icon" href="http://www.mtgdyyx.bjedu.cn/wpresources/dyyx/images/bitbug_favicon.ico">
    <title>大峪第一小学</title>
    <link href="/DYYX/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="/DYYX/css/layout.css" rel="stylesheet" type="text/css" />
    <link href="/DYYX/css/jquery.excoloSlider.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript"  src="/Scripts/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="/DYYX/js/layout.js" ></script>
    <script type="text/javascript" src="/DYYX/js/jquery.excoloSlider.js" charset="gbk"></script>
    <script src="/Scripts/jscrollpane/scripts/jquery.mousewheel.js"></script>
    <script src="/Scripts/jscrollpane/scripts/jquery.jscrollpane.min.js"></script>
     <script src="/Scripts/Common.js"></script>
    <script src="/DYYX/js/common.js"></script>
     <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <link href="/Scripts/videojs/video-js.min.css" rel="stylesheet" />
    <script src="/Scripts/videojs/video.min.js"></script>
    <script>
        videojs.options.flash.swf = "Scripts/videojs/video-js.swf";
    </script>
    <style>
        #sliderB{
            width:250px;height:155px;margin-left:10px;
        }
        .content .slide > *{
            width:250px;height:155px;
        }
            #list_zjyx a {
                width: 121px;
                height: 72px;
                padding:4px;
                display: block;
                overflow: hidden;
                margin-left: 8px;
                float: left;
                margin-bottom: 8px;
                border: 1px solid #dcdcdc;
                border-radius:2px;
            }
            #quickenter_list a{width:253px;height:46px;display:block;margin:0 auto;border-radius:2px;}
    </style>
    <!-- Init Skitter -->
     <script>
         $(function () {
             $('#header').load('/DYYX/Header.aspx');
             $('#footer').load('/DYYX/bottom.aspx');
         })
    </script>
    <script id="item_slider" type="text/x-jquery-tmpl">
        <a href="/DYYX/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">
        <img src="${url}" data-plugin-slide-caption="${desc}" />
</a>
    </script>
    <script id="item_list" type="text/x-jquery-tmpl">
        <li>
            <img src="/DYYX/images/point.png" />
            <span class="text">
                <a href="/DYYX/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date">
                <a>${DateTimeConvert(CreateTime,'MM/dd')}</a>
            </span>
        </li>
    </script>
  <script id="item_list_XYKX" type="text/x-jquery-tmpl">
        <li>
            <img src="/DYYX/images/point.png" />
            <span class="text">
                <a href="/DYYX/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,25)}</a>
            </span>
            <span class="date">
                <a>${DateTimeConvert(CreateTime,'MM/dd')}</a>
            </span>
        </li>
    </script>
     <script id="item_img" type="text/x-jquery-tmpl">
         <ul class="everyone fl">
             <li class="teacherphoto">
                 <a href="/DYYX/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">
                     <img src="${Img}" /></a>
             </li>
             <li class="name">
                 <a href="/DYYX/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
             </li>
         </ul>
    </script>
   <%-- <script id="item_img1" type="text/x-jquery-tmpl">
         <ul class="everyone fl">
             <li class="teacherphoto">
                 <a href="/DYYX/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">
                     <img src="${Img}" /></a>
             </li>
             <li class="name">
                 <a href="/DYYX/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${Description}</a>
             </li>
         </ul>
    </script>--%>
      <script id="item_zjyx" type="text/x-jquery-tmpl">
          <a href="/DYYX/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" class="introduce">
              <img style="width: 121px; height: 72px;" src="${Img}" />
          </a>
    </script>
    <script id="item_link" type="text/x-jquery-tmpl">
        <li class="fl"><a href="${Href}" target="_blank"><img src="${ImageUrl}" /></a></li>
    </script>
    <script id="item_notice" type="text/x-jquery-tmpl">
        <li>
            <img src="/DYYX/images/point.png">
            <span class="text"><a href="/DYYX/SitePages/NoticeView.aspx?id=${Id}&mid=${MenuId}" target="_blank">${NameLengthUpdate(Title,15)}</a></span>
            <span class="date">
                <a>${DateTimeConvert(CreateTime,'MM/dd')}</a>
            </span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="quickenter_item">
        <p><a href="${Href}" target="_blank"><img src="${ImageUrl}" /></a></p>
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
        
        <div id="header" style="height:400px;"></div>
        <div class="clear"></div>
        <div class="center">
            <!--校园快讯-->
            <div class="center_top">
                <div class="center_con_top main">
                    <div class="centertop_News">
                        <div id="sliderA" class="slider">
                         
                        </div>
                        <div class="campus_alerts fl">
                            <div class="title ">
                                <p class="clearfix">
                                    <span class="tit_left fl">
                                        <img src="/DYYX/images/icon01.png" />
                                        <a class="tit">校园快讯</a>
                                        <a class="english">School News</a>
                                    </span>
                                    <span class="tit_right fr" style="display: block">
                                        <a href="/DYYX/SitePages/BeforeItemList.aspx?id=53">更多</a>
                                    </span>
                                </p>
                            </div>
                            <div class="content">
                                <ul class="li_list" id="list_xykx">
                                    
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="center_center">
                <div class="center_center_con main">
                    <!--左侧-->
                    <div class="center_center_left fl">
                        <!--课程教学  德育在线-->
                        <div class="left_1">
                            <div class="entrance fl">
                                <div class="title">
                                    <p>
                                        <span class="tit_left fl">
                                            <img src="/DYYX/images/hongjiantou.png" />
                                            <a class="tit">课程教学</a>
                                            <a class="english">Course Teaching</a>
                                        </span>
                                        <span class="tit_right fr" style="display: block">
                                            <a href="/DYYX/SitePages/BeforeItemList.aspx?id=14">更多</a>
                                        </span>
                                    </p>
                                </div>
                                <div class="content">
                                    <ul class="li_list" id="list_kcjx">
                                        
                                    </ul>
                                </div>
                            </div>
                            <div class="entrance_r fl">
                                <div class="title">
                                    <p>
                                        <span class="tit_left fl">
                                            <img src="/DYYX/images/hongjiantou.png" />
                                            <a class="tit">德育在线</a>
                                            <a class="english">Moral Education</a>
                                        </span>
                                        <span class="tit_right fr" style="display: block">
                                            <a href="/DYYX/SitePages/BeforeItemList.aspx?id=20">更多</a>
                                        </span>
                                    </p>
                                </div>
                                <div class="content">
                                    <ul class="li_list" id="list_dyzx">
                                        
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="left_2 fl">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl">
                                        <img src="/DYYX/images/hongjiantou.png" />
                                        <a class="tit">学生天地</a>
                                        <a class="english">Student's Area</a>
                                    </span>
                                    <span class="tit_right fr" style="display: block">
                                        <a href="/DYYX/SitePages/BeforeItemList.aspx?id=18">更多</a>
                                    </span>
                                </p>
                            </div>
                            <div class="content" id="list_xstd">
                                
                                
                            </div>
                        </div>
                        <!--党建园地 域外之声-->
                        <div class="left_1">
                            <div class="entrance fl">
                                <div class="title">
                                    <p>
                                        <span class="tit_left fl">
                                            <img src="/DYYX/images/icon01.png" />
                                            <a class="tit">党建园地</a>
                                            <a class="english">Party Building</a>
                                        </span>
                                        <span class="tit_right fr" style="display: block">
                                            <a href="/DYYX/SitePages/BeforeItemList.aspx?id=29">更多</a>
                                        </span>
                                    </p>
                                </div>
                                <div class="content">
                                    <ul class="li_list" id="list_djyd">
                                        
                                    </ul>
                                </div>
                            </div>
                            <div class="entrance_r fl">
                                <div class="title">
                                    <p>
                                        <span class="tit_left fl">
                                            <img src="/DYYX/images/icon01.png" />
                                            <a class="tit">域外之声</a>
                                            <a class="english">The Voice Of The Outside</a>
                                        </span>
                                        <span class="tit_right fr" style="display: block">
                                            <a href="/DYYX/SitePages/BeforeItemList.aspx?id=47">更多</a>
                                        </span>
                                    </p>
                                </div>
                                <div class="content">
                                    <ul class="li_list" id="list_ywzs">
                                        
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!--骨干团队-->
                        <div class="entrance1 fl">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl">
                                        <img src="/DYYX/images/hongjiantou.png" />
                                        <a class="tit">团队骨干</a>
                                        <a class="english">Core Teams</a>
                                    </span>
                                    <span class="tit_right fr" style="display: block">
                                        <a href="/DYYX/SitePages/BeforeList.aspx?id=38">更多</a>
                                    </span>
                                </p>
                            </div>
                            <div class="content" id="list_tdgg">

                            </div>
                        </div>
                        <div class="entrance_r1 fl">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl">
                                        <img src="/DYYX/images/ads.jpg" />
                                        <a class="tit">职工之家</a>
                                        <a class="english">Family of Staff</a>
                                    </span>
                                    <span class="tit_right fr" style="display: block">
                                        <a href="/DYYX/SitePages/BeforeItemList.aspx?id=45">更多</a>
                                    </span>
                                </p>
                            </div>
                            <div class="content" id="list_zgzj">
                                
                            </div>
                        </div>
                    </div>
                    <!--右侧-->
                    <div class="center_center_right fr">
                        <div class="entrance_right">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl">
                                        <img src="/DYYX/images/icon01.png" />
                                        <a class="tit">公告栏</a>
                                        <a class="english">Notice</a>
                                    </span>
                                    <span class="tit_right fr" style="display: none">
                                        <a href="">更多</a>
                                    </span>
                                </p>
                            </div>
                            <div class="content">
                                <div>
                                    <ul  id="list_notice" class="li_list">
                                        
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!--登录-->
                        <div class="entrance_right4">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl">
                                        <img src="/DYYX/images/icon02.png">
                                        <a class="tit">快速入口</a>
                                        <a class="english">Express Entry</a>
                                    </span>
                                    <span class="tit_right fr" style="display: block">
                                        <a href=""></a>
                                    </span>
                                </p>
                            </div>
                            <div class="con_con" id="quickenter_list">
                               
                            </div>
                        </div>
                       
                        <!--视频专区-->
                        <div class="entrance_right">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl">
                                        <img src="/DYYX/images/icon02(1).png">
                                        <a class="tit">视频专区</a>
                                        <a class="english">Video zone</a>
                                    </span>
                                    <span class="tit_right fr">
                                        <a></a>
                                    </span>
                                </p>
                            </div>
                          <%--  <div class="content">
                                <p class="icon01">
                                    <video src="/DYYX/video/movie.mp4" controls="controls"  width="280" height="150" preload="auto"/>
                                </p>
                            </div>--%>

                              <div class="content">
                                  <div id="sliderB" class="slider">
                                        
                                  </div>
                                    <%--<p class="icon01" id="playerVideo">
                                        <video width="250" height="155" src="" controls="controls" preload="auto" poster="/YQZJ/images/voidpic.png"></video>
                                    </p>--%>
                                </div>
                        </div>
                         <!--走进一小-->
                        <div class="entrance_right5">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl">
                                        <img src="/DYYX/images/icon02(1).png">
                                        <a class="tit">走进一小</a>
                                        <a class="english">General Situation</a>
                                    </span>
                                    <span class="tit_right fr" style="display: none">
                                        <a href="">更多</a>
                                    </span>
                                </p>
                            </div>
                            <div class="content" id="list_zjyx">
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--底部-->
            <div class="center_bottom">
                <div class="center_bottom_con main">
                    <ul id="list_link">
                        
                        
                    </ul>
                </div>
            </div>
        </div>
        <!--footer-->
        <div id="footer" style="height:68px;"></div>
        <div id="top"></div>
        <link href="/DYYX/css/layout.css" rel="stylesheet" type="text/css">
    </form>
    <script type="text/javascript">
        $(function () {
            initXYKX();
            initKCJX();
            initDYZX();
            initXSTD();
            initDJYD();
            initYWZS();
            initTDGG();
            initZGZJ();
            initZJYX();
            initLink();
            initNotice();
            initKSRK();

            initPlay();
        })

        function initPlay() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": 62,
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 1,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length == 1) {
                            var ary = items[0].FilePath.split(',');
                            for (var i = 0; i < ary.length; i++) {
                                var video = '<div><video id="play_'+i+'" class="video-js vjs-default-skin vjs-big-play-centered" controls preload="auto" width="250" height="155" poster="/YQZJ/images/voidpic.png"><source src="'+ary[i]+'" type="video/mp4" /></video></div>';
                                $('#sliderB').append(video);
                                videojs("play_" + i, { "example_option": true }, function () {
                                });
                                $('#sliderB').excoloSlider({
                                    width: 250,
                                    height: 155,
                                });

                            }
                        }
                    } else {
                        $("#playerVideo").html('暂无视频');
                    }
                },
                error: OnError
            });
        }

        //校园快讯
        function initXYKX()
        {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("校园快讯"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize":9,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#sliderA").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            var dataImgs = [];

                            for (var i = 0; i < items.length; i++) {
                                var imgstr = items[i].ImageUrl.split(',');
				imgstr = imgstr[0];
if (imgstr != null && imgstr != "") {
                                    var imgObj = new Object();
                                    imgObj.url = imgstr;
                                    imgObj.desc = items[i].Description;
imgObj.Id = items[i].Id;
imgObj.MenuId =items[i].MenuId;


                                    dataImgs.push(imgObj);
                                }
                               
                            }
                            if (dataImgs.length != 0) {
                                $("#item_slider").tmpl(dataImgs).appendTo("#sliderA");
                                $("#sliderA").excoloSlider();
                            } else {
                                $("#sliderA").html("暂无数据");
                            }
                            $("#item_list_XYKX").tmpl(items).appendTo("#list_xykx");
                        } else {
                            $("#sliderA").html("暂无数据");
                            $("#list_xykx").html("<li>暂无数据</li>");
                        }
                        
                    }
                },
                error: OnError
            });
        }

        //课程教学
        function initKCJX() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": enumSystemType("课程教学"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 7,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_kcjx").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_list").tmpl(items).appendTo("#list_kcjx");
                        } else {
                            $("#list_kcjx").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        //德育在线
        function initDYZX() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": enumSystemType("德育在线"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize":7,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_dyzx").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_list").tmpl(items).appendTo("#list_dyzx");
                        } else {
                            $("#list_dyzx").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        //学生天地
        function initXSTD() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": enumSystemType("学生天地"),
                    "ImgUrl":"yes",
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 4,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_xstd").html();
                        var items = json.result.retData.PagedData;
                        var newItems = items;
                        if (newItems != null && newItems.length > 0) {
                            for (var i = 0; i < newItems.length; i++) {
                                var img = ImgIndex(newItems[i].ImageUrl);
                                items[i].Img = img;
                            }
                            $("#item_img").tmpl(items).appendTo("#list_xstd");
                        } else {
                            $("#list_xstd").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        //党建园地
        function initDJYD() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": enumSystemType("党建园地"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize":6,
                    "NotItem": enumSystemType("收获成果") + "," + enumSystemType("多彩活动"),
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_djyd").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_list").tmpl(items).appendTo("#list_djyd");
                        } else {
                            $("#list_djyd").html("<li>暂无数据</li>");
                        }
                    }
                },
                error: OnError
            });
        }

        //域外之声
        function initYWZS() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": enumSystemType("域外之声"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 6,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_ywzs").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_list").tmpl(items).appendTo("#list_ywzs");
                        } else {
                            $("#list_ywzs").html("<li>暂无数据</li>");
                        }
                    }
                },
                error: OnError
            });
        }

        //团队骨干
        function initTDGG() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("行政领导"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 2,
                    "isPage": true,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_tdgg").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            var newItems = items;
                            for (var i = 0; i < newItems.length; i++) {
                                var img = newItems[i].ImageUrl;
                                items[i].Img = ImgIndex(img);
                            }
                            $("#item_img").tmpl(items).appendTo("#list_tdgg");
                        } else {
                            $("#list_tdgg").html("<li>暂无数据</li>");
                        }
                    }
                },
                error: OnError
            });
        }

        //职工之家
        function initZGZJ() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": enumSystemType("职工之家"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 2,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_zgzj").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            var newItems = items;
                            for (var i = 0; i < newItems.length; i++) {
                                var img = newItems[i].ImageUrl;
                                items[i].Img = ImgIndex(img);
                            }
                            $("#item_img").tmpl(items).appendTo("#list_zgzj");
                        } else {
                            $("#list_zgzj").html("<li>暂无数据</li>");
                        }
                    }
                },
                error: OnError
            });
        }

        //走进一小
        function initZJYX() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": enumSystemType("校园风貌"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 1,
                    "ChildId": true,
                    "isPage": true,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_zjyx").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            var images=[];
                            var imgs = items[0].ImageUrl.split(",");
                            for (var i = 0; i < imgs.length; i++) {
                                var obj = new Object();
                                obj.Img = imgs[i];
                                obj.MenuId = items[0].MenuId;
                                obj.Id = items[0].Id;
                                images.push(obj);
                            }
                            if (images.length>8) {
                                images = images.splice(0, 8);
                            }
                           
                            $("#item_zjyx").tmpl(images).appendTo("#list_zjyx");
                        } else {
                            $("#list_zjyx").html("<li>暂无数据</li>");
                        }
                    }
                },
                error: OnError
            });
        }
        //快速入口
        function initKSRK() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/DYYX/AdminManagerHandler.ashx",
                    Func: "GetLinkList_QUICK",
                    IsPage: true,
                    PageIndex: 1,
                    pageSize: 3
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#quickenter_list").html('');
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#quickenter_item").tmpl(items).appendTo("#quickenter_list");
                        }
                    }
                    else {
                        $("#list_link").html("暂无数据");
                    }
                },
                error: OnError
            });
        }
        //友情链接
        function initLink() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/DYYX/AdminManagerHandler.ashx",
                    Func: "GetLinkList",
                    IsPage: true,
                    PageIndex: 1,
                    pageSize: 20
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#list_link").html('');
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_link").tmpl(items).appendTo("#list_link");
                        }
                    }
                    else {
                        $("#list_link").html("暂无数据");
                    }
                },
                error: OnError
            });
        }

        //通知公告
        function initNotice() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/NoticesHandler.ashx",
                    "func": "GetPageList",
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 6,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_notice").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_notice").tmpl(items).appendTo("#list_notice");
                        } else {
                            $("#list_notice").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        function ImgIndex(path) {
            if (path == null || path == "") return "";
            var imgs = path.split(',');
            return imgs[0];
        }
    </script>
</body>
</html>
