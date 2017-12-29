<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SysLinkManager.aspx.cs" Inherits="PMSWeb.Admin.SysLinkManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <link href="/Admin/AdminCss/reset.css" rel="stylesheet" />
    <link href="/Admin/AdminCss/layout.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/common.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/repository.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/onlinetest.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/DYYX/js/layout.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <style>
        #dndArea {
            width: 475px;
        }

        .ui-upload-input {
            position: absolute;
            top: 0px;
            right: 0px;
            height: 100%;
            cursor: pointer;
            opacity: 0;
            filter: alpha(opacity:0);
            z-index: 999;
            font-size: 100px;
        }

        .ui-upload-holder {
            position: relative;
            width: 100px;
            height: 27px;
            border: 1px solid silver;
            overflow: hidden;
            border-radius: 3px;
            cursor: pointer;
        }

        .ui-upload-txt {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100px;
            height: 27px;
            line-height: 27px;
            text-align: center;
            background: #0097DD none repeat scroll 0% 0%;
            color: #fff;
            font: 12px "微软雅黑";
            vertical-align: middle;
            padding: 5px 0px;
            cursor: pointer;
        }

        .settingsd {
            padding: 20px;
        }

            .settingsd table tr td {
                border: 1px solid #ccc;
                padding: 10px;
            }

        .shgnchuanbottom {
            width: 102px;
            height: 30px;
            margin: 0 auto;
        }


        .h-ico {
            display: inline-block;
        }

        .imgShow {
            width: 80px;
            height: 100px;
        }

        .course_manage .crumbs {
            border: none;
        }
    </style>
     <script id="tr_Link" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Title}</td>
            <td>
                <img src="${ImageUrl}" alt="" class="imgShow" /></td>
            <td>${SortId}</td>
            <td>${Href}</td>
            <td>${DateTimeConvert(CreateTime)}</td>
            <td>
                <a href="javascript:;" onclick="javascript: window.location='SysLinkEdit.aspx?Id=${Id}'"><i class="icon icon-edit"></i>修改</a>
                <a href="javascript:;" onclick="DelLink('${Id}')"><i class="icon icon-trash"></i>删除</a>
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
                        <a href="javascript:void(0);" onclick="javascript: window.location='SysLinkEdit.aspx'"><i class="icon icon-plus"></i>添加</a>
                    </div>
                </div>
                <div class="wrap">
                    <table>
                        <thead>
                            <tr>
                                <th class="number">序号</th>
                                <th>标题</th>
                                <th>图片信息</th>
                                <th>排序</th>
                                <th>链接地址</th>
                                <th>创建时间</th>
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
                    Func: "GetLinkList",
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_Link").html('');
                        $("#tr_Link").tmpl(json.result.retData.PagedData).appendTo("#tb_Link");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
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

        function DelLink(Id) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: "UpdateLink",
                    IsDelete: 1,
                    Id: Id
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg("操作成功！");
                        query();
                    }
                    else {
                        layer.msg("操作失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function query() {
            getData(1, 10);
        }

    </script>
</body>
</html>
