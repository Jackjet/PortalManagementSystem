<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DepartmentIndex.aspx.cs" Inherits="PMSWeb.HZNW.Category.DepartmentIndex" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <title>黄庄职业高中</title>
    <link href="/HZNW/css/reset.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css"   id="layout"/>
    <link href="/HZNW/css/iconfont.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/HZNW/js/common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script>
        $(function () {
            
        })
    </script>
    <script type="text/x-jquery-tmpl" id="item_xbdt">
        <li>
            <div class="dates fl">
                <span class="date">${DateTimeConvert(CreateTime,'MM-dd')}</span>
                <em><i></i></em>
            </div>
            <span class="gif_list_news fr"><a href="/HZNW/Category/DepartmentBeforeView.aspx?advid=${Id}&id=${MenuId}" target="_blank">${NameLengthUpdate(Description,15)}</a></span>
        </li>
    </script>
    <script type="text/x-jquery-tmpl" id="item_banner">
        <a href="${BeforeUrl}" class="${EnName}">
            <i class="iconfont icon-${EnName}"></i>
            <span>${Name}</span>
        </a>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="hidType" />
        <input type="hidden" id="hidId"  runat="server"/>
        <asp:HiddenField ID="hspid" runat="server" />
        <div>
            <div id="header"></div>
            <div class="main wrap">
                <div class="banner">
                    <img  id="banner"/>
                </div>
                <div class="clearfix" style="padding-top: 30px;">
                    <div class="department_brief fl">
                        <div class="title">
                            <p>
                                <span class="tit_left fl">
                                    <a href="#" class="ENG">ABOUT</a><a class="tit">学部简介</a></span>
                                <span class="tit_right fr" style="display: block"><a href="" id="xbjjmore">查看更多+</a></span>
                            </p>
                        </div>
                        <div class="clear"></div>
                        <div class="school_year fl">
                            <ul>
                                <li class="active">
                                    <span class="fl">1981</span>
                                    <i></i>
                                </li>
                                <li>
                                    <span class="fr">1982</span>
                                    <i></i>
                                </li>
                                <li>
                                    <span class="fl">1983</span>
                                    <i></i>
                                </li>
                                <li>
                                    <span class="fr">......</span>
                                    <i></i>
                                </li>
                                <li>
                                    <span class="fl">2016</span>
                                    <i></i>
                                </li>
                            </ul>
                        </div>
                        <p class="fl school_jian" id="list_xxjj">
                        </p>
                        <div class="school_img fr">
                            <img src="/HZNW/images/school_img.jpg" />
                        </div>
                    </div>
                    <div class="department_dynamics fr">
                        <div class="title">
                            <p>
                                <span class="tit_left fl">
                                    <a href="#" class="ENG">NEWS</a><a class="tit">学部动态</a>
                                </span>
                                <span class="tit_right fr" style="display: block">
                                    <a href="" id="xbdtmore">查看更多+</a>
                                </span>
                            </p>
                        </div>
                        <div class="clear"></div>
                        <ul class="li_list" id="list_xbdt">
                        </ul>
                    </div>
                </div>
                <div class="hot_major clearfix" id="list_banner">
                    
                </div>
            </div>
            <div id="footer"></div>
        </div>
    </form>
    <script>
        (function initCss() {
            var id = $("#hidId").val();
            var spid = $("#hspid").val();
            readydata(id, spid);
            readyChild(id,spid);
           
        })();

        function initCss(ename) {
            var p = enumStr(getQueryString('spid'));
            var mid = getQueryString('id');
            $('#header').load('/HZNW/Category/DepartmentHeader.aspx?typename=' + p + "&typeid=" + getQueryString('spid') + "&mid=" + mid+"&enname="+ename);
            $('#footer').load('/HZNW/Category/DepartmentFooter.aspx?typename=' + p + "&typeid=" + getQueryString('spid') + "&mid=" + mid+"&enname="+ename);
        }

        function readydata(id,pid) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetTreeDataForIdOrPId",
                    "Id": id,
                    "pId":pid,
                    "IsDelete": 0,
                    "Display":0
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var item=json.result.retData ;
                        if (item != null) {
                            var ename = "";
                            if (id != null && id != "" && id != "null")  ename = item[0].EnName;
                            else if (pid != null && pid != "" && pid != "null") ename = item.EnName;
                            var hrefstr = '/HZNW/css/depart_' + ename + '.css';
                            var imgSrc = '/HZNW/images/' + ename + '_banner.jpg';
                            $('#banner').attr('src', imgSrc);
                            $('#layout').attr('href', hrefstr);
                            initCss(ename);


                        }
                    } 
                },
                error: OnError
            });
        }


        function readyChild(id, pid)
        {
            if (id!=null && id!="" && id!="null") {
                queryDataForId(id);
            } else if (pid != null && pid != "" && pid != "null") {
                queryDataForPid(pid);
            }
        }

        function queryDataForId(id) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: "GetPortalTreeDataForChildId",
                    MenuId: id
                },
                success: function (json) {
                    if (json.result.errMsg == "success")
                    {
                        var items = json.result.retData;
                        if (items!=null && items.length>0) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].Name.indexOf("学部动态") > -1) {
                                    initXBDT(items[i].Id);
                                }
                                if (items[i].Name.indexOf("学部简介") > -1) {
                                    initXBJJ(items[i].Id);
                                }
                                if (items[i].Name.indexOf("专业设置") > -1) {
                                    setting(items[i].Id);
                                }
                            }
                        }
                    }
                },
                error: OnError
            });
        }

        function queryDataForPid(pid) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: "GetPortalTreeDataForParentId",
                    MenuId: pid
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].Name.indexOf("学部动态") > -1) {
                                    initXBDT(items[i].Id);
                                }
                                if (items[i].Name.indexOf("学部简介") > -1) {
                                    initXBJJ(items[i].Id);
                                }
                                if (items[i].Name.indexOf("专业设置") > -1) {
                                    setting(items[i].Id);
                                }
                            }
                        }
                    }
                },
                error: OnError
            });
        }

        function setting(id) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetChildMenuForId",
                    "isPage": false,
                    "Id": id,
                    "Display": 0,
                    "IsDelete": 0
                },
                success: function (json) {
                    $("#list_banner").html("");
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            for (var i = 0; i < items.length; i++) {
                                items[i].BeforeUrl = items[i].BeforeUrl + "&s=" + id;
                            }
                            $("#item_banner").tmpl(items).appendTo("#list_banner");
                        } else {
                            $("#list_banner").html("<li>暂无数据！<li>");
                        }
                    } else {
                        $("#list_banner").html("<li>暂无数据！<li>");
                    }

                },
                error: OnError
            });
        }

        function initXBJJ(xbjj) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": xbjj,
                    "IsDelete": 0,
                    "isPage": false,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_xxjj").html();
                        var newItems = json.result.retData;
                        if (newItems != null && newItems.length > 0) {
                            var html = newItems[0].CreativeHTML;
                            $("#xbjjmore").attr("href", newItems[0].BeforeUrl);
                            if (html != "" && html.length > 0) {
                                if (html.length > 233)
                                    $("#list_xxjj").html(html.substring(0, 233));
                                else
                                    $("#list_xxjj").html(html.substring(0, html.length - 1));
                            }
                        } else {
                            $("#list_xxjj").html("暂无数据");
                        }
                    } else {
                        $("#list_xxjj").html("暂无数据");
                    }
                },
                error: OnError
            });
        }

        function initXBDT(xbdt) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetPageList",
                    "MenuId": xbdt,
                    "IsDelete": 0,
                    "PageIndex": 1,
                    "PageSize": 5,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_xbdt").html();
                        var newItems = json.result.retData.PagedData;
                        if (newItems != null && newItems.length > 0) {
                            var href = "/" + '<%=System.Configuration.ConfigurationManager.AppSettings["SystemWeb"]%>' + "/Category/DepartmentBeforeItemList.aspx?id=" + newItems[0].MenuId;
                            $("#xbdtmore").attr("href", href);
                            $("#item_xbdt").tmpl(newItems).appendTo("#list_xbdt");
                        } else {
                            $("#list_xbdt").html("<li>暂无数据</li>");
                        }
                    } else {
                        $("#list_xbdt").html("<li>暂无数据</li>");
                    }
                },
                error: OnError
            });
        }

        function initBanner() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetPortalChildTreeDataForParentId",
                    "Id": $("#hspid").val(),
                    "Display": 0,
                    "IsDelete": 0
                },
                success: function (json) {
                    $("#ulMenus").html("");
                    var typeName = "";
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].Name == "影视影像") {
                                    $(".films").attr("href", items[i].BeforeUrl);
                                }
                                if (items[i].Name == "美容美发") {
                                    $(".beauty").attr("href", items[i].BeforeUrl);
                                }
                                if (items[i].Name == "动漫游戏") {
                                    $(".game").attr("href", items[i].BeforeUrl);
                                }
                                if (items[i].Name == "时装设计") {
                                    $(".preview").attr("href", items[i].BeforeUrl);
                                }
                                if (items[i].Name == "金融财会") {

                                }
                                if (items[i].Name == "酒店餐饮") {

                                }
                                if (items[i].Name == "旅游体育") {

                                }
                                if (items[i].Name == "园林园艺") {

                                }
                                if (items[i].Name == "网络物联") {

                                }
                                if (items[i].Name == "口腔修复") {

                                }
                                if (items[i].Name == "钟表维修") {

                                }
                                if (items[i].Name == "电子商务") {

                                }
                            }
                        }
                    }

                },
                error: OnError
            });
        }
    </script>
</body>
</html>
