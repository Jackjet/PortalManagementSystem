<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DepartmentScrollList.aspx.cs" Inherits="PMSWeb.HZNW.Category.DepartmentScrollList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <title>北京市黄庄职业高中</title>
    <link rel="stylesheet" href="/HZNW/css/reset.css" />
    <link rel="stylesheet"  id="layout"/>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/HZNW/js/common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/HZNW/js/jquery.SuperSlide.2.1.1.js"></script>
    <style type="text/css">
        .game163 {
            position: relative;
            border: 1px solid #dcdddd;
            padding: 4px;
            overflow: hidden;
            width: 745px;
        }

            .game163 .bigImg {
                height: 350px;
                position: relative;
            }

                .game163 .bigImg li a {
                    vertical-align: middle;
                    width: 745px;
                    height: 450px;
                    overflow:hidden;
                    display:block;
                }
                .game163 .bigImg li a img{width:100%;}
                .game163 .bigImg h4 {
                    font-size: 14px;
                    font-weight: bold;
                    line-height: 33px;
                    height: 33px;
                    padding-right: 30px;
                    overflow: hidden;
                    text-align: left;
                }

            .game163 .smallScroll {
                height: 120px;
                margin-bottom: 6px;
            }

            .game163 .sPrev, .game163 .sNext {
                float: left;
                display: block;
                width: 14px;
                height: 47px;
                margin-top: 32px;
                text-indent: -9999px;
                background: url(/HZZS/images/sprites1008.png) no-repeat 0 -3046px;
            }

            .game163 .sNext {
                background-position: 0 -2698px;
            }

            .game163 .sPrev:hover {
                background-position: 0 -3133px;
            }

            .game163 .sNext:hover {
                background-position: 0 -2785px;
            }

            .game163 .smallImg {
                float: left;
                margin: 0 6px;
                display: inline;
                width: 705px;
                overflow: hidden;
            }

                .game163 .smallImg ul {
                    height: 123px;
                    width: 9999px;
                    overflow: hidden;
                }

                .game163 .smallImg li {
                    float: left;
                    padding: 0 4px 0 0;
                    width: 172px;
                    cursor: pointer;
                    display: inline;
                }

                .game163 .smallImg a {
                    border: 1px solid #dcdddd;
                    width: 173px;
                    height: 120px;
                    overflow:hidden;
                    display:block;
                }
                 .game163 .smallImg a img{width:100%;}
                .game163 .smallImg .on img {
                    border-color: #1e50a2;
                }

            .game163 .pageState {
                position: absolute;
                top: 450px;
                right: 5px;
                font-family: "Times New Roman", serif;
                letter-spacing: 1px;
            }

                .game163 .pageState span {
                    color: #f00;
                    font-size: 16px;
                }
    </style>
     <script>
         $(function () {
             var p = enumStr(getQueryString('id'));
             $('#header').load('/HZNW/Category/DepartmentHeader.aspx?typename=' + p);
             $('#footer').load('/HZNW/Category/DepartmentFooter.aspx?typename=' + p);
         })
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
         <div id="header"></div>
            <div class="clear"></div>
        <div class="wrap">
                <div class="centercontent">
                    <div class="center_con main">
                        <div class="maintopLeft" style="float: left;">
                              <div class="left_nav">
                                <h2 id="hTitle">科技之光</h2>
                                <div class="left_navcon">
                                    <ul class="con_wenzi" id="div_leftTree">
                                         <li class="visited"> <a href="" target="_self" >科技之光</a> </li>

                                    </ul>
                                </div>
                                <div class="footer"></div>
                            </div>
                        </div>
                        <div class="maintopRight">
                            <div class="entrance">
                                <div class="moretitle">
                                    <p>
                                        <span class="tit_left fl">
                                            <a class="tit" id="menuPNav">dsadsa</a>
                                            <a class="english"></a>
                                        </span>
                                    </p>
                                </div>
                                <div class="clear"></div>
                                <div class="content">
                                    <div class="game163" style="margin: 0 auto">
                                        <ul class="bigImg" id="ultop">
                                             <li>
                                                <a href="#"><img src="${ImageUrl}" /></a>
                                                <h4><a href="#">${NameLengthUpdate(Description,15)}</a></h4>
                                            </li>
                                        </ul>
                                        <div class="smallScroll">
                                            <a class="sPrev" href="javascript:void(0)">←</a>
                                            <div class="smallImg">
                                                <ul id="uldown">
                                                    <li>
                                                        <a>
                                                            <img src="${ImageUrl}" /></a>
                                                    </li>
                                                    
                                                </ul>
                                            </div>
                                            <a class="sNext" href="javascript:void(0)">→</a>
                                        </div>
                                        <div class="pageState"></div>
                                    </div> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
         <div id="footer"></div>
        <script>
               //(function initCss() {
               //    var p = enumStr(getQueryString('tagname'));
               //    var hrefstr = '/HZNW/css/depart_' + p + '.css';
               //    $('#layout').attr('href', hrefstr);
               //})();
            jQuery(".game163").slide({
                titCell: ".smallImg li",
                mainCell: ".bigImg",
                effect: "fold",
                defaultIndex: 1,
                autoPlay: true,
                delayTime: 200,
                startFun: function (i, p) {
                    //控制小图自动翻页
                    if (i == 0) { jQuery(".game163 .sPrev").click() } else if (i % 4 == 0) { jQuery(".game163 .sNext").click() }
                }
            });

            //小图左滚动切换
            jQuery(".game163 .smallScroll").slide({ defaultIndex: 1, mainCell: "ul", delayTime: 100, vis: 4, scroll: 4, effect: "left", autoPage: true, prevCell: ".sPrev", nextCell: ".sNext", pnLoop: false });
        </script>
    </div>
    </form>
</body>
</html>
