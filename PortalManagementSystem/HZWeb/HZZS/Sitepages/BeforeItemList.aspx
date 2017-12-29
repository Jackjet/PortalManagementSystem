<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeItemList.aspx.cs" Inherits="PMSWeb.HZZS.Sitepages.BeforeItemList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title>北京市黄庄职业高中</title>
    <link rel="stylesheet" href="/HZZS/css/reset.css" />
    <link rel="stylesheet" href="/HZZS/css/layout.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
       {{if Id!=$("#HMenuId").val()}}
            <li><a href="${BeforeUrl}" target="_self" class="">${Name}</a> </li>
        {{else}}
           <li class="visited"><a href="${BeforeUrl}" target="_self">${Name}</a> </li>
        {{/if}}
       
        {{/if}}
    </script>
    <script id="item_data" type="text/x-jquery-tmpl">
        <li>
            <%if (!string.IsNullOrWhiteSpace(HPMenuId.Value))
              { %>
            <span class="sort">[ ${Name} ]</span>
            <%} %>
            <span class="text"><a href="/HZZS/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${Description}</a></span>
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
        <div>
            <iframe name="htmlHeader" src="/HZZS/Header.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="480px"></iframe>
            <div class="centercontent">
                <div class="center_con main" style="width: 1000px;">
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
                        <div class="entrance">
                            <div class="moretitle">
                                <p>
                                    <span class="tit_left fl">
                                        <a class="tit" id="menuPNav"></a>
                                        <a class="english"></a>
                                    </span>

                                </p>
                            </div>
                            <div class="clear"></div>
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
            <iframe name="htmlHeader" src="/HZZS/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="92px"></iframe>
        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            if ($("#HPMenuId").val() != "" && $("#HPMenuId").val() == "0") {
                getDatePanrent(1, $("#PageNumber").val());
            } else if ($("#HMenuId").val() != "" && $("#HMenuId").val().length > 0) {
                getData(1, $("#PageNumber").val());
            }

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
                    isPush:1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_data").html('');
                        $("#item_data").tmpl(json.result.retData.PagedData).appendTo("#list_data");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, $("#PageNumber").val(), json.result.retData.RowCount);
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
                    pageSize: pageSize,
                    isPush: 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_data").html('');
                        $("#item_data").tmpl(json.result.retData.PagedData).appendTo("#list_data");
                        makePageBar(getDatePanrent, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, $("#PageNumber").val(), json.result.retData.RowCount);
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
</body>
</html>
