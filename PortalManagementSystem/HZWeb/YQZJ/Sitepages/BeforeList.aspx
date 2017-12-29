<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeList.aspx.cs" Inherits="PMSWeb.YQZJ.Sitepages.BeforeList" %>

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
    <style>
        .o-list{padding:0px 10px;}
.o-list li{
    padding-bottom: 10px;
    margin-bottom: 10px;
    overflow: hidden;
    vertical-align: bottom;
    border-bottom: 1px dashed #c1c1c1;
    zoom: 1;
}
.o-list li .r-s{
    margin-left:25px;
    width: 670px;
    display: inline;
    line-height: 22px;
    color: #6d6d6d;
}
.o-list li .r-s h3{
    height:40px;font-size:20px;color:#555;
}
.o-list li .r-s h3 a{
    color:#555;}
    </style>
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
        function setPid(url) {
            var spid = $("#selectPid").val()
            if (spid != null && spid != '') {
                url = " &selectPid=" + $("#selectPid").val();

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
                            <div class="clear"></div>
                			<ul class="o-list" id="list_data">
				                <li class="clearfix">             
                                    <div class="l-s fl">                 
                                        <a href="">  
                                             <img src="" alt="" width="238" height="175">
                                        </a>             
                                    </div>             
                                    <div class="r-s fl" style="height:175px;overflow:hidden;">       
                                            <h3 class="n"><a href="">北京ABB电器传动系统有限公司</a></h3>  
                                            <p>北京ABB电气传动系统有限公司成立于1994年，是ABB集团在中国的交直流传动产品供应商。ABB的传动产品用于从0.12kW至100,000kW的电机调速，广泛应用于冶金、造纸、石油天然气、风力发电、纺织、橡胶塑料等众多行业。在金属轧机、起重机、石油钻机、压缩机、挤出机、拉丝机、风机、泵类等应用中，传动设备都起着提高精度控制、实现增效节能的重要作用。随着公司生产能力的不断扩大，生产管理、工艺装备与质量控制等方面的不断提高，ABB传动公司不仅面向中国市场供应传动产品，而且向亚洲市场出口标准传动，并提供相应的支持与服务。通过始终如一的不断努力，ABB传动公司不仅拥有认真敬业、充满活力、不断创新的员工团队，而且建立了由系统集成商与分销商组成的遍及全国有效运转的渠道销售网络，以及专业的传动服务中心网络。在中国，ABB传动公司旨在为客户提供最优的传动产品与服务。</p>
                                    </div> 
				                </li>
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
            selectPid = getQueryString('selectPid');

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
                    isPush: 1,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_data").html('');
                        var pagedata = json.result.retData.PagedData;
                        //pagedata.p_ID = selectPid;
                        for (var i in pagedata) {
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
                        var ary = [];
                        for (var i = 1; i < items.length; i++) {
                            ary.push(items[i]);
                        }
                        $("#tr_leftTree").tmpl(ary).appendTo("#div_leftTree");
                        if (ary != null) {
                            for (var i = 0; i < ary.length; i++) {
                                if (ary[i].Id == $("#HMenuId").val()) {
                                    $("#menuNav").html(ary[i].Name);
                                    $(".tit").html(ary[i].Name);
                                    $(".english").html(ary[i].EnName);
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
