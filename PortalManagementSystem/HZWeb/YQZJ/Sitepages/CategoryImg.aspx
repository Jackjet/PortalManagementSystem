<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryImg.aspx.cs" Inherits="PMSWeb.YQZJ.Sitepages.CategoryImg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
		<title>延庆县职业技术教育中心</title>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
		<link rel="stylesheet" href="/YQZJ/css/reset.css" />
		<link rel="stylesheet" href="/YQZJ/css/layout.css" />
		<script src="/Scripts/jquery-1.11.2.min.js"></script>
        <script src="/Scripts/jquery-1.11.2.min.js"></script>
        <script src="/Scripts/Common.js"></script>
        <script src="/YQZJ/js/common.js"></script>
        <script src="/Scripts/jquery.tmpl.js"></script>

		<script type="text/javascript">
		    $(function () {
		        $("#header").load('/YQZJ/Header.aspx');
		        $('#footer').load('/YQZJ/bottom.aspx');
		    });
		</script>
     <script type="text/x-jquery-tmpl" id="modult">
        <div class="entrance_r fl">
		    <div class="title">
			    <p>
				    <span class="tit_left fl">
					    <img src="/YQZJ/images/icon01.png" />
					    <a class="tit">${Name}</a>
					    <a class="english"></a>
				    </span>
				    <span class="tit_right fr" style="display: block">
					    <a href="/YQZJ/Sitepages/BeforeItemList.aspx?id=${Id}">更多</a>
				    </span>
			    </p>
		    </div>

    	    <div class="content">
                <ul class="li_list" id="lists_${Id}">
           	    </ul>      
    	    </div>
	    </div>
    </script>
    <script id="item_list1" type="text/x-jquery-tmpl">
        <li>
			<img src="/YQZJ/images/point.png" />
			<span class="text"><a href="/YQZJ/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a></span>
			<span class="date">   
			    <a>${DateTimeConvert(CreateTime,'MM-dd')}</a>
            </span>
        </li>
    </script>
    <script id="item_list2" type="text/x-jquery-tmpl">
        <li>
			<img src="/YQZJ/images/point.png" />
			<span class="text"><a href="/YQZJ/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}" target="_blank">${NameLengthUpdate(Description,15)}</a></span>
			<span class="date">   
			   <a>${ClickNum}</a>
            </span>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div id="header" style="min-height:242px;"></div>
		<div class="center main" id="initheight">
			<div class="center_center_con main" >	
				<div class="center_center_left fl">
                    <div id="modult_wrap"></div>
					<div class="left_2 fl">
				        <div class="title">
				            <p>
				                <span class="tit_left fl">
				                    <img src="/YQZJ/images/icon01.png">
				                    <a class="tit">教工活动</a>
				                    <a class="english"></a>
				                </span>
				                <span class="tit_right fr" style="display: block">
				                    <a href="">更多</a>
				                </span>
				            </p>
				        </div>
    				    <div class="content">
		                    <ul class="everyone fl">
		                        <li class="teacherphoto">
		                            <a href="">
		                                <img src=""></a>
		                        </li>
		                        <li class="name">
		                            <a href="">职教中心重阳节慰问活动走进延庆镇光荣院</a>
		                        </li>
		                    </ul>
                		    <ul class="everyone fl">
		                        <li class="teacherphoto">
		                            <a href="">
		                                <img src=""></a>
		                        </li>
		                        <li class="name">
		                            <a href="">职教中心重阳节慰问活动走进延庆镇光荣院</a>
		                        </li>
		                    </ul>
    				    </div>
				    </div>
				</div>
				<div class="center_center_right fr">
					<div class="entrance_right4 rHeight fr">
					    <div class="title">
					        <p>
					            <span class="tit_left fl">
					                <img src="/YQZJ/images/icon01.png">
					                <a class="tit">新闻快讯</a>
					                <a class="english"></a>
					            </span>
					            <span class="tit_right fr" style="display: none">
					                <a href="">更多</a>
					            </span>
					        </p>
					    </div>
	    				<div class="content">
	                		<ul class="li_list" id="list_news">
				               
	        				</ul>
	    				</div>
					</div>
				</div>
			</div>
		</div>
		<div id="footer"  style="height:44px;"></div>
    </div>
    </form>
    <script>
        $(function () {
            //initModult();
            initXWKX(1, 20);
        })
        function initModult() {
            //Id = getQueryString('id');
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetMenusItemsData",
                    "IsDelete": 0,
                    "PageIndex": 1,
                    //"MenuIdList": Id,
                    "isPush": 1,
                    "isAll": true,
                    //"IsShowIndex": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $('#modult_wrap').html('');
                        var titles = json.result.retData;
                        if (titles != null && titles.length > 0) {
                            $("#modult").tmpl(titles).appendTo("#modult_wrap");
                        }
                        for (i = 0; i < titles.length; i++) {
                            var title = titles[i];
                            var newlists = title.ListData.PagedData;
                            if (newlists != null && newlists.length > 0) {
                                if (title.DisplayType == "时间") {
                                    $("#item_list1").tmpl(newlists).appendTo('#lists_' + title.Id);
                                } else if (title.DisplayType == "点击量") {
                                    $("#item_list2").tmpl(newlists).appendTo('#lists_' + title.Id);
                                }
                            } else {
                                $('#lists_' + title.Id).html("<li>暂无数据</li>");
                            }
                        }
                    } else {
                        $("#modult").html("暂无数据");
                    }
                },
                error: OnError
            });

        }
        function initXWKX(startIndex, pageSize) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdvertisingHandler.ashx",
                    Func: "GetNewData",
                    PageIndex: startIndex,
                    PageSize: pageSize,
                    isPush: 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#list_news").html('');
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            $('#item_list1').tmpl(items).appendTo('#list_news')
                        } else {
                            $("#list_news").html('暂无数据！');
                        }
                    } else {
                        $("#list_news").html('暂无信息！');
                    }
                },
                error: OnError
            });
        }
    </script>
</body>
</html>
