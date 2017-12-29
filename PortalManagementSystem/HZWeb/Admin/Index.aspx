<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="PMSWeb.Admin.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" />
    <title>后台管理系统</title>
    <link type="text/css" rel="stylesheet" href="/Admin/AdminCss/reset.css" />
    <link type="text/css" rel="stylesheet" href="/Admin/AdminCss/common.css" />
    <link type="text/css" rel="stylesheet" href="/Admin/AdminCss/style.css" />
    <link type="text/css" rel="stylesheet" href="/Admin/AdminCss/iconfont.css" />
    <link type="text/css" rel="stylesheet" href="/Admin/AdminCss/animate.css" />


    <link href="/Scripts/jscrollpane/style/jquery.jscrollpane.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/jscrollpane/scripts/jquery.mousewheel.js"></script>
    <script src="/Scripts/jscrollpane/scripts/jquery.jscrollpane.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/Common.js"></script>

    <script>
        //$(document).ready(function () {


        //alert($.cookie('LoginCookie_Cube'));
        if ($.cookie('LoginCookie_Cube') == null || $.cookie('LoginCookie_Cube') == "null" || $.cookie('LoginCookie_Cube') == undefined || $.cookie('LoginCookie_Cube') == '') {
            //if (SystemWeb == "DYYX") window.location = "/DYYXIndex.aspx";
            if (SystemWeb == "DYYX") window.location.href = '/DYYX/DYYXLogin.aspx';
            else if (SystemWeb == "YQYZ") window.location.href = '/YQYZ/YQYZLogin.aspx';
            else if (SystemWeb == "HZNW") window.location.href = '/HZNW/HZNWLogin.aspx';
            else if (SystemWeb == "HZZS") window.location.href = '/HZZS/HZZSLogin.aspx';
            else if (SystemWeb == "YQZJ") window.location.href = '/YQZJ/YQZJLogin.aspx';
            else if (SystemWeb == "ZZMH") window.location.href = '/ZZMH/ZZMHLogin.aspx';
            else if (SystemWeb == "PreSchool") window.location.href = '/PreSchool/PreSchoolLogin.aspx';
        } 

        //});
    </script>
    <script type="text/javascript">
        $(function () {
            function reSize() {
                $('.box .left').height($(window).height() - 60 + 'px');
                $('.box .right,#iframbox').height($(window).height() - 60 + 'px');
            }
            reSize();
            $(window).resize(function () {
                reSize();
            })
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="LoginName" value="" />
        <input type="hidden" id="RoleId" value="" />
        <div class="wrap">
            <!--头部-->
            <div class="top ms-dialogHidden">
                <div class="topcon">
                    <div class="top_left fl">
                        <div class="logo fl">
                            <%if (SysWeb == "DYYX")
                              { %>
                            <a href="/DYYXindex.aspx">
                                <img src="/DYYX/images/logo.png" style="margin-top: 0;" /></a>
                            <%}
                              else if (SysWeb == "YQYZ")
                              { %>
                            <a href="/YQYZindex.aspx">
                                <img src="/YQYZ/images/logo.png" style="margin-top: 0;" /></a>
                            <%}
                              else if (SysWeb == "HZNW")
                              { %>
                            <a href="/HZNWIndex.aspx">
                                <img src="/HZNW/images/logo.png" style="margin-top: 0;" /></a>
                            <%}
                              else if (SysWeb == "HZZS")
                              { %>
                            <a href="/HZZSIndex.aspx">
                                <img src="/HZZS/images/logo.png" style="margin-top: 0;" />
                            </a>
                            <%}
                              else if (SysWeb == "YQZJ")
                              { %>
                            <a href="/YQZJIndex.aspx">
                                <img src="/YQZJ/images/logo2.png" style="margin-top: 0;" />
                                <span style="color:#fff;margin-left:10px;font-weight:normal;border-left:1px solid #fff;padding-left:10px;">延庆县职业技术教育中心农民网络教育平台</span>
                            </a>
                            <%}
                              else if (SysWeb == "ZZMH")
                              { %>
                            <a href="/ZZMHIndex.aspx">
                                <img src="/ZZMH/images/logo.png" style="margin-top: 0;" /></a>
                            <%}
                              else if (SysWeb == "PreSchool")
                              { %>
                                <a href="/PreSchoolIndex.aspx">
                                <img src="/PreSchool/images/AfterLogo.png" style="margin-top: 0;height:28px;" /></a>
                            <%} %>
                        </div>
                    </div>
                    <div class="top_right fr">
                        <div class="login fl"><a id="hrefback" href="#" target="_blank">返回前台</a></div>
                        <div class="rightcontent fl">

                            <div class="login fl" style="position: relative; cursor: pointer;">
                                <span id="Loginname" style="color: #fff;"></span>
                                <a href="#"><span id="sp_LoginName" name="sp_LoginName" runat="server"></span><b class="jiantou" style="font-weight: bold; font-size: 12px;">▼</b></a>
                                <div class="login_none" style="position: absolute; top: 100%; right: 10px; width: 90px; border-bottom: 0; border: 1px solid #ccc; background: #fff; z-index: 999; display: none;">

                                    <a href="#" onclick="sysloginOut()" style="line-height: 30px; text-align: center; display: block; width: 100%; height: 30px; color: #666;">退出</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                $(function () {
                    $('.login').hover(function () {
                        $(this).find('.jiantou').addClass('active');
                        $(this).find('.login_none').stop().slideDown();
                    }, function () {
                        $(this).find('.jiantou').removeClass('active');
                        $(this).find('.login_none').stop().slideUp();
                    })
                    $('.login_none>span,.login_none>a').hover(function () {
                        $(this).css({ 'background': '#65ce67', 'color': '#fff' });
                    }, function () {
                        $(this).css({ 'background': '#fff', 'color': '#666' });
                    })
                })

            </script>
            <!--头部结束-->
            <div class="clear"></div>
            <div class="center">
                <!--内容区域-->
                <div class="box">
                    <!--左边-->
                    <div class="left" id="sliderbox" style="height: 918px;">
                        <div class="menubox">
                            <div class="aside" style="display: block;"></div>
                            <!--菜单区域-->
                            <div class="menu" id="menubox">
                                <ul id="ul_leftmenu"></ul>
                            </div>
                            <!--end 菜单区域-->
                        </div>
                    </div>
                    <!--右边-->
                    <div class="right" style="height: 918px;">
                        <iframe id="iframbox" src="/Admin/Home.aspx" width="100%" frameborder="0" height="100%" style="height: 918px;"></iframe>
                    </div>
                </div>
            </div>
            <div class="clear"></div>

        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                initHome();

                //绑定左侧导航
                if (SystemWeb == "DYYX") {
                    $("#hrefback").attr("href", "/DYYXIndex.aspx");
                } else if (SystemWeb == "YQYZ") {
                    $("#hrefback").attr("href", "/YQYZIndex.aspx");
                } else if (SystemWeb == "HZNW") {
                    $("#hrefback").attr("href", "/HZNWIndex.aspx");
                } else if (SystemWeb == "HZZS") {
                    $("#hrefback").attr("href", "/HZZSIndex.aspx");
                } else if (SystemWeb == "YQZJ") {
                    $("#hrefback").attr("href", "/YQZJIndex.aspx");
                }
                else if (SystemWeb == "ZZMH") {
                    $("#hrefback").attr("href", "/ZZMHIndex.aspx");
                }
                else if (SystemWeb == "PreSchool") {
                    $("#hrefback").attr("href", "/PreSchoolIndex.aspx");
                }
            });
           

            function loading() {
                var silderBox = document.getElementById("sliderbox");//dom对象
                var adoms = silderBox.getElementsByTagName("a");//这是一个集合对象HTMLCollection对象
                //document.getElementsByClassName document.querySelectorAll(".items");
                var len = adoms.length;
                while (len--) {
                    adoms[len].onclick = function () {
                        var src = this.getAttribute("data-src");

                        //$(".submenu li").each(function(){
                        //$(this).removeClass("selected");
                        // });

                        $(this).parent().addClass("selected").siblings().removeClass("selected");
                        if (src != null) {
                            document.getElementById("iframbox").src = src;
                        }
                    }
                };
            };
            GetUserInfoCookie();
            window.onload = loading;

            function initHome() {

                BindLeftNavigationMenu();
                loading();
            }

            //绑定左侧导航
            function BindLeftNavigationMenu() {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/AdminManagerHandler.ashx",
                        "func": "GetLeftNavigationMenu",
                        "BeforeAfter": "1",
                        "Display": 0,
                        "IsDelete": 0,
                        "isParam": true,
                        "Creator": $("#LoginName").val(),
                        "RoleId": $("#RoleId").val()
                    },
                    success: function (data) {
                        if (data.result != null) {
                            $("#ul_leftmenu").html(data.result.retData);   //绑定菜单

                            $("#menubox").find(".menuclick").click(function () {
                                $(this).parent().toggleClass("selected").siblings().removeClass("selected").find('span').toggleClass('active');
                                $(this).find('span').toggleClass('active');
                                $("#menubox").find('span').not($(this).find('span')).removeClass('active');
                                $(this).next().stop(true, true).slideToggle("fast").end().parent().siblings().find(".submenu")
                                .addClass("animated flipInX").stop(true, true)
                                .slideUp("fast").end();
                            });
                        }
                    },
                    error: function (textStatus) {
                        layer.msg("获取导航出现问题了,请通知管理员!");
                    }
                });
            }

            function GetUserInfoCookie() {
                if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                    var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
                    if (UserInfo != null) {
                        $("#RoleId").val(UserInfo.RoleId);
                        $("#LoginName").val(UserInfo.LoginName);
                        $('#Loginname').html(UserInfo.LoginName);
                    }
                } else {

                }
            }

            function sysloginOut() {
                $.cookie('LoginCookie_Cube', null, { path: '/', secure: false });               
                if (SystemWeb == "YQYZ") {
                    window.location = "/YQYZIndex.aspx";
                } else if (SystemWeb == "DYYX") {
                    window.location = "/DYYXIndex.aspx";
                } else if (SystemWeb == "HZNW") {
                    window.location = "/HZNWIndex.aspx";
                } else if (SystemWeb == "HZZS") {
                    window.location = "/HZZSIndex.aspx";
                } else if (SystemWeb == "YQZJ") {
                    window.location = "/YQZJIndex.aspx";
                }
                else if (SystemWeb == "ZZMH") {
                    window.location = "/ZZMHIndex.aspx";
                }
                else if (SystemWeb == "PreSchool") {
                    window.location = "/PreschoolIndex.aspx";
                }


            }
        </script>
    </form>
</body>
</html>
