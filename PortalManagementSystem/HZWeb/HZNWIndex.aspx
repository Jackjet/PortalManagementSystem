<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HZNWIndex.aspx.cs" Inherits="PMSWeb.HZNWIndex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title>黄庄职业高中</title>
    <link href="/HZNW/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="/HZNW/css/layout.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/HZNW/js/common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/HZNW/js/jquery.SuperSlide.2.1.1.js"></script>
    <style>
        .slider {
            width: 345px;
            height: 196px;
            position: relative;
            overflow: hidden;
            float: left;
        }

            .slider li {
                width: 345px;
                height: 196px;
            }

                .slider li a {
                    display: block;
                    width: 345px;
                    height: 196px;
                    overflow: hidden;
                }

                    .slider li a img {
                        width: 100%;
                    }

            .slider .prev {
                cursor: pointer;
                display: none;
                position: absolute;
                width: 45px;
                height: 45px;
                top: 0;
                left: 0;
                bottom: 0;
                margin: auto auto auto 5px;
                z-index: 100;
                background: url(/HZNW/images/sprite-clean.png) no-repeat -1px -1px;
            }

            .slider .next {
                cursor: pointer;
                display: none;
                position: absolute;
                width: 45px;
                height: 45px;
                top: 0;
                right: 0;
                bottom: 0;
                margin: auto 5px auto auto;
                background: url(/HZNW/images/sprite-clean.png) no-repeat -1px -47px;
                z-index: 100;
            }

        .descrition_bg {
            height: 35px;
            width: 345px;
            background: #000;
            opacity: 0.8;
            filter: alpha(opacity=80);
            position: absolute;
            bottom: 0px;
            z-index: 100;
        }

        .descrition {
            height: 35px;
            width: 345px;
            text-align: center;
            font-size: 14px;
            color: #fff;
            line-height: 35px;
            position: absolute;
            bottom: 0px;
            z-index: 111;
        }
       #close_float_ad{
           width:20px;height:20px;background:#ff0000;border-radius:50%;color:#fff;text-align:center;line-height:20px;position:absolute;top:20px;right:35px;font-family:'Microsoft YaHei UI'
       }
    </style>
    <script>
        $(function () {
            $('#header').load('/HZNW/Header.aspx');
        })
    </script>
    <script type="text/x-jquery-tmpl" id="item_newsScroll">
        <li>
            <a href="/HZNW/SitePages/BeforeView.aspx?id=${mid}&advId=${id}" target='_blank'>
                <img src="${url}" />
                <div class="descrition_bg"></div>
                <p class="descrition">${NameLengthUpdate(desc,15)}</p>
            </a>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_news">
        <li>
            <span class='text'>
                <img src='/HZNW/images/point.png' />
                <a href='/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}' target='_blank'>${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class='date'><a>${DateTimeConvert(CreateTime,'MM-dd')}</a></span>
        </li>

    </script>
    <script type="text/x-jquery-tmpl" id="item_dytd">
        <li>
            <span class="text">
                <img src="/HZNW/images/point.png" />
                <a href="/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date">
                <a>${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</a>
            </span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_jyky">
        <li>
            <span class="text">
                <img src="/HZNW/images/point.png" />
                <a href="/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date">
                <a>${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</a>
            </span>
        </li>
    </script>
    <%--<script type="text/x-jquery-tmpl" id="item_zdzy">
        <ul class="everyone fl">
            <li class="teacherphoto">
                <a href="/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${ImageUrl}</a>
            </li>
            <li class="name">
                <a href="/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
            </li>
        </ul>
    </script>--%>
    <script type="text/x-jquery-tmpl" id="item_gjhz">
        <li>
            <span class="text">
                <img src="/HZNW/images/point.png" />
                <a href="/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date">
                <a>${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</a>
            </span>
        </li>

    </script>
    <script type="text/x-jquery-tmpl" id="item_zsjy">
        <li>
            <span class="text">
                <img src="/HZNW/images/point.png" />
                <a href="/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date">
                <a>${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</a>
            </span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_jyxb">
        <a href="/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
    </script>
    <script type="text/x-jquery-tmpl" id="item_ysxb">
        <a href="/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
    </script>
    <script type="text/x-jquery-tmpl" id="item_fwxb">
        <a href="/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
    </script>
    <script type="text/x-jquery-tmpl" id="item_jsxb">
        <a href="/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
    </script>
    <script type="text/x-jquery-tmpl" id="item_xydt">
        <li>
            <div class="dates fl">
                <span class="date">${DateTimeConvert(CreateTime,'MM-dd')}</span>
                <em><i></i></em>
            </div>
            <span class="gif_list_news fr"><a href="/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a></span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_syslink">
        <li class="fl"><a href="${Href}">
            <img src="${ImageUrl}" /></a></li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_dept">
        <li class="${EnName}">
            <a href="/HZNW/Category/DepartmentBeforeView.aspx?id=${ssId}&spid=${Id}&p=setting" target="_blank">
                <div class="active">
                    <img src="/HZNW/images/enter_${EnName}.jpg" />
                    <span class="entrance_sort" id="tree_${Id}">
                        <%--<a href="">学前教育</a>
                        <a href="">学前教育</a>
                        <a href="">学前教育</a>
                        <a href="">学前教育</a>--%>
                    </span>
                </div>
            </a>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_tree">
        <a href="${BeforeUrl}" target="_blank">${Name}</a>
    </script>
    <script type="text/x-jquery-tmpl" id="item_zdzy">
        <ul class="everyone fl">
            <li class="teacherphoto">
                <a href="${Href}" target="_blank">
                    <img src="${ImageUrl}"/></a>
            </li>
            <li class="name">
                <a href="${Href}">${Title}</a>
            </li>
        </ul>
    </script>
</head>
<body>
   
    <div id="header" style="min-height: 340px;"></div>
    <!--内容-->
    <div class="center">
        <div class="center_center main">
            <div class="center_top">
                <div class="center_top_con">
                    <div class="center_top_left fl">
                        <div class="School_News left_2">
                            <div class="School_News_con">
                                <div class="title">
                                    <p>
                                        <span class="tit_left fl">
                                            <a  class="ENG">School News</a><a class="tit">学校新闻</a></span>
                                        <span class="tit_right fr" style="display: block"><a href="/HZNW/SitePages/BeforeItemList.aspx?id=74">查看更多+</a></span>
                                    </p>
                                </div>
                                <div class="clear"></div>
                                <div class="content">
                                    <div class="slider">
                                        <ul class="51buypic" id="list_newsScroll">
                                        </ul>
                                        <div class="prev"></div>
                                        <div class="next"></div>
                                    </div>
                                    <!-- 新闻列表 -->
                                    <div class="fr" style="width: 320px;">
                                        <ul class='li_list' id="list_news">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--德育天地-->
                        <div class="left_2">
                            <div class="entrance fl">
                                <div class="entrance_con">
                                    <div class="title">
                                        <p>
                                            <span class="tit_left fl"><a class="tit">德育天地</a><a  class="ENG">Moral world</a></span>
                                            <span class="tit_right1 fr"><a href="/HZNW/SitePages/BeforeItemList.aspx?id=42">更多+</a></span>
                                        </p>
                                    </div>
                                    <div class="content">
                                        <ul class="li_list" id="list_dytd">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="entrance entrancer fl">
                                <div class="entrance_con fr">
                                    <div class="title">
                                        <p>
                                            <span class="tit_left fl"><a class="tit">教育科研</a><a  class="ENG">Educational research</a></span>
                                            <span class="tit_right1 fr"><a href="/HZNW/SitePages/BeforeItemList.aspx?id=27">更多+</a></span>
                                        </p>
                                    </div>
                                    <div class="content">
                                        <ul class="li_list" id="list_jyky">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <!--职工之家-->
                        <div class="left_2">
                            <div class="School_News_con">
                                <div class="title">
                                    <p>
                                        <span class="tit_left fl"><a  class="ENG">Professional introduction</a><a class="tit">专业介绍</a><b class="xian" style="width:372px;"><i></i></b></span>
                                        <%--<span class="tit_right fr"><a href="">查看更多+</a></span>--%>
                                    </p>
                                </div>
                                <div class="clear"></div>
                                <div class="content" id="list_zdzy" style="height:210px;overflow:hidden;">
                                    
                                </div>
                            </div>
                        </div>
                        <div class="left_2">
                            <div class="entrance fl">
                                <div class="entrance_con">
                                    <div class="title">
                                        <p>
                                            <span class="tit_left fl"><a  class="tit">国际合作</a><a  class="ENG">Moral world</a></span>
                                            <span class="tit_right1 fr"><a href="/HZNW/SitePages/BeforeItemList.aspx?id=59">更多+</a></span>
                                        </p>
                                    </div>
                                    <div class="content">
                                        <ul class="li_list" id="list_gjhz">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="entrance entrancer fl">
                                <div class="entrance_con fr">
                                    <div class="title">
                                        <p>
                                            <span class="tit_left fl"><a  class="tit">招生就业</a><a class="ENG">Educational research</a></span>
                                            <span class="tit_right1 fr"><a href="/HZNW/SitePages/BeforeItemList.aspx?pid=0&id=33">更多+</a></span>
                                        </p>
                                    </div>
                                    <div class="content">
                                        <ul class="li_list" id="list_zsjy">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <!--专业入口-->
                        <div class="left_2">
                            <div class="School_News_con">
                                <div class="title">
                                    <p>
                                        <span class="tit_left fl"><a  class="ENG">Department introduction</a><a class="tit">学部介绍</a><b class="xian1" style="width:372px;"><i></i></b></span>
                                       
                                    </p>
                                </div>
                                <div class="clear"></div>
                                <div class="content">
                                    <ul class="everyone1 fl" id="list_dept">
                                        <%--<li class="JYXB">
                                            <a href="/HZNW/Category/DepartmentIndex.aspx?spid=22" target="_blank">
                                                <div class="active">
                                                    <img src="/HZNW/images/enter_JYXB.jpg" />
                                                    <span class="entrance_sort" id="list_jyxb">
					                    			    <a href="">学前教育</a>
					                    			    <a href="">学前教育</a>
					                    			    <a href="">学前教育</a>
					                    			    <a href="">学前教育</a>
                                                    </span>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="YSXB">
                                            <a href="/HZNW/Category/DepartmentIndex.aspx?spid=23" target="_blank">
                                                <div>
                                                    <img src="/HZNW/images/enter_YSXB.jpg" />
                                                    <span class="entrance_sort" id="list_ysxb"></span>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="FWXB">
                                            <a href="/HZNW/Category/DepartmentIndex.aspx?spid=24" target="_blank">
                                                <div>
                                                    <img src="/HZNW/images/enter_FWXB.jpg" />
                                                    <span class="entrance_sort" id="list_fwxb"></span>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="JSXB">
                                            <a href="/HZNW/Category/DepartmentIndex.aspx?spid=25" target="_blank">
                                                <div>
                                                    <img src="/HZNW/images/enter_JSXB.jpg" />
                                                    <span class="entrance_sort" id="list_jsxb"></span>
                                                </div>
                                            </a>
                                        </li>--%>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="center_top_right fr">
                        <!--学校简介-->
                        <div class="entrance_right" style="height: 235px;">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl"><a  class="ENG">ABOUT</a><a  class="tit">学校简介</a></span>
                                    <span class="tit_right fr"><a href="/HZNW/SitePages/BeforeView.aspx?id=3">查看更多+</a></span>
                                </p>
                            </div>
                            <div class="clear"></div>
                            <div class="content clearfix">
                                <div class="school_year fl">
                                    <ul>
                                        <li>
                                            <span class="fl">1981</span>
                                            <i></i>
                                        </li>
                                        <li>
                                            <span class="fr">1982</span>
                                            <i></i>
                                        </li>
                                        <li>
                                            <span class="fl">1983</span>
                                            <i></i>
                                        </li>
                                        <li>
                                            <span class="fr">......</span>
                                            <i></i>
                                        </li>
                                        <li>
                                            <span class="fl">2016</span>
                                            <i></i>
                                        </li>
                                    </ul>
                                </div>
                                <p class="fl school_jian" id="list_xxjj">
                                </p>
                            </div>
                        </div>
                        <!--学校简介结束-->

                        <!--快速进入-->
                        <div class="entrance_right1">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl"><a class="ENG">Entrance</a><a class="tit">快速入口</a></span>
                                </p>
                            </div>
                            <div class="clear"></div>
                            <div class="content">
                                <div class="enter_btn">
                                    <a href="" target="_blank">
                                        <img src="/HZNW/images/quickenterbtn_01.jpg" /></a>
                                    <a href="" class="mt10" target="_blank">
                                        <img src="/HZNW/images/quickenterbtn_02.jpg" /></a>
                                    <a href="http://117.114.64.205/" class="mt10" target="_blank">
                                        <img src="/HZNW/images/quickenterbtn_03.jpg" />
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!--快速进入结束-->
                        <div class="entrance_right" style="height: 268px;">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl">

                                        <a class="tit">校园公告</a>

                                        <a  class="ENG">NEWS</a>
                                    </span>
                                    <span class="tit_right fr" style="display: block">
                                        <a href="/HZNW/SitePages/BeforeItemList.aspx?id=129">查看更多+</a>
                                    </span>
                                </p>
                            </div>
                            <div class="clear"></div>
                            <div class="content">
                                <ul class="li_list" id="list_xydt">
                                </ul>
                            </div>
                        </div>
                        <!--视频专区-->
                        <div class="entrance_right2" style="height: 265px;">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl"><a  class="ENG">Video Zone</a><a  class="tit">视频专区</a></span>
                                </p>
                            </div>
                            <div class="clear"></div>
                            <div class="content">
                                <p class="icon01" id="playerVideo">
                                    
                                </p>
                                <p class="wenzi"><a >北京市黄庄职业高中 </a></p>
                            </div>
                        </div>
                        <!--视频专区结束-->
                        <!--校园风貌-->
                        <div class="entrance_right3">
                            <div class="content">
                                <div class="concant">
                                    <p>黄庄职高欢迎您的加入</p>
                                    <div class="concant_mes">
                                        <i class="fl">
                                            <img src="/HZNW/images/tel.png" /></i>
                                        <div class="fl concant_mes_right">
                                            <div class="concant_tel">
                                                010-68666475
                                            </div>
                                            <div class="conant_date">
                                                预约报名时间：8：30-16：30
                                            </div>
                                            <div class="concant_address">
                                                报名地点：北京市黄庄职业高中招生就业处（石景山区鲁谷东街29号，邮编100040）
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
            <!--合作伙伴-->
            <div class="center_bottom">
                <div class="center_bottom_con">
                    <div class="School_News_con">
                        <div class="title">
                            <p>
                                <span class="tit_left fl"><a  class="tit tita">合作伙伴</a><a  class="ENG">Partner</a><b class="xian xianparnter"><i></i></b></span>
                            </p>
                        </div>
                        <div class="clear"></div>
                        <div class="content">
                            <ul class="linkcon clearfix" id="list_SysLink">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <iframe name="htmlHeader" src="/HZNW/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="92px"></iframe>
    <script type="text/javascript">
        $(function () {
            initScoll();//图片滚动
            initDYTD();//德育天地
            initJYKY();//教育科研
            initGJHZ();//国际合作
            initZSJY();//招生就业
            initXXJJ();//学校简介
            initXYGG();//校园公告
            initLINK();//友情链接
            initDEPT();//专业入口
            initPlay();//视频
            initKeyMajor();//重点专业
        })
        function lazyLoad(element, fn) {
            $(element).each(function () {
                var offsetTop = $(this).offset().top;
                var windowHeight = $(window).height();
                var scrollTop = $(window).scrollTop();
                if (offsetTop <= scrollTop) {
                    fn && fn();
                }
                $(window).scroll(function () {
                    if (offsetTop <= scrollTop) {
                        fn && fn();
                    }
                })
            })
        }
        function initScoll() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": 74,
                    "ChildId": true,
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 8,
                    "isPush": 1,
                    "isAll":true
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_newsScroll").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            var dataImgs = [];
                            var scrollIndex = 0;
                            for (var i = 0; i < items.length; i++) {
                                if (scrollIndex > 5) break;
                                if (i > items.length - 1) break;
                                var imgstr = items[i].ImageUrl;
                                if (imgstr != null && imgstr != "" && imgstr.length > 0) {
                                    var imgArry = imgstr.split(',');
                                    for (var j = 0; j < imgArry.length; j++) {
                                        if (imgArry[j] != "" && imgArry[j] != null) {
                                            var imgObj = new Object();
                                            imgObj.url = imgArry[j];
                                            imgObj.mid = items[i].MenuId;
                                            imgObj.desc = items[i].Description;
                                            imgObj.id = items[i].Id;
                                            scrollIndex++;
                                            dataImgs.push(imgObj);
                                            break;
                                        }

                                    }
                                }
                            }

                            if (dataImgs.length != 0) {
                                $("#item_newsScroll").tmpl(dataImgs).appendTo("#list_newsScroll");
                                jQuery(".slider").hover(function () { jQuery(this).find(".prev,.next").stop(true, true).fadeIn() }, function () { jQuery(this).find(".prev,.next").fadeOut() });
                                $(".slider").slide({
                                    titCell: ".num ul", mainCell: ".51buypic", effect: "fold", autoPlay: true, delayTime: 1200, autoPage: true
                                });
                            } else {
                                $("#list_newsScroll").html("暂无数据");
                            }
                            $("#item_news").tmpl(items).appendTo("#list_news");
                        } else {
                            $("#list_newsScroll").html("暂无数据");
                            $("#list_news").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        function initDYTD() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": enumSystemType("德育天地"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 7,
                    "isPush": 1,
                    "isAll": true
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_dytd").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_dytd").tmpl(items).appendTo("#list_dytd");
                        } else {
                            $("#list_dytd").html("<li>暂无数据</li>");
                        }
                    } else {
                        $("#list_dytd").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

        function initJYKY() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",            
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": enumSystemType("教育科研"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 7,
                    "isPush": 1,
                    "isAll": true
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_jyky").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_jyky").tmpl(items).appendTo("#list_jyky");
                        } else {
                            $("#list_jyky").html("<li>暂无数据</li>");
                        }
                    } else {
                        $("#list_jyky").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

        function initGJHZ() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",              
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": enumSystemType("国际合作"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 7,
                    "isPush": 1,
                    "isAll": true
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_gjhz").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_gjhz").tmpl(items).appendTo("#list_gjhz");

                        } else {
                            $("#list_gjhz").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        function initZSJY() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",         
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",                    
                    "MenuIds":"37,38,40",
                    "ChildId": true,
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 7,
                    "isPush": 1,
                    "isAll": true
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_zsjy").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_zsjy").tmpl(items).appendTo("#list_zsjy");

                        } else {
                            $("#list_zsjy").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        function initXXJJ() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",                
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("学校简介"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_xxjj").html();
                        var newItems = json.result.retData.PagedData;
                        if (newItems != null && newItems.length > 0) {
                            var html = newItems[0].CreativeHTML.replace(/<[^>]+>/g, '');
                            if (html != "" && html.length > 0) {
                                if (html.length > 185)
                                    $("#list_xxjj").html(html.substring(0, 185)+'...');
                                else
                                    $("#list_xxjj").html(html.substring(0, html.length - 1));
                            }
                        } else {
                            $("#list_xxjj").html("暂无数据");
                        }
                    } else {
                        $("#list_xxjj").html("暂无数据");
                    }
                },
                error: OnError
            });
        }

        function initXYGG() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",               
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("校园公告"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1,
                    "isAll": true
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_xydt").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_xydt").tmpl(items).appendTo("#list_xydt");
                        } else {
                            $("#list_xydt").html("<li>暂无数据</li>");
                        }
                    } else {
                        $("#list_xydt").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

        function initLINK() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",               
                dataType: "json",
                data: {
                    PageName: "/DYYX/AdminManagerHandler.ashx",
                    Func: "GetLinkList",
                    IsPage: true,
                    PageIndex: 1,
                    pageSize: 20,
                    OneNavId:1
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#list_SysLink").html('');
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_syslink").tmpl(items).appendTo("#list_SysLink");
                            $('.content').slide({ mainCell: "#list_SysLink", effect: "leftLoop", vis: 8, autoPlay: true });
                        } else {
                            $("#list_SysLink").html("暂无数据");
                        }
                    }
                    else {
                        $("#list_SysLink").html("暂无数据");
                    }
                },
                error: OnError
            });
        }

        function initDEPT() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",               
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetChildMenuForId",
                    "Id": enumSystemType("学部设置"),
                    "IsDelete": 0,
                    "Display": 0
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_dept").html();
                        var items = json.result.retData;
                        var ary = ['103', '108', '109', '110'];
                        for (var i = 0; i < items.length; i++) {
                            items[i].ssId = ary[i];
                        }
                        $("#item_dept").tmpl(items).appendTo("#list_dept");

                        
                        for (var i = 0; i < items.length; i++) {
                           
                            initChildTree(items[i].Id, items[i].EnName);

                        }

                    } else {
                        $("#list_dept").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

        function initChildTree(pid, penname) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",              
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetChildMenuForId",
                    "Id": pid,
                    "IsDelete": 0,
                    "Display": 0
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].Name == "专业设置") {
                                    initSettingDept(items[i].Id, pid, penname);
                                }
                            }
                            //$("#item_tree").tmpl(items).appendTo("#tree_" + pid);
                        }

                    }
                },
                error: OnError
            });
        }

        function initSettingDept(pid, treeid, penname) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",                
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetChildMenuForId",
                    "Id": pid,
                    "IsDelete": 0,
                    "Display": 0
                },
                success: function (json) {
                    //$("#list_zdzy").html("");
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            for (var i = 0; i < items.length; i++) {
                                items[i].BeforeUrl = items[i].BeforeUrl + "&s=" + pid;
                               
                            }
                            //if (penname == "YSXB") {
                            //    $("#item_zdzy").tmpl(items).appendTo("#list_zdzy");
                            //}
                            $("#item_tree").tmpl(items).appendTo("#tree_" + treeid);
                        }

                    }
                },
                error: OnError
            });
        }
        function initKeyMajor() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                dataType: "json",
                data: {
                    PageName: "/DYYX/AdminManagerHandler.ashx",
                    Func: "GetLinkList",
                    IsPage: true,
                    PageIndex: 1,
                    pageSize: 20,
                    OneNavId: 33
                },
                success: function (json) {
                    $("#list_zdzy").html("");
                    if (json.result.errNum.toString() == "0") {                        
                        if (json.result.errMsg == "success") {
                            var items = json.result.retData.PagedData;
                            $("#item_zdzy").tmpl(items).appendTo("#list_zdzy");
                            $('.School_News_con').slide({ mainCell: "#list_zdzy", effect: "leftLoop", vis: 5, autoPlay: true });
                        }
                    }
                    else {
                        $("#list_zdzy").html("暂无数据");
                    }
                },
                error: OnError
            });
        }

        function initPlay() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",               
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("校内视频"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 1,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData.PagedData;
                        if (items!=null && items.length==1) {
                            $("#playerVideo").html(items[0].CreativeHTML);
                        }
                    }
                },
                error: OnError
            });
        }
    </script>
    <script src="/HZNW/js/js.js"></script>
    <script>
        $(function () {
            //调用漂浮插件
            $("body").floatAd({
                imgSrc: '/HZNW/images/xuanfuchuang.png',
                url: 'http://117.114.64.203/HZNW/SitePages/BeforeView.aspx?id=38&advId=2643',
                speed: 15
            });
        })
    </script>
</body>
</html>
