<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeItemList.aspx.cs" Inherits="PMSWeb.ZZMH.Sitepages.BeforeItemList" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" />
    <meta name="keywords" content="北京市门头沟区中等职业学校,门头沟中职,城子职高,职成教集团,门职,门头沟职业教育" /> 
    <title>中职门户</title>
    <link href="/ZZMH/css/reset.css" rel="stylesheet" type="text/css">
    <link href="/ZZMH/css/layout.css" rel="stylesheet" type="text/css">
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="../js/common.js"></script>
    <script src="/Scripts/laypage/laypage.js"></script>
</head>

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
        <span class="sort fl">[ ${Name} ]</span>
        <%} %>
        <span class="text"><a href="/ZZMH/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${Description}</a></span>
        <span class="date">
            <a>${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</a>
        </span>
    </li>
</script>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HiddenField ID="HMenuId" runat="server" />
            <asp:HiddenField ID="HPMenuId" runat="server" />
           <%-- <asp:HiddenField ID="selectPid" runat="server" />--%>
            <asp:HiddenField ID="PageNumber" runat="server" />
            <div id="Header" style="min-height: 282px;"></div>
            <div class="centercontent">
                <div class="center_con main" id="initheight">
                    <div class="maintopLeft">
                        <div class="left_nav">
                            <h2 id="hTitle"></h2>
                            <div class="left_navcon">
                                <ul class="con_wenzi" id="div_leftTree">
                                    <%-- <li>
                                    <a href="morebylist.aspx?ListName=%e4%b8%93%e4%b8%9a%e4%bb%8b%e7%bb%8d" target="_self" class="visited">专业介绍</a>
                                </li>
    
                                <li>
                                    <a href="morebylist.aspx?ListName=%e6%8b%9b%e7%94%9f%e7%ae%80%e7%ab%a0" target="_self" class="">招生简章</a>
                                </li>
    
                                <li>
                                    <a href="morebylist.aspx?ListName=%e5%ae%9e%e4%b9%a0%e5%b7%a5%e4%bd%9c" target="_self" class="">实习工作</a>
                                </li>
    
                                <li>
                                    <a href="morebylist.aspx?ListName=%e4%bc%98%e7%a7%80%e6%af%95%e4%b8%9a%e7%94%9f" target="_self" class="">优秀毕业生</a>
                                </li>
    
                                <li>
                                    <a href="morebylist.aspx?ListName=%e9%ab%98%e7%ad%89%e5%ad%a6%e5%8e%86" target="_self" class="">高等学历</a>
                                </li>--%>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="maintopRight">
                        <div id="crumb"></div>
                        <div class="entrance">
                            <div class="moretitle">
                                <p>
                                    <span class="tit_left fl">
                                        <img src="/ZZMH/images/icon01.png" />
                                        <a class="tit">支部介绍</a>
                                        <a class="english"></a>
                                    </span>

                                </p>
                            </div>
                            <div class="content">
                                <ul class="li_list" id="list_data">
                                </ul>
                            </div>
                        </div>
                        <div class="pagination">
                            <div id="pageBar" style="text-align: center;"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="footer" style="min-height: 80px;"></div>
            <script>
                $(function () {
                  
                    $('#Header').load('/ZZMH/Header.aspx');
                    $('#footer').load('/ZZMH/footer.html');
                    $('#menuList a').each(function () {
                        var href = $(this).attr('href');

                    })
                })
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
                            PageIndex: startIndex,
                            pageSize: pageSize,
                            isPush: 1,
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
                            NotItem: enumSystemType("咨询电话") + "," + enumSystemType("友情链接") + "," + enumSystemType("横幅图片"),
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
                                            $(".english").html(items[i].EnName);
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
        </div>
    </form>
</body>
</html>
