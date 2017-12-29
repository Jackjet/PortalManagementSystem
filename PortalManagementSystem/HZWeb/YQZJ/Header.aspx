<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Header.aspx.cs" Inherits="PMSWeb.YQZJ.Header" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
	<title>延庆县职业技术教育中心</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
<%--    <link rel="stylesheet" href="/YQZJ/css/reset.css" />
	<link rel="stylesheet" href="/YQZJ/css/layout.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>--%>
    <script type="text/x-jquery-tmpl" id="menu">
        <li>
		    <dl class="xiala">
		        <dt>
		            <a Selfid="${Id}" href="${BeforeUrl}">${Name}</a>
		        </dt>
		        <dd>
		            <div class="lie" style="display: none;">
		                <ul class="liea" id="sub_menu_${Id}">
		                                    
		                </ul>
		            </div>
		        </dd>
		    </dl>
		</li>
    </script>
    <script type="text/x-jquery-tmpl" id="menu_sup">
        <li><a SelfID="${Id}" href="${BeforeUrl}">${Name}</a></li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div class="top">
			<!--头部上面的logo-->
			<div class="logo main">
				<a href="javascript:;" onclick="ResponstUrl('/YQZJIndex.aspx')"><img src="/YQZJ/images/logo.png" /></a>
			</div>
			<!--头部导航-->	
		    <div class="nav">
				<div class="nav_a main">
    				<ul class="nav_b" id="menuList">
		                
    				</ul>
				</div>
			</div>
		</div>
		<script>
		    $(function () {
		        initMenu();
		    })
		    function initMenu() {
		        $.ajax({
		            type: "Post",
		            url: "/Common.ashx",
		            async: false,
		            dataType: "json",
		            data: {
		                "PageName": "DYYX/AdvertisingHandler.ashx",
		                "func": "GetMenuOwnLevel",
		                "IsDelete": 0,              
		                "isPush": 1,              
		                "MenuLevelIndex": 1

		            },
		            success: function (json) {
		                if (json.result.errMsg == "success") {
		                    //debugger;
		                    var menulists = json.result.retData;
		                   console.log(JSON.stringify(menulists));
		                    if (menulists!=null && menulists.length>0) {
		                        $('#menu').tmpl(menulists).appendTo('#menuList');
		                        for (var i = 0; i < menulists.length;i++){
		                            var childlists = menulists[i].ChildList;
		                            if (childlists != null && childlists.length > 0 && menulists[i].Name == '科研工作') {
		                                $('#menu_sup').tmpl(childlists).appendTo('#sub_menu_' + menulists[i].Id);
		                                //return false;
		                            }
		                        }
		                    } else {
		                        $('#menu').html('<li>暂无数据</li>');
		                    }
		                    var _id = getQueryString('selectPid');
		                    if (_id != null) {

		                        $('#menuList a').each(function () {
		                            var id = $(this).attr('Selfid');

		                            if (id == _id) {
		                                console.log(_id)
		                                $(this).parents('li').addClass('hover');
		                            }

		                        })
		                    }


		                    $('.xiala').hover(function () {
		                        $(this).find('dt').addClass('hover');
		                        $(this).find(".lie").show();
		                    }, function () {
		                        $(this).find('dt').removeClass('hover');
		                        $(this).find(".lie").hide();
		                    });
		                    var length = $('#menuList>li').length;
                            var width = 100 / length +'%';
                            $('#menuList>li').width(width)
		                } else {
		                    $('#menu').html('<li>暂无数据</li>');
		                }
		            },
		            error: OnError
		        });

		    }
		    function ResponstUrl(url) {
		        window.parent.window.location.href = url;
		    }
		</script>
    </div>
    </form>
</body>
</html>
