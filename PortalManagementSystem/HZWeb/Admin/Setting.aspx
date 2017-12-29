<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Setting.aspx.cs" Inherits="PMSWeb.Admin.Setting" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
     <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/reset.css" />
    <link href="/Scripts/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/zTree/js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="/Scripts/zTree/js/jquery.ztree.excheck-3.5.min.js"></script>

    <script type="text/x-jquery-tmpl" id="tree_data">
        <li onclick="javascript:filter(${Id},this)"><a>${RoleName}</a></li>
    </script>
    <style>
        .left_navcon h1 { background:#2789ba; color:#fff; font-size:16px; line-height:34px;padding-left:10px; font-weight:normal; margin-top:10px;}
.left_navcon h1 .btn { line-height:32px;padding-right:10px; font-weight:normal; }
.left_navcon h1 .btn a { border-radius:2px; border:1px solid #fff; padding:0 4px; color:#fff; font-size:12px;}
.left_navcon h3 {  font-size:14px; line-height:32px;padding-left:10px; padding-right:10px; font-weight:normal; color:#333; cursor:pointer;}
/*menu区域*/
.left_navcon li{ line-height:30px; color:#646464;background:#fff;border-bottom:1px solid #e9e9e9;transition:all 0.3s ease-in-out;cursor:pointer;}
.left_navcon li .menuclick1 { color:#fff;background:#68accf; font-size:14px; display:block; padding:0px 10px;}
.left_navcon li.selected{background:#2789ba;}
.left_navcon li.selected a{ color:#fff;}
.left_navcon li i{font-size:18px;padding-right:4px;}
/*子菜单*/
.left_navcon .menu .submenu1 li{ background:#fff;color:#3c434d;padding:0px 30px; line-height:30px; border-bottom:1px solid #ddd;}
.left_navcon .menu .submenu1 li:hover{background:#fff;transition:all 0.3s ease-in-out;cursor:pointer;}
.left_navcon .menu .submenu1 li:hover a{color:#333;}
.left_navcon .menu .submenu1 li.selected{background:#83bcd8;}
/*.left_navcon .menu .submenu1 li.selected a{color:#fff}*/
.left_navcon .menu .submenu1 li a{color:#3c434d;}
        .confirm_btn {
           width: 100px;
    height: 36px;
    color: #fff;
    line-height: 36px;
    text-align: center;
    border-radius: 2px;
    font-size: 18px;
    display: inline-block;
    cursor: pointer;
    background: #1783c7;
    margin: 0 auto;
        }
        .cancel_btn{
             width: 100px;
    height: 36px;
    color: #fff;
    line-height: 36px;
    text-align: center;
    border-radius: 2px;
    font-size: 18px;
    display: inline-block;
    cursor: pointer;
    background: #1783c7;
    margin: 0 auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="padding:10px;">
        <input type="hidden" id="roleId" />
        <div class="menubox1 left_navcon fl" style="min-height:390px;width:40%;">
            <!--头部-->
            <h1><span class="tit_name">角色管理</span><span class="fr btn"></span></h1>
            <!--菜单区域-->
            <div class="menu">
                <ul>
                    <li>
                        <a class="menuclick1" onclick="javascript:filter(-1)"><i>-</i>全部</a>
                        <div class="zTreeDemoBackground left">
                            <ul id="tree_Role" style="padding: 0px;" class="submenu1"></ul>
                        </div>
                    </li>

                </ul>
            </div>
            <!--end 菜单区域-->
        </div>

        <div class="right_dcon fr" style="width:56%;margin-top:10px;">
            <div class="Operation_area">
                <div class="right_add">
                    <ul id="treeMenu" class="ztree"></ul>
                </div>
            </div>
            <div style="margin-top:20px;">
                <%--  <a class=" confirm_btn" onclick="saveData()" id="btnCreate">确定</a>
                  <a  class=" cancel_btn" id="btnCancel" onclick="btnBack()" >返回</a>--%>
                <div class="course_form_select clearfix" style="text-align:center;">
                        <a class="course_btn confirm_btn" onclick="saveData()" id="btnCreate" style="display:inline-block;">确定</a>
                        <a href="javascript:window.history.go(-1);" class="course_btn confirm_btn" style="display:inline-block;">返回</a>
                    </div>
            </div>
            
        </div>
    </form>
     <script type="text/javascript">
         var zNodes = [];
         var trees = [];
         var setting = {
             check: {
                 enable: true
             },
             data: {
                 simpleData: {
                     enable: true
                 }
             }
         };
         $(function () {
             initRole();
         })

         function initRole() {
             $.ajax({
                 type: "Post",
                 url: "/Common.ashx",
                 async: false,
                 dataType: "json",
                 data: {
                     "PageName": "DYYX/RoleHandler.ashx",
                     "func": "GetPageList",
                     "isPage": false
                 },
                 success: function (json) {
                     var items = json.result.retData;
                     if (items != null && items.length > 0) {
                         $("#tree_data").tmpl(items).appendTo("#tree_Role");
                         initTree();
                     }
                 },
                 error: OnError
             });
         }



         function initTree() {
             $.ajax({
                 type: "Post",
                 url: "/Common.ashx",
                 async: false,
                 dataType: "json",
                 data: {
                     "PageName": "DYYX/AdminManagerHandler.ashx",
                     "func": "GetNavigationMenu",
                     "IsDelete": 0
                 },
                 success: function (json) {
                     if (json.result.errMsg == "success") {
                         var dtJson = $.parseJSON(json.result.retData);
                         var items = dtJson.data;
                         if (items != null) {
                             for (var i = 0; i < items.length; i++) {
                                 var node = new Object();
                                 node.id = items[i].Id;
                                 node.pId = items[i].PId;
                                 node.name = items[i].Name;
                                 trees.push(node);
                             }
                         }
                     }
                 },
                 error: OnError
             });
         }

         function initRoleOfMenu() {

             var zTrees = $.fn.zTree.getZTreeObj("treeMenu");
             if (zTrees != null) {
                 zTrees.checkAllNodes(false);
             }
             $.ajax({
                 type: "Post",
                 url: "/Common.ashx",
                 async: false,
                 dataType: "json",
                 data: {
                     "PageName": "DYYX/RoleHandler.ashx",
                     "func": "GetMenuIdsForRoleId",
                     "RoleId": $("#roleId").val()
                 },
                 success: function (json) {
                     if (json.result.retData == null) {
                         $.fn.zTree.init($("#treeMenu"), setting, trees);
                         return;
                     }
                     var items = json.result.retData.PagedData;
                     if (items != null && items.length > 0) {//待权限的对号
                         var newT = new Array();
                         //newT = trees.slice();
                         newT = deepCopy(trees);
                         for (var j = 0; j < newT.length; j++) {
                             var treeid = newT[j].id;
                             for (var i = 0; i < items.length; i++) {
                                 var mid = items[i].MenuId;
                                 if (mid == treeid) {
                                     newT[j].checked = true;
                                     break;
                                 }
                             }
                         }
                         $.fn.zTree.init($("#treeMenu"), setting, newT);
                     } else {

                     }
                 },
                 error: OnError
             });
         }

         var deepCopy = function (o) {
             if (o instanceof Array) {
                 var n = [];
                 for (var i = 0; i < o.length; ++i) {
                     n[i] = deepCopy(o[i]);
                 }
                 return n;

             } else if (o instanceof Object) {
                 var n = {}
                 for (var i in o) {
                     n[i] = deepCopy(o[i]);
                 }
                 return n;
             } else {
                 return o;
             }
         }

         function saveData() {
             var zTree = $.fn.zTree.getZTreeObj("treeMenu");
             var nodes = zTree.getCheckedNodes(true);
             var mids = [];
             for (var i = 0, l = nodes.length; i < l; i++) {
                 mids.push(nodes[i].id);
             }
             $.ajax({
                 type: "Post",
                 url: "/Common.ashx",
                 async: false,
                 dataType: "json",
                 data: {
                     "PageName": "DYYX/RoleHandler.ashx",
                     "func": "EditRoleMenu",
                     "RoleId": $("#roleId").val(),
                     "MenuIds": mids.toString()
                 },
                 success: function (json) {
                     if (json.result.errMsg == "success") {
                         layer.msg("修改成功！");
                     } else {

                     }
                 },
                 error: OnError
             });
         }

         function filter(rid, evet) {
             var e = evet || window.event;
             if (e != null) $(e).addClass("selected").siblings().removeClass("selected");
             if (rid == -1) {
                 $("#roleId").val("");
                 $("#tree_Role li").removeClass("selected");
                 $.fn.zTree.init($("#treeMenu"), setting, []);
             } else {
                 $("#roleId").val(rid);
                 initRoleOfMenu();
             }
         }

         function btnBack() {
             parent.layer.closeAll();
         }

     </script>
</body>
</html>
