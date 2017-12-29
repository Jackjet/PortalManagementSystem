<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Header.aspx.cs" Inherits="PMSWeb.HZNW.Header" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title>黄庄职业高中</title>
    <link href="/HZNW/css/reset.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="/HZNW/css/reset.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <!--头部-->
            <div class="top">
                <!--头部上面的logo -->
                <div class="top_topcon main">
                    <div class="logo"><a style="cursor:pointer;" onclick="ResponstUrl('/HZNWIndex.aspx')">
                        <img src="/HZNW/images/logo.png" /></a></div>
                </div>
                <!--头部下面的 nav-->
                <div class="nav" style="position: relative;">
                    <div class="main" id="navbar">
                        <div class="nav_a">
                            <ul class="nav_b" id="menuList">
                                
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
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
                        })
                    }
                },
                error: OnError
            });
        }

        function ResponstUrl(url) {
            window.parent.window.location.href = url;
        }
    </script>
</body>
</html>
