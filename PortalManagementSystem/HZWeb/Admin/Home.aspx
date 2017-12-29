<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PMSWeb.Admin.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <link href="/Admin/AdminCss/reset.css" rel="stylesheet" />
    <style>
        .header_top{padding:20px;}
        .header_top div{width:33.3%;float:left;font-size:14px;}
        .main_content{border:1px solid #EBEBEB;padding:20px;}
        .main_content div{width:33.3%;float:left;}
        .title{font-size:16px;line-height:30px;}
        .main_content div p{line-height:20px;font-size:14px;}
        .article_content{margin-top:20px;}
        .article_content .article_left{width:37%;}
        .article_content .article_right{width:60%;margin-top:10px;border:1px solid #EBEBEB;padding:20px;}
        .article_right p{line-height:25px;color:#035DBC;font-size:14px;}
        .app_list {width:100%;}
        .app_list li{margin:10px;float:left;}
    </style>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="padding:20px;">
            <div class="header_top clearfix">
                <div>
                    本次登录IP:<asp:Label ID="CurrentIP" runat="server"></asp:Label>
                </div>
               <%-- <div>
                    上次登录IP:<asp:Label ID="PreIP" runat="server"></asp:Label>
                </div>--%>
                <div>
                    当前登录时间<asp:Label ID="PreDate" runat="server"></asp:Label>
                </div>
            </div>
            <div class="main_content clearfix">
                <h1 class="title">站点信息</h1>
                <div>
                    <p>站点名称：<asp:Label ID="siteName" runat="server" Text="SMSWeb"></asp:Label></p>
                    <p>安装目录：<asp:Label ID="installPath" runat="server"></asp:Label></p>
                    <p>服务器名称：<asp:Label ID="serviceName" runat="server"></asp:Label></p>
                    <p>操作系统：<asp:Label ID="SystemWindow" runat="server"></asp:Label></p>
                    
                </div>
                <div>
                    <p>公司名称：<asp:Label ID="companyName" runat="server" Text="北京圣邦天麒科技有限公司"></asp:Label></p>
                    <p>网站管理目录：<asp:Label runat="server" ID="webPath"></asp:Label></p>
                   <%-- <p>服务器IP：<asp:Label runat="server" ID="ServiceIP" value="192.168.1.122"></asp:Label></p>--%>
                    <p>IIS版本：<asp:Label runat="server" ID="IISConfig"></asp:Label></p>
                     <p>服务器端口：<asp:Label runat="server" ID="ServiceHost"></asp:Label></p>
                 <%--   <p>系统版本：<asp:Label runat="server" ID="SysVersion"></asp:Label></p>--%>
                </div>
                <div>
                    <p>网站域名：<asp:Label runat="server" ID="WebDNS"></asp:Label></p>
                    <p>附件上传目录：<asp:Label runat="server" ID="FileUploadPath"></asp:Label></p>
                    <p>NET框架版本：<asp:Label runat="server" ID="NetFramework"></asp:Label></p>
                   <p>目录物理路径：<asp:Label ID="SystemPath" runat="server"></asp:Label></p>
                  <%--  <p>系统内存：<asp:Label runat="server" ID="SystemMemory"></asp:Label></p>--%>
                </div>
            </div>
            <div class="article_content">
                <div class="article_left fl">
                    <ul class="app_list p10 clearfix" id="Menu">
                        <%if (SystemWeb == "DYYX")
                          { %>
                        <li>
                            <a href="/admin/NoticeManager.aspx?id=51&title=公告栏&ptitle=公告栏" class="bgblue">
                                <img src="/Admin/AdminImg/notice.png" />
                            </a>
                        </li>
                        <li>
                            <a href="/admin/TreeView.aspx?title=菜单管理&ptitle=系统参数配置" class="bgblue">
                                <img src="/Admin/AdminImg/menu.png" />
                            </a>
                        </li>
                        <li>
                            <a href="/admin/UserManager.aspx?title=用户管理&ptitle=权限管理" class="bgblue">
                                <img src="/Admin/AdminImg/users.png" />
                            </a>
                        </li>
                        <%}
                          else if (SystemWeb == "YQYZ")
                          { %>
                        <li>
                            <a href="/admin/AfterList.aspx?id=62&title=通知公告&ptitle=首页模块" class="bgblue">
                                <img src="/Admin/AdminImg/notice.png" />
                            </a>
                        </li>

                        <li>
                            <a href="/admin/TreeView.aspx?title=菜单管理&ptitle=系统管理" class="bgblue">
                                <img src="/Admin/AdminImg/menu.png" />
                            </a>
                        </li>
                        <li>
                            <a href="/admin/UserManager.aspx?title=用户管理&ptitle=权限管理" class="bgblue">
                                <img src="/Admin/AdminImg/users.png" />
                            </a>
                        </li>
                        <%} %>
                    </ul>
                </div>
                <div class="article_right fr">
                    <a href="#" target="_blank" style="display:none"><span id="userHelp">用户手册</span> </a>
                    <%--<h1 class="title">建站三步曲</h1>
                    <p>1.进入后台管理中心，点击"系统参数管理"修改网站配置信息；</p>
                    <p>2.点击"菜单管理"，建立系统菜单配置路径；</p>
                    <p>2.制作好网站模板，上传到站点Portal目录下，即可完成。</p>
                    <h1 class="title">官方消息</h1>--%>
                    <%if (SystemWeb == "YQYZ")
                      { %>
                    <a onclick="javascript:FolderClick('/YQYZ/延庆一中门户系统_用户手册.docx')" style="text-decoration:underline;font-size:15px;color:#0092CD; cursor:pointer;">网站用户手册下载</a>
                    <%} else if (SystemWeb == "DYYX"){ %>
                    <a onclick="javascript:FolderClick('/DYYX/大峪一小门户系统_用户手册.docx')" style="text-decoration:underline;font-size:15px;color:#0092CD; cursor:pointer;">网站用户手册下载</a>
                    <%} %>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            function FolderClick(FoldUrl) {
                var FileExt = getFileName(FoldUrl);
                if (FileExt == "ppt" || FileExt == "pptx" || FileExt == "doc" || FileExt == "docx" || FileExt == "xls" || FileExt == "xlsx") {
                    $.ajax({
                        url: "/Handler/WordOpenHTML.ashx",
                        type: "post",
                        async: false,
                        dataType: "text",
                        data: {
                            "Func": "Wopi_Proxy", filepath: FoldUrl
                        },
                        success: function (result) {
                            //window.open(result);
                            $("#userHelp").parent().attr("href", result);
                            $("#userHelp").trigger("click");
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            layer.msg("附件不存在！");
                        }
                    });
                }
            }

            function getFileName(o) {
                //通过第一种方式获取文件名
                var pos = o.lastIndexOf(".");
                //查找最后一个\的位置
                return o.substring(pos + 1);
            }
        </script>
    </form>
</body>
</html>
