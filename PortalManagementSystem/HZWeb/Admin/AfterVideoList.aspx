<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AfterVideoList.aspx.cs" Inherits="PMSWeb.Admin.AfterVideoList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script id="item_news" type="text/x-jquery-tmpl">
        <li>
            <b></b><a href="AfterVideoEdit.aspx?id=${MenuId}&advId=${Id}">${NameLengthUpdate(Description,70)}</a>        
            <em style="cursor: pointer; text-decoration: underline; color: #207abd; float: right; margin-left: 10px;" onclick="javascript:DeleteAdvert(${Id})">删除</em>
            {{if AdminPower(isPush)==1}}
            {{if isPush==0}}
            <em style="cursor: pointer; text-decoration: underline; color: #207abd; float: right; margin-left: 10px;" onclick="javascript:UpdateAdvert(${Id},${isPush})">发布</em>
            {{else}}
            <em style="cursor: pointer; text-decoration: underline; color: #207abd; float: right; margin-left: 10px;" onclick="javascript:UpdateAdvert(${Id},${isPush})">取消发布</em>
            {{/if}}
            {{/if}}
            <span>${DateTimeConvert(CreateTime,'yyyy-MM--dd')}</span>
        </li>
    </script>
</head>
<body style="background:#fff;">
    <form id="form1" runat="server">
        <asp:HiddenField ID="HMenuId" runat="server" />
        <div class=" clearfix mb20" style="padding: 10px 20px 0px 20px">
            <script type="text/javascript">
                var ptitle = getQueryString("ptitle");
                var title = getQueryString("title");
                document.write("<div class=\"crumbs\" style=\"padding: 0; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
            </script>
            <!--leftnav-->
            <div class="newcourse_select clearfix">
                <div class="distributed fr">
                    <a href="javascript:void(0);" onclick="javascript:RedirectUrl() "><i class="icon icon-plus"></i>添加</a>
                </div>
            </div>
            <div>
                <div class="content_detail">
                    <div class="clearfix" style="border: 1px solid #96BFE2;line-height:30px;margin-bottom:10px;padding:5px 10px;background: #d0e3f1;">
                        <div class="title fl">
                            标题
                        </div>
                        <div class="fr oprate" style="margin-right:10px;color:#2562ba">
                            操作
                        </div>
                        <div class="fr date" style="margin-right:70px;color:#2562ba">
                            日期
                        </div>
                    </div>
                    <ul class="news_lists" id="newsList">
                    </ul>
                     <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>
            </div>
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
                     PageName: "DYYX/AdvertisingHandler.ashx",
                     Func: "GetPageList",
                     //type: $("#selType").val(),
                     MenuId: $("#HMenuId").val(),
                     PageIndex: startIndex,
                     pageSize: pageSize
                 },
                 success: function (json) {
                     if (json.result.errMsg == "success") {
                         $("#newsList").html('');
                         $("#item_news").tmpl(json.result.retData.PagedData).appendTo("#newsList");
                         makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                     }
                     else {
                         $("#newsList").html("<tr><td colspan='2'>暂无数据！</td></tr>");
                         $("#pageBar").html("");
                     }
                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                 }
             });
         }
         function DeleteAdvert(delid) {
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
                        data: { PageName: "DYYX/AdvertisingHandler.ashx", Func: "UpdateAdvertising", Id: delid, IsDelete: 1 },
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
         function UpdateAdvert(id, isPush) {
             if (isPush == 0) isPush = 1;
             else isPush = 0;
             $.ajax({
                 url: "/Common.ashx",
                 type: "post",
                 async: false,
                 dataType: "json",
                 data: { PageName: "DYYX/AdvertisingHandler.ashx", Func: "UpdateAdvertising", Id: id, isPush: isPush },
                 success: function (json) {
                     if (json.result.errNum.toString() == "0") {
                         layer.msg("操作成功");
                         getData(1, 10);
                     }
                     else { layer.msg('操作失败！'); }
                 },
                 error: function (errMsg) {
                     layer.msg('操作失败！');
                 }
             });
         }
         function RedirectUrl() {
             window.location = 'AfterVideoEdit.aspx?id=' + $("#HMenuId").val();
         }
         function getImageUrl(filepath) {
             if (filepath!=null&&filepath != "") {
                 var imageurl = filepath.substring(0, filepath.lastIndexOf('.')) + ".jpg";
                 return imageurl;
             }
             return "";
         }
     </script>
</body>
</html>
