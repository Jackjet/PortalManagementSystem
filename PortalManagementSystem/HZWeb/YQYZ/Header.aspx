<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Header.aspx.cs" Inherits="PMSWeb.YQYZ.Header" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <link href="/YQYZ/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="/YQYZ/css/layout2.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/YQYZ/js/common.js"></script>
    <script src="/YQYZ/js/jquery.SuperSlide.2.1.1.js"></script>
    <script type="text/javascript">
        $(function () {
            $(window).resize(function () {
                $('.slider .51buypic').width($(window).width());
                $('.slider .51buypic li').width($(window).width());
            });

        })
    </script>
    <script type="text/x-jquery-tmpl" id="item_slider">
        <li style="background: url(${ImageUrl}) no-repeat center top; height: 326px;"></li>
    </script>
    <style>
          .slider {
            width: 100%;
            height: 326px;
            position: relative;
            overflow: hidden;
        }
            .slider ul li a {
                display: block;
                width: 100%;
                height: 326px;
            }
            .slider ul li a img{width:100%; vertical-align:top;  } 

            /*数字按钮样式*/
            .slider .num {
                
                height: 14px;
                bottom: 15px;
                position: absolute;
                right:25%;
                z-index: 1;
            }

                .slider .num ul {
                    
                    height: 14px;
                    vertical-align: top;
                }

                .slider .num li {
                    display: inline-block;
                    width: 12px;
                    text-indent: -9999px;
                    height: 12px;
                    float: left;
                    border-radius: 100%;
                    background: #666;
                    margin-left: 10px;
                    cursor: pointer;
                }

                    .slider .num li.on {
                        background: #3174f3;
                    }
    </style>
</head>
<body>
    <input runat="server" id="scrollNum" type="hidden" />
    
    <div class="clear"></div>
    <!--banner-->
        <!--banner-->
        <div class="banner_bg" style="background:#fff;">
            <div class="banner">
                <div class="slider">
                    <ul class="51buypic" id="sliderA"></ul>
                    <div class="num">
                        <ul></ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    <script type="text/javascript">
        //(function searchShow() {
        //    var params = getQueryString("query");
        //    if (params !=null && params=="query") {
        //        $('#SearchAdd').append('');
        //    }
        //})();
        $(function () {
            initBanner();  
        })



        function initBanner() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/SchoolStyleHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": enumSystemType("首页滚动图片"),
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": $("#scrollNum").val(),
                    "isPage": true
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#sliderA").html();
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $("#item_slider").tmpl(items).appendTo("#sliderA");
                        } else {
                            $("#sliderA").html("<li>暂无数据</li>");
                        }
                        $(".slider").slide({ titCell: ".num ul", mainCell: ".51buypic", effect: "fold", autoPlay: true, delayTime: 700, autoPage: true });
                        //jQuery(".slider").slide({ titCell: ".num ul", mainCell: ".51buypic", effect: "leftLoop", vis: "auto", autoPlay: true, autoPage: true, trigger: "click" });
                    }
                },
                error: OnError
            });
        }

       

        //banner
        //function initBanner() {
        //    $.ajax({
        //        type: "Post",
        //        url: "/Common.ashx",
        //        async: false,
        //        dataType: "json",
        //        data: {
        //            PageName: "DYYX/AdvertisingHandler.ashx",
        //            Func: "GetPageListForMenuId",
        //            PageIndex: 1,
        //            PageSize: 7,
        //        },
        //        success: function (json) {
        //            if (json.result.errMsg == "success") {
        //                $("#sliderA").html();
        //                var items = json.result.retData.PagedData;
        //                if (items != null && items.length > 0) {
        //                    var dataImgs = [];
        //                    for (var i = 0; i < 7; i++) {
        //                        if (i > items.length - 1) break;
        //                        var imgstr = items[i].ImageUrl;
        //                        if (imgstr != null && imgstr != "" && imgstr.length > 0) {
        //                            var imgArry = imgstr.split(',');
        //                            for (var j = 0; j < imgArry.length; j++) {
        //                                if (imgArry[j] != "" && imgArry[j] != null) {
        //                                    var imgObj = new Object();
        //                                    imgObj.url = imgArry[j];
        //                                    imgObj.desc = items[i].Description;
        //                                    dataImgs.push(imgObj);
        //                                }
        //                            }
        //                        }
        //                    }
        //                    if (dataImgs.length != 0) {
        //                        $("#item_slider").tmpl(dataImgs).appendTo("#sliderA");
        //                    } else {
        //                        $("#sliderA").html("暂无数据");
        //                    }
        //                } else {
        //                    $("#sliderA").html("暂无数据");
        //                }
        //            }
        //        },
        //        error: OnError
        //    });
        //}

       
    </script>
</body>
</html>
