<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="top.aspx.cs" Inherits="PMSWeb.YQYZ.top" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <%--<link href="/YQYZ/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="/YQYZ/css/layout2.css" rel="stylesheet" type="text/css" />--%>
    <style>
        .search{
            position:relative;z-index:999;
        }
        .select{width:50px;height:31px;float:left;color:#fff;cursor:pointer;}
        .select i{
            width:15px;height:15px;display:block;transform:rotate(90deg);float:right;text-align:center;line-height:15px;margin-top:8px;font-size:16px;
        }
        .select.active i{
            transform:rotate(-90deg);
        }
        .select_none{
            position:absolute;top:100%;z-index:2;left:-1px;width:50px;background:#5c5f68;display:none;
        }
        .select_none span{
            height:30px;display:block;color:#fff;cursor:pointer;
        }
        .select_none span:hover{
            background:#fff;color:#5c5f68;
        }
    </style>
</head>
<body>
    <form id="form1">
    <div>
        <div class="toptop">
            <div class="top">
                <!--头部上面的logo-->
                <div class="top_top">
                    <div class="top_top_con main clearfix" id="SearchAdd">
                        <div class="logo fl">
                            <a onclick="ResponstUrl('/YQYZIndex.aspx')">
                                <img src="/YQYZ/images/logo.png" /></a>
                        </div>
                        <div class="search fr">
                            <div class="select">全部<i>></i></div>
                            <div class="select_none">
                                <span>标题</span><input type="hidden" name="name" value="0" />
                                <span>内容</span><input type="hidden" name="name" value="1" />
                            </div>
                            <input type="hidden" id="searchkey" value="" />
                            <input type="text" name="name" value="" class="search_bg" id="queryText" placeholder="请输入搜索内容"/>
                            <input type="button" name="name" value="搜索" class="btn" id="queryBtn"/>
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
        <script>
            $(function () {
                initMenu();
                //
                $('.select').click(function () {
                    var $hidden = $('.select_none');
                    if ($hidden.is(':hidden')) {
                        $(this).addClass('active');
                        $hidden.stop().slideDown();
                    } else {
                        $hidden.slideUp();
                        $(this).removeClass('active');
                    }
                    return false;
                })
                $('.select_none>span').click(function () {
                    var text = $(this).text();
                    var val = $(this).next('input[type=hidden]').val();
                    $('.select').html(text + '<i>></i>');
                    $('.select').removeClass('active');
                    $('#searchkey').val(val);
                    $('.select_none').slideUp();
                })
                $(document).click(function () {
                    $('.select').removeClass('active');
                    $('.select_none').slideUp();
                })
                //
                $("#queryBtn").on("click", function () {
                    var flag = $('#searchkey').val();
                    if (flag != null && flag != "")
                    {
                        flag += "-";
                    }
                    var key =$.trim($("#queryText").val());
                    if (key != "")
                    {
                        ResponstUrl("/YQYZ/SitePages/SearchContent.aspx?key=" + encodeURI(flag+key));
                    }
                });
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
                            $('#menuList>li').width(width);
                            $('.lie ul.liea li').css('width', '100%');
                        }
                    },
                    error: OnError
                });
            }
            function ResponstUrl(url) {
                window.parent.window.location.href = url;
            }
        </script>
    </div>
    </form>
</body>
</html>
