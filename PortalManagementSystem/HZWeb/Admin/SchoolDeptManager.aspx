<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SchoolDeptManager.aspx.cs" Inherits="PMSWeb.Admin.SchoolDeptManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <link href="/Admin/AdminCss/reset.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>

    <link rel="stylesheet" href="/Scripts/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">

    <script src="/Scripts/zTree/js/jquery.ztree.core-3.5.min.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/HZNW/js/common.js"></script>
    <style>
        .menu_sup {
            width: 20%;
            border: 1px solid #DCDCDC;
        }

            /*.menu_sup a {
                display: block;
                height: 35px;
                border-bottom: 1px solid #dcdcdc;
                line-height: 35px;
                font-size: 15px;
                color: #333;
                padding: 0px 15px;
            }

                .menu_sup a:hover, .menu_sup a.selected {
                    border-left: 2px solid #007cdb;
                    margin-left: -1px;
                }*/

        .menu_supcontent {
            width: 78%;
            border: 1px solid #dcdcdc;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <script type="text/javascript">
             var ptitle = getQueryString("ptitle");
             var title = getQueryString("title");
             document.write("<div class=\"crumbs\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                </script>
        <asp:HiddenField ID="hId" runat="server" />
        <div class="clearfix" style="padding: 20px;">
            
            <div class="fl menu_sup">
                <ul id="treeDemo" class="ztree"></ul>
                <%--<a data="/Admin/AfterList.aspx" target="iframbox_sup">科技之光</a>
            <a data="/Admin/AfterEdit.aspx" target="iframbox_sup">科技之光</a>--%>
            </div>
            <div class="fr menu_supcontent">
                <div class="iframe_wrap">
                    <iframe id="iframbox_sup" src="" width="100%" frameborder="0" height="100%" style="height: 825px;"></iframe>
                </div>
            </div>
            <script>
                $(function () {
                    //$('.menu_sup a').each(function () {
                    //    var href= $(this).attr('data');
                    //    if ($('#iframbox_sup').attr('src')==href) {
                    //        $(this).addClass('selected');
                    //    }
                    //})
                    $('.menu_sup a').on("click", function () {
                        //$('#iframbox_sup').attr('src', $(this).attr("data"));
                        //$(this).addClass('selected').siblings().removeClass("selected");
                    });
                })
            </script>
        </div>
    </form>
    <script type="text/javascript">
        var setting = {
            data: {
                key: {
                    title: "t"
                },
                simpleData: {
                    enable: true
                }
            },
            callback: {
                beforeClick: beforeClick,
                onClick: onClick
            }
        };

        function beforeClick(treeId, treeNode, clickFlag) {
            return (treeNode.click != false);
        }
        function onClick(event, treeId, treeNode, clickFlag) {
            getTreeData(treeNode.name, treeNode.path);
        }
        var zNodes = [];

        $(function () {
            initTree();
        })

        function initTree() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetPortalChildTreeDataForParentId",
                    "isPage": false,
                    "Id": $("#hId").val(),
                    "Display": 0,
                    "IsDelete": 0
                },
                success: function (json) {
                    var items = json.result.retData;
                    if (items != null && items.length > 0) {
                        for (var i = 0; i < items.length; i++) {
                            if (items[i].IsDelete == "0") {
                                if (items[i].Name.indexOf("首页") > -1) continue;
                                var obj = new Object();
                                obj.id = items[i].Id;
                                obj.name = items[i].Name;
                                obj.pId = items[i].PId;
                                obj.path = items[i].AfterUrl;
                                obj.target = "#";
                                zNodes.push(obj);
                            }
                        }
                        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                    }
                },
                error: OnError
            });
        }

        function getTreeData(name, url) {
            $('#iframbox_sup').attr('src', url + "&ptitle=" + ptitle + "&title=" + title + ">" + name);
        }
    </script>
</body>
</html>
