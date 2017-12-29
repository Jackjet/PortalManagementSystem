<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AfterImgList.aspx.cs" Inherits="PMSWeb.Admin.AfterImgList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/common.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/repository.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/onlinetest.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <style type="text/css">
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
    <script id="tr_School" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Title}</td>
            <td>
                <img src="${ImageUrl}" alt="" class="imgShow" />
            </td>
            <%if(isImgScool){ %>
            <td>${SortId}</td>
            <%} %>
            <td>${Creator}</td>
            <td>${DateTimeConvert(CreateTime)}</td>
            <td>
                <a  onclick="javascript: window.location='AfterImgEdit.aspx?Id=${Id}&MenuId=${MenuId}';"><i class="icon icon-edit"></i>修改</a>
                <a  onclick="DeleteSchool('${Id}')"><i class="icon icon-trash"></i>删除</a>
            </td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <asp:HiddenField ID="MenuId" runat="server" />

        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <script type="text/javascript">
                    var ptitle = getQueryString("ptitle");
                    var title = getQueryString("title");
                    document.write("<div class=\"crumbs\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                </script>
                <div class="newcourse_select clearfix">

                    <div class="distributed fr">
                        <a href="javascript:void(0);" onclick="javascript:AddAfterImg()"><i class="icon icon-plus"></i>添加</a>
                    </div>
                </div>
                <div class="wrap">
                    <table>
                        <thead>
                            <tr>
                                <th class="number">序号</th>
                                <th>标题</th>
                                <th>展示图片</th>
                                <th>排序</th>
                                <th>创建人</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="tb_School"></tbody>
                    </table>
                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>
        <%if(isImgScool){ %>
         设置显示滚动图片个数<asp:TextBox type="text" placeholder="个数" class="text"  ID="scool" Text=""  runat="server"/><asp:Button runat="server" Text="确定"  ID="btnOk" OnClick="btnOk_Click" />
        <%} %>
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
                    PageName: "DYYX/SchoolStyleHandler.ashx",
                    Func: "GetPageList",
                    MenuId: $("#MenuId").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_School").html('');
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            var newItems = items;
                            for (var i = 0; i < newItems.length; i++) {
                                var img = newItems[i].ImageUrl;
                                items.ImageUrl = ImgIndex(img);
                            }
                        }
                        $("#tr_School").tmpl(items).appendTo("#tb_School");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_School").html("<tr><td colspan='6'>暂无数据！</td></tr>");
                        $("#pageBar").html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function DeleteSchool(delid) {
            layer.msg("确定要删除该风貌?", {
                time: 0 //不自动关闭
               , btn: ['确定', '取消']
               , yes: function (index) {
                   layer.close(index);
                   $.ajax({
                       url: "/Common.ashx",
                       type: "post",
                       async: false,
                       dataType: "json",
                       data: { PageName: "DYYX/SchoolStyleHandler.ashx", Func: "UpdateSchoolStyle", Id: delid, IsDelete: 1 },
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

        function ImgIndex(path) {
            if (path == null || path == "") return "";
            var imgs = path.split(',');
            return imgs[0];
        }

        function AddAfterImg() {
            window.location.href = 'AfterImgEdit.aspx?MenuId=' + $("#MenuId").val();
        }
    </script>
</body>
</html>
