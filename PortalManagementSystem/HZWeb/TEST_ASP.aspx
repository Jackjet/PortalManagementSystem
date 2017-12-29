<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TEST_ASP.aspx.cs" Inherits="PMSWeb.TEST_ASP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">


    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>

<link rel="stylesheet" href="/YQZJ/css/reset.css" />
<link rel="stylesheet" href="/YQZJ/css/layout.css" />
<script src="/Scripts/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="/YQZJ/js/jquery.easing.1.3.js"></script>
<script src="/YQZJ/js/jquery.skitter.min.js"></script>
<script src="/Scripts/Common.js"></script>
<script src="/Scripts/jquery.tmpl.js"></script>
<script src="/YQZJ/js/common.js"></script>
<script src="/Scripts/json2.js"></script>
<body>
    <form id="form1" runat="server">
        <div>


        </div>
    </form>
    

</body>
<script type="text/javascript">
    $(function () {
        initXWKX(1, 7);
    });

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
                IsDelete: 0,
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
                        jQuery(".slider").hover(function () {
                            jQuery(this).find(".prev,.next").stop(true,
true).fadeIn()
                        }, function () { jQuery(this).find(".prev,.next").fadeOut() });
                        $(".slider").slide({
                            titCell: ".num ul", mainCell: ".51buypic", effect: "fold", autoPlay: true, delayTime:
1200, autoPage: true
                        });
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
    

</script>

</html>

<%--$(function () {
        $.ajax({
            type: "Post",
            url: "/Common.ashx",
            async: false,
            dataType: "json",
            data: {
                "PageName": "DYYX/AdvertisingHandler.ashx",
                "func": "GetMenusItemsData",
                "IsDelete": 0,             
                "isPush": 1,
                "isAll": true,
                //"IsShowIndex": 1
                "MenuIds":35
            },
            success: function (json) {
                if (json.result.errMsg == "success") {
                }
            },
            error: OnError
        });
    })--%>

<%--通过一级菜单的id获取二级菜单的数据（附近导读数据）--%>
 <%--$(function () {
        $.ajax({
            type: "Post",
            url: "/Common.ashx",
            async: false,
            dataType: "json",
            data: {
                "PageName": "DYYX/AdvertisingHandler.ashx",
                "func": "GetMenusItemsData",
                "IsDelete": 0,             
                "isPush": 1,
                "isAll": true,
                //"IsShowIndex": 1
                "MenuIds":35
            },
            success: function (json) {
                if (json.result.errMsg == "success") {
                }
            },
            error: OnError
        });
    })--%>

<%--获取新闻导读--%>
 <%--$(function () {
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "DYYX/AdvertisingHandler.ashx",
                Func: "GetNewData",
                PageIndex: 1,
                PageSize: 12,
                isPush: 1
            },
            success: function (json) {
                if (json.result.errMsg == "success") {
                }
            },
            error: OnError
        });
    --%>})


<%--友情链接--%>
 <%--$(function () {
        $.ajax({
            type: "Post",
            url: "/Common.ashx",
            async: false,
            dataType: "json",
            data: {
                "PageName": "DYYX/AdminManagerHandler.ashx",
                "func": "GetLinkList",
                "IsDelete": 0,
                "PageIndex": 1,                
                "PageSize": 12,
                "isPush": 1                          
            },
            success: function (json) {
                if (json.result.errMsg == "success") {
                }
            },
            error: OnError
        });
    })--%>

<%--获取菜单下的子菜单（首页模块化，包含排序）--%>
<%--<script type="text/javascript">

   $(function () {
        $.ajax({
            type: "Post",
            url: "/Common.ashx",
            async: false,
            dataType: "json",
            data: {
                "PageName": "DYYX/AdvertisingHandler.ashx",
                "func": "GetMenusItemsData",
                "IsDelete": 0,              
                "PageSize": 9,
                "isPush": 1,
                "isAll": true,
                "IsShowIndex": 1
            },
            success: function (json) {
                if (json.result.errMsg == "success") {
                }
            },
            error: OnError
        });
    })



</script>--%>

<%--获取菜单 分一级二级三级--%>
<%--$(function () {
        $.ajax({
            type: "Post",
            url: "/Common.ashx",
            async: false,
            dataType: "json",
            data: {
                "PageName": "DYYX/AdvertisingHandler.ashx",
                "func": "GetMenuOwnLevel",
                "IsDelete": 0,              
                "isPush": 1,              
                "MenuLevelIndex": 1

            },
            success: function (json) {
                if (json.result.errMsg == "success") {


                }
            },
            error: OnError
        });
    })--%>
