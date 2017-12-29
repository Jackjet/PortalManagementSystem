

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta charset="utf-8" /><title>
	延庆县职业技术教育中心
</title><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /><meta name="renderer" content="webkit" /><link rel="stylesheet" href="/YQZJ/css/reset.css" /><link rel="stylesheet" href="/YQZJ/css/layout.css" />
		<script src="/Scripts/jquery-1.11.2.min.js"></script>
        <script src="/YQZJ/js/jquery.SuperSlide.2.1.1.js"></script>
        <script src="/Scripts/Common.js"></script>
        <script src="/Scripts/jquery.tmpl.js"></script>
        <script src="/YQZJ/js/common.js"></script>
		<script type="text/javascript">
		    $(function () {
		        $("#header").load('/YQZJ/Header.aspx');
		        $('#footer').load('/YQZJ/bottom.aspx');
		    });
		</script>
    <style>
        #list_news li span.text a {
            width: 285px;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }
    </style>
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
                        <a href="/YQZJ/Sitepages/BeforeItemList.aspx?id=${Id}&selectPid=${PId}" target="_blank">更多</a>
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
            <span class="text"><a href="/YQZJ/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}&selectPid=${PId}" target="_blank">${Description}</a></span>
			<span class="date">   
			    <a>${DateTimeConvert(CreateTime,'MM-dd')}</a>
            </span>
        </li>
    </script>
    <script id="item_list2" type="text/x-jquery-tmpl">
        <li>
			<img src="/YQZJ/images/point.png" />
            <span class="text"><a href="/YQZJ/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}&selectPid=${p_ID}" target="_blank">${Description}</a></span>
			<span class="date">   
			   <a>${ClickNum}</a>
            </span>
        </li>
    </script>
    <script id="item_imgList" type="text/x-jquery-tmpl">
        <ul class="everyone fl">
            <li class="teacherphoto">
                <a href="/YQZJ/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}&selectPid=${p_ID}">
                    <img src="${ImageUrl.split(',')[0]}" />
                </a>
            </li>
            <li class="name">
                <a href="/YQZJ/Sitepages/BeforeView.aspx?id=${MenuId}&advId=${Id}&selectPid=${p_ID}">${Description}</a>
            </li>
        </ul>
    </script>
    <script id="img_module" type="text/x-jquery-tmpl">
        <div class="left_2 fl">
			<div class="title">
				<p>
				    <span class="tit_left fl">
				        <img src="/YQZJ/images/icon01.png" />
				        <a class="tit">${Name}</a>
				        <a class="english"></a>
				    </span>
				    <span class="tit_right fr" style="display: block">
                        <a href="/YQZJ/Sitepages/BeforeItemList.aspx?id=${Id}&selectPid=${p_ID}">更多</a>
				    </span>
				</p>
			</div>
    		<div class="content" id="img_lists">
                <div class="scroll">
                </div>
    		</div>
		</div>
    </script>
</head>
<body>
    <form method="post" action="Category.aspx?pid=0&amp;id=16&amp;selectPid=16" id="form1">
