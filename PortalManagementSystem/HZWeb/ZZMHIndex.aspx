<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZZMHIndex.aspx.cs" Inherits="PMSWeb.ZZMHIndex" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" />
    <meta name="keywords" content="北京市门头沟区中等职业学校,门头沟中职,城子职高,职成教集团,门职,门头沟职业教育" /> 
    <title>中职门户</title>
    <link href="/ZZMH/css/reset.css" rel="stylesheet" type="text/css">
    <link href="/ZZMH/css/layout.css" rel="stylesheet" type="text/css">
    <link href="/Scripts/jscrollpane/style/jquery.jscrollpane.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/jscrollpane/scripts/jquery.mousewheel.js"></script>
    <script src="/Scripts/jscrollpane/scripts/jquery.jscrollpane.min.js"></script>
    <script src="/ZZMH/js/jquery.SuperSlide.2.1.1.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="ZZMH/js/common.js"></script>
    <style>
         .scroll-pane
		{
			width: 287px;
			height:200px;
			overflow: auto;
            outline:none;margin:10px 10px 0 10px;
		}
        .slider {
            width: 320px;
            height: 190px;
            position: relative;
            overflow: hidden;
            float: left;
            margin: 10px;
            margin-right: 0;
        }

            .slider li {
                width: 320px;
                height: 190px;
            }

                .slider li a {
                    display: block;
                    width: 320px;
                    height: 190px;
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
                background: url(/ZZMH/images/sprite-clean.png) no-repeat -1px -1px;
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
                background: url(/ZZMH/images/sprite-clean.png) no-repeat -1px -47px;
                z-index: 100;
            }

        .descrition_bg {
            height: 35px;
            width: 320px;
            background: #000;
            opacity: 0.8;
            filter: alpha(opacity=80);
            position: absolute;
            bottom: 0px;
            z-index: 100;
        }

        .descrition {
            height: 35px;
            width: 320px;
            text-align: center;
            font-size: 14px;
            color: #fff;
            line-height: 35px;
            position: absolute;
            bottom: 0px;
            z-index: 111;
        }
    </style>
    <script type="text/x-jquery-tmpl" id="modult">
        <div class="entrance_r fl">
            <div class="title">
                <p>
                    <span class="tit_left fl">
                        <img src="/ZZMH/images/icon01.png">
                        <a class="tit">${Name}</a>
                        <a class="english"></a>
                    </span>
                    <span class="tit_right fr" style="display: block">
                        <a href="/ZZMH/Sitepages/BeforeItemList.aspx?pid=0&id=${Id}" target="_blank">更多</a>
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
            <a href="/ZZMH/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">
                <img src="${Img}" />
                <div class="descrition_bg"></div>
                <p class="descrition">${NameLengthUpdate(Description,15)}</p>
            </a>
        </li>
    </script>
    <script id="item_list1" type="text/x-jquery-tmpl">
        <li>
            <img src="/ZZMH/images/point.png" />
            <span class="text"><a href="/ZZMH/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a></span>
            <span class="date">
                <a>${DateTimeConvert(CreateTime,'MM-dd')}</a>
            </span>
        </li>
    </script>
    <script id="item_list2" type="text/x-jquery-tmpl">
        <li>
            <img src="/ZZMH/images/point.png" />
            <span class="text"><a href="/ZZMH/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a></span>
            <span class="date">
                <a>${ClickNum}</a>
            </span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_syslink">
        <li>
            <a href="${Href}" target="_blank">
                <img src="${ImageUrl}" width="118" height="40"></a>
        </li>
    </script>

    <script type="text/x-jquery-tmpl" id="item_school">
        <li class="teacherphoto">
            <a href="/ZZMH/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}">
                <img src="${}"></a>
        </li>
        <li class="name">
            <a href="/ZZMH/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
        </li>
    </script>

    <script type="text/x-jquery-tmpl" id="item_xywh">
        <%--<p><a href="${Href}" target="_blank"><img src="${ImageUrl}" /></a></p>--%>

        <ul class="everyone fl">
            <li class="teacherphoto">
                <a href="/ZZMH/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">
                    <img src="${Img}"></a>
            </li>
            <li class="name">
                <a href="/ZZMH/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>
            </li>
        </ul>
    </script>

     <script type="text/x-jquery-tmpl" id="item_XXJJ">
        <%--<p><a href="${Href}" target="_blank"><img src="${ImageUrl}" /></a></p>--%>

        <ul >
            <li >
                <a href="/ZZMH/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">
                    <img src="${Img}"></a>
            </li>
          <%--  <li >
                <a href="/ZZMH/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>
            </li>--%>
        </ul>
    </script>
