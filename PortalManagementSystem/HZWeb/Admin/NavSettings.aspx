<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NavSettings.aspx.cs" Inherits="PMSWeb.Admin.NavSettings" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <link href="/Admin/AdminCss/font-awesome.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/common.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/repository.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/onlinetest.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script id="tr_Old" type="text/x-jquery-tmpl">
        <tr>
            <td class="checkradio pr">
                <input type="checkbox" value="${Id}"/></td>
            <td>${Description}</td>
            <td>${DateTimeConvert(CreateTime)}</td>
        </tr>
    </script>
    <script id="tr_New" type="text/x-jquery-tmpl">
        <tr>
            <td class="checkradio pr">
                <input type="checkbox" value="${Id}"/></td>
            <td>${Description}</td>
            <td>${DateTimeConvert(CreateTime)}</td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div class="enroll_allot mt10 clearfix">
			<div class="enroll_students fl">
				<div class="enroll_title">
					原导航
				</div>
				<div class="enrollgrade_select clearfix">
					<div class="clearfix fl course_select">
						<label for="">一级导航：</label>
						<select name="" id="FirstNav" class="select " onchange="GetSecondNav('old')">
							
						</select>
					</div>
                    <div class="clearfix fl course_select">
						<label for="">二级导航：</label>
						<select name="" id="SecondNav" class="select " onchange="getOldData(1, 10);">
							
						</select>
					</div>
				</div>
				<div class="students_lists" id="OldList">
					<div class="wrap" style="padding:10px;margin-top:0;">
					    <table id="table_Old">
						    <thead>
                                <tr>
							        <th class="pr checkall"><input type="checkbox" name="" id="" /> 选择</th>
							        <th>标题</th>
							        <th>时间</th>
                                </tr>
						    </thead>
						    <tbody id="tb_Old"></tbody>
                        </table>
                    </div>
				</div>
			</div>
			<div class="tab_btn fl">
				<div class="tab_left" onclick="SaveData('left');">
					<i class="icon  icon-angle-left"></i>
				</div>
				<div class="tab_right" onclick="SaveData('right');">
					<i class="icon icon-angle-right"></i>
				</div>
			</div>
			<div class="allot_students fr">
				<div class="allot_title">
					新导航
				</div>
				<div class="allotgrade_select clearfix">
					<div class="clearfix fl course_select">
						<label for="">一级导航：</label>
						<select name="" id="NewFirstNav" class="select" onchange="GetSecondNav('new')">
							<option value="">高一</option>
							<option value="">高二</option>
							<option value="">高三</option>
						</select>
					</div>
                    <div class="clearfix fl course_select">
						<label for="">二级导航：</label>
						<select name="" id="NewSecondNav" class="select " onchange="getNewData(1, 10);">
							<option value="">高一</option>
						</select>
					</div>
				</div>
				<div class="students_lists" id="NewList">
					<div class="wrap wrap1" style="padding:10px;margin-top:0;">
					    <table id="table_New">
						    <thead>
                                <tr>
							        <th class="pr checkall"><input type="checkbox" name="" id="" /> 选择</th>
							        <th>标题</th>
							    <th>时间</th>
                                </tr>
						    </thead>
						    <tbody id="tb_New"></tbody>
                        </table>
                    </div>
				</div>
			</div>
		</div>
    </div>
    </form>
    <script>
        $(function () {
            GetFirstNav();
        });       
        function GetFirstNav() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetMenuParent"                   
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {                       
                        var items = json.result.retData.PagedData;
                        if (items != null) {
                            $("#FirstNav").empty();
                            $("#NewFirstNav").empty();
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].Name == "首页") continue;
                                if (items[i].Name == "首页模块") continue;
                                if (items[i].Name == "系统管理") continue;
                                if (items[i].Name == "权限管理") continue;
                                var node = new Object();                                
                                node.id = items[i].Id;                                
                                node.name = items[i].Name;
                                $("#FirstNav").append("<option value=" + node.id + ">" + node.name + "</option>");
                                $("#NewFirstNav").append("<option value=" + node.id + ">" + node.name + "</option>");                                
                            }
                            GetSecondNav("old");
                            GetSecondNav("new");
                        }
                    }
                },
                error: function (textStatus) {
                    layer.msg("获取导航出现问题了,请通知管理员!");
                }
            });
        }
        function GetSecondNav(type) {
            var pid = type=='old'?$('#FirstNav option:selected').val():$('#NewFirstNav option:selected').val();
            var secNav = type == 'old' ? "#SecondNav" : "#NewSecondNav";
            var $secNav = $(secNav);
            $secNav.empty();
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetPortalChildTreeDataForParentId",
                    "isPage": false,
                    "Id": pid,
                    "Display": 0,
                    "IsDelete": 0
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null) {
                            for (var i = 0; i < items.length; i++) {                                
                                var node = new Object();
                                node.id = items[i].Id;
                                node.name = items[i].Name;                                                          
                                $secNav.append("<option value=" + node.id + ">" + node.name + "</option>");
                            }
                            if (type == 'old') {
                                getOldData(1, 10);
                            } else {
                                getNewData(1, 10);
                            }
                        }                                              
                    }
                },
                error: function (textStatus) {
                    layer.msg("获取导航出现问题了,请通知管理员!");
                }
            });
        }
        function getOldData(startIndex, pageSize) {
            $('#table_Old input[type=checkbox]')[0].checked = false;
            $("#tb_Old").html('');
            var menuid = $('#SecondNav option:selected').val();            
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",               
                dataType: "json",
                data: {
                    PageName: "DYYX/AdvertisingHandler.ashx",
                    Func: "GetPageList",
                    PageIndex: startIndex,
                    PageSize: pageSize,
                    MenuId: menuid,
                    isPush: 1,
                    isPage: false
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {                        
                        $("#tr_Old").tmpl(json.result.retData).appendTo("#tb_Old");
                        NewCheckAll($('#table_Old input[type=checkbox]'));
                        //makePageBar(getOldData, document.getElementById("pageBar_Old"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_Old").html("<tr><td colspan='9'>暂无信息！</td></tr>");
                        //$("#pageBar_Old").html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {}
            });
        }
        function getNewData(startIndex, pageSize) {
            $('#table_New input[type=checkbox]')[0].checked = false;
            $("#tb_New").html('');
            var menuid = $('#NewSecondNav option:selected').val();            
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",               
                dataType: "json",
                data: {
                    PageName: "DYYX/AdvertisingHandler.ashx",
                    Func: "GetPageList",
                    PageIndex: startIndex,
                    PageSize: pageSize,
                    MenuId: menuid,
                    isPush: 1,
                    isPage:false
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {                        
                        $("#tr_New").tmpl(json.result.retData).appendTo("#tb_New");
                        NewCheckAll($('#table_New input[type=checkbox]'));
                        //makePageBar(getNewData, document.getElementById("pageBar_New"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_New").html("<tr><td colspan='9'>暂无信息！</td></tr>");
                        $("#pageBar_New").html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { }
            });
        }
        function SaveData(type) {
            var secOldid=$('#SecondNav option:selected').val(),secNewid=$('#NewSecondNav option:selected').val(); 
            if (secOldid == secNewid) {
                layer.msg("原二级导航和新二级导航不能一样!");
                return;
            }
            var checkedtr = [];
            var menuid = 0;
            if (type == 'left') {
                checkedtr = $("#tb_New input[type=checkbox]:checked");
                menuid = secOldid;
            } else {
                checkedtr = $("#tb_Old input[type=checkbox]:checked");
                menuid = secNewid;
            }
            if (checkedtr.length == 0) { layer.msg('请选择要更改的行！'); return; }
            var idArray = [];
            $(checkedtr).each(function (i, n) {
                idArray.push(n.value);
            });
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdvertisingHandler.ashx",
                    Func: "BatchChangeMenuId",
                    MenuId: menuid,
                    Ids: idArray.join(",")                    
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        layer.msg("操作成功!");
                        getOldData(1, 10);                  
                        getNewData(1, 10);
                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
    </script>
</body>
</html>
