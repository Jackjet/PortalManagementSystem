<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeVote.aspx.cs" Inherits="PMSWeb.ZZMH.SitePages.BeforeVote" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <meta name="keywords" content="北京市门头沟区中等职业学校,门头沟中职,城子职高,职成教集团,门职,门头沟职业教育" /> 
    <title>延庆区第一中学</title>
    <link href="/ZZMH/css/reset.css" rel="stylesheet" />
    <link href="/ZZMH/css/layout.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/ZZMH/js/common.js"></script>
  
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <style>
        .test_area{width:100%;padding:0px 10px;}
        .test_area .test_type{color:#333;font-size:16px;font-weight:normal;line-height:35px;}
        .test_detail ul li{padding:12px;position:relative;}
        .test_detail ul li input{width:15px;height:15px;color:#333;}
        .test_detail ul li label{font-size:14px;color:#666;}
        .test_area .button{width:120px;border:none;height:30px;color:#fff;background:#006e0a;border-radius:2px;font-size:0.875rem;margin:10px auto;display:block;cursor:pointer;}
    </style>
    <script type="text/x-jquery-tmpl" id="item_answer">
        <li>
            <input type="radio" name="answer" value="${Id}" vid="${VoteId}" />
            <label for="">${Title}</label>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
         <div id="Header" style="min-height: 282px;"></div>
        <div class="clear"></div>
        <div class="center"  style="min-height:500px;">
            <div class="centercontent">
                <div class="center_con main">
                    <div class="test_area">
		                <h1 class="test_type"></h1>
		                <div class="test_detail">
			                <ul class="radios" id="list_answer"> 
				                
			                </ul>
		                </div>
		                <input  type="button" class="button" value="提交"/>
	                </div>
                </div>
            </div>
        </div>
        <!--footer-->
        <iframe name="htmlFoot" src="/ZZMH/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="92px" id="htmlFoot"></iframe>
        <div id="top"></div>
    </div>
    </form>
    <script type="text/javascript">
        $(function () {
            $('#Header').load('/ZZMH/Header.aspx')
            initVote();
            $(".button").on("click", function () {
                var val = $('input:radio[name="answer"]:checked').val();
                if (val == null || val=="") {
                    alert("请选择一个结果后提交！");
                    return false;
                }
                var answerId = $("input[name='answer']:checked").val();
                var vid=$("input[name='answer']:checked").attr("vid");
                inserVote(answerId,vid);
            });
        })

        function initVote() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: "GetVoteList",
                    isPush: 1,
                    IsDelete: 0,
                    isPage:false
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            $(".test_type").html(items[0].Title);
                            answer(items[0].Id);
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function answer(id) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: "GetVoteDetailList",
                    VoteId: id
                    
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            $("#item_answer").tmpl(items).appendTo("#list_answer");
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function inserVote(id, vid) {
            if ($.cookie('vote_zzmh' + vid) != null && $.cookie('vote_zzmh' + vid) != "null" && $.cookie('vote_zzmh' + vid) != "") {
                layer.msg("每日只能投票一次！");
                return false;
            }
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: "EditVoteRecord",
                    isPush: 1,
                    detailId: id
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $.cookie('vote_zzmh' + vid, "yes", { path: '/', secure: false, expires: 1 });
                        layer.msg("投票成功！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

    </script>
</body>
</html>
