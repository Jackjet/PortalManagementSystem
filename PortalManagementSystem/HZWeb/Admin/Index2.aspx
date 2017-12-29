<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index2.aspx.cs" Inherits="PMSWeb.Admin.Index2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" />
    <title>后台管理系统</title>
    <link type="text/css" rel="stylesheet" href="/Admin/AdminCss/reset.css" />
    <link type="text/css" rel="stylesheet" href="/Admin/AdminCss/common.css" />
    <link type="text/css" rel="stylesheet" href="/Admin/AdminCss/style.css" />
    <link type="text/css" rel="stylesheet" href="/Admin/AdminCss/iconfont.css" />
    <link type="text/css" rel="stylesheet" href="/Admin/AdminCss/animate.css" />

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" />
    <link href="/Scripts/jscrollpane/style/jquery.jscrollpane.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/jscrollpane/scripts/jquery.mousewheel.js"></script>
    <script src="/Scripts/jscrollpane/scripts/jquery.jscrollpane.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/Common.js"></script>
    <link href="AdminCss/sidebar-menu.css" rel="stylesheet" />
    <script src="AdminCss/sidebar-menu.js"></script>
</head>
<body>
    <div class="wrap">
        <!--头部-->
        <div class="top ms-dialogHidden">
            <div class="topcon">
                <div class="top_left fl">
                    <div class="logo fl">
                            
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
        <div class="center">
            <!--内容区域-->
            <div class="box">
                <!--左边-->
                <div class="left" id="sliderbox" style="height: 918px;">
                    <div class="menubox">
                       
                        <!--菜单区域-->
                        <aside class="main-sidebar">
                            <section  class="sidebar">
	                            <ul class="sidebar-menu">
	                              <li class="treeview">
		                            <a href="#">
		                              <span>Dashboard</span>
                                      <i class="fa fa-angle-right pull-right"></i>
		                            </a>
		                            <ul class="treeview-menu">
		                              <li><a href="#"> Dashboard v1</a></li>
		                              <li><a href="#">Dashboard v2</a></li>
		                            </ul>
	                              </li>
	                              <li class="treeview">
		                            <a href="#">
		                              <span>Layout Options</span>
                                        <i class="fa fa-angle-right pull-right"></i>
		                            </a>
		                            <ul class="treeview-menu">
		                              <li><a href="#">Top Navigation</a></li>
		                              <li><a href="#"> Boxed</a></li>
		                              <li><a href="#">Fixed</a></li>
		                              <li><a href="#">Collapsed Sidebar</a>
		                              </li>
		                            </ul>
	                              </li>
	                              <li class="treeview">
		                            <a href="#">
		                              <span>Multilevel</span>
                                       <i class="fa fa-angle-right pull-right"></i>
		                            </a>
		                            <ul class="treeview-menu">
		                              <li><a href="#">Level One</a></li>
		                              <li>
			                            <a href="#">Level One<i class="fa fa-angle-right pull-right"></i></a>
			                            <ul class="treeview-menu">
			                              <li><a href="#">Level Two</a></li>
			                              <li>
				                            <a href="#">Level Two</a>
			                              </li>
			                            </ul>
		                              </li>
		                            </ul>
	                              </li>
	                            </ul>
                              </section>
                             </aside>
                        <!--end 菜单区域-->
                    </div>
                </div>
                <!--右边-->
                <div class="right" style="height: 918px;">
                    <iframe id="iframbox" src="/Admin/Home.aspx" width="100%" frameborder="0" height="100%" style="height: 918px;"></iframe>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            reSize();
            $(window).resize(function () {
                reSize();
            });
            $('.login').hover(function () {
                $(this).find('.jiantou').addClass('active');
                $(this).find('.login_none').stop().slideDown();
            }, function () {
                $(this).find('.jiantou').removeClass('active');
                $(this).find('.login_none').stop().slideUp();
            });
            $('.login_none>span,.login_none>a').hover(function () {
                $(this).css({ 'background': '#65ce67', 'color': '#fff' });
            }, function () {
                $(this).css({ 'background': '#fff', 'color': '#666' });
            });
        })
        function reSize() {
            $('.box .left').height($(window).height() - 60 + 'px');
            $('.box .right,#iframbox').height($(window).height() - 60 + 'px');
        }

        $.sidebarMenu($('.sidebar-menu'));
    </script>
</body>
</html>
