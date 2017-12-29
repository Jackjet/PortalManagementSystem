<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DepartmentBeforeList.aspx.cs" Inherits="PMSWeb.HZNW.Category.DepartmentBeforeList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" /> 
    <title>黄庄职业高中</title>
    <link href="/HZNW/css/reset.css" rel="stylesheet" type="text/css" />
    <link  rel="stylesheet" type="text/css"   id="layout"/>
    <script src="/HZNW/js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/HZNW/js/common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/PageBar.js"></script>
     <script>
         $(function () {
            
         })
    </script>
     <script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
       {{if Id!=$("#HMenuId").val()}}
            <li> <a href="${BeforeUrl}" target="_self" class="">${Name}</a> </li>
            {{else}}
           <li class="visited"> <a href="${BeforeUrl}" target="_self" >${Name}</a> </li>
            {{/if}}
       
        {{/if}}
    </script>
    <script type="text/x-jquery-tmpl" id="item_data">
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
         <div id="header"></div>
            <div class="clear"></div>
         <div class="wrap">
            <div class="centercontent">
                <div class="center_con main">
                    <div class="maintopLeft" style="float: left;">
                        <div class="left_nav">
                            <h2 id="hTitle"></h2>
                            <div class="left_navcon">
                                <ul class="con_wenzi" id="div_leftTree">
                                        <li class="visited"> <a href="" target="_self" ></a> </li>

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
         <div id="footer"></div>
         <script>
             //(function initCss() {
             //    var p = enumStr(getQueryString('tagname'));
             //    var hrefstr = '/HZNW/css/depart_' + p + '.css';
             //    $('#layout').attr('href', hrefstr);
             //})();

             $(function () {
                 readydata();
                 getData(1, 12);
                 leftTree();
             })

             function initCss(ename) {
                 var p = getQueryString('id');
                 if (p == null || p == "" || p == "null") p = getQueryString('mid');
                 $('#header').load('/HZNW/Category/DepartmentHeader.aspx?mid=' + p + "&enname=" + ename);
                 $('#footer').load('/HZNW/Category/DepartmentFooter.aspx?mid=' + p + "&enname=" + ename);
             }

             function readydata() {
                 $.ajax({
                     type: "Post",
                     url: "/Common.ashx",
                     async: false,
                     dataType: "json",
                     data: {
                         "PageName": "DYYX/AdminManagerHandler.ashx",
                         "func": "GetTreeDataForIdOrPId",
                         "Id": $("#HMenuId").val(),
                         "pId": "",
                         "IsDelete": 0,
                         "Display": 0
                     },
                     success: function (json) {
                         if (json.result.errMsg == "success") {
                             var item = json.result.retData;
                             if (item != null) {
                                 var ename = item[0].EnName;
                                 var hrefstr = '/HZNW/css/depart_' + ename + '.css';
                                 $('#layout').attr('href', hrefstr);

                                 initCss(ename);
                             }
                         }
                     },
                     error: OnError
                 });
             }

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
                 var func = "";
                 if ($("#HMenuId").val() != null && $("#HMenuId").val() != "") func = "GetPortalTreeDataForChildId";
                 if ($("#HPMenuId").val() != null && $("#HPMenuId").val() != "") func = "GetPortalTreeDataForParentId";
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

                             if (items != null) {
                                 var newitem = [];
                                 for (var j = 0; j < items.length; j++) {
                                     if (items[j].Name.indexOf("专业设置") > -1 || items[j].Name.indexOf("教育学部") > -1 || items[j].Name.indexOf("艺术学部") > -1 || items[j].Name.indexOf("服务学部") > -1 || items[j].Name.indexOf("技术学部") > -1) {
                                         continue;
                                     }
                                     newitem.push(items[j]);
                                 }
                                 $("#tr_leftTree").tmpl(newitem).appendTo("#div_leftTree");
                                 for (var i = 0; i < items.length; i++) {
                                     if (items[i].Name.indexOf("教育学部") > -1 || items[i].Name.indexOf("艺术学部") > -1 || items[i].Name.indexOf("服务学部") > -1 || items[i].Name.indexOf("技术学部") > -1) {
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
    </div>
    </form>
</body>
</html>
