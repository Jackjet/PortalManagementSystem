<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DepartmentHeader.aspx.cs" Inherits="PMSWeb.HZNW.Category.DepartmentHeader" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <title>黄庄职业高中</title>
    <link href="/HZNW/css/reset.css" rel="stylesheet" type="text/css" />
    <link  rel="stylesheet" type="text/css" id="layout" />

    <script type="text/x-jquery-tmpl" id="item_menu">
        <li>
            <a href="${BeforeUrl}">${Name}</a>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField  ID="HTypeName" runat="server"/>
        <asp:HiddenField ID="HTypeId" runat="server" />
        <asp:HiddenField ID="HMId"  runat="server"/>
        
    <div>
        <div class="header_top main">
            <a onclick="ResponstUrl('/HZNWIndex.aspx')" class="logo_s fl">
                <img src="/HZNW/images/logo.png" alt="Alternate Text" /></a>
            <div class="department_name fl">
                <%if (HTypeName.Value == "JYXB")
                  { %>
                <img src="/HZNW/images/educatedepartment.png" alt="Alternate Text" />
                <%}
                  else if (HTypeName.Value == "YSXB")
                  {%>
                <img src="/HZNW/images/artdepartment.png" alt="Alternate Text" />
                <%    
                  }
                  else if (HTypeName.Value == "FWXB")
                  {%>
                <img src="/HZNW/images/serverdepartment.png" alt="Alternate Text" />
                <%}
                  else if (HTypeName.Value == "JSXB")
                  { %>
                <img src="/HZNW/images/skilldepartment.png" alt="Alternate Text" />
                <%} %>
            </div>
            <div class="school_motto fr">
                <img src="/HZNW/images/motto.png" alt="Alternate Text" />
            </div>
        </div>
        <nav class="nav">
            <ul class="main clearfix" id="ulMenus">
               
            </ul>
        </nav>
    </div>
    </form>
    <script type="text/javascript">
        $(function () {
           // initTree();
        })

        function initTree() {
            if ($("#HTypeId").val() != "" && $("#HTypeId").val() != "null") {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/AdminManagerHandler.ashx",
                        "func": "GetChildMenuForId",
                        "isPage": false,
                        "Id": $("#HTypeId").val(),
                        "Display": 0,
                        "IsDelete": 0
                    },
                    success: function (json) {
                        $("#ulMenus").html("");
                        if (json.result.errMsg == "success") {
                            var items = json.result.retData;
                            if (items != null && items.length > 0) {
                                $("#item_menu").tmpl(items).appendTo("#ulMenus");
                            } else {
                                $("#ulMenus").html("<li>暂无数据！<li>");
                            }
                        } else {
                            $("#ulMenus").html("<li>暂无数据！<li>");
                        }

                    },
                    error: OnError
                });
            } else if ($("#HMId").val() != "" && $("#HMId").val() != "null") {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/AdminManagerHandler.ashx",
                        "func": "GetLevelTreeForId",
                        "isPage": false,
                        "Id": $("#HMId").val(),
                        "Display": 0,
                        "IsDelete": 0
                    },
                    success: function (json) {
                        $("#ulMenus").html("");
                        if (json.result.errMsg == "success") {
                            var items = json.result.retData;
                            if (items != null && items.length > 0) {
                                $("#item_menu").tmpl(items).appendTo("#ulMenus");
                            } else {
                                $("#ulMenus").html("<li>暂无数据！<li>");
                            }
                        } else {
                            $("#ulMenus").html("<li>暂无数据！<li>");
                        }

                    },
                    error: OnError
                });
            }

        }

        function ResponstUrl(url) {
            window.parent.window.location.href = url;
        }
    </script>
</body>
</html>
