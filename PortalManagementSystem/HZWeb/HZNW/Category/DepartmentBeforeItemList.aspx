<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DepartmentBeforeItemList.aspx.cs" Inherits="PMSWeb.HZNW.Category.DepartmentBeforeItemList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <title>黄庄职业高中</title>
    <link href="/HZNW/css/reset.css" rel="stylesheet" type="text/css" />
    <link  rel="stylesheet" type="text/css"  id="layout"/>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
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
        <li>
            <%if (!string.IsNullOrWhiteSpace(HPMenuId.Value))
                { %>
            <span class="sort">[ ${Name} ]</span>
            <%} %>
            <span class="text"><a href="/HZNW/Category/DepartmentBeforeView.aspx?mid=${MenuId}&advId=${Id}" target="_blank">${Description}</a></span>
            <span class="date">
                <a>${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</a>
            </span>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
         <asp:HiddenField ID="HMenuId" runat="server" />
        <asp:HiddenField ID="HPMenuId"  runat="server"/>
        <asp:HiddenField ID="PageNumber" runat="server" />
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
            </div>
            <div id="footer"></div>
    </div>
        <script>
            //(function initCss() {
            //    var p = enumStr(getQueryString('tagname'));
            //    var hrefstr = '/HZNW/css/depart_' + p + '.css';
            //    $('#layout').attr('href', hrefstr);
            //})();
            $(function () {
                readydata();
                getData(1, $("#PageNumber").val());
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
                        pageSize: pageSize,
                        isPage: true,
                        isPush: 1,
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

            //function getDatePanrent(startIndex, pageSize) {
            //    pageNum = (startIndex - 1) * pageSize + 1;
            //    $.ajax({
            //        url: "/Common.ashx",
            //        type: "post",
            //        async: false,
            //        dataType: "json",
            //        data: {
            //            PageName: "DYYX/AdvertisingHandler.ashx",
            //            Func: "GetAdvertising",
            //            MenuIds: $("#HMenuId").val(),
            //            PageIndex: startIndex,
            //            pageSize: pageSize,
            //            isPush:1,
            //            isPage: true
            //        },
            //        success: function (json) {
            //            if (json.result.errMsg == "success") {
            //                $("#list_data").html('');
            //                $("#item_data").tmpl(json.result.retData.PagedData).appendTo("#list_data");
            //                makePageBar(getDatePanrent, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, $("#PageNumber").val(), json.result.retData.RowCount);
            //            }
            //            else {
            //                $("#list_data").html(" <li> 暂无数据！ </li>");
            //            }
            //        },
            //        error: function (XMLHttpRequest, textStatus, errorThrown) {

            //        }
            //    });
            //}


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
                                    //if (setting=="all") {
                                    //    $("#hTitle").html("专业设置");
                                    //    $("#menuPNav").html("专业设置");
                                    //}
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
    </form>
</body>
</html>


