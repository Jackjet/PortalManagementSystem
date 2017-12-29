<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PreschoolIndex.aspx.cs" Inherits="PMSWeb.PreschoolIndex" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="财贸幼儿园始建于1976年，隶属于昌平区教委，是一所全日制公立幼儿园。2010年被评为北京市一级一类幼儿园和区级示范性幼儿园，幼儿园现设7个日托班，在园幼儿210名。全园教职工50人，其中专任带班教师28人，全部具有大专以上学历。园内设园长办公室、党支部、工会、园务会、业务室、保健室等13个科室和群团组织。" />
    <meta name="Keywords" content="财贸,幼儿园,财贸幼儿园,昌平区财贸幼儿园,北京市昌平区财贸幼儿园,昌平财贸幼儿园" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" />
    <title>北京市昌平区财贸幼儿园</title>
    <link rel="stylesheet" href="/PreSchool/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/PreSchool/css/style.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/PreSchool/SitePages/TwoLevelCommon.js"></script>
    <!--[if lt IE 9]><script src="/PreSchool/js/html5shiv.min.js"></script><![endif]-->
    <!--[if lte IE 8]><script src="/PreSchool/js/selectivizr-min.js"></script><![endif]-->
    <script src="/PreSchool/js/jquery.SuperSlide.2.1.1.js"></script>
    <script src="/PreSchool/js/common.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <!--通知公告-->
    <script id="item_data" type="text/x-jquery-tmpl">
        <li><a href="/PreSchool/SitePages/NoticeView.aspx?id=${MenuId}&advId=${Id}&bgname=index_bg" target="_blank" title="${Title}">${Title}</a></li>
    </script>
    <!--园长寄语-->
    <script id="li_40" type="text/x-jquery-tmpl">
        <div class="kindergarten fl">
            <img src="${ImageUrl.split(',')[0]}" onerror="javascript:this.src='/PreSchool/images/deans.jpg'" />
        </div>
        <div class="kindergarten_dean">
            <h2 id="garten_nmae">${Description}</h2>
            <p>
                <span id="garten_jiyu">${NameLengthUpdate(CreativeHTML.replace(/<[^>]+>/g,''),100)}</span>
                <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=index_bg" id="seedetail">[查看详细]</a>
            </p>
        </div>
    </script>
    <!--园所介绍-->
    <script id="li_15" type="text/x-jquery-tmpl">
        <h1 class="title">园所介绍
			<a class="more fr" href="/preschool/SitePages/BeforeView.aspx?id=15&bgname=index_bg">更多</a>
        </h1>
        <div class="content">
            <div class="introduce_img fl">
                <img src="${ImageUrl.split(',')[0]}" onerror="javascript:this.src='/PreSchool/images/in.jpg'" />
            </div>
            <div class="introduce_detail fr" id="introduce_con">${NameLengthUpdate(CreativeHTML.replace(/<[^>]+>/g,''),185)}</div>
        </div>
    </script>
    <!-- 新闻动态--图片滚动-->
    <script id="li_img_16" type="text/x-jquery-tmpl">
        <li>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=index_bg" target="_blank">
                <img src="${ImageUrl.split(',')[0]}" alt="" /><p class="detail">${Description}</p>
            </a>
        </li>
    </script>
    <!-- 新闻动态list-->
    <script id="li_16" type="text/x-jquery-tmpl">
        <li>
            <i></i>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=index_bg" target="_blank" title="${Description}">${Description}</a>
            <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>
        </li>
    </script>
    <!--精彩瞬间 滚动图list-->
    <script id="li_108" type="text/x-jquery-tmpl">
        <li>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=index_bg" target="_blank">
                <div class="img">
                    <img src="${ImageUrl.split(',')[0]}" alt="" />
                </div>
                <p>${Description}</p>
            </a>
        </li>
    </script>
    <!-- 空中课程-->
    <script id="li_45" type="text/x-jquery-tmpl">
        <li>
            <a style="cursor: pointer" tag="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=index_bg&loadid=45" target="_blank">
                <div class="img">
                    <img src="${getImageUrl(FilePath)}" alt="" />
                </div>
                <p>${Description}</p>
            </a>
        </li>
    </script>
    <!-- 友情链接-->
    <script type="text/x-jquery-tmpl" id="li_1">
        <li>
            <a href="${Href}" target="_blank">
                <img src="${ImageUrl}" alt="" /></a>
        </li>
    </script>
    <!-- 温馨提示-->
    <script id="li_44" type="text/x-jquery-tmpl">
        <li>
            <i></i>
            <a href="/PreSchool/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}&bgname=index_bg" target="_blank" title="${Description}">${Description}</a>
            <%--   <span>${DateTimeConvert(CreateTime,'MM-dd')}</span>--%>
        </li>
    </script>
    <script>
        $(function () {
            $('#nav').load('/PreSchool/nav.html');
            $('#footer').load('/PreSchool/footer.html');
            $('#survey_wrap').load('/PreSchool/Survey.html');
        });
    </script>
