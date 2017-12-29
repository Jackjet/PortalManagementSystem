<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Header.aspx.cs" Inherits="PMSWeb.DYYX.Header" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
   <%-- <link href="/DYYX/css/reset.css" rel="stylesheet" type="text/css">
    <link href="/DYYX/css/layout.css" rel="stylesheet" type="text/css">
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/Common.js"></script>--%>
</head>
<body>
    <form id="form1" runat="server">
        <div class="top">
            <!--头部上面的logo-->
            <div class="logo main">
                <a href="javascript:;" onclick="ResponstUrl('/DYYXIndex.aspx')">
                    <img src="/DYYX/images/logo.png"></a>
            </div>
            <!--头部下面的 nav-->
            <div class="nav">
                <div class="nav_a main">
                    <ul class="nav_b" id="menuList">
                        
                    </ul>
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
