<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YQYZIndex.aspx.cs" Inherits="PMSWeb.YQYZIndex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>延庆区第一中学</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <link href="/YQYZ/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="/YQYZ/css/layout2.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Scripts/jquery-1.11.2.min.js"></script>

    <script src="/Scripts/jscrollpane/scripts/jquery.mousewheel.js"></script>
    <script src="/Scripts/jscrollpane/scripts/jquery.jscrollpane.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/YQYZ/js/common.js"></script>
    <script src="/YQYZ/js/layer/layer.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/YQYZ/js/jquery.SuperSlide.2.1.1.js"></script>
    <style>
        .slider {
            width: 485px;
            height: 236px;
            position: relative;
            overflow: hidden;
            float: left;
        }

            .slider li {
                width: 485px;
                height: 236px;
            }

                .slider li a {
                    display: block;
                    width: 485px;
                    height: 236px;
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
                background: url(/YQYZ/images/sprite-clean.png) no-repeat -1px -1px;
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
                background: url(/YQYZ/images/sprite-clean.png) no-repeat -1px -47px;
                z-index: 100;
            }

        .descrition_bg {
            height: 35px;
            width: 485px;
            background: #000;
            opacity: 0.8;
            filter: alpha(opacity=80);
            position: absolute;
            bottom: 0px;
            z-index: 100;
        }

        .descrition {
            height: 35px;
            width: 485px;
            text-align: center;
            font-size: 14px;
            color: #fff;
            line-height: 35px;
            position: absolute;
            bottom: 0px;
            z-index: 111;
        }
    </style>

    <script id="item_zxdd" type="text/x-jquery-tmpl">
        <li>
            <span class="mun">${pageIndex()}</span>
            <span class="text">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,25)}</a>
            </span>
            <span class="date"><a>${ClickNum}</a></span>
        </li>
    </script>
    <script id="item_zxdd2" type="text/x-jquery-tmpl">
        <li>
            <span class="mun">${pageIndex()}</span>
            <span class="text">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,25)}</a>
            </span>
            <span class="date"><a>${DateTimeConvert(CreateTime,'MM-dd')}</a></span>
        </li>
    </script>
    <script id="item_zxddimg" type="text/x-jquery-tmpl">
        <li>
            <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">
                <img src="${Img}" />
                <div class="descrition_bg"></div>
                <p class="descrition">${NameLengthUpdate(Description,15)}</p>
            </a>
        </li>
    </script>
    <script id="item_xxtd" type="text/x-jquery-tmpl">
        <li>
            <span class="text">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>

            </span>
            <span class="date"><a>${ClickNum}</a></span>

        </li>
    </script>
    <script id="item_xxtd2" type="text/x-jquery-tmpl">
        <li>
            <span class="text">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>

            </span>
            <span class="date"><a>${DateTimeConvert(CreateTime,'MM-dd')}</a></span>

        </li>
    </script>
    <script id="item_jxhd" type="text/x-jquery-tmpl">
        <li>
            <span class="text">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date"><a>${ClickNum}</a></span>
        </li>
    </script>
    <script id="item_jxhd2" type="text/x-jquery-tmpl">
        <li>
            <span class="text">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date"><a>${DateTimeConvert(CreateTime,'MM-dd')}</a></span>
        </li>
    </script>
    <script id="item_dyzc" type="text/x-jquery-tmpl">
        <li>
            <span class="text">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date"><a>${ClickNum}</a></span>
        </li>
    </script>
    <script id="item_dyzc2" type="text/x-jquery-tmpl">
        <li>
            <span class="text">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date"><a>${DateTimeConvert(CreateTime,'MM-dd')}</a></span>
        </li>
    </script>
    <script id="item_djyd" type="text/x-jquery-tmpl">
        <li>
            <span class="text">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date"><a>${ClickNum}</a></span>
        </li>
    </script>
    <script id="item_djyd2" type="text/x-jquery-tmpl">
        <li>
            <span class="text">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date"><a>${DateTimeConvert(CreateTime,'MM-dd')}</a></span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_xyfc">
        <ul class="activity fl">
            <li class="teacherphoto">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">
                    <img src="${Img}" /></a>
            </li>

        </ul>
    </script>
    <script type="text/x-jquery-tmpl" id="item_jsfc">
        <ul class="activity fl">
            <li class="teacherphoto">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">
                    <img src="${Img}" /></a>
            </li>
        </ul>
    </script>

    <script type="text/x-jquery-tmpl" id="item_xsfc">
        <ul class="activity fl" style="float: left; width: 148px;">
            <li class="teacherphoto">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">
                    <img src="${Img}" /></a>
            </li>
        </ul>
    </script>
    <script type="text/x-jquery-tmpl" id="item_tzgg">
        <li>
            <span class="text fl">
                <a href="javascript:OpenIFrameWindow('通知公告','/YQYZ/SitePages/AnnounceNotice.aspx?id=${MenuId}&advId=${Id}','800px','700px')">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date fr"><a>${DateTimeConvert(CreateTime,'MM-dd')}</a></span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_tzgg2">
        <li>
            <span class="text fl">
                <a href="javascript:OpenIFrameWindow('通知公告','/YQYZ/SitePages/AnnounceNotice.aspx?id=${MenuId}&advId=${Id}','800px','700px')" >${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date fr"><a>${ClickNum}</a></span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_tzgglist1">
        <li>
            <span class="text fl">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date fr"><a>${DateTimeConvert(CreateTime,'MM-dd')}</a></span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_tzgglist2">
        <li>
            <span class="text fl">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a>
            </span>
            <span class="date fr"><a>${ClickNum}</a></span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_statistics">
        <li>
            <span class="text fl"><a target="_blank" href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a></span>
            <span class="date fr"><a>${ClickNum}</a></span>
        </li>
    </script>
    <style>
        .txtScroll {
            padding-bottom: 20px;
            height: 30px;
        }

            .txtScroll ul {
                overflow: hidden;
                height: 30px;
            }

                .txtScroll ul li {
                    line-height: 30px;
                    background: url(/YQYZ/images/notice.png) no-repeat left;
                    padding-left: 30px;
                }

                    .txtScroll ul li a {
                        font-size: 15px;
                    }
    </style>
    <script type="text/x-jquery-tmpl" id="item_scroll">
        <li><a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,35)}</a></li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="header_top" style="position: fixed; top: 0; z-index: 999; width: 100%;"></div>
        <iframe name="htmlHeader" src="/YQYZ/Header.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="326px" style="margin-top: 98px;"></iframe>
        <div class="center" id="centerwrap">
            <!--最新动态-->
            <div id="newRead" class="center_con_top main">
                <div class="txtScroll none" id="txtScroll">
                    <ul id="list_scroll">
                    </ul>
                </div>
                <div class="slider">
                    <ul class="51buypic" id="list_zxddimg">
                    </ul>
                    <div class="prev"></div>
                    <div class="next"></div>
                </div>
                <div class="campus_alerts fr">
                    <div class="title">
                        <p>
                            <span class="tit_left fl">
                                <img src="/YQYZ/Images/icon.png" /><a class="tit">最新导读</a><a class="english"></a></span>
                        </p>
                    </div>
                    <div class="content">
                        <ul class="li_list" id="list_zxdd">
                        </ul>
                    </div>
                </div>
            </div>
            <div class="clear"></div>
            <!--内容中间的-->
            <div class="center_con_center main">
                <div class="center_left fl">
                    <div class="left_1">
                        <div class="entrance fl">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl">
                                        <img src="/YQYZ/images/icon01.png" />
                                        <a class="tit">学习天地</a>
                                        <a class="english"></a>
                                    </span>
                                    <span class="tit_right fr" style="display: block;">
                                        <a href="/YQYZ/SitePages/BeforeItemList.aspx?pid=0&&id=32">更多</a>
                                    </span>
                                </p>
                            </div>
                            <div id="study" class="content" style="width: 322px;">
                                <ul class="li_list" id="list_xxtd">
                                </ul>
                            </div>
                        </div>
                        <div class="entrance_r fl">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl">
                                        <img src="/YQYZ/images/icon01.png" />
                                        <a class="tit">教学园地</a>
                                        <a class="english"></a>
                                    </span>
                                    <span class="tit_right fr" style="display: block;">
                                        <a href="/YQYZ/SitePages/BeforeItemList.aspx?pid=0&&id=27">更多</a>
                                    </span>
                                </p>
                            </div>
                            <div id="educate" class="content" style="width: 322px;">
                                <ul class="li_list" id="list_jxhd">
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="left_1">
                        <div class="entrance fl">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl">
                                        <img src="/YQYZ/images/icon01.png" />
                                        <a class="tit">德育之窗</a>
                                        <a class="english"></a>
                                    </span>
                                    <span class="tit_right fr" style="display: block;">
                                        <a href="/YQYZ/SitePages/BeforeItemList.aspx?pid=0&&id=11">更多</a>
                                    </span>
                                </p>
                            </div>
                            <div id="moral" class="content" style="width: 322px;">
                                <ul class="li_list" id="list_dyzc">
                                </ul>
                            </div>
                        </div>
                        <div class="entrance_r fl">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl">
                                        <img src="/YQYZ/images/icon01.png" />
                                        <a class="tit">党建园地</a>
                                        <a class="english"></a>
                                    </span>
                                    <span class="tit_right fr" style="display: block;">
                                        <a href="/YQYZ/SitePages/BeforeItemList.aspx?pid=0&&id=38">更多</a>
                                    </span>
                                </p>
                            </div>
                            <div id="partyBuid" class="content" style="width: 322px;">
                                <ul class="li_list" id="list_djyd">
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="left_1">
                        <div class="tab_con1">
                            <div class="tab_tit">
                                <ul class="tab_con fl">
                                    <li class="hover"><a href="javascript:;">校园风采</a></li>
                                    <li class=""><a href="javascript:;">教师风采</a></li>
                                    <li class=""><a href="javascript:;">学生风采</a></li>
                                </ul>
                                <ul class="fr">
                                    <li>
                                        <span class="tit_right">
                                            <a href="#" onclick="preview();">更多</a></span>
                                    </li>
                                </ul>
                            </div>
                            <div class="con fl">
                                <!--校园风采-->
                                <div id="con_1" style="display: block;">
                                    <div class="left_1 fl">
                                        <div class="content" style="height: 139px;">
                                            <div class="tempWrap" style="overflow: hidden; position: relative; width: 672px">
                                                <div class="scroll" id="list_xyfc">

                                                    <!--为了让图片滚动-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--教师风采-->
                                <div id="con_2" style="display: none;">
                                    <div class="left_1 fl">
                                        <div class="content" style="height: 139px;">
                                            <div class="scroll" id="list_jsfc">
                                                <!--为了让图片滚动-->


                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--学生风采-->
                                <div id="con_3" style="display: none;">
                                    <div class="left_1 fl">
                                        <div class="content" style="height: 139px;">
                                            <div class="tempWrap" style="overflow: hidden; position: relative; width: 672px">
                                                <div class="scroll" id="list_xsfc">

                                                    <!--为了让图片滚动-->

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="center_right">
                    <div class="message_rignt">
                        <div class="title_message">
                            <p>
                                <span class="tit_left fl">
                                    <img src="/YQYZ/Images/icon(1).png" />
                                    <a class="tit">通知公告</a>
                                    <a class="english"></a>
                                </span>
                                <span class="tit_right fr" style="display: none;">
                                    <a href="/YQYZ/SitePages/BeforeItemList.aspx?id=62">更多</a>
                                </span>
                            </p>
                        </div>
                        <div id="notice" class="con_con">
                            <ul class="li_list" id="list_tzgg">
                            </ul>
                        </div>
                    </div>
                    <div class="message_rignt">
                        <a href="http://61.50.236.206/" target="_blank">
                            <img src="/YQYZ/Images/inner.jpg" /></a>
                    </div>
                    <div class="message_rignt" style="height: 188px;">
                        <div class="title_message">
                            <p>
                                <span class="tit_left fl">
                                    <img src="/YQYZ/Images/icon(1).png" />
                                    <a class="tit">网站综合统计</a>
                                    <a class="english"></a>
                                </span>
                            </p>
                        </div>

                        <div class="con_con">
                            <ul class="li_list" id="list_statistics">
                            </ul>



                        </div>
                    </div>

                    <div class="pagination" style="text-align: center; padding-top: 10px; display: none">
                    </div>

                </div>
                <div class="clear"></div>
                <!--底部-->
                <div class="center_con_bottom main">
                    <div class="entrance_link main">
                        <div class="content_link">
                            <p class="link_con">
                                友情链接： 
			   
                                <span>
                                    <select onchange="if(this.value!=&#39;&#39;) window.open(this.value,&#39;&#39;,&#39;&#39;);">
                                        <option value="http://www.chinaedu.edu.cn/">中国教育网 </option>
                                        <option value="http://www.neea.edu.cn/">中国教育考试网 </option>
                                    </select>
                                </span>
                                <span>
                                    <select onchange="if(this.value!=&#39;&#39;) window.open(this.value,&#39;&#39;,&#39;&#39;);">
                                        <option value="http://www.yqedu.com.cn/">延庆教育委员会 </option>
                                        <option value="http://117.106.85.17/YQYZIndex.aspx">延庆县第一中学 </option>
                                    </select>
                                </span>
                                <span>
                                    <select onchange="if(this.value!=&#39;&#39;) window.open(this.value,&#39;&#39;,&#39;&#39;);">
                                        <option value="http://117.106.85.17/YQYZIndex.aspx">延庆县第一中学 </option>
                                        <option value="http://117.106.85.17/YQYZIndex.aspx">延庆县第一中学 </option>
                                    </select>
                                </span>
                                <span>
                                    <select onchange="if(this.value!=&#39;&#39;) window.open(this.value,&#39;&#39;,&#39;&#39;);">
                                        <option value="http://117.106.85.17/YQYZIndex.aspx">延庆县第一中学 </option>
                                        <option value="http://117.106.85.17/YQYZIndex.aspx">延庆县第一中学 </option>
                                    </select>
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <iframe name="htmlHeader" src="/YQYZ/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="92px" id="htmlFoot"></iframe>
        <link href="/YQYZ/css/layout2.css" rel="stylesheet" type="text/css" />
    </form>

    <script type="text/javascript">
        var PortalTreeDataListDic = new Array();;

        function GetPortalTreeDataByPId() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: "GetPortalTreeDataByPId",
                    IsDelete: 0,
                    Display: 0,
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = [];
                        items = json.result.retData;
                        for (var i = 0; i < items.length; i++) {
                            PortalTreeDataListDic[items[i].Id] = items[i];
                        }
                    }
                    else {

                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        //初始化(获取系统设置信息)
        function GetSystemInfo() {

            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "ReadXmlPage"
                },
                success: function (json) {
                    if (json.result != null) {
                        if (json.result.errMsg == "success") {
                            var dtJson = json.result.retData;

                            if (dtJson.IsShowNotiecRoll == 0) {
                                $('#txtScroll').show();
                            }
                            else {
                                $('#txtScroll').hide();
                            }
                            if (dtJson.NoticeDisplayType == "1") {
                                initTZGG1();
                            }
                            else if (dtJson.NoticeDisplayType == "2") {
                                initTZGG2();
                            }
                            //switch (dtjson.NoticeDisplayType) {
                            //    case 1:
                            //        initTZGG1();
                            //        break;

                            //    case 2:
                            //        initTZGG2();
                            //        break;
                            //    default:

                            //}
                        }
                    }
                },
                error: function (textStatus) {
                    layer.msg("获取设置信息失败!");
                }
            });
        }
        
        $(function () {

            GetPortalTreeDataByPId();
            GetSystemInfo();
          
            initZXDD(1, 7);
            initXXTD();
            initJXHD();
            initDYZC();
            initDJYD();
            initXYFC();
            initJSFC();
            initXSFC();
            
            initZHTJ();
            initScroll();
            $('#header_top').load('/YQYZ/top.aspx')
        })

        //tab切换

        $(document).ready(function () {
            $('.con > div').hide();
            $('.con > div').eq(0).show();
            $(".tab_tit .tab_con li").mouseover(function () {

                $(this).addClass('hover').siblings().removeClass('hover');
                a = $(this).index();
                var textValue = $(this).text();
                var hrefvalue = $("#topmoreurl").attr("flag");
                $("#moreurl").attr("href", hrefvalue + encodeURI(textValue));

                $('.con > div').eq(a).show().siblings().hide();
            });
        });

        function initZXDD(startIndex, pageSize) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdvertisingHandler.ashx",
                    Func: "GetPageListForMenuId",
                    PageIndex: startIndex,
                    PageSize: pageSize,
                    isPush: 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_zxdd").html('');
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
                                    obj.Id = newItems[i].Id;
                                    obj.MenuId = newItems[i].MenuId;
                                    imgs.push(obj);
                                }
                            }

                            var Id = enumSystemType("最新导读")
                            $("#item_zxddimg").tmpl(imgs).appendTo("#list_zxddimg");


                            if (PortalTreeDataListDic[Id].DisplayType == '点击量') {
                                $("#item_zxdd").tmpl(items).appendTo("#list_zxdd");
                            }
                            else if (PortalTreeDataListDic[Id].DisplayType == '时间') {
                                $("#item_zxdd2").tmpl(items).appendTo("#list_zxdd");
                            }

                            jQuery(".slider").hover(function () { jQuery(this).find(".prev,.next").stop(true, true).fadeIn() }, function () { jQuery(this).find(".prev,.next").fadeOut() });
                            $(".slider").slide({
                                titCell: ".num ul", mainCell: ".51buypic", effect: "fold", autoPlay: true, delayTime: 1200, autoPage: true
                            });
                        } else {
                            $("#list_zxdd").html("<li><img src=\"YQYZ/images/default.jpg\" /></li>");
                        }

                    }
                    else {
                        $("#list_zxdd").html("<tr><td colspan='9'>暂无信息！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        //学习天地
        function initXXTD() {

            var Id = enumSystemType("学习天地")
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": Id,
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_xxtd").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            if (PortalTreeDataListDic[Id].DisplayType == '点击量') {
                                $("#item_xxtd").tmpl(items).appendTo("#list_xxtd");
                            }
                            else if (PortalTreeDataListDic[Id].DisplayType == '时间') {
                                $("#item_xxtd2").tmpl(items).appendTo("#list_xxtd");
                            }

                        } else {
                            $("#list_xxtd").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        //教学活动
        function initJXHD() {
            var Id = enumSystemType("教学活动")
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": Id,
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_jxhd").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            if (PortalTreeDataListDic[Id].DisplayType == '点击量') {
                                $("#item_jxhd").tmpl(items).appendTo("#list_jxhd");
                            }
                            else if (PortalTreeDataListDic[Id].DisplayType == '时间') {
                                $("#item_jxhd2").tmpl(items).appendTo("#list_jxhd");
                            }
                        } else {
                            $("#list_jxhd").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        //德育之窗
        function initDYZC() {
            var Id = enumSystemType("德育之窗")
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": Id,
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_dyzc").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            if (PortalTreeDataListDic[Id].DisplayType == '点击量') {
                                $("#item_dyzc").tmpl(items).appendTo("#list_dyzc");
                            }
                            else if (PortalTreeDataListDic[Id].DisplayType == '时间') {
                                $("#item_dyzc2").tmpl(items).appendTo("#list_dyzc");
                            }
                        } else {
                            $("#list_dyzc").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        //党建园地
        function initDJYD() {
            var Id = enumSystemType("党建园地")
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetAdvertising",
                    "MenuIds": Id,
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_djyd").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            if (PortalTreeDataListDic[Id].DisplayType == '点击量') {
                                $("#item_djyd").tmpl(items).appendTo("#list_djyd");
                            }
                            else if (PortalTreeDataListDic[Id].DisplayType == '时间') {
                                $("#item_djyd2").tmpl(items).appendTo("#list_djyd");
                            }

                        } else {
                            $("#list_djyd").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        function preview() {
            var url = "/YQYZ/SitePages/BeforeItemList.aspx?id=99";
            $(".tab_tit .tab_con li").each(function () {
                var hover = $(this).hasClass('hover');
                if (hover) {
                    var text=$(this).text();
                    if (text == "教师风采") {
                       // url = "";
                    }
                    else if (text == "学生风采") {
                       // url = "";
                    }
                }
            });
            window.open(url);
        }

        //校园风采
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
                    "PageSize": 20,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_xyfc").html();
                        var newItems=new Array(5);
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            for (var i = 0; i < items.length; i++) {
                                var imgurl = items[i].ImageUrl;
                                if (imgurl == null || imgurl == "") {
                                }
                                else {
                                    var img = ImgIndex(imgurl);
                                    items[i].Img = img;
                                    newItems.push(items[i]);
                                }
                            }
                            $("#item_xyfc").tmpl(newItems).appendTo("#list_xyfc");
                            jQuery("#con_1").slide({ mainCell: ".scroll", effect: "leftLoop", vis: 4, autoPlay: true });

                        } else {
                            $("#list_xyfc").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        //教师风采
        function initJSFC() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdvertisingHandler.ashx",
                    Func: "GetPageListForMenuId",
                    MenuId: enumSystemType("教师风采"),
                    PageIndex: 1,
                    pageSize: 20
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_jsfc").html();
                        var items = json.result.retData.PagedData;
                        var newItems = items;
                        if (newItems != null && newItems.length > 0) {
                            for (var i = 0; i < newItems.length; i++) {
                                var img = ImgIndex(newItems[i].ImageUrl);
                                items[i].Img = img;
                            }
                            $("#item_jsfc").tmpl(items).appendTo("#list_jsfc");
                            jQuery("#con_2").slide({ mainCell: ".scroll", effect: "leftLoop", vis: 4, autoPlay: true });

                        } else {
                            $("#list_jsfc").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }

        //学生风采
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
                    "PageSize": 20,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_xsfc").html();
                        var items = json.result.retData.PagedData;
                        var newItems = items;
                        if (newItems != null && newItems.length > 0) {
                            for (var i = 0; i < newItems.length; i++) {
                                var img = ImgIndex(newItems[i].ImageUrl);
                                items[i].Img = img;
                            }
                            $("#item_xsfc").tmpl(items).appendTo("#list_xsfc");
                            jQuery("#con_3").slide({ mainCell: ".scroll", effect: "leftLoop", vis: 4, autoPlay: true });
                        } else {
                            $("#list_xsfc").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }
        //滚动列表
        function initScroll() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("通知公告"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 10,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_scroll").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_scroll").tmpl(items).appendTo("#list_scroll");
                            $('.txtScroll').slide({ mainCell: "ul", effect: "topLoop", vis: 1, autoPlay: true, interTime: 3500 });
                        } else {
                            $("#item_scroll").html("<li>暂无数据</li>");
                        }

                    }
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
                            if (PortalTreeDataListDic[Id].DisplayType == '点击量') {
                                $("#item_tzgg").tmpl(items).appendTo("#list_tzgg");
                            }
                            else if (PortalTreeDataListDic[Id].DisplayType == '时间') {
                                $("#item_tzgg2").tmpl(items).appendTo("#list_tzgg");
                            }
                        } else {
                            $("#list_tzgg").html("<li>暂无数据</li>");
                        }

                    }
                },
                error: OnError
            });
        }
        function initTZGG2() {
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
                            if (PortalTreeDataListDic[Id].DisplayType == '点击量') {
                                $("#item_tzgglist1").tmpl(items).appendTo("#list_tzgg");
                            }
                            else if (PortalTreeDataListDic[Id].DisplayType == '时间') {
                                $("#item_tzgglist2").tmpl(items).appendTo("#list_tzgg");
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
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_statistics").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_statistics").tmpl(items).appendTo("#list_statistics");
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
