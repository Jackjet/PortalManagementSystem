<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoticeManager.aspx.cs" Inherits="PMSWeb.Admin.NoticeManager" %>

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
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script id="tr_notice" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Title}</td>
            <td>{{if Hot==1}}是
                {{else}}否
                {{/if}}</td>
            <td>${SortId}</td>
            <td>${ClickNum}</td>
            <td>${DateTimeConvert(CreateTime)}</td>
            <td>{{if Hot==1}}
                 <a href="javascript:;" onclick="UpOrDown('${Id}','0')">取消置顶</a>
                {{else}}
                <a href="javascript:;" onclick="UpOrDown('${Id}','1')">置顶</a>
                {{/if}}

                {{if isPush==0}}
                 <a href="javascript:;" onclick="ShowOrClose('${Id}','1')">发布</a>
                {{else}}
                <a href="javascript:;" onclick="ShowOrClose('${Id}','0')">取消发布</a>
                {{/if}}

                <a  href="javascript:;" onclick="javascript:request(${Id}) ;"><i class="icon icon-edit"></i>修改</a>
                <a  href="javascript:;" onclick="DeleteNotice('${Id}')"><i class="icon icon-trash"></i>删除</a>
            </td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <!--header-->
        <asp:HiddenField ID="MenuId" runat="server" />
        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <script type="text/javascript">
                    var ptitle = getQueryString("ptitle");
                    var title = getQueryString("title");
                    document.write("<div class=\"crumbs\" style=\"padding: 0; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                </script>
                <div class="newcourse_select clearfix">
                    
                   <%-- <div class="clearfix fl course_select">
                        <label for="">选择日期：</label>
                        <input type="text" class="Wdate text" id="StarDate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'EndDate\',{d:-1});}'})" style="height: 26px; border: 1px solid #9ec5e2; border-radius: 2px; width: 178px;" />
                        <input type="text" class="Wdate text" id="EndDate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'StarDate\',{d:0});}'})" style="height: 26px; border: 1px solid #9ec5e2; border-radius: 2px; width: 178px;" />
                    </div>
                    <div class="clearfix fl course_select">
                        <label for="">关键字：</label>
                        <input type="text" id="keyWord" class="text" style="height: 26px; border: 1px solid #9ec5e2; border-radius: 2px; width: 178px;" />
                    </div>--%>
                    <div class="distributed fr">
                        <%--<a href="javascript:void(0);" onclick="queryTab('q')">查询</a>--%>
                        <a href="javascript:void(0);" onclick="javascript: request();"><i class="icon icon-plus"></i>添加</a>
                    </div>
                </div>
                <div id="tabA">
                    <div class="wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th class="number">序号</th>
                                    <th>标题</th>
                                    <th>是否置顶</th>
                                    <th>排序</th>
                                    <th>点击量</th>
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
                    PageName: "DYYX/NoticesHandler.ashx",
                    Func: "GetPageList",
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize,
                    keyWord: $("#keyWord").val(),
                    MenuId:$("#MenuId").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_notice").html('');
                        $("#tr_notice").tmpl(json.result.retData.PagedData).appendTo("#tb_notice");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_notice").html("<tr><td colspan='9'>暂无系统通知！</td></tr>");
                        $("#pageBar").html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("#ul_notice_course").html(json.result.errMsg.toString());
                }
            });
        }

        function DeleteNotice(delid) {
            layer.msg("确定要删除该通知?", {
                time: 0 //不自动关闭
               , btn: ['确定', '取消']
               , yes: function (index) {
                   layer.close(index);
                   $.ajax({
                       url: "/Common.ashx",
                       type: "post",
                       async: false,
                       dataType: "json",
                       data: { PageName: "DYYX/NoticesHandler.ashx", Func: "UpdateNotice", Id: delid, IsDelete: 1 },
                       success: function (json) {
                           if (json.result.errNum.toString() == "0") {
                               layer.msg("删除成功");
                               getData(1, 10);
                           }
                           else { layer.msg('删除失败！'); }
                       },
                       error: function (errMsg) {
                           layer.msg('删除失败！');
                       }
                   });
               }
            });
        }

        function UpOrDown(id, status) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "DYYX/NoticesHandler.ashx", Func: "UpdateNotice", Id: id, Hot: status },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("操作成功！");
                        getData(1, 10);
                    }
                    else { layer.msg('操作失败！'); }
                },
                error: function (errMsg) {
                    layer.msg('操作失败！');
                }
            });
        }

        function ShowOrClose(id, status) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "DYYX/NoticesHandler.ashx", Func: "UpdateNotice", Id: id, isPush: status },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("操作成功！");
                        getData(1, 10);
                    }
                    else { layer.msg('操作失败！'); }
                },
                error: function (errMsg) {
                    layer.msg('操作失败！');
                }
            });
        }

        function query() {
            getData(1, 10);
        }

        function request(id) {
            if (id == null) id = "";
            window.location='NoticeEdit.aspx?Id=' + id + "&MenuId=" + $("#MenuId").val();
        }

    </script>
</body>
</html>
