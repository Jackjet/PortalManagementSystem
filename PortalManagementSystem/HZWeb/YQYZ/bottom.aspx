<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bottom.aspx.cs" Inherits="PMSWeb.YQYZ.bottom" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <link href="/YQYZ/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="/YQYZ/css/layout2.css" rel="stylesheet" type="text/css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
</head>
<body>
    <div class="bottom">
        <p>请使用IE5.0或以上版本浏览器,分辩率800×600或更高&nbsp;&nbsp;&nbsp;&nbsp;第一中学版权所有 ©</p>
        <p>
            <img src="/YQYZ/images/police.png">京公网安备110229000057号&nbsp;&nbsp;&nbsp;&nbsp;京ICP备05015260号
        </p>
        <p><%--<a href="javascript:;" id="requestLogin" style="cursor:pointer" target="_blank">管理员登录</a>--%></p>
    </div>
     <script type="text/javascript">
         //$(function () {
         //    initLogin();
         //})

         //function initLogin() {
         //    if ($.cookie('LoginCookie_Cube') == null || $.cookie('LoginCookie_Cube') == "null" || $.cookie('LoginCookie_Cube') == "") {
         //        $("#requestLogin").attr("href", "/YQYZ/YQYZLogin.aspx");
         //    } else {
         //        $("#requestLogin").attr("href", "/admin/Index.aspx");
         //    }
         //}
    </script>
</body>
</html>