</head>
<body id="index_bg">
    <div id="index_bgwrap">
        <header id="header">
            <div class="motto_logo clearfix center">
                <a class="logo fl" href="/PreschoolIndex.aspx">
                    <img src="/PreSchool/images/logo.png" />
                </a>
            </div>
            <nav id="nav"></nav>
        </header>
        <div id="content" class="center">
            <div class="notice_wrap clearfix">
                <span class="fl label">通知公告
                </span>
                <div class="notice">
                    <ul id="list_data"></ul>
                </div>
            </div>
            <div class="module clearfix">
                <div class="dean fl">
                    <h1 class="title">园长寄语</h1>
                    <div id="ul_40" psize="1" class="content clearfix TwoLevelC"></div>
                </div>
                <div id="ul_15" psize="1" class="garden_introduce fr TwoLevelC"></div>
            </div>
            <div class="module mt25 clearfix">
                <div class="module_left fl">
                    <div class="newswrap clearfix">
                        <div class="news_banner fl">
                            <div class="slides">
                                <ul id="ul_img_16" psize="3" imgstr="yes" class="slide TwoLevelC">
                                    <li><img src="/PreSchool/images/banner.jpg" alt=""></li>
                                </ul>
                                <div class="num">
                                    <ul></ul>
                                </div>
                            </div>
                        </div>
                        <div class="news_lists fr">
                            <h1 class="title">
                                <span class="fl">新闻动态</span>
                                <a href="/PreSchool/SitePages/BeforeItemList.aspx?id=16&bgname=index_bg" class="fr" target="_blank">更多</a>
                            </h1>
                            <div class="content">
                                <ul id="ul_16" psize="8" class="lists TwoLevelC"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="lists_img">
                        <div class="lists_img_wrap">
                            <div class="lists_img_inner">
                                <h2 class="title1">
                                    <span>空中课堂</span>
                                    <a href="/PreSchool/SitePages/BeforeList.aspx?id=45&bgname=index_bg" target="_blank">更多</a>
                                </h2>
                                <div class="slider" id="scroll_45">
                                    <ul id="ul_45" class="clearfix scroll"></ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="module_right fr">
                    <div class="login fr">
                        <div class="login_inner">
                            <h2>用户登录</h2>
                            <form action="" id="form" class="successfail">
                                <div class="row clearfix">
                                    <label for="">登录名</label>
                                    <input type="text" class="text" placeholder="请输入用户名" id="txt_loginName" />
                                </div>
                                <div class="row clearfix">
                                    <label for="">密码</label>
                                    <input type="password" class="text" placeholder="请输入密码" id="txt_passWord" />
                                </div>

                                <div class="row clearfix">
                                    <label for="">验证码</label>
                                    <input type="text" class="text" placeholder="请输入验证码" id="inpCode" style="width:100px;float:left;margin-left:9px;" />
                                    <div class="yzmtu fl" style="margin-left:8px;">
                                        <span id="checkCode" class="code" onclick="createCode()"></span>
                                        <%--<a href="javascript:;" onclick="createCode()" class="fr" id="fresh">刷新</a>--%>
                                    </div>
                                </div>
                                <a href="javascript:;" class="loginbtn" id="BtnLogin" onclick="Login()">登录</a>
                            </form>
                            <div id="loginsuccess" class="loginsuccess" style="display: none;">
                                <img src="/PreSchool/images/photo.png" alt="" />
                                <div id="div_uname" class="a"></div>
                                <div class="b">
                                    <span id="span_rname"></span>
                                    <a style="cursor: pointer" id="login_out">退出登录</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <%--温馨提示--%>
                    <div class="tips">
                        <h2 class="title">
                            <img src="/PreSchool/images/tips_zi.png" /></h2>
                        <div class="content">
                            <ul id="ul_44" psize="4" class="tip_lists TwoLevelC"></ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="module jingcai clearfix">
                <div class="lists_img">
                    <div class="lists_img_wrap">
                        <div class="lists_img_inner">
                            <h2 class="title2">
                                <span>精彩瞬间</span>
                                <a href="/PreSchool/SitePages/BeforeList.aspx?id=108&bgname=index_bg" target="_blank">更多
									<img src="/PreSchool/images/mao.png" alt="" />
                                </a>
                            </h2>
                            <div class="slider" id="scroll_108">
                                <ul id="ul_108" psize="15" imgstr="yes" class="clearfix scroll TwoLevelC"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--友情链接-->
            <div class="clearfix link">
                <h2 class="title">友情链接</h2>
                <div class="content">
                    <div id="scroll_1" class="linksss">
                        <ul class="scroll TwoLevelC" psize="20" btype="link" id="ul_1"></ul>
                    </div>
                </div>
            </div>
        </div>
        <footer id="footer"></footer>
        <!--在线调查-->
        <div id="survey_wrap"></div>
    </div>
