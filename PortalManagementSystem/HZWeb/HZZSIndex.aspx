<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HZZSIndex.aspx.cs" Inherits="PMSWeb.HZZSIndex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title>北京市黄庄职业高中</title>
    <link rel="stylesheet" href="/HZZS/css/reset.css" />
    <link rel="stylesheet" href="/HZZS/css/layout.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/HZZS/js/common.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script type="text/javascript" src="/HZZS/js/jquery.SuperSlide.2.1.1.js"></script>

    <script type="text/x-jquery-tmpl" id="item_zsdt">
        <li>
            <span class="text">
                <img src="/HZZS/images/point.png">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,25)}</a>
            </span>
            <span class="date"><a>${DateTimeConvert(CreateTime,'MM-dd')}</a></span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_zskx">
        <li>
            <span class="text">
                <img src="/HZZS/images/point.png">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>
            </span>
        </li>

    </script>
    <script type="text/x-jquery-tmpl" id="item_tszy">
        <ul class="everyone fl">
            <li class="teacherphoto">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">
                    <img src="${Img}">
                </a>
            </li>
            <li class="name">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
            </li>
        </ul>

    </script>
    <script type="text/x-jquery-tmpl" id="item_jydt">
        <li>
            <span class="text">
                <img src="/HZZS/images/point.png">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,25)}</a>
            </span>
            <span class="date"><a>${DateTimeConvert(CreateTime,'MM-dd')}</a></span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_zcjd">
        <li>
            <span class="text">
                <img src="/HZZS/images/point.png" />
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>
            </span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_xxhj">
        <ul class="everyone fl">
            <li class="teacherphoto">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">
                    <img src="${Img}">
                </a>
            </li>
            <li class="name">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
            </li>
        </ul>
    </script>
    <script type="text/x-jquery-tmpl" id="item_sthj">
        <ul class="everyone fl">
            <li class="teacherphoto">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">
                    <img src="${Img}">
                </a>
            </li>
            <li class="name">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
            </li>
        </ul>

    </script>
    <script type="text/x-jquery-tmpl" id="item_sshj">
        <ul class="everyone fl">
            <li class="teacherphoto">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">
                    <img src="${Img}">
                </a>
            </li>
            <li class="name">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
            </li>
        </ul>

    </script>
    <script type="text/x-jquery-tmpl" id="item_xyfc">
        <ul class="everyone fl">
            <li class="teacherphoto">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">
                    <img src="${Img}">
                </a>
            </li>
            <li class="name">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
            </li>
        </ul>

    </script>
    <script type="text/x-jquery-tmpl" id="item_jsfc">
        <ul class="everyone fl">
            <li class="teacherphoto">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">
                    <img src="${Img}">
                </a>
            </li>
            <li class="name">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
            </li>
        </ul>

    </script>
    <script type="text/x-jquery-tmpl" id="item_xsfc">
        <ul class="everyone fl">
            <li class="teacherphoto">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">
                    <img src="${Img}">
                </a>
            </li>
            <li class="name">
                <a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
            </li>
        </ul>

    </script>
    <script type="text/x-jquery-tmpl" id="item_syslink">
        <li class="fl">
            <a href="${Href}" target="_blank">
                <img src="${ImageUrl}"></a>
        </li>
    </script>
