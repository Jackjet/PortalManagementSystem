<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserManager.aspx.cs" Inherits="PMSWeb.Admin.UserManager" %>

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
    <script type="text/x-jquery-tmpl" id="item_data">
        <tr>
            <td>${pageIndex()}</td>
            <td>${LoginName}</td>
            <td>${RoleName}</td>
            <td>${DateTimeConvert(CreateTime)}</td>
            <td>
                <a href="javascript:;" onclick="javascript: OpenIFrameWindow('修改数据', 'UserInfoEdit.aspx?id=${Id}', '700px', '500px');"><i class="icon icon-edit"></i>修改</a>
                <a href="javascript:;" onclick="DelUser(${Id})"><i class="icon icon-trash"></i>删除</a>

            </td>
        </tr>
    </script>
    <script type="text/x-jquery-tmpl" id="tree_data">
        <li onclick="javascript:filter(${Id},this)" attrid="${Id}"><a >${RoleName}</a></li>
    </script>
    <style>
       /*leftnav*/
.left_navcon {  width:20%; background:#fff; min-height:584px; }
.left_navcon h1 { background:#2789ba; color:#fff; font-size:16px; line-height:34px;padding-left:10px; font-weight:normal; margin-top:10px;}
.left_navcon h1 .btn { line-height:32px;padding-right:10px; font-weight:normal; }
.left_navcon h1 .btn a { border-radius:2px; border:1px solid #fff; padding:0 4px; color:#fff; font-size:12px;}
.left_navcon h3 {  font-size:14px; line-height:32px;padding-left:10px; padding-right:10px; font-weight:normal; color:#333; }
/*menu区域*/
.left_navcon li{ line-height:30px; color:#646464;background:#fff;border-bottom:1px solid #e9e9e9;transition:all 0.3s ease-in-out;}
.left_navcon li .menuclick1 { color:#fff;background:#68accf; font-size:14px; display:block; padding:0px 10px;}
.left_navcon li.selected{background:#2789ba;}
.left_navcon li.selected a{ color:#fff;}
.left_navcon li i{font-size:18px;padding-right:4px;}
/*子菜单*/
.left_navcon .menu .submenu1 li{ background:#fff;color:#3c434d;padding:0px 30px; line-height:30px; border-bottom:1px solid #ddd;}
.left_navcon .menu .submenu1 li:hover{background:#fff;transition:all 0.3s ease-in-out;cursor:pointer;}
.left_navcon .menu .submenu1 li.selected{background:#83bcd8;}
/*.left_navcon .menu .submenu1 li.selected a{color:#fff}*/
.left_navcon .menu .submenu1 li a{color:#3c434d;}


/*right_dcon*/
.right_dcon { width:78%; position:relative;}
.right_dcon .Display_form { margin-top:10px;}
/*操作区域*/
.Operation_area { padding:10px 0; overflow:hidden; }
/*table表格*/
table.W_form { width:100%; text-align:center; font-size:14px;background:#fff;}
table.W_form th {  text-align:center;  color:#575656; font-size:14px; line-height:40px; }
table.W_form tr {  color:#666; line-height:34px; border-bottom:1px solid #d2d2d2; }
table.W_form tr:hover {  background:#f0f8fb; }
table.W_form td {  border-right:1px solid #eee; color:#666; line-height:34px; vertical-align:middle; text-align:left; text-align:center;}
table.W_form td input{  line-height:20px; text-align:center;}
table.W_form td a{ color:#2789ba;}
table.W_form td.list_date { width:90px; float:right;}
/*左边*/
.left_choice ul li { float:left; margin-right:10px;color:#666;}
.left_choice ul li select {border: 1px solid #2789ba;  border-radius: 3px; color: #666;  font-family: "微软雅黑",microsoft yahei ui; font-size: 14px;  height: 32px; line-height: 32px; padding: 0 10px;  width: 200px;}
.left_choice ul li select option { color:#666; line-height:26px; height:26px;}
.left_choice ul li.Sear input.search_w {border: 1px solid #2789ba; border-radius: 3px; color: #666;font-family: "微软雅黑",microsoft yahei ui;font-size: 14px; height: 28px; line-height: 28px; padding-left: 10px;}
.left_choice ul li.Sear input.search_w:hover,.left_choice ul li.Sear input.search_w:visited { border-radius:3px; border:1px solid #5493d7; color:#bbb; }
.left_choice ul li.Sear a.sea {  background: #2789ba; border: 1px solid #2789ba; border-radius: 3px; color: #fff; font-size: 14px; height: 30px; line-height: 27px;  margin-left: -3px; padding: 0 12px; display:inline-block;}
.left_choice ul li.Lab input.search_w {border: 0px solid #2789ba; border-radius: 3px; color: #666;font-family: "微软雅黑",microsoft yahei ui;font-size: 14px; height: 28px; line-height: 28px; padding-left: 10px;}
/*右边*/
.right_add .add { display:block; padding:8px 8px; background:#2789ba; border-radius:3px; color:#fff; float:left; margin-right:4px;}
    </style>
</head>
<body>
    <input type="hidden" id="hRId" />
    <form id="form1" runat="server">
        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <script type="text/javascript">
                    var ptitle = getQueryString("ptitle");
                    var title = getQueryString("title");
                    document.write("<div class=\"crumbs\" style=\"padding: 0; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                </script>
                <%--<div class="newcourse_select clearfix">
                    <div class="distributed fr">
                        <a href="javascript:void(0);" onclick="javascript: OpenIFrameWindow('添加数据', 'UserInfoEdit.aspx', '700px', '500px');"><i class="icon icon-plus"></i>添加</a>
                    </div>
                </div>--%>
                <div class="clearfix">
                <div class="menubox1 left_navcon fl">
                    <!--头部-->
                    <h1><span class="tit_name">角色管理</span><span class="fr btn"><a href="#" onclick="OpenIFrameWindow('权限设置', 'Setting.aspx', '700px', '500px');">权限设置</a></span></h1>
                    <!--菜单区域-->
                    <div class="menu">
                        <ul>
                            <li >
                                <a class="menuclick1" onclick="javascript:filter(-1)" ><i>-</i>全部</a>
                                <div class="zTreeDemoBackground left">
                                    <ul id="tree_Role" style="padding: 0px;" class="submenu1"></ul>
                                </div>
                            </li>

                        </ul>
                    </div>
                    <!--end 菜单区域-->
                </div>


                <div class="right_dcon fr">
                    <div class="Operation_area">
                        <div class="right_add fr">
                            <a class="add" href="#" onclick="responseUrl();">添加成员</a>
                        </div>
                    </div>
                    <div class="Administrator_settings">
                        <table class="W_form" id="tb_UserList">
                            <thead>
                                <tr class="trth">
                                    <th class="number">序号</th>
                                    <th>用户名</th>
                                    <th>角色</th>
                                    <th>创建时间</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody id="tb_notice"></tbody>
                        </table>
                    </div>
                    <!--分页页码开始-->
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                    <!--分页页码结束-->
                </div>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">


        $(function () {
            initRole();
        })
        var roles = [];

        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/UserManagerHandler.ashx",
                    Func: "GetPageList",
                    PageIndex: startIndex,
                    PageSize: pageSize,
                    RoleId: $("#hRId").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_notice").html('');
                        $("#item_data").tmpl(json.result.retData.PagedData).appendTo("#tb_notice");
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

        function initRole() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/RoleHandler.ashx",
                    "func": "GetPageList",
                    "isPage": false
                },
                success: function (json) {
                    var items = json.result.retData;
                    if (items != null && items.length > 0) {
                        for (var i = 0; i < items.length; i++) {
                            var obj = new Object();
                            obj.id = items[i].Id;
                            obj.name = items[i].RoleName;
                            roles.push(obj);
                        }
                        $("#tree_data").tmpl(items).appendTo("#tree_Role");
                        getData(1, 20);
                    }
                },
                error: OnError
            });
        }

        function DelUser(id) {
            layer.confirm('是否删除该用户？', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: { PageName: "DYYX/UserManagerHandler.ashx", Func: "UpdateUserInfo", Id: id, IsDelete: 1 },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            layer.msg('删除成功！');
                            getData(1, 20);
                        } else {
                            layer.msg('操作失败！');
                        }
                    },
                    error: function (errMsg) {
                        layer.msg('操作失败！');
                    }
                });
            }, function () {

            });
        }

        function RoleName(id) {
            var result = false;
            for (var i = 0; i < roles.length; i++) {
                var roleId = roles[i].id;
                if (id == roleId) {
                    result = true;
                    return roles[i].name;
                }
            }
            if (!result) {
                return "暂无";
            }
        }

        function filter(id, evet) {
            var e = evet || window.event;
            if (e != null) $(e).addClass("selected").siblings().removeClass("selected");
            if (id == -1) {
                $("#tree_Role li").removeClass("selected");
                $("#hRId").val("");
            } else {
                $("#hRId").val(id);
            }
            getData(1, 20);

        }

        function responseUrl() {
            debugger;
            var id = "";
            $("#tree_Role li").each(function (index, ele) {
                if ($(ele).hasClass("selected")) {
                    id = $(ele).attr("attrid");
                }
            });
            OpenIFrameWindow('添加成员', 'UserInfoEdit.aspx?roleId=' + id, '400px', '300px');
        }
    </script>
</body>
</html>