</body>
<script>
    $(function () {
        //判断当前是否已登录
        var LoginCookie_Cube = $.cookie('LoginCookie_Cube');
        if (LoginCookie_Cube != null && LoginCookie_Cube != "null" && LoginCookie_Cube != '' && LoginCookie_Cube != undefined) {
            $('.successfail').hide();
            $('.loginsuccess').show();
            var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
            if (UserInfo != null) {
                $("#div_uname").html(UserInfo.LoginName + "，欢迎回来");
                $("#span_rname").html(UserInfo.RoleName);
            }            
        }
        //退出
        $('#login_out').on('click', function () {
           
            window.location.reload();
            $('.successfail').show();
            $('.loginsuccess').hide();
            //清楚当前缓存的登陆信息
            $.cookie('LoginCookie_Cube', null, { path: '/', secure: false });
        });
        //登录
        createCode();
    })
    //登录
    var code; //在全局 定义验证码
    function createCode() {
        code = "";
        var codeLength = 4;//验证码的长度
        var checkCode = document.getElementById("checkCode");
        checkCode.innerHTML = "";
        var selectChar = new Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');

        for (var i = 0; i < codeLength; i++) {
            var charIndex = Math.floor(Math.random() * 60);
            code += selectChar[charIndex];
        }
        if (code.length != codeLength) {
            createCode();
        }
        checkCode.innerHTML = code;
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
            //$('.successfail').hide();
            //$('.loginsuccess').show();
            window.location.reload();
        } else {
            layer.msg("登录名或密码错误！");
        }
    }
    function OnErrorLogin(XMLHttpRequest, textStatus, errorThrown) {
        layer.msg("登录名或密码错误！" + errorThrown);
    }
    $('#loginout').click(function () {
        $.cookie('LoginCookie_Cube', null, { path: '/', secure: false });
        $('.successfail').show();
        $('.loginsuccess').hide();
    })

    function ImgIndex(path) {
        if (path == null || path == "") return "";
        var imgs = path.split(',');
        return imgs[0];
    }
    //var video, output;
    //var scale = 0.8;
    //var initialize = function () {
    //    output = document.getElementById("output");
    //    video = document.getElementById("video");
    //    video.addEventListener('loadeddata', captureImage);
    //};

    //var captureImage = function () {
    //    var canvas = document.createElement("canvas");
    //    canvas.width = video.videoWidth * scale;
    //    canvas.height = video.videoHeight * scale;
    //    canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);

    //    var img = document.createElement("img");
    //    img.src = canvas.toDataURL("image/png");
    //    output.appendChild(img);
    //};

    //initialize();  
</script>
</html>
