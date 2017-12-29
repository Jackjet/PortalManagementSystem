<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeList.aspx.cs" Inherits="PMSWeb.PreSchool.SitePages.BeforeList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" />  
    <title>北京市昌平区财贸幼儿园</title>
    <link rel="stylesheet" href="/PreSchool/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/PreSchool/css/style.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/PreSchool/js/common.js"></script>
    <!--[if lt IE 9]><script src="/PreSchool/js/html5shiv.min.js"></script><![endif]-->
    <!--[if lte IE 8]><script src="/PreSchool/js/selectivizr-min.js"></script><![endif]-->
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/laypage/laypage.js"></script>
    <script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
            {{if Id!=$("#HMenuId").val()}}
            <li>
                <a href="${BeforeUrl}" target="_self" class="">${Name}</a>
                <ul id="nav-${Id}"></ul>
            </li>
            {{else}}
            <li class="visited">
                <a href="${BeforeUrl}" target="_self" >${Name}</a>
                <ul id="nav-${Id}"></ul>
            </li>
            {{/if}}
        {{/if}}
    </script>
     <script type="text/x-jquery-tmpl" id="secnav_item">
	{{if Id!=$("#HMenuId").val()}}
        <li>
             <a href="${BeforeUrl}&loadid=${PId}" target="_self" class="">${Name}</a>
        </li>
	{{else}}
	<li class="visited">
             <a href="${BeforeUrl}&loadid=${PId}" target="_self" class="">${Name}</a>
        </li>
	{{/if}}
    </script>
    <script id="item_list" type="text/x-jquery-tmpl" >
        <li>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=${getQueryString('bgname')}" target="_blank">
                <div class="img fl">
                    {{if ImageUrl!=null&&ImageUrl!=""}}
                    <img src="${ImageUrl.split(',')[0]}" />
                    {{else}}    
                    <img src="${getImageUrl(FilePath)}" />
                    {{/if}}
                </div>
                <div class="con">
                    <h2>${Description}</h2>
                    <div>${CreativeHTML.replace(/<[^>]+>/g,'')}</div>
                </div>
            </a>
        </li>
    </script>
      <script id="tree_data" type="text/x-jquery-tmpl">
        <li>
			<a href="${BeforeUrl}&loadid=${$('#HMenuId').val()}" target="_blank">${Name}</a>
        </li>
    </script>
    <script>
        $(function () {
            //获取地址栏背景图参数给页面赋值不同的参数
            var bgname = getQueryString("bgname");
            $('.bgname').attr('id', bgname);
            $('.wrap').attr('id', bgname + 'wrap');
            $('#hTitle').attr('class', bgname + 'h2');
            $('#div_leftTree').addClass(bgname + 'ul');
            //var spid = $("#selectPid").val()
            //if (spid != null && spid != '') {
            //    url = " &selectPid=" + $("#selectPid").val();

            //}
        });
    </script>
