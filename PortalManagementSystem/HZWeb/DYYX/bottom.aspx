<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bottom.aspx.cs" Inherits="PMSWeb.DYYX.bottom" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <%--<link href="/DYYX/css/reset.css" rel="stylesheet" type="text/css">
    <link href="/DYYX/css/layout.css" rel="stylesheet" type="text/css">
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>--%>
</head>
<body>
    <div class="bottom">
        <p>
            <span>地址：北京市门头沟区永定镇上园北路9号</span> &nbsp; &nbsp;  
				<span>电话：69842047</span> &nbsp; &nbsp; 
				<span>邮编：102300</span> &nbsp; &nbsp; 
				<span>邮箱：mtgdyyx@163.com</span>
        </p>
        <p>京ICP备05039435号-1</p>
        <%--<p><a  href="#"  id="requestLogin" style="cursor:pointer">管理员登录</a></p>--%>
    </div>
    <script type="text/javascript">
        $(function () {
            //initLogin();
        })

        function initLogin() {
            if ($.cookie('LoginCookie_Cube') == null || $.cookie('LoginCookie_Cube') == "null" || $.cookie('LoginCookie_Cube') == "") {
                $("#requestLogin").attr("onclick", "javascript:window.parent.OpenIFrameWindow('用户登录', '/DYYX/DYYXLogin.aspx', '500px', '400px');");
            } else {
                $("#requestLogin").attr("onclick", "javascript:window.parent.window.location.href ='/Admin/Index.aspx'");
            }
        }
    </script>
</body>
</html>
