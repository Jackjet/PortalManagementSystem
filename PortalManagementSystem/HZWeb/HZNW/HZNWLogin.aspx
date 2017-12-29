<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HZNWLogin.aspx.cs" Inherits="PMSWeb.HZNW.HZNWLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <link href="css/reset.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <style type="text/css">
	*{padding:0px;margin:0px;}
	body{font-size:14px;font-family:"微软雅黑",microsoft yahei ui;}
	ul,li{list-style:none;}
	a ,em,p{font-family:"微软雅黑",microsoft yahei ui;}
	
.wrap { background:url(/Admin/AdminImg/bg.png) no-repeat top ; width:100%; height:100%; background-size:cover;}
.Login { padding-top:250px;}
.Login .login_con { background:#fff; border-radius:3px; padding:10px;width:360px; height:310px; margin:auto;padding:20px;}
.Login .login_con h1 { font-size:18px; color:#666;font-family:"微软雅黑",microsoft yahei ui; line-height:32px;margin-bottom:10px;}
.Login .login_con form span.btn  input.btn_btn{background:url(/Admin/AdminImg/login.png) no-repeat;width:361px; height:64px; cursor:pointer; border:0; }
.Login .login_con form span.btn  input.btn_btn:hover {background:url(/Admin/AdminImg/login_hover.png) no-repeat; width:361px; height:64px;}	
.Login .login_con .con .xian {background:url(/Admin/AdminImg/xian.png) no-repeat bottom; line-height:44px;}
.Login .login_con .con li {padding:6px 0; color:#666; }
.Login .login_con .con input.kuang { border:none; padding-left:4px; width:330px; outline:none;height:35px;}
.Login .login_con .con input.kuang1 { border:none; padding-left:4px; outline:none;height:35px;width:215px;}
.yzm { }
.Login .login_con form p.forget { margin-left:4px; }
.Login .login_con form p.forget b a,.Login .login_con form p.forget b lable {font-family:"微软雅黑",microsoft yahei ui; color:#306cb6;line-height:18px;}
.Login .login_con form p.forget b.left_l input { margin-right:4px;}
 .code {
            font-family: Arial;
            font-style: italic;
            color: Red;
            border: 0;
            padding: 2px 3px;
            letter-spacing: 3px;
            font-weight: bolder;
            font-size:20px;text-align:center;
        }
    </style>
</head>
<body style="background:#fff;">
    <div class="wrap"> 
		<div class="Login">
			<div class="login_con">
				<h1>门户系统欢迎您！</h1>
				<div class="form">
                    <form method="get" action="" runat="server">
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        <asp:HiddenField ID="HiddenField2" runat="server" />
                        <ul class="con">
                            <li class="xian"><span class="icon">
                                <img src="/Admin/AdminImg/people.png" /></span><input id="txt_loginName" type="text" class="kuang" value="" placeholder="请输入用户名" /></li>
                            <li class="xian"><span class="icon">
                                <img src="/Admin/AdminImg/password.png" /></span><input id="txt_passWord" type="password" class="kuang" value="" placeholder="请输入密码" /></li>
                            <li class="yzm xian"><span class="icon">
                                <img src="/Admin/AdminImg/yzm.png" /></span><input id="inpCode" type="text" class="kuang1" placeholder="请输入验证码" />
                                <span class="yzmtu">
                                    <input type="text" id="checkCode" class="code" style="width: 80px" /></span><a href="#" onclick="createCode()">刷新</a></li>
                            <li >
                                <span class="btn">
                                    <input id="BtnLogin" type="button" class="btn_btn"  onclick="Login()" />
                                </span>
                            </li>
                        </ul>
                        <div class="clear"></div>
                    </form>
                </div>
			</div>
		</div>
	</div>
   
    <script type="text/javascript">

        $(document).ready(function () {
            //加载验证码
            createCode();
            //回车提交事件
            $("body").keydown(function () {
                if (event.keyCode == "13") {//keyCode=13是回车键
                    $("#BtnLogin").click();
                }
            });
        });

        var code; //在全局 定义验证码
        function createCode() {
            code = "";
            var codeLength = 4;//验证码的长度
            var checkCode = document.getElementById("checkCode");
            checkCode.value = "";
            var selectChar = new Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');

            for (var i = 0; i < codeLength; i++) {
                var charIndex = Math.floor(Math.random() * 60);
                code += selectChar[charIndex];
            }
            if (code.length != codeLength) {
                createCode();
            }
            checkCode.value = code;
            //$("#inpCode").val(code);
        }

        function Login() {
            var inputCode = document.getElementById("inpCode").value.toUpperCase();
            var codeToUp = code.toUpperCase();

            if (inputCode.length <= 0) {
                layer.msg("请输入验证码！");
                return false;
            }
            else if (inputCode != codeToUp) {
                layer.msg("验证码输入错误！");
                createCode();
                $("#inpCode").val('').focus();
                return false;
            }
            else {
                var loginName = $("#txt_loginName").val();
                var passWord = $("#txt_passWord").val();
                $.ajax({
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "/DYYX/UserManagerHandler.ashx", "func": "Login", "LoginName": loginName, "LoginPassword": passWord },
                    success: OnSuccessLogin,
                    error: OnErrorLogin

                });
            }
        }

        function OnSuccessLogin(json) {
            var cookie = json.result;
            if (cookie.errNum == "0") {
                $.cookie('LoginCookie_Cube', JSON.stringify(cookie.retData[0]), { path: '/', secure: false });
                parent.window.location = "/Admin/index.aspx";
                //parent.CloseIFrameWindow();
            } else {
                layer.msg("登录名或密码错误！");
            }
        }
        function OnErrorLogin(XMLHttpRequest, textStatus, errorThrown) {
            layer.msg("登录名或密码错误！" + errorThrown);
        }
    </script>
</body>
</html>