</head>
<body>
    <div id="Header" style="min-height: 282px;"></div>
    <div class="center_center">
        <div class="center_center_con main">
            <!--左侧-->
            <div class="center_center_left fl">
                <div class="left_2">
                    <div class="title">
                        <p>
                            <span class="tit_left fl">
                                <img src="/ZZMH/images/icon01.png"><a class="tit">学校新闻</a>
                            </span>
                            <span class="tit_right" style="display: none"><a href="">更多</a></span>
                        </p>
                    </div>
                    <div class="content">
                        <div class="slider">
                            <ul class="51buypic" id="list_newsScroll">
                            </ul>
                            <div class="prev"></div>
                            <div class="next"></div>
                        </div>
                        <ul class="li_list fl" style="width: 348px; margin-left: 10px;" id="list_news">
                            <li>
                                <img src="/ZZMH/images/point.png">
                                <span class="text">
                                    <a href="">第二十届学生会成员招募大会</a>
                                </span>
                                <span class="date">
                                    <a href="">12-08</a>
                                </span>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="left_1 clearfix" id="modult_wrap">
                </div>
            </div>
            <!--右侧-->
            <div class="center_center_right fr">
                <div class="entrance_right"  >
                    <div class="title">
                        <p>
                            <span class="tit_left fl">
                                <img src="/ZZMH/images/icon02.png">
                                <a class="tit">学校简介</a>
                                <a class="english"></a>
                            </span>
                            <span class="tit_right fr" style="display: none;"><a href="">更多</a>
                            </span>
                        </p>
                    </div>
                    <div class="content"  >
                        <div class="scroll-pane">
                            <div style="align-content:center;left: 0;text-align: center;" id="list_XXJJ"  ></div>
                    </div>
                        
                </div>
                </div>
                <!--公告栏-->
                <div class="entrance_right">
                    <div class="title">
                        <p>
                            <span class="tit_left fl">
                                <img src="/ZZMH/images/icon02.png">
                                <a class="tit">公告栏</a>
                                <a class="english"></a>
                            </span>
                            <span class="tit_right fr" style="display: none">
                                <a href="">更多</a>
                            </span>
                        </p>
                    </div>
                    <div class="content">
                        <ul class="li_list" id="list_tzgg">
                        </ul>
                    </div>
                </div>
                <div class="entrance_right" >
                    <div class="title">
                        <p>
                            <span class="tit_left fl">
                                <img src="/ZZMH/images/icon02.png">
                                <a class="tit">网站综合统计</a>
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
    <div class="clear"></div>
    <div class="center_bottom">
        <div class="center_bottom_con main">
            <!--校园文化-->
            <div class="left_3 main">
                <div class="title">
                    <p>
                        <span class="tit_left fl">
                            <img src="/ZZMH/images/icon01.png">
                            <a class="tit">校园文化</a>
                            <a class="english"></a>
                        </span>
                        <span class="tit_right fr" style="display: block">
                            <a href="/ZZMH/Sitepages/BeforeItemList.aspx?pid=0&id=69" target="_blank" >更多</a>
                        </span>
                    </p>
                </div>
                <div class="content" id="list_xywh">
                </div>
            </div>
            <!--友情链接-->
            <div class="left_3 main">
                <div class="title">
                    <p>
                        <span class="tit_left fl">
                            <img src="/ZZMH/images/icon01.png">
                            <a class="tit">友情链接</a>
                        </span>
                        <span class="tit_right fr">
                           <%-- <a href="/ZZMH/Sitepages/BeforeItemList.aspx?pid=0&id=${Id}">更多</a>--%>
                        </span>
                    </p>
                </div>
                <div class="content">
                    <ul class="link_con" id="list_SysLink">
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div id="footer" style="min-height: 80px;"></div>
    <script>
        $(function () {
            $('#Header').load('/ZZMH/Header.aspx');
            $('#footer').load('/ZZMH/footer.html');
            initModult();
            initXXXW();
            initLINK();
            initXXWH();
            initXXJJ();
            initTZGG1();
            initZHTJ();
        })
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
                    "DisplayCount": 7
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
                            if (newlists != null && newlists.PagedData.length > 0) {
                                if (title.DisplayType == "时间") {
                                    $("#item_list1").tmpl(newlists.PagedData).appendTo('#lists_' + title.Id);
                                } else if (title.DisplayType == "点击量") {
                                    $("#item_list2").tmpl(newlists.PagedData).appendTo('#lists_' + title.Id);
                                }
                            } else {
                                $('#lists_' + title.Id).html('<li><img src="/ZZMH/images/point.png"><span class="text"><a href="javascript:;" target="_blank">暂无数据</a></span></li>');
                            }
                        }
                    } else {
                        $("#modult").html("暂无数据");
                    }
                },
                error: OnError
            });

        }
      
        //学校新闻
        function initXXXW() {
            var MenuId = enumSystemType("学校新闻")
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuId": MenuId,
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 6,
                    //"NotItem": enumSystemType("收获成果") + "," + enumSystemType("多彩活动"),
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_news").html('');
                        var items = json.result.retData;
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
                        } else {
                            $("#list_news").html('暂无数据！');
                            $("#list_newsScroll").html("<li><img src=\"ZZMH/images/default.jpg\" /></li>");
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

        

        //校园文化      
        function initXXWH() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": enumSystemType("校园文化"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 6,
                    //"NotItem": enumSystemType("收获成果") + "," + enumSystemType("多彩活动"),
                    "isPush": 1
                },
                success: function (json) {
                   
                    if (json.result.errMsg == "success") {
                        $("#list_xywh").html();
                        var items = json.result.retData.PagedData;
                        var newItems = items;
                        if (newItems != null && newItems.length > 0) {
                            for (var i = 0; i < newItems.length; i++) {
                                var img = ImgIndex(newItems[i].ImageUrl);
                                items[i].Img = img;
                            }
                            $("#item_xywh").tmpl(items).appendTo("#list_xywh");
                        } else {
                            $("#list_xywh").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        //学校简介      
        function initXXJJ() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuId": enumSystemType("学校简介"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 6,
                    //"NotItem": enumSystemType("收获成果") + "," + enumSystemType("多彩活动"),
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_XXJJ").html();
                        var item = json.result.retData[0];
                        if (item) {
                            $("#list_XXJJ").tmpl(item).appendTo('#list_XXJJ');
                            if (item.CreativeHTML) {
                                var realcrehtml = item.CreativeHTML.replace(new RegExp("pre", "gm"), "p");

                                realcrehtml = "<a target='_black' href='" + "/ZZMH/SitePages/BeforeView.aspx?id=" + enumSystemType("学校简介") + "'>" + realcrehtml + "</a>"

                                $("#list_XXJJ").html(realcrehtml);
                            }



                        } else {
                            $("#list_XXJJ").html("<li>暂无数据</li>");
                        }
                    }

                    //if (json.result.errMsg == "success") {
                    //    $("#list_XXJJ").html();
                    //    var item = json.result.retData[0];
                      
                    //    if (item) {
                    //        var imgs = item.ImageUrl.split(',');
                    //        for (var i in imgs) {
                    //            var img = imgs[i];
                    //            item.Img = img;
                    //        }
                    //        $("#item_XXJJ").tmpl(item).appendTo("#list_XXJJ");
                    //    } else {
                    //        $("#list_XXJJ").html("<li>暂无数据</li>");
                    //    }

                    //}
                },
                error: OnError
            });
        }

        //通知公告
        function initTZGG1() {
            var Id = enumSystemType("通知公告")
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": Id,
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 4,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_tzgg").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            for (var i in items) {
                                $("#item_list1").tmpl(items[i]).appendTo("#list_tzgg");
                            }

                        } else {
                            $("#list_tzgg").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        //综合统计
        function initZHTJ() {
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
                    "PageSize": 5,
                    "NotItem": enumSystemType("咨询电话") + "," + enumSystemType("友情链接") + "," + enumSystemType("横幅图片"),
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

