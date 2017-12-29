<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Header.aspx.cs" Inherits="PMSWeb.ZZMH.Header" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" />
    <title></title>
</head>
<%--<script type="text/javascript"  src="/Scripts/jquery-1.11.2.min.js"></script>
<script src="js/common.js"></script>--%>
<body>


    <div class="top main">
        <!--头部上面的logo-->
        <div class="top_top">

                <a href="/ZZMHIndex.aspx" class="logo fl"><img src="/ZZMH/images/logo.png"></a>

        </div>

        <!--头部下面的 nav-->
        <div class="nav">
            <div class="nav_a main">
                <ul class="nav_b" id="menuList">
                </ul>
            </div>
        </div>
    </div>
        <script>
            $(function () {
                initMenu();
                //hengfu();
                //lianxi();
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

                            var _id = getQueryString('selectPid');

                            if (_id != null) {

                                $('#menuList a').each(function () {
                                    var id = $(this).attr('SelfID');
                                   
                                    if (id == _id) {
                                        //console.log(_id)
                                        $(this).parents('li').addClass('hover');                                  
                                    }

                                })
                            }
                            //下拉列表
                            $(".xiala").mouseover(function () {
                                $(this).find(".lie").show();
                                $(this).find("dt").addClass("hover");
                            });
                            $(".xiala").mouseout(function () {
                                $(this).find(".lie").hide();
                                $(this).find("dt").removeClass("hover");
                            })
                        }
                    },
                    error: OnError
                });
            }

            function hengfu() {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/AdvertisingHandler.ashx",
                        "func": "GetAdvertising",
                        "MenuId": enumSystemType("横幅图片"),
                        "IsDelete": 0,
                        "isPush": 1
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            $("#baine").html();
                            var item = json.result.retData[0];
                            if (item) {

                                if (item.CreativeHTML) {
                                    var realcrehtml = item.CreativeHTML.replace(new RegExp("pre", "gm"), "p");
                                    $("#baine").html(realcrehtml);
                                }
                            } else {
                                $("#baine").html("<li>暂无数据</li>");
                            }
                        }
                    },
                    error: OnError
                });
            }

            function lianxi() {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/AdvertisingHandler.ashx",
                        "func": "GetAdvertising",
                        "MenuId": enumSystemType("咨询电话"),
                        "IsDelete": 0,
                        "isPush": 1
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            $("#lianxi").html();
                            var item = json.result.retData[0];
                            if (item) {

                                if (item.CreativeHTML) {
                                    var realcrehtml = item.CreativeHTML.replace(new RegExp("pre", "gm"), "p");
                                    $("#lianxi").html(realcrehtml);
                                }
                            } else {
                                $("#lianxi").html("<li>暂无数据</li>");
                            }
                        }
                    },
                    error: OnError
                });
            }

            function ResponstUrl(url) {
                window.parent.window.location.href = url;
            }

            //function OnError()
            //{

            //}
        </script>
</body>
</html>
