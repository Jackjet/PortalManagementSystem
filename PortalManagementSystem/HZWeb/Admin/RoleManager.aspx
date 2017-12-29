<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RoleManager.aspx.cs" Inherits="PMSWeb.Admin.RoleManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <link href="/Admin/AdminCss/font-awesome.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/common.css" />
    <link href="/Admin/AdminCss/common.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/repository.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/onlinetest.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script  type="text/x-jquery-tmpl" id="item_data">
        <tr>
            <td>${pageIndex()}</td>
            <td>${RoleName}</td>
            <td>
                <a href="javascript:;" onclick="javascript: OpenIFrameWindow('修改数据', 'RoleInfoEdit.aspx?id=${Id}', '700px', '500px');"><i class="icon icon-edit"></i>修改</a>
                <a href="javascript:;" onclick="DelRole(${Id})"><i class="icon icon-trash"></i>删除</a>

            </td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">
     <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <script type="text/javascript">
                    var ptitle = getQueryString("ptitle");
                    var title = getQueryString("title");
                    document.write("<div class=\"crumbs\" style=\"padding: 0; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                </script>
                 <div class="newcourse_select clearfix">
                    <div class="distributed fr">
                        <a href="javascript:void(0);" onclick="javascript: OpenIFrameWindow('添加数据', 'RoleInfoEdit.aspx', '700px', '500px');"><i class="icon icon-plus"></i>添加</a>
                    </div>
                </div>
                <div class="wrap">
                    <table>
                        <thead>
                            <tr>
                                <th class="number">序号</th>
                                <th>角色名称</th>
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
    </form>
     <script type="text/javascript">
         $(function () {
             getData(1, 20);
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
                     PageName: "DYYX/RoleHandler.ashx",
                     Func: "GetPageList",
                     PageIndex: startIndex,
                     PageSize: pageSize,
                     isPage: true
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

         function DelRole(id) {
             layer.confirm('是否删除角色？', {
                 btn: ['确定', '取消'] //按钮
             }, function () {
                 $.ajax({
                     url: "/Common.ashx",
                     type: "post",
                     async: false,
                     dataType: "json",
                     data: { PageName: "DYYX/RoleHandler.ashx", Func: "UpdateRoleInfo", Id: id, IsDelete: 1 },
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

    </script>
</body>
</html>
