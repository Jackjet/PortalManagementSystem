<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeItemList.aspx.cs" Inherits="PMSWeb.YQYZ.SitePages.BeforeItemList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title>延庆区第一中学</title>
    <link href="/YQYZ/css/reset.css" rel="stylesheet" />
    <link href="/YQYZ/css/layout2.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/YQYZ/js/common.js"></script>
    <script src="/YQYZ/js/layout.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/laypage/laypage.js"></script>
    <script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
        <li>{{if Id!=$("#HMenuId").val()}}
            <a href="${BeforeUrl}" target="_self" class="">${Name}</a>
            {{else}}
            <a href="${BeforeUrl}" target="_self" class="visited">${Name}</a>
            {{/if}}
        </li>
        {{/if}}
    </script>
    <script id="item_data" type="text/x-jquery-tmpl">
        <li>
            <%if (!string.IsNullOrWhiteSpace(HPMenuId.Value))
              { %>
            <span class="sort">[ ${Name} ]</span>
            <%} %>
            <span class="text"><a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${Description}</a></span>
            <span class="date">
                <a>${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</a>
            </span>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HMenuId" runat="server" />
        <asp:HiddenField ID="HPMenuId" runat="server" />
        <asp:HiddenField ID="PageNumber" runat="server" />
        <div id="header_top" style="position: fixed; top: 0; z-index: 999; width: 100%;"></div>
        <iframe name="htmlHeader" src="/YQYZ/Header.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="326px" style="margin-top: 98px;"></iframe>
        <div class="clear"></div>
        <div class="center" id="centerwrap">
            <div class="centercontent">
                <div class="center_con main">
                    <div class="maintopLeft" style="float: left;">
                        <div class="left_nav">
                            <h2 id="hTitle"></h2>
                            <div class="left_navcon">
                                <ul class="con_wenzi" id="div_leftTree">
                                </ul>
                            </div>
                            <div class="footer"></div>
                        </div>
                    </div>
                    <div class="maintopRight">
                        <div class="entrancemore">
                            <div class="moretitle clearfix">
                                <p>
                                    <span class="tit_left fl">
                                        <img src="/YQYZ/images/icon01.png">
                                        <a class="tit"></a>
                                       <%-- <a class="english"></a>--%>
                                    </span>
                                    <span class="tit_right" style="display: none">
                                        <a href="">更多</a>
                                    </span>
                                </p>
                            </div>
                            <div class="content">
                                <ul class="li_list" id="list_data">
                                </ul>
                            </div>
                        </div>
                        <div class="pagination">
                            <span id="pageBar"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--footer-->
        <iframe name="htmlFoot" src="/YQYZ/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="92px" id="htmlFoot"></iframe>
        <div id="top"></div>
    </form>
    <script type="text/javascript">

        var hMenu_Item;

        function GetPortalTreeDataById(ID) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: "GetPortalTreeDataById",
                    IsDelete: 0,
                    Display: 0,
                    ID: ID
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = [];
                        items = json.result.retData;
                        if (items.length > 0) {
                            hMenu_Item = items[0];
                        }
                    }
                    else {

                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        //初始化加载（包含分页【根据后台设置条目数量】）
        $(function () {
            var hMenuId = $("#HMenuId").val();
            var hPMenuId = $("#HPMenuId").val();
            if ($("#HPMenuId").val() != "" && $("#HPMenuId").val() == "0") {
                GetPortalTreeDataById(hMenuId);
                if (hMenu_Item != null) {
                    getDatePanrent(1, hMenu_Item.DisplayCount);
                }
            } else if (hMenuId != "" && hMenuId.length > 0) {
                GetPortalTreeDataById(hMenuId);
                if (hMenu_Item != null) {
                    getData(1, hMenu_Item.DisplayCount);
                }
            }
            $('#header_top').load('/YQYZ/top.aspx');
            leftTree();
        })

        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdvertisingHandler.ashx",
                    Func: "GetPageList",
                    MenuId: $("#HMenuId").val(),
                    isPush:1,
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_data").html('');
                        $("#item_data").tmpl(json.result.retData.PagedData).appendTo("#list_data");
                        //makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, $("#PageNumber").val(), json.result.retData.RowCount);
                        laypage({
                            cont: 'pageBar', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
                            pages: json.result.retData.PageCount, //通过后台拿到的总页数
                            curr: json.result.retData.PageIndex || 1, //当前页
                            skip: false, //是否开启跳页
                            skin: '#07a94b',
                            jump: function (obj, first) { //触发分页后的回调
                                if (!first) { //点击跳页触发函数自身，并传递当前页：obj.curr
                                    getData(obj.curr, pageSize)
                                }
                            }
                        });
                    }
                    else {
                        $("#list_data").html(" <li> 暂无数据！ </li>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function getDatePanrent(startIndex, pageSize) {
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdvertisingHandler.ashx",
                    Func: "GetPageListForMenuId",
                    MenuId: $("#HMenuId").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_data").html('');
                        $("#item_data").tmpl(json.result.retData.PagedData).appendTo("#list_data");
                        //makePageBar(getDatePanrent, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, $("#PageNumber").val(), json.result.retData.RowCount);
                        laypage({
                            cont: 'pageBar', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
                            pages: json.result.retData.PageCount, //通过后台拿到的总页数
                            curr: json.result.retData.PageIndex || 1, //当前页
                            skip: false, //是否开启跳页
                            skin: '#07a94b',
                            jump: function (obj, first) { //触发分页后的回调
                                if (!first) { //点击跳页触发函数自身，并传递当前页：obj.curr
                                    getDatePanrent(obj.curr, pageSize)
                                }
                            }
                        });
                    }
                    else {
                        $("#list_data").html(" <li> 暂无数据！ </li>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function leftTree() {
            var func = "";
            if ($("#HMenuId").val() != "") func = "GetPortalTreeDataForChildId";
            if ($("#HPMenuId").val() != "") func = "GetPortalTreeDataForParentId";
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: func,
                    BeforeAfterNot: "1",
                    MenuId: $("#HMenuId").val()
                   
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#div_leftTree").html('');
                        var items = json.result.retData;
                        $("#tr_leftTree").tmpl(items).appendTo("#div_leftTree");
                        if (items != null) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].PId == "0") {
                                    $("#hTitle").html(items[i].Name);
                                    $("#menuPNav").html(items[i].Name);
                                }
                                if (items[i].Id == $("#HMenuId").val()) {
                                    $("#menuNav").html(items[i].Name);
                                    $(".tit").html(items[i].Name);
                                    //$(".english").html(items[i].EnName);
                                }
                            }
                        }
                    }
                    else {
                        $("#div_leftTree").html("暂无数据！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    </script>
</body>
</html>