<div class="aspNetHidden">
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="OS8noj2C8uerHWeG+6s4s1Oi7Fkw3cuAkIJSbgAjTfl3fnIqieb09o2fDrD9PpjKsTfRu0b7GPhyinFBqQsqQLRxQ8VB8qeUYzFNV5Vabgk=" />
</div>

    <div>
        <div id="header" style="min-height: 242px;"></div>
		<div class="center main" id="initheight">
			<div class="center_center_con main" >	
				<div class="center_center_left fl">
                    <div class="left_1"  id="modult_wrap">

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
        <div id="footer" style="height: 44px;"></div>
    </div>
    </form>
    <script>
        var selectPid;

        $(function () {
            selectPid = getQueryString('selectPid');
            initModult();
            initXWKX(1, 20)
        })
        function initModult() {
            Id = getQueryString('id');
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdvertisingHandler.ashx",
                    "func": "GetMenusItemsData",
                    "MenuIds": Id,
                    "IsDelete": 0,
                    "isPush": 1,
                    "isAll": true,
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $('#modult_wrap').html('');
                        var titles = json.result.retData;
                        if (titles != null && titles.length > 0) {
                            //采集数据
                            if ((titles.length) % 2 == 1) {
                                var ary = [];
                                for (var i = 0; i < titles.length - 1; i++) {
                                    ary.push(titles[i]);
                                }
                                $("#modult").tmpl(ary).appendTo("#modult_wrap");
                                //循环数据实体
                                for (i = 0; i < ary.length; i++) {
                                    var title = ary[i];
                                    var newlists = title.ListData;
                                    if (newlists != null) {
                                        var _list = newlists.PagedData;
                                        for (var j in _list) {
                                            _list[j].p_ID = selectPid;
                                        }
                                    }else {
                                        $('#lists_' + title.Id).html('<li><img src="/YQZJ/images/point.png"><span class="text"><a href="javascript:;" target="_blank">暂无数据</a></span></li>');
                                    }
                                    if (newlists != null && newlists.PagedData.length > 0) {
                                        if (title.DisplayType == "时间") {
                                            $("#item_list1").tmpl(newlists.PagedData).appendTo('#lists_' + title.Id);
                                        } else if (title.DisplayType == "点击量") {
                                            $("#item_list2").tmpl(newlists.PagedData).appendTo('#lists_' + title.Id);
                                        }
                                    } else {
                                        $('#lists_' + title.Id).html('<li><img src="/YQZJ/images/point.png"><span class="text"><a href="javascript:;" target="_blank">暂无数据</a></span></li>');
                                    }
                                }
                                //最后一段数据（属于图片数据）
                                var curItem = titles[titles.length - 1];
                                $('#img_module').tmpl(curItem).appendTo('#modult_wrap');
                                //德育教育的数据（图片模式显示）
                                var imgList = curItem.ListData;
                                //项集合
                                if (imgList != null && imgList.PagedData.length > 0) {
                                    if (imgList != null) {
                                        if (imgList.PagedData !== null) {
                                            //通过该方式将没有图片的数据进行排出（不显示）
                                            var count = imgList.PagedData.length;
                                            var j = 0
                                            for (j; j < count; j++) {
                                                if (imgList.PagedData[j].ImageUrl == "") {
                                                    imgList.PagedData.splice(j, 1);
                                                    j--;
                                                    count--;
                                                }
                                                else {
                                                    imgList.PagedData[j].p_ID = selectPid;
                                                }
                                            }
                                        } else {
                                            $('#img_lists').html('暂无数据').css({ 'textAlign': 'center', 'lineHeight': '178px' });
                                        }
                                    } else {
                                        $('#img_lists').html('暂无数据').css({ 'textAlign': 'center', 'lineHeight': '178px' });
                                    }
                                    $("#item_imgList").tmpl(imgList.PagedData).appendTo('#img_lists .scroll');
                                    $('#img_lists').slide({ mainCell: ".scroll", effect: "leftLoop", vis: 5, autoPlay: true });
                                } else {
                                    $('#img_lists').html('暂无数据').css({ 'textAlign': 'center', 'lineHeight': '178px' });
                                }
				
                                 
                            } else {
                                $("#modult").tmpl(titles).appendTo("#modult_wrap");
                                for (i = 0; i < titles.length; i++) {
                                    var title = titles[i];
                                    var newlists = title.ListData;
                                    if (newlists!=null&&newlists.PagedData != null) {
                                        var _list = newlists.PagedData;
                                        for (var j in _list) {
                                            _list[j].p_ID = selectPid;
                                        }
                                    }
                                    if (newlists != null && newlists.PagedData.length > 0) {
                                        if (title.DisplayType == "时间") {
                                            $("#item_list1").tmpl(newlists.PagedData).appendTo('#lists_' + title.Id);
                                        } else if (title.DisplayType == "点击量") {
                                            $("#item_list2").tmpl(newlists.PagedData).appendTo('#lists_' + title.Id);
                                        }
                                    } else {
                                        $('#lists_' + title.Id).html('<li><img src="/YQZJ/images/point.png"><span class="text"><a href="javascript:;" target="_blank">暂无数据</a></span></li>');
                                    }
                                }
                               
                            } 
                        } else {
                            $("#modult").html("暂无数据");
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

                        for (var i in items) {
                            items[i].p_ID = selectPid;
                        }

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
