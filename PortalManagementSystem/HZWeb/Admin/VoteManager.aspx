<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VoteManager.aspx.cs" Inherits="PMSWeb.Admin.VoteManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
        <link href="/Admin/AdminCss/reset.css" rel="stylesheet" />
    <link href="/Admin/AdminCss/layout.css" rel="stylesheet" />
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
    <style>
        .news_lists li{cursor:pointer;}
        .news_lists li:hover{background:#fff;}
    </style>
    <script id="tr_Link" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Title}</td>
            <td>${NameLengthUpdate(Description,35)}</td>
            <td>${DateTimeConvert(CreateTime)}</td>
            <td>{{if isPush==0}}未发布{{else}}已发布{{/if}}</td>
            <td>
                {{if isPush==0}}<a href="javascript:;" onclick="UpdateVote('${Id}','${isPush}')">发布</a>
                {{else}}<a href="javascript:;" onclick="UpdateVote('${Id}','${isPush}')">取消</a>
                {{/if}}
                <a href="javascript:;" onclick="javascript:OpenIFrameWindow('添加','VoteDetails.aspx?VoteId=${Id}','700px','500px')">添加选项</a>
                <a href="javascript:;" onclick="javascript: window.location='VoteEdit.aspx?id=${Id}'"><i class="icon icon-edit"></i>修改</a>
                <a href="javascript:;" onclick="DelVote('${Id}')"><i class="icon icon-trash"></i>删除</a>
                <a href="javascript:;" class="see"><i class="icon icon-eye-open"></i>查看选项</a>
            </td>
        </tr>
        <tr style="display:none;" class="lists">
            <td colspan="6">
                 <ul class="news_lists" style="padding:0px 10px;" id="detals_${Id}">
                   
                 </ul>
            </td>
        </tr>
    </script>
    <script type="text/x-jquery-tmpl" id="tr_vote">
        <li>
            <b></b><em class="fl ml10">${Title}</em>
            <span>${Count}次</span>
            <div onclick="DelVoteDetail('${Id}')" class="fr" style="color:#007cdb;text-decoration:underline;margin-right:10px;cursor:pointer;">删除</div>
        </li>

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
                        <a href="javascript:void(0);" onclick="javascript: window.location='VoteEdit.aspx'"><i class="icon icon-plus"></i>添加</a>
                    </div>
                </div>
                <div class="wrap">
                    <table>
                        <thead>
                            <tr>
                                <th class="number">序号</th>
                                <th>标题</th>
                                <th>描述</th>
                                <th>创建时间</th>
                                <th>状态</th>
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
                    IsDelete:0
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
        function slide() {
            $('#tb_Link tr td').find('.see').click(function () {
                var next = $(this).parents('tr').next('tr');
                $('#tb_Link tr.lists').not(next).slideUp(600);
                next.stop().slideToggle(600);
            })
        }
        function UpdateVote(id, operation) {
            var ispush = 0;
            if (operation == 0) ispush = 1;
            else ispush = 0;
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "UpdateVote",
                    "Id": id,
                    "isPush": ispush
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg('操作成功!');
                        getData(1, 10);
                    }
                },
                error: OnError
            });
        }

        function DelVote(id) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "UpdateVote",
                    "Id": id,
                    "del":"del"
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg('操作成功!');
                        getData(1, 10);
                    }
                },
                error: OnError
            });
        }

        function GetVoteDetails(votes) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetVoteDetailList",
                    "VoteId": votes
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0)
                            $("#tr_vote").tmpl(items).appendTo("#detals_" + votes);
                    }
                },
                error: OnError
            });
        }

        function DelVoteDetail(id) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "UpdateVoteDetail",
                    "Id": id
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg('操作成功!');
                        getData(1, 10);
                    }
                },
                error: OnError
            });
        }

        
    </script>


</body>
</html>
