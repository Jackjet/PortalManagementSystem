<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Header.aspx.cs" Inherits="PMSWeb.HZZS.Header" %>

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
    <script type="text/javascript" src="/HZZS/js/jquery.SuperSlide.2.1.1.js"></script>
    <script src="/Scripts/Common.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="toptop">
                <div class="top">
                    <!--头部上面的logo-->
                    <div class="top_top">
                        <div class="top_top_con main clearfix">
                            <div class="logo fl">
                                <a style="cursor:pointer;" onclick="ResponstUrl('/HZZSIndex.aspx');">
                                    <img src="/HZZS/images/logo.png" /></a>
                            </div>
                            <div class="telephone">
                            </div>
                        </div>
                    </div>
                    <!--头部下面的 nav-->
                    <div class="top_bottom">
                        <div class="nav">
                            <div id="navbar" class="main">
                                <div class="nav_a">
                                    <ul class="nav_b" id="menuList">

                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--banner-->
            <div class="banner_bg">
                <div class="banner">
                    <div class="slider">
                        <ul class="51buypic" id="sliderA">
                            <li style="background: url(/HZZS/images/banner_01.jpg) no-repeat center top; height: 334px;"></li>
                            <li style="background: url(/HZZS/images/banner_02.jpg) no-repeat center top; height: 334px;"></li>
                            <li style="background: url(/HZZS/images/banner_03.jpg) no-repeat center top; height: 334px;"></li>
                        </ul>
                        <div class="num">
                            <ul>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        $(function () {
            $(function () {
                initMenu();
            })

            function initMenu() {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/AdminManagerHandler.ashx",
                        "func": "GetBeforeMenu",
                        "IsDelete": 0,
                        "Display": 0,
                        "BeforeAfter": 0
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            $("#menuList").html("");
                            $("#menuList").html(json.result.retData);

                            $('.xiala').hover(function () {
                                $(this).find('dt').addClass('hover');
                                $(this).find(".lie").show();
                            }, function () {
                                $(this).find('dt').removeClass('hover');
                                $(this).find(".lie").hide();
                            });
                            var length = $('#menuList>li').length;
                            var width = 100 / length + '%';
                            $('#menuList>li').width(width)
                        }
                    },
                    error: OnError
                });
            }

            function ResponstUrl(url) {
                window.parent.window.location.href = url;
            }


            $(window).resize(function () {
                $('.slider .51buypic').width($(window).width());
                $('.slider .51buypic li').width($(window).width());
            });
            $(".slider").slide({ titCell: ".num ul", mainCell: ".51buypic", effect: "fold", autoPlay: true, delayTime: 700, autoPage: true });

        })

        function ResponstUrl(url) {
            window.parent.window.location.href = url;
        }
    </script>
</body>
</html>
