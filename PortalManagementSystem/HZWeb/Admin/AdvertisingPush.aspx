<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdvertisingPush.aspx.cs" Inherits="PMSWeb.Admin.AdvertisingPush" %>
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
    <script id="item_advert" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Name}</td>
            <td><div style="cursor:pointer;" onclick="javascript: window.location='AfterListEdit.aspx?id=${MenuId}&advId=${Id}';">${NameLengthUpdate(Description,30)}</div></td>                  
            <td>${DateTimeConvert(CreateTime)}</td>
            <td>
                <a href="javascript:;" onclick="UpdateAdvert(${Id})">发布</a>                
            </td>
        </tr>
    </script>
    <style>
        .tiao{
            margin-left: 5px;
            min-width: 88px;
            height: 28px;
            border: 1px solid #a1c7e3;
            border-radius: 2px;
            font-size: 14px;
            text-indent:8px;
        }
        .Btn{
            background: #207abd;
            padding: 7px 12px;
            font-size: 14px;
            color: #fff;
            border-radius: 2px;
            display: inline-block;margin-left:5px;}
        .radio{margin-top:12px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <script type="text/javascript">
                    var ptitle = getQueryString("ptitle");
                    var title = getQueryString("title");
                    document.write("<div class=\"crumbs\" style=\"padding: 10px 20px;line-height:20px; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                </script>
                <div class="newcourse_select clearfix">

                    <div class="clearfix fl course_select">
                        <label for="">类型：</label>
                        <select id="menuType"  onchange="query()" class="select"></select>
                    
                    </div>
                </div>
                <div id="tabA">
                    <div class="wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th class="number">序号</th>
                                    <th>栏目</th>
                                    <th>标题</th>                                    
                                    <th>创建时间</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody id="tb_notice"></tbody>
                        </table>
                    </div>
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>
            </div>
        </div>
        <!--分页-->
    </form>
    <script type="text/javascript">
        $(function () {
            query();
            initSelect();
        })

        function initSelect() {
            var opt = document.getElementById('menuType');
            opt.options.length = 0;
            opt.options.add(new Option("请选择", ""));
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: "GetMenuParent"
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].Name == "首页") continue;
                                if (items[i].Name == "首页模块") continue;
                                if (items[i].Name == "系统管理") continue;
                                if (items[i].Name == "权限管理") continue;
                                var option = new Option(items[i].Name, items[i].Id);
                                opt.options.add(option);
                            }
                            query();
                        }
                    }
                    else {

                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function getData(startIndex, pageSize) {
            var d = $("#menuType").val();
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdvertisingHandler.ashx",
                    Func: "GetPageListForMenuId",
                    PageIndex: startIndex,
                    PageSize: pageSize,
                    MenuId: $("#menuType").val(),
                    isPush: 0,
                    isAll:true
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_notice").html('');
                        $("#item_advert").tmpl(json.result.retData.PagedData).appendTo("#tb_notice");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_notice").html("<tr><td colspan='9'>暂无信息！</td></tr>");
                        $("#pageBar").html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
        function query() {
            getData(1, 30);
        }
        //发布
        function UpdateAdvert(id) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "DYYX/AdvertisingHandler.ashx", Func: "UpdateAdvertising", Id: id, isPush: 1 },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("发布成功");
                        getData(1, 30);
                    }
                    else { layer.msg('发布失败！'); }
                },
                error: function (errMsg) {
                    layer.msg('发布失败！');
                }
            });
        }
    </script>
</body>
</html>