</head>
<body class="bgname">
    <div class="wrap">
    <form id="form1" runat="server">
        <asp:HiddenField ID="HMenuId" runat="server" />
        <asp:HiddenField ID="HPMenuId" runat="server" />
        <asp:HiddenField ID="PageNumber" runat="server" />
        <header id="header">
            <div class="motto_logo clearfix center">
                <a class="logo fl" href="/PreschoolIndex.aspx">
                    <img src="/PreSchool/images/logo.png" />
                </a>
            </div>
            <nav id="nav"></nav>
        </header>
        <div id="content" class="center clearfix" >
            <div class="view_content clearfix">
                <div class="left_nav fl">
                    
                    <div class="leftnav_inner">

                    <div class="clear"></div>
                    <h2 id="hTitle"></h2>
                    <div class="left_navcon">
                        <ul class="con_wenzi" id="div_leftTree">
                        </ul>
                    </div>
                        </div>
                </div>
                <div class="con_details fr">
                    <div class="entrancemore">
                        <div class="moretitle clearfix">
                            <a href="#" id="one_nav"></a>
                            <span>></span>
                            <a href="#" id="second_nav"></a>
                            <span style="display:none;">></span>
                            <a href="#" id="three_nav" style="display:none;"></a>
                        </div>
                        <div class="content">
                            <ul id="lists_da" class="lists_da">
                                
                                
                            </ul>
                        </div>
                    </div>
                    <div class="pagination">
                        <div id="pageBar" style="text-align:center;"></div>
                    </div>
                </div>
            </div>
             <footer id="footer"></footer>
        </div>
       
        <!--在线调查-->
        <div id="survey_wrap"></div>
    </form>
        </div>
    <script>
        var hMenu_Item;
        var selectPid;        
        $(function () {
            //selectPid = getQueryString('selectPid');
            $('#nav').load('/PreSchool/nav.html');
            $('#footer').load('/PreSchool/footer.html');
            $('#survey_wrap').load('/PreSchool/Survey.html');
            var loadid = getQueryString("loadid");
            if (loadid !=null)
            {
                leftTree(loadid,"");
            }
            else {
                leftTree($("#HMenuId").val(),$("#HPMenuId").val());
            }
            LoadChildMenu($("#HMenuId").val());
            GetPortalTreeDataById($("#HMenuId").val());
        });
        function LoadChildMenu(ID)
        {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetChildMenuForId",
                    "Id": ID,
                    "IsDelete": 0,
                    "Display": 0
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#lists_da").html();
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            $("#lists_da").attr("class", "lists");
                            $("#tree_data").tmpl(items).appendTo("#lists_da");
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
        }
        function leftTree(menuid,pmenuid) {
            var func = "";
            if (menuid != "") func = "GetPortalTreeDataForChildId";
            if (pmenuid != "") func = "GetPortalTreeDataForParentId";
            $.ajax({
                url: "/Common.ashx",
                type: "post",                
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: func,
                    BeforeAfterNot: "1",
                    MenuId: menuid
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var isok = "";
                        $("#div_leftTree").html('');
                        var items = json.result.retData;
                        $("#tr_leftTree").tmpl(items).appendTo("#div_leftTree");
                        if (items != null) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].PId == "0") {
                                    $("#hTitle").html(items[i].Name);
                                    $("#one_nav").html(items[i].Name);
                                    $('#one_nav').attr('href', items[i].BeforeUrl)
                                }
                                if (items[i].Id == menuid) {
                                    $("#second_nav").html(items[i].Name);
                                    $("#second_nav").attr('href', items[i].BeforeUrl);
                                    isok = GetChildMenuForId(items[i].Id);
                                }
                                if (isok == "success") {
                                    $("#nav-" + items[i].Id).slideDown();
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
        function GetChildMenuForId(ID) {
            var isok = "";
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetChildMenuForId",
                    "Id": ID,
                    "IsDelete": 0,
                    "Display": 0
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#nav-" + ID).html();
                        var items = json.result.retData;
                        $('#three_nav').show();
                        $('#three_nav').prev().show();
                        if (items != null && items.length > 0) {
                            $("#secnav_item").tmpl(items).appendTo("#nav-" + ID);
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].Id == getQueryString('id')) {
                                    $("#three_nav").html(items[i].Name);
                                    $("#three_nav").attr('href', items[i].BeforeUrl);
                                }
                            }
                            isok = "success";
                        } 
                    } 
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
            return isok;
        }
        function GetPortalTreeDataById(ID) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
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
                        var hPMenuId = $("#HPMenuId").val();
                        if (hPMenuId != "" && hPMenuId == "0") {
                            if (hMenu_Item != null) {
                                getDatePanrent(1, hMenu_Item.DisplayCount);
                            }
                        } else if (ID != "" && ID.length > 0) {
                            if (hMenu_Item != null) {
                                getData(1, hMenu_Item.DisplayCount);
                            }
                        }
                    }
                    else { }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",              
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
                        $("#lists_da").html('');
                        var pagedata = json.result.retData.PagedData;
                        //for (var i in pagedata) {
                        //    pagedata[i].p_ID = selectPid;
                        //}
                       
                        $("#item_list").tmpl(pagedata).appendTo("#lists_da");
                        ////限制左侧图片
                        //$('#lists_da img').each(function (i, item) {
                        //    width = parseInt($(item).width());
                        //    height = parseInt($(item).height());
                        //    if (width >= height) {
                        //        $(item).width('100%');
                        //    } else {
                        //        $(item).height('128px');
                        //    }
                        //})
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
                        $("#lists_da").html('');
                        var pagedata = json.result.retData.PagedData;
                        $("#item_list").tmpl(pagedata).appendTo("#lists_da");
                        //makePageBar(getDatePanrent, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, $("#PageNumber").val(), json.result.retData.RowCount);
                        //限制左侧图片
                        alert($('#lists_da img').length)
                        $('#lists_da img').each(function (i, item) {
                            width = parseInt($(item).width());
                            height = parseInt($(item).height());
                            if (width >= height) {
                                $(item).width('100%');
                            } else {
                                $(item).height('128px');
                            }
                        })
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
        function getImageUrl(filepath) {
            if (filepath != null && filepath != "") {
                var imageurl = filepath.substring(0, filepath.lastIndexOf('.')) + ".jpg";
                return imageurl;
            }
            return "";
        }
    </script>
</body>
</html>

