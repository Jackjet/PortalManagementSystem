<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchContent.aspx.cs" Inherits="PMSWeb.YQYZ.SitePages.SearchContent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title>延庆区第一中学</title>
    <link href="/YQYZ/css/reset.css" rel="stylesheet" />
    <link href="/YQYZ/css/layout2.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/YQYZ/js/common.js"></script>
    <script src="/YQYZ/js/layout.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <style>
        .search_lists li {
            padding: 10px 0px;
            border-bottom:1px dashed #ccc;
        }
        .search_lists li a {color:#008412;line-height:25px;font-size:18px;}
        .search_lists li .detail{line-height:20px;color:#333;font-size:15px;text-indent:2em;margin:5px 0px;max-height:120px;overflow:hidden;}
    </style>
    <script type="text/x-jquery-tmpl" id="keyword">
        <li>
            <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">{{html Description}}</a>
            <div class="detail">
                <a href="/YQYZ/SitePages/BeforeView.aspx?id=${MenuId}&advId=${Id}">{{html CreativeHTML}}</a>
            </div>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <input id="Hkey" runat="server" type="hidden" />
    <div>
         <div id="header_top" style="position:fixed;top:0;z-index:999;width:100%;"></div>
        <iframe name="htmlHeader" src="/YQYZ/Header.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="326px" style="margin-top:98px;"></iframe>
        <div class="clear"></div>
        <div class="center"  style="min-height:500px;"  id="centerwrap">
            <div class="centercontent">
                <div class="center_con main">
                    <ul class="search_lists" id="bindData">
                        
                    </ul>
                    <div class="pagination">
                        <span id="pageBar"></span>
                    </div>
                </div>
            </div>
        </div>
        
        <!--footer-->
        <iframe name="htmlFoot" src="/YQYZ/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="92px" id="htmlFoot"></iframe>
        <div id="top"></div>
    </div>
    </form>
    <script type="text/javascript">
        var params = "";
        $(function () {
            $('#header_top').load('/YQYZ/top.aspx')
            var key = $("#Hkey").val();
            params = validInput(key);//getQueryString("key");
            query();
        })
        function validInput(s) {
            var pattern = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");
            var rs = "";
            for (var i = 0; i < s.length; i++) {
                rs = rs + s.substr(i, 1).replace(pattern, '');
            }
            return rs;
        }
        function keyQuery(startIndex,startNum) {
            pageNum = (startIndex - 1) * startNum + 1;
            $.ajax({
                url: "/Handler/CommonInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageIndex: startIndex,
                    PageSize: startNum,
                    Pageing: true,
                    Func: "NoticesForKeyWord",
                    SearchKey: params
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#bindData").html('');
                        var items = json.result.retData.PagedData;
                        if (items != null && items.length > 0) {
                            //$(items).each(function (index, ele) {
                            //    $("#bindData").append("<li><a href=\"\">" + delSHtmlTag(ele.Description) + "</a><div class=\"detail\">" + delSHtmlTag(ele.CreativeHTML) + "</div></li>");
                            //});
                            for (var i = 0; i < items.length; i++) {
                                items[i].Description = delSHtmlTag(items[i].Description);
                                items[i].CreativeHTML = delSHtmlTag(items[i].CreativeHTML);
                            }
                            $("#keyword").tmpl(items).appendTo("#bindData");
                        }
                        makePageBar(keyQuery, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, startNum, json.result.retData.RowCount);
                    }
                    else {
                        $("#bindData").html("<tr><td colspan='9'>暂无数据！</td></tr>");
                    }
                },
                error: OnError
            });
        }

        function query() {
            keyQuery(1, 30);
        }

        function delSHtmlTag(strp) {
            if (strp == null && strp == "") return "";
            strp = $.trim(strp);
            str = strp.replace(/<[^>]*>/g, " ");//去掉所有的html标记
            var star = replaceCode(str,"<");
            star = replaceCode(star, ">");
            star = replacesAll(star);
            return replaceeAll(star);
        }

        function replacesAll(str){    
            return str.replace(/ABCDEFG/g, "<font style=\"font-style:normal;color:#cc0000;\"><b>");
        }

        function replaceeAll(str){    
            return str.replace(/GFEDCBA/g, "</b></font>");
        }

        function replaceCode(str,code) {
            if (str.indexOf(code) > -1) {
                str = str.replace(code, "");
                return replaceCode(str);
            } else {
                return str;
            }
        }
        
    </script>

</body>
</html>
