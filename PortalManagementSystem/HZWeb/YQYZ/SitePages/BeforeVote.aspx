<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeforeVote.aspx.cs" Inherits="PMSWeb.YQYZ.SitePages.BeforeVote" %>

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
    <script src="/Scripts/jquery.cookie.js"></script>
    <style>
        .test_area {
            width: 100%;
            padding: 0px 10px;
        }

            .test_area .test_type {
                color: #333;
                font-size: 16px;
                font-weight: normal;
                line-height: 35px;
            }

        .test_detail ul li {
            padding: 12px;
            position: relative;
        }

            .test_detail ul li input {
                width: 15px;
                height: 15px;
                color: #333;
            }

            .test_detail ul li label {
                font-size: 14px;
                color: #666;
            }

        .test_area .button {
            width: 120px;
            border: none;
            height: 30px;
            color: #fff;
            background: #006e0a;
            border-radius: 2px;
            font-size: 0.875rem;
            margin: 10px auto;
            display: block;
            cursor: pointer;
        }
    </style>
    <script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
        <li>{{if Id!="87"}}
            <a href="${BeforeUrl}" target="_self" class="">${Name}</a>
            {{else}}
            <a href="${BeforeUrl}" target="_self" class="visited">${Name}</a>
            {{/if}}
        </li>
        {{/if}}
    </script>
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
            <div id="header_top" style="position: fixed; top: 0; z-index: 999; width: 100%;"></div>
            <iframe name="htmlHeader" src="/YQYZ/Header.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="326px" style="margin-top: 98px;"></iframe>
            <div class="clear"></div>
            <div class="center" style="min-height: 500px;" id="centerwrap">
                <div class="centercontent">
                    <div class="center_con main">
                        <div class="maintopLeft" style="float: left;">
                            <div class="left_nav">
                                <h2 id="hTitle"></h2>
                                <div class="left_navcon">
                                    <ul class="con_wenzi" id="div_leftTree">
                                    </ul>
                                </div>
                                <div class="footer"></div>
                            </div>
                        </div>
                        <div class="maintopRight">
                            <div class="entrancemore">
                                <div class="moretitle clearfix">
                                    <p>
                                        <span class="tit_left fl">
                                            <img src="/YQYZ/images/icon01.png">
                                            <a class="tit"></a>
                                            <%--<a class="english"></a>--%>
                                        </span>
                                        <span class="tit_right" style="display: none">
                                            <a href="">更多</a>
                                        </span>
                                    </p>
                                </div>
                                <div class="content">
                                    <div class="test_area">
                                        <ul class="li_list" id="list_data">
                                        </ul>
                                        <h1 class="test_type"></h1>

                                        <div class="test_detail">
                                            <ul class="radios" id="list_answer">
                                            </ul>
                                        </div>
                                        <input id="sumbit" type="button" class="button" value="提交" style="display:none;"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--<div class="centercontent">
                <div class="center_con main">
                    
                </div>
            </div>--%>
            </div>
            <!--footer-->
            <iframe name="htmlFoot" src="/YQYZ/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="92px" id="htmlFoot"></iframe>
            <div id="top"></div>
        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            $('#header_top').load('/YQYZ/top.aspx');
            initVote();
            leftTree();
            $(".button").on("click", function () {
                var val = $('input:radio[name="answer"]:checked').val();
                if (val == null || val == "") {
                    alert("请选择一个结果后提交！");
                    return false;
                }
                var answerId = $("input[name='answer']:checked").val();
                var vid = $("input[name='answer']:checked").attr("vid");
                inserVote(answerId, vid);
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
                    isPage: false
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            $("#sumbit").show();
                            $(".test_type").html(items[0].Title);
                            answer(items[0].Id);
                        } else {
                            $(".test_type").html("暂无数据！");
                            
                        }
                    }
                    else
                    {
                        $("#list_data").html(" <li> 暂无数据！ </li>");
                        
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    
                    $("#list_data").html(" <li> 暂无数据！ </li>");
                    

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
            if ($.cookie('vote_yqyz' + vid) != null && $.cookie('vote_yqyz' + vid) != "null" && $.cookie('vote_yqyz' + vid) != "") {
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
                        $.cookie('vote_yqyz' + vid, "yes", { path: '/', secure: false, expires: 1 });
                        layer.msg("投票成功！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
        function leftTree() {

            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "DYYX/AdminManagerHandler.ashx",
                    Func: "GetPortalTreeDataForChildId",
                    MenuId: "87"
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#div_leftTree").html('');
                        var items = json.result.retData;
                        $("#tr_leftTree").tmpl(items).appendTo("#div_leftTree");
                        if (items != null) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].PId == "0") {
                                    $("#hTitle").html(items[i].Name);
                                }
                                if (items[i].Id == "87") {
                                    $(".tit").html(items[i].Name);
                                }
                            }
                        }
                    }
                    else {
                        $("#div_leftTree").html("暂无数据！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    </script>
</body>
</html>