</head>
<body>
    <iframe name="htmlHeader" src="/HZZS/Header.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="480px"></iframe>
    <div class="center_con_center main">
        <div class="wrap mt10 clearfix">
            <div class="wrap_left fl">
                <div class="title_message">
                    <p>
                        <span class="tit_left fl">
                            <img src="/HZZS/images/icon.png">
                            <a class="tit">招生动态</a>
                            <a class="english"></a>
                        </span>
                        <span class="tit_right fr">
                            <a href="/HZZS/SitePages/BeforeItemList.aspx?id=19">更多</a>
                        </span>
                    </p>
                </div>
                <div class="content">
                    <div class="list_tu fl">
                        <img src="" id="imgzsdt" />
                    </div>
                    <ul class="li_list fl li_lista" id="list_zsdt">
                    </ul>
                </div>
            </div>
            <div class="wrap_right fr">
                <div class="title_message">
                    <p>
                        <span class="tit_left fl">
                            <img src="/HZZS/images/icon.png">
                            <a class="tit">招生快讯</a>
                            <a class="english"></a>
                        </span>
                    </p>
                </div>
                <div class="content">
                    <ul class="li_list" id="list_zskx">
                    </ul>
                </div>
            </div>
        </div>
        <div class="mt10 wrap1">
            <div class="title_message">
                <p>
                    <span class="tit_left fl">
                        <img src="/HZZS/images/icon.png">
                        <a class="tit">特色专业</a>
                        <a class="english"></a>
                    </span>
                    <span class="tit_right fr">
                        <a href="/HZZS/SitePages/BeforeItemList.aspx?id=6">更多</a>
                    </span>
                </p>
            </div>
            <div class="content" id="list_tszy">
            </div>
        </div>
        <div class="wrap mt10 clearfix">
            <div class="wrap_left fl">
                <div class="title_message">
                    <p>
                        <span class="tit_left fl">
                            <img src="/HZZS/images/icon.png">
                            <a class="tit">就业动态</a>
                            <a class="english"></a>
                        </span>
                        <span class="tit_right fr">
                            <a href="/HZZS/SitePages/BeforeItemList.aspx?id=20">更多</a>
                        </span>
                    </p>
                </div>
                <div class="content">
                    <div class="list_tu fl">
                        <img src="/HZZS/images/list_tu.jpg" />
                    </div>
                    <ul class="li_list fl li_lista" id="list_jydt">
                    </ul>
                </div>
            </div>
            <div class="wrap_right fr">
                <div class="title_message">
                    <p>
                        <span class="tit_left fl">
                            <img src="/HZZS/images/icon.png">
                            <a class="tit">政策解读</a>
                            <a class="english"></a>
                        </span>
                    </p>
                </div>
                <div class="content">
                    <ul class="li_list" id="list_zcjd">
                    </ul>
                </div>
            </div>
        </div>
        <div class="wrap1 mt10">
            <div class="nav_tu">
                <a href="javascript:;" class="on">学习环境</a>
                <a href="javascript:;">食堂环境</a>
                <a href="javascript:;">宿舍环境</a>
            </div>
            <div class="content">
                <div class="con_1" style="height:160px;">
                    <div class="scroll" id="list_xxhj">
                    </div>
                </div>
                <div class="con_2 none" style="height:160px;">
                    <div class="scroll" id="list_sthj">
                    </div>
                </div>
                <div class="con_3 none" style="height:160px;">
                    <div class="scroll" id="list_sshj">
                    </div>

                </div>
            </div>
        </div>
        <div class="wrap1 mt10">
            <div class="nav_tu">
                <a href="javascript:;" class="on">校园风采</a>
                <a href="javascript:;">教师风采</a>
                <a href="javascript:;">学生风采</a>
            </div>
            <div class="content">
                <div class="con_1" style="height:160px;">
                    <div class="scroll" id="list_xyfc">
                    </div>
                </div>
                <div class="con_2 none" style="height:160px;">
                    <div class="scroll" id="list_jsfc">
                    </div>
                </div>
                <div class="con_3 none" style="height:160px;">
                    <div class="scroll" id="list_xsfc">
                    </div>

                </div>
            </div>
        </div>
        <div class="wrap1 mt10 mb10">
            <div class="title_message">
                <p>
                    <span class="tit_left fl">
                        <img src="/HZZS/images/icon.png">
                        <a class="tit">合作企业</a>
                        <a class="english"></a>
                    </span>
                    <span class="tit_right fr">
                        <a href="#">更多</a>
                    </span>
                </p>
            </div>
            <div class="content">
                <div class="link">
                    <ul class="scroll" id="list_syslink">
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <iframe name="htmlHeader" src="/HZZS/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="92px"></iframe>
    <script>
        $(function () {
            $('.nav_tu a').each(function () {
                $(this).hover(function () {
                    $(this).addClass('on').siblings().removeClass('on');
                    var n = $(this).index();
                    $(this).parent().next().children().eq(n).show().siblings().hide();

                })
            })
           

            initZSDT();//招生动态
            initZSKX();//招生快讯
            initTSZY();//特色专业
            initJYDT();//就业动态
            initZCJD();//政策解读
            initXXHJ();//学习环境
            initSTHJ();//食堂环境
            initSSHJ();//宿舍环境
            initXYFC();//校园风采
            initJSFC();//教师风采
            initXSFC();//学生风采
            initLINK();//友情链接
        })

        function initZSDT() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("招生动态"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush":1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_zsdt").html();
                        var items = json.result.retData.PagedData;
                        var newItems = items;
                        var imgUrl = "";
                        if (newItems != null && newItems.length > 0) {
                            for (var i = 0; i < newItems.length; i++) {
                                if (imgUrl != "") break;
                                var imgstr = newItems[i].ImageUrl;
                                if (imgstr != null && imgstr != "" && imgstr.length > 0) {
                                    var imgArry = imgstr.split(',');
                                    for (var j = 0; j < imgArry.length; j++) {
                                        if (imgArry[j] != "" && imgArry[j] != null) {
                                            imgUrl = imgArry[j];
                                            $("#imgzsdt").attr("src", imgUrl);
                                            break;
                                        }
                                    }
                                }
                            }
                            $("#item_zsdt").tmpl(items).appendTo("#list_zsdt");
                        } else {
                            $("#list_zsdt").html("<li>暂无数据</li>");
                        }
                    } else {
                        $("#list_zsdt").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

        function initZSKX() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("招生快讯"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_zskx").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_zskx").tmpl(items).appendTo("#list_zskx");
                        } else {
                            $("#list_zskx").html("<li>暂无数据</li>");
                        }
                    } else {
                        $("#list_zskx").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

        function initTSZY() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("特色专业"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_tszy").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].ImageUrl != "" && items[i].ImageUrl != null) {
                                    items[i].Img = ImgIndex(items[i].ImageUrl);
                                }
                            }
                            $("#item_tszy").tmpl(items).appendTo("#list_tszy");
                        } else {
                            $("#list_tszy").html("<li>暂无数据</li>");
                        }
                    } else {
                        $("#list_tszy").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

        function initJYDT() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("就业动态"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_jydt").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_jydt").tmpl(items).appendTo("#list_jydt");
                        } else {
                            $("#list_jydt").html("<li>暂无数据</li>");
                        }
                    } else {
                        $("#list_jydt").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

        function initZCJD() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("政策解答"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_zcjd").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_zcjd").tmpl(items).appendTo("#list_zcjd");
                        } else {
                            $("#list_zcjd").html("<li>暂无数据</li>");
                        }
                    } else {
                        $("#list_zcjd").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

        function initXXHJ() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("学习环境"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_xxhj").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].ImageUrl != "" && items[i].ImageUrl != null) {
                                    items[i].Img = ImgIndex(items[i].ImageUrl);
                                }
                            }
                            $("#item_xxhj").tmpl(items).appendTo("#list_xxhj");
                            $('.con_1').slide({ mainCell: ".scroll", effect: "leftLoop", vis: 6, autoPlay: true });
                        } else {
                            $("#list_xxhj").html("<li>暂无数据</li>");
                        }
                    } else {
                        $("#list_xxhj").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

        function initSTHJ() {

        }

        function initSSHJ() {

        }

        function initXYFC() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("校园风采"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_xyfc").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].ImageUrl != "" && items[i].ImageUrl != null) {
                                    items[i].Img = ImgIndex(items[i].ImageUrl);
                                }
                            }
                            $("#item_xyfc").tmpl(items).appendTo("#list_xyfc");
                            $('.con_1').slide({ mainCell: ".scroll", effect: "leftLoop", vis: 6, autoPlay: true });
                        } else {
                            $("#list_xyfc").html("<li>暂无数据</li>");
                        }
                    } else {
                        $("#list_xyfc").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

        function initJSFC() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("教师风采"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_jsfc").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].ImageUrl != "" && items[i].ImageUrl != null) {
                                    items[i].Img = ImgIndex(items[i].ImageUrl);
                                }
                            }
                            $("#item_jsfc").tmpl(items).appendTo("#list_jsfc");
                            $('.con_2').slide({ mainCell: ".scroll", effect: "leftLoop", vis: 6, autoPlay: true });
                        } else {
                            $("#list_jsfc").html("<li>暂无数据</li>");
                        }
                    } else {
                        $("#list_jsfc").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

        function initXSFC() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("学生风采"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_xsfc").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].ImageUrl != "" && items[i].ImageUrl != null) {
                                    items[i].Img = ImgIndex(items[i].ImageUrl);
                                }
                            }
                            $("#item_xsfc").tmpl(items).appendTo("#list_xsfc");
                            $('.con_3').slide({ mainCell: ".scroll", effect: "leftLoop", vis: 6, autoPlay: true });
                        } else {
                            $("#list_xsfc").html("<li>暂无数据</li>");
                        }
                    } else {
                        $("#list_xsfc").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

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
                    pageSize: 7
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#list_syslink").html('');
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_syslink").tmpl(items).appendTo("#list_syslink");
                        } else {
                            $("#list_syslink").html("暂无数据");
                        }
                        $('.link').slide({ mainCell: ".scroll", effect: "leftLoop", vis: 8, autoPlay: true });
                    }
                    else {
                        $("#list_syslink").html("暂无数据");
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
