<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeList.aspx.cs" Inherits="PMSWeb.HZNW.SitePages.BeforeList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title>黄庄职业高中</title>
    <link href="/HZNW/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="/HZNW/css/layout.css" rel="stylesheet" type="text/css" />
    <script src="/HZNW/js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script>
        $(function () {
            $('#header').load('/HZNW/Header.aspx');

        })
    </script>
    <script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
        {{if Id!=$("#HMenuId").val()}}
            <li><a href="${BeforeUrl}" target="_self" class="">${Name}</a> </li>
            {{else}}
           <li class="visited"><a href="${BeforeUrl}" target="_self" >${Name}</a> </li>
            {{/if}}
       
        {{/if}}
    </script>
    <script id="item_data" type="text/x-jquery-tmpl">
        <ul class="activity fl">
            <li class="teacherphoto">
                <a href="/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">
                    <img src="${Img}"></a>
            </li>
            <li class="name">
                <a href="/HZNW/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,15)}</a>
            </li>
        </ul>

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HMenuId" runat="server" />
    <div>
        <div id="header" style="min-height:350px;"></div>
        <div class="clear"></div>
        <div class="center">
            <div class="centercontent">
                <div class="center_con main" style="width:1000px">
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
                        <div class="entrancePhoto">
                            <div class="title">
                                <p>
                                    <span class="tit_left fl">
                                        <a class="tit"></a>
                                        <a class="english"></a>
                                    </span>
                                    <span class="tit_right fr" style="display: none">
                                        <a href="">更多</a>
                                    </span>
                                </p>
                            </div>
                            <div class="clear"></div>
                            <div class="content" id="list_data">
                            </div>
                        </div>
                        <div class="pagination">
                            <span id="pageBar"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <iframe name="htmlHeader" src="/HZNW/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="92px"></iframe>
    </div>
    </form>
     <script type="text/javascript">
         var advIdForMenuId;
         $(function () {
             getData(1, 12);
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
                     pageSize: pageSize
                 },
                 success: function (json) {
                     if (json.result.errMsg == "success") {
                         $("#list_data").html('');
                         var items = json.result.retData.PagedData;
                         if (items != null && items.length > 0) {
                             var newItems = items;
                             var images = [];
                             for (var i = 0; i < items.length; i++) {
                                 newItems[i].Img = ImgIndex(items[i].ImageUrl);
                             }
                             $("#item_data").tmpl(newItems).appendTo("#list_data");
                             makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                         } else {
                             $("#list_data").html("暂无数据！");
                             $("#pageBar").html("");
                         }
                     }
                     else {
                         $("#list_data").html("暂无数据！");
                     }
                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {

                 }
             });
         }

         function leftTree() {
             $.ajax({
                 url: "/Common.ashx",
                 type: "post",
                 async: false,
                 dataType: "json",
                 data: {
                     PageName: "DYYX/AdminManagerHandler.ashx",
                     Func: "GetPortalTreeDataForChildId",
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

         function ImgIndex(path) {
             if (path == null || path == "") return "";
             var imgs = path.split(',');
             return imgs[0];
         }
    </script>
</body>


</html>
