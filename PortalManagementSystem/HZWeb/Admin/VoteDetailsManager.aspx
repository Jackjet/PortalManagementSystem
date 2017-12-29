<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VoteDetailsManager.aspx.cs" Inherits="PMSWeb.Admin.VoteDetailsManager" %>

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
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/repository.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/onlinetest.css" />
    
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>

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
                        <a href="javascript:void(0);" onclick="javascript: window.location='VoteEdit.aspx'"><i class="icon icon-plus"></i>添加</a>
                    </div>
                </div>
                <div class="wrap">
                    <table>
                        <thead>
                            <tr>
                                <th class="number">序号</th>
                                <th>标题</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="tb_Link"></tbody>
                    </table>
                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            getData(1, 10);
        });

        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: "GetVoteList",
                    PageIndex: startIndex,
                    pageSize: pageSize,
                    IsDelete: 0
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_Link").html('');
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {

                            $("#tr_Link").tmpl(items).appendTo("#tb_Link");
                            makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                            for (var i = 0; i < items.length; i++) {
                                GetVoteDetails(items[i].Id);
                            }
                        }

                        slide();
                    }
                    else {
                        $("#tb_Link").html("<tr><td colspan='8'>暂无信息！</td></tr>");
                        $("#pageBar").html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    </script>

</body>
</html>
