<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeItemList.aspx.cs" Inherits="PMSWeb.YQZJ.Sitepages.BeforeItemList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
		<title>延庆县职业技术教育中心</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
		<link rel="stylesheet" href="/YQZJ/css/reset.css" />
		<link rel="stylesheet" href="/YQZJ/css/layout.css" />
		<script src="/Scripts/jquery-1.11.2.min.js"></script>
        <script src="/Scripts/jquery-1.11.2.min.js"></script>
        <script src="/Scripts/Common.js"></script>
        <script src="/YQZJ/js/common.js"></script>
        <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/laypage/laypage.js"></script>
		<script type="text/javascript">
		    $(function () {
		        $("#header").load('/YQZJ/Header.aspx');
		        $('#footer').load('/YQZJ/bottom.aspx');
		    });
		</script>
        <script id="tr_leftTree" type="text/x-jquery-tmpl">
            {{if PId!=0}}
            {{if Id!=$("#HMenuId").val()}}
                <li><a href="${BeforeUrl}" target="_self" class="" title="${Name}">${Name}</a> </li>
                {{else}}
                <li class="visited"><a href="${BeforeUrl}" target="_self" title="${Name}">${Name}</a> </li>
                {{/if}}
           
            {{/if}}
        </script>
     <script id="item_data" type="text/x-jquery-tmpl">
        <li>
            <%if (!string.IsNullOrWhiteSpace(HPMenuId.Value))
              { %>
            <span class="sort fl">[ ${Name} ]</span>
            <%} %>
            <span class="text"><a  href="/YQZJ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&selectPid=${p_ID}"  target="_blank">${Description}</a></span>
            <span class="date">
                <a>${DateTimeConvert(CreateTime,'yyyy-MM-dd')}</a>
            </span>
        </li>
    </script>

    <script>
        //${setPid(url)}
        function setPid(url)
        {
            var spid = $("#selectPid").val()
            if (spid != null && spid != '')
            {
                url =" &selectPid="+ $("#selectPid").val();
               
            }
          
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HiddenField ID="HMenuId" runat="server" />
        <asp:HiddenField ID="HPMenuId" runat="server" />
        <asp:HiddenField ID="PageNumber" runat="server" />
         <div id="header" style="min-height:242px;"></div>
        <div class="wrap_center">
		<div class="centercontent" >
      		<div class="center_con main clearfix" id="initheight">
      			<div class="maintopLeft">	
        			<div class="left_nav">
            			<h2 id="hTitle"></h2>
                        <div class="left_navcon">
                            <ul class="con_wenzi" id="div_leftTree">
                            </ul>
                        </div>
       				</div>
				</div>
				<div class="maintopRight">
					<div class="entrance">
					    <div class="moretitle">
					        <p>
					            <span class="tit_left fl">
					                <img src="/YQZJ/images/icon01.png" />
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
                        <div id="pageBar" style="text-align:center;"></div>
                    </div>
				</div>
			</div>
		</div>
        </div>
		<div id="footer"  style="height:44px;"></div>
    </div>
    </form>
    <script>

        var hMenu_Item;
        var selectPid;

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
           selectPid  = getQueryString('selectPid');

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
                    isPush:1,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_data").html('');
                        var pagedata = json.result.retData.PagedData;
                        //pagedata.p_ID = selectPid;
                        for (var i in pagedata)
                        {
                            pagedata[i].p_ID = selectPid;
                        }
                        $("#item_data").tmpl(pagedata).appendTo("#list_data");
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
                        var pagedata = json.result.retData.PagedData;
                        for (var i in pagedata) {
                            pagedata[i].p_ID = selectPid;
                        }
                        $("#item_data").tmpl(pagedata).appendTo("#list_data");
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
                    MenuId: $("#HMenuId").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#div_leftTree").html('');
                        var items = json.result.retData;
                        $("#hTitle").html(items[0].Name);
                        $("#menuPNav").html(items[0].Name);
                        var ary = items.slice(1);
                        $("#tr_leftTree").tmpl(ary).appendTo("#div_leftTree");
                        if (items != null && items != '') {
                            for (var i = 0; i < items.length; i++) {
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
