<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="PMSWeb.ZZMH._default" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
		<title>中职数字校园</title>
        <style>
            body
{ 	width: 100%;
	height: 100%;
	font-size:12px; 
	line-height:25px; 
	color:#333; 
	font-family:"微软雅黑";
	background-image:url(/ZZMH/images/jyjt.jpg);
	background-size:100%;
	background-repeat: no-repeat;
}
body,ul,ol,li,dd,dt,dl,p,h1,h2,h3,label,form,img
{
	display: block;
	margin: 0px;
	padding:0px;
	list-style: none;
	color:#333; 
	font-family:"微软雅黑";
}
a:link{ color:#333; text-decoration:none}
a:visited{ color:#006}
a:hover{ color:#600; text-decoration:none;}


.main{
	width: 1024px;
	height: auto;
	margin: 0px auto;
}
.title{
	color: #282828;
	font-size: 35px;
	font-weight: bold;
	width: 210px;
	margin: 100px auto 50px;
}
.content{
	margin: 0px auto;
	width: 1024px;
	/*position: relative;
	bottom: -370px;*/
}
.content li{
	width: 310px; 
	float: left;
	display: block;
	margin-right: 15px;
	padding: 10px;
	font-size: 14px;
}
.content li.ali{
	background: #f0be00;
	margin-top:20px;
	/*position: absolute;
	bottom: 0px;
	left: 0px;*/
}
.content li.bli{
	background: #029cec;
/*	position: absolute;
	bottom: 0px;
	left: 34%;*/
	margin-top:20px;
}
.content li.cli{
	background: #f97e55;
	/*position: absolute;
	bottom: 0px;
	left: 68%;*/
	margin-top:20px;
    margin-right:0px;
}
.content li h3{
	font-size: 18px;
	color: #fff;
    font-weight: normal;
    padding: 10px;
	text-align: center;
}
.content li div{
	text-indent: 2em;
	text-align: left;
}
.content li div.jy{
	text-align: right; 
}
.content li div.fgx{
	height: 2px;
    padding:10px;
}
.content li div.fgx img{
	width: 100%;
}
.content li div.jianjie{
	color: #fff;
}
.content li div.xq{
	color: #fff;
	font-size: 14px;
	text-align: center;
	margin-left: -10px;
}
.content li div.xq a{
	color: #fff;
	font-size: 14px;
}
.content li div.xq i{
	margin-right: 5px;
}
.rukou{
	clear: both;
	width: 204px;
	padding-top:50px;
	margin:0px auto;
}
.rukou a{
	width: 115px;
	height: 45px;
	line-height: 35px;
	text-align: center;
	border-radius: 8px; 
    padding:4px 12px;
    font-size:14px;
}
.rukou a.houtai{
	color: #0095f7;
	border: solid 1px #0095f7;
	background: rgba(0,0,0,0);
	margin-right: 20px;
}
.rukou a.qiye{
	color: #fff;
	background: #1da5ff;
	border: solid 1px #0090ee
}
        </style>
	</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div class="main">
            
            <div class="title">教育集团网站</div>
            <ul class="content">
                <li class="ali">
                    <h3>门头沟城子小学</h3>
                    <div>门头沟中等职业学校作为我区唯一的一所职业学校，既是全区教育的重要板块，也是全区职业教育的重要组成部分。</div>
                    <div class="jy">——校长寄语</div>
                     <div class="fgx">
                        <img src="/ZZMH/images/xhx.png">
                    </div>
                    <div class="jianjie">门头沟中等职业学校作为我区唯一的一所职业学校，既是全区教育的重要板块，也是全区职业教育的门头沟中等职业学校作为我区唯一的一所职业学校，既是全区教育的重要板块，也是全区职业教育的……</div>
                    <div class="xq" style="position:relative"><img src="/ZZMH/images/detail.png" alt="" style="left:120px;top:3px;position:absolute;"/><a href="">了解详情</a></div>
                </li>
                <li class="bli">
                    <h3>门头沟中等职业教育学校</h3>
                    <div>门头沟中等职业学校作为我区唯一的一所职业学校，既是全区教育的重要板块，也是全区职业教育的重要组成部分。</div>
                    <div class="jy">——校长寄语</div>
                    <div class="fgx">
                       <img src="/ZZMH/images/xhx.png">
                    </div>
                    <div class="jianjie">门头沟中等职业学校作为我区唯一的一所职业学校，既是全区教育的重要板块，也是全区职业教育的门头沟中等职业学校作为我区唯一的一所职业学校，既是全区教育的重要板块，也是全区职业教育的……</div>
                    <div class="xq" style="position:relative"><img src="/ZZMH/images/detail.png" alt="" style="left:120px;top:3px;position:absolute;" /><a href="/ZZMHIndex.aspx">了解详情</a></div>
                </li>
                <li class="cli">
                    <h3>门头沟学校</h3>
                    <div>门头沟中等职业学校作为我区唯一的一所职业学校，既是全区教育的重要板块，也是全区职业教育的重要组成部分。</div>
                    <div class="jy">——校长寄语</div>
                    <div class="fgx">
                        <img src="/ZZMH/images/xhx.png">
                    </div>
                    <div class="jianjie">门头沟中等职业学校作为我区唯一的一所职业学校，既是全区教育的重要板块，也是全区职业教育的门头沟中等职业学校作为我区唯一的一所职业学校，既是全区教育的重要板块，也是全区职业教育的……</div>
                    <div class="xq" style="position:relative"><img src="/ZZMH/images/detail.png" alt="" style="left:120px;top:3px;position:absolute;"/><a href="">了解详情</a></div>
                </li>
            </ul>
        </div>
    </div>
    </form>
</body>
</html>
