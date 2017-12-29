<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YQZJIndex.aspx.cs" Inherits="PMSWeb.YQZJIndex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>延庆县职业技术教育中心</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <link rel="stylesheet" href="/YQZJ/css/reset.css" />
    <link rel="stylesheet" href="/YQZJ/css/layout.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/YQZJ/js/jquery.SuperSlide.2.1.1.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/YQZJ/js/common.js"></script>
    <style>
        .slider {
            width: 580px;
            height: 326px;
            position: relative;
            overflow: hidden;
            float: left;
        }

            .slider li {
               width: 580px;
            height: 326px;
            }

                .slider li a {
                    width: 580px;
                    height: 326px;
                    overflow: hidden;
                    display:table-cell;
                    vertical-align:middle;
                    text-align:center;
                }

                    .slider li a img {
                        width: 580px;
                    }
            .slider .num{
                display:inline-block;
                width:100%;text-align:center;
                position:absolute;bottom:0;height:35px;background:rgba(0,0,0,.6);
            }
            .slider .num ul{
                display:inline-block;
                text-align:center;margin-top:8px;
            }
            .slider .num ul li{
                width:18px;height:18px;border-radius:50%;display:inline-block;float:left;margin-left:6px;background:#fff;color:#555;text-align:center;line-height:18px;
            }
             .slider .num ul li.on{
                 background:#07a94b;color:#fff;
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
                background: url(/YQZJ/images/sprite-clean.png) no-repeat -1px -1px;
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
                background: url(/YQZJ/images/sprite-clean.png) no-repeat -1px -47px;
                z-index: 100;
            }

        .descrition_bg {
            height: 35px;
          width: 580px;
            background: #000;
            opacity: 0.8;
            filter: alpha(opacity=80);
            position: absolute;
            bottom: 0px;
            z-index: 100;
        }

        .descrition {
            height: 35px;
            width: 580px;
            text-align: center;
            font-size: 14px;
            color: #fff;
            line-height: 35px;
            position: absolute;
            bottom: 0px;
            z-index: 111;
        }
    </style>
    <script>
		$(function () {
		    $("#header").load('/YQZJ/Header.aspx');
		    $('#footer').load('/YQZJ/bottom.aspx');
		})
    </script>
    <script type="text/x-jquery-tmpl" id="modult">
        <div class="entrance_r fl">
            <div class="title">
                <p>
                    <span class="tit_left fl">
                        <img src="/YQZJ/images/icon01.png" />
                        <a class="tit">${Name}</a>
                        <a class="english"></a>
                    </span>
                    <span class="tit_right fr" style="display: block">
                        <a href="/YQZJ/Sitepages/Category.aspx?id=${Id}&selectPid=${p_ID}">更多</a>
                    </span>
                </p>
            </div>

            <div class="content">
                <ul class="li_list" id="lists_${Id}">
                </ul>
            </div>
        </div>
    </script>

    <script id="item_newsScroll" type="text/x-jquery-tmpl">
        <li>
            <a href="/YQZJ/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}&selectPid=${p_ID}" target="_blank">
                <img src="${Img}" />
                <%--<div class="descrition_bg"></div>
                <p class="descrition">${NameLengthUpdate(Description,15)}</p>--%>
            </a>
        </li>
    </script>
    <script id="item_list1" type="text/x-jquery-tmpl">
        <li>
            <img src="/YQZJ/images/point.png" />
            <span class="text"><a href="/YQZJ/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}&selectPid=${p_ID}" target="_blank">${Description}</a></span>
            <span class="date">
                <a>${DateTimeConvert(CreateTime,'MM-dd')}</a>
            </span>
        </li>
    </script>
    <script id="item_list2" type="text/x-jquery-tmpl">
        <li>
            <img src="/YQZJ/images/point.png" />
            <span class="text"><a href="/YQZJ/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}&selectPid=${p_ID}" target="_blank">${Description}</a></span>
            <span class="date">
                <a>${ClickNum}</a>
            </span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_syslink">
        <li>
            <a target="_blank" href="${Href}" style="background: url(${ImageUrl}) no-repeat scroll center center rgba(0, 0, 0, 0);background-size:cover;"></a>
        </li>
    </script>
    <script type="text/template" id="quickenter_item">
        <p class="app_pic_l">
            <a class="jump" href="${Href}" target="_blank">
                <img src="${ImageUrl}" />
            </a>
        </p>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="header" style="min-height: 242px;"></div>
            <div class="center" id="initheight">
                <div class="center_top">
                    <div class="center_top_con main">
                        <!--校园快讯-->
                        <div class="centertop_News">
                            <div class="center_top_left fl">
                                <div class="slider">
                                    <ul class="51buypic" id="list_newsScroll">
                                    </ul>
                                    <div class="num">
                                        <ul>
                                           
                                        </ul>
                                    </div>
                                    <div class="prev"></div>
                                    <div class="next"></div>
                                </div>
                            </div>
                            <div class="campus_alerts fr">
                                <div class="title">
                                    <p>
                                        <span class="tit_left fl">
                                            <img src="/YQZJ/images/icon01.png">
                                            <a class="tit">新闻快讯</a>
                                            <a class="english"></a>
                                        </span>
                                        <span class="tit_right fr" style="display: none">
                                            <a href="">更多</a>
                                        </span>
                                    </p>
                                </div>
                                <div class="content">
                                    <ul class="li_list" id="list_news">
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <!--内容中间的-->
                <div class="center_center">
                    <div class="center_center_con main">
                        <div class="center_center_left fl">
                            <div class="left_1 fl" id="modult_wrap">
                            </div>
                        </div>
                        <!--右侧-->
                        <div class="center_center_right fr">
                            <div class="entrance_right5 fr">
                                <div class="title">
                                    <p>
                                        <span class="tit_left fl">
                                            <a class="tit">快速入口</a>
                                            <a class="english">Express Entry</a>
                                        </span>
                                        <span class="tit_right fr" style="display: block">
                                            <a href=""></a>
                                        </span>
                                    </p>
                                </div>
                                <div class="con_con" id="quickenter_list" style="width: 220px; padding-left: 75px;">
                                </div>
                            </div>
                            <div class="entrance_right4 fr">
                                <div class="title">
                                    <p>
                                        <span class="tit_left fl">
                                            <img src="/YQZJ/images/icon01.png" />
                                            <a class="tit">视屏专区</a>
                                            <a class="english"></a>
                                        </span>
                                        <span class="tit_right fr">
                                            <a></a>
                                        </span>
                                    </p>
                                </div>
                                <div class="content">
                                    <p class="icon01" id="playerVideo">
                                        <video width="330" height="225" src="" controls="controls" preload="auto" poster="/YQZJ/images/voidpic.png"></video>
                                    </p>
                                </div>
                            </div>
                            <div class="entrance_right4 fr">
                                <div class="title">
                                    <p>
                                        <span class="tit_left fl">
                                            <img src="/YQZJ/images/icon01.png">
                                            <a class="tit">点击率排行</a>
                                            <a class="english"></a>
                                        </span>
                                        <span class="tit_right fr" style="display: none">
                                            <a href="">更多</a>
                                        </span>
                                    </p>
                                </div>
                                <div class="content">
                                    <ul class="li_list" id="list_statistics">
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--友情链接-->
                <div class="center_bottom">
                    <div class="link main">
                        <div class="title">
                            <p>
                                <span class="tit_left fl"><a href="" class="tit">友情链接</a></span>
                                <span class="tit_right fr"><a href=""></a></span>
                            </p>
                        </div>
                        <div class="content">
                            <div class="img_show">
                                <ul id="list_SysLink">
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="footer" style="height: 44px;"></div>
        </div>
    </form>

    <script type="text/javascript">       

        $(function () {
            initXWKX(1, 10)
            initLINK();
            initClickRate();
            initModult();
            initPlay();
            initKQRK();
        })
        //教育工作，德育工作,科研工作，成效管理，社会培训党建园地
        function initModult() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetMenusItemsData",
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "isPush": 1,
                    "isAll": true,
                    "IsShowIndex": 1,
                     "DisplayCount":8
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $('#modult_wrap').html('');
                        var titles = json.result.retData;
                        if (titles != null && titles.length > 0) {
                            $("#modult").tmpl(titles).appendTo("#modult_wrap");
                        } else {
                            $("#modult").html("暂无数据");
                        }
                        for (i = 0; i < titles.length; i++) {
                            var title = titles[i];
                            var newlists = title.ListData;
                            //使用循环遍历的模式将赋予 selectedID(通过这种方式进行变色的依据，数据绑定)
                            if (newlists != null && newlists.PagedData != null) {
                                var _list = newlists.PagedData;
                                for (var j in _list) {
                                    _list[j].p_ID = title.Id;
                                }
                            }

                            //数据绑定
                            if (newlists != null && newlists.PagedData.length > 0) {
                                if (title.DisplayType == "时间") {
                                    $("#item_list1").tmpl(newlists.PagedData).appendTo('#lists_' + title.Id);
                                } else if (title.DisplayType == "点击量") {
                                    $("#item_list2").tmpl(newlists.PagedData).appendTo('#lists_' + title.Id);
                                }
                            } else {
                                $('#lists_' + title.Id).html('<li><img src="/YQZJ/images/point.png"><span class="text"><a href="javascript:;" target="_blank">暂无数据</a></span></li>');
                            }
                        }
                    } else {
                        $("#modult").html("暂无数据");
                    }
                },
                error: OnError
            });

        }
        //新闻快讯
        function initXWKX(startIndex, pageSize) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdvertisingHandler.ashx",
                    Func: "GetNewData",
                    PageIndex: startIndex,
                    PageSize: pageSize,
                    isPush: 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_news").html('');
                        var items = json.result.retData.PagedData;
                        var newItems = items;
                        var imgs = [];
                        if (newItems != null && newItems.length > 0) {
                            for (var i = 0; i < newItems.length; i++) {
                                if (newItems[i].ImageUrl != "") {
                                    var img = ImgIndex(newItems[i].ImageUrl);
                                    var obj = new Object();
                                    obj.Img = img;
                                    obj.Description = newItems[i].Description;
                                    obj.MenuId = newItems[i].MenuId;
                                    obj.Id = newItems[i].Id;
                                    imgs.push(obj);
                                }
                            }
                           $("#item_newsScroll").tmpl(imgs).appendTo("#list_newsScroll");
                            $("#item_list1").tmpl(items).appendTo("#list_news");
                            jQuery(".slider").hover(function () { jQuery(this).find(".prev,.next").stop(true, true).fadeIn() }, function () { jQuery(this).find(".prev,.next").fadeOut() });
                            $(".slider").slide({
                                titCell: ".num ul", mainCell: ".51buypic", effect: "fold", autoPlay: true, delayTime: 1200, autoPage: true
                            });
                            $('#list_newsScroll img').each(function (index, item) {
                                width = $(item).width();
                                height = $(item).height();
                                if (width > height) {
                                    $(item).width('580px');
                                } else {
                                    $(item).height('320px');
                                }
                            })
                        } else {
                            $("#list_news").html('暂无数据！');
                            $("#list_newsScroll").html("<li><img src=\"YQZJ/images/default.jpg\" /></li>");
                        }

                    }
                    else {
                        $("#list_news").html("暂无信息！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
        //快速入口
        function initKQRK() {
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
                    pageSize: 7
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
        //播放初始化视频
        function initPlay() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": 1095,
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 1,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length == 1) {
                            $("#playerVideo video").attr('src', items[0].FilePath);
                        }
                    } else {
                        $("#playerVideo").html('暂无视频');
                    }
                },
                error: OnError
            });
        }
        //友情链接
        function initLINK() {
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
                    pageSize: 12
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#list_SysLink").html('');
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_syslink").tmpl(items).appendTo("#list_SysLink");
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
        //点击率排行榜
        function initClickRate() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetStatistics",
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize":7,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_statistics").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_list2").tmpl(items).appendTo("#list_statistics");
                        } else {
                            $("#list_statistics").html("<li>暂无数据</li>");
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
