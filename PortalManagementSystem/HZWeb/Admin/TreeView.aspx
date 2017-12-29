<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TreeView.aspx.cs" Inherits="PMSWeb.Admin.TreeView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>
    <link href="/Admin/AdminCss/reset.css" rel="stylesheet" />
    <link href="/Scripts/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <style type="text/css">
        .ztree li span.button.add {
            margin-left: 2px;
            margin-right: -1px;
            background-position: -144px 0;
            vertical-align: top;
            *vertical-align: middle;
        }
        .level2 span.button.add {
            display:none;
        }
    </style>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/zTree/js/jquery.ztree.core-3.5.js"></script>
    <script src="/Scripts/zTree/js/jquery.ztree.excheck-3.5.js"></script>
    <script src="/Scripts/zTree/js/jquery.ztree.exedit-3.5.js"></script>
    <script type="text/javascript">
        $(function(){
            $(window).resize(function () {
                initHeight();
            })
            initHeight();
            function initHeight() {
                $('.ztreea_left').height($('body').height())
            }
        })
        var zNodes = [];
        var setting = {
            view: {
                addHoverDom: addHoverDom,
                removeHoverDom: removeHoverDom,
                selectedMulti: false
            },
            edit: {
                enable: true,
                drag:{
                    autoExpandTrigger: true,
                    isCopy:true,
                    isMove: true,
                    prev: true,
                    next: true,
                    inner: true
                },
                editNameSelectAll: true,
                showRemoveBtn: showRemoveBtn,
                showRenameBtn: showRenameBtn
            },
            data: {
                keep: {
                    parent: true,
                    leaf: true
                },
                simpleData: {
                    enable: true
                }
            },
            callback: {
                beforeDrag: beforeDrag,
                beforeEditName: beforeEditName,
                beforeRemove: beforeRemove,
                beforeRename: beforeRename,
                onRemove: onRemove,
                onRename: onRename,
                beforeClick: beforeClick,
                onClick: onClick,
                onDrop: onDrop
            }

        };
        var log, className = "dark";
        function beforeDrag(treeId, treeNodes) {           
            return true;
        }
       

        function onDrop(event, treeId, treeNodes, targetNode, moveType, isCopy) {
           
            className = (className === "dark" ? "" : "dark");
            var pids = [];
            var Creator;
            var PId;
            var Id;
            var Display;
            var BeforeUrl;
            var BeforeAfter;
            var AfterUrl;
            var SortId;
            var EnName;
            var Name;
          
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetPortalTreeData",
                    "Id": treeNodes[0].id
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var item = json.result.retData;
                        if (item != null) {
                            Creator = item.Creator;

                            Id = item.Id;
                            Display = item.Display;
                            BeforeUrl = item.BeforeUrl;
                            BeforeAfter = item.BeforeAfter;
                            AfterUrl = item.AfterUrl;
                            SortId = item.SortId;
                            EnName = item.SortId;
                            Name = item.Name;
                        }
                    }
                },
                error: OnError
            });

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
                                if (items[i].PId == 0)
                                {
                                    pids[i] = items[i].Id;
                                }
                                                            
                            }                          
                        }
                    }
                },
                error: function (textStatus) {
                    layer.msg("获取导航出现问题了,请通知管理员!");
                }
            });

            var isPID;
            //判断是否是一级菜单
            for (var i = 0; i < pids.length; i++) {                
                if (treeNodes[0].id == pids[i]) {
                    isPID = true;
                }
                else {
                    isPID = false;
                }

            }


            if (targetNode.pId == "" || targetNode.pId == 0 ||targetNode.pId=="0"|| targetNode.pId == null||treeNodes[0].pId==""||!isPID)
            {
                alert("只能在子菜单中调动！");
                zNodes = [];
                BindNavigationMenu();
                $("input[type=reset]").trigger("click");
            }            
            else
            {
                
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/AdminManagerHandler.ashx",
                        "func": "EditPortalTreeData",
                        "Name": Name,
                        "Creator": Creator,
                        "PId": targetNode.pId,
                        "Id": Id,
                        "Display": Display,
                        "BeforeUrl": BeforeUrl,
                        "BeforeAfter": BeforeAfter,
                        "AfterUrl": AfterUrl,
                        "SortId": SortId,
                        "EnName": EnName,

                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            zNodes = [];
                            BindNavigationMenu();
                            $("input[type=reset]").trigger("click");
                        }
                    },
                    error: OnError
                });
            }
                

            }



            
        


        function beforeEditName(treeId, treeNode) {
            className = (className === "dark" ? "" : "dark");
            showLog("[ " + getTime() + " beforeEditName ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
            var zTree = $.fn.zTree.getZTreeObj("treeRerouce");
            zTree.selectNode(treeNode);
            return true;
            //return confirm("进入节点 -- " + treeNode.name + " 的编辑状态吗？");
        }
        function beforeRemove(treeId, treeNode) {
            className = (className === "dark" ? "" : "dark");
            showLog("[ " + getTime() + " beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
            var zTree = $.fn.zTree.getZTreeObj("treeRerouce");
            zTree.selectNode(treeNode);
            return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
        }
        function onRemove(e, treeId, treeNode) {
            ////删除//
            delData(treeNode.id, 1);
            /////
            showLog("[ " + getTime() + " onRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
        }
        function beforeRename(treeId, treeNode, newName, isCancel) {
            className = (className === "dark" ? "" : "dark");
            showLog((isCancel ? "<span style='color:red'>" : "") + "[ " + getTime() + " beforeRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>" : ""));
            if (newName.length == 0) {
                alert("节点名称不能为空.");
                var zTree = $.fn.zTree.getZTreeObj("treeRerouce");
                setTimeout(function () { zTree.editName(treeNode) }, 10);
                return false;
            }
            //新增代码//
            renTreeData(treeNode.id, newName);
            ////
            return true;
        }
        function onRename(e, treeId, treeNode, isCancel) {
            showLog((isCancel ? "<span style='color:red'>" : "") + "[ " + getTime() + " onRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>" : ""));
        }
        function showRemoveBtn(treeId, treeNode) {
            //return !treeNode.isFirstNode;
            return true;
        }
        function showRenameBtn(treeId, treeNode) {
            //return !treeNode.isLastNode;
            return true;
        }
        function showLog(str) {
            if (!log) log = $("#log");
            log.append("<li class='" + className + "'>" + str + "</li>");
            if (log.children("li").length > 8) {
                log.get(0).removeChild(log.children("li")[0]);
            }
        }
        function getTime() {
            var now = new Date(),
			h = now.getHours(),
			m = now.getMinutes(),
			s = now.getSeconds(),
			ms = now.getMilliseconds();
            return (h + ":" + m + ":" + s + " " + ms);
        }

        var newCount = 1;

        function add(e) {
            var zTree = $.fn.zTree.getZTreeObj("treeRerouce"),
			isParent = e.data.isParent,
			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];
            if (treeNode) {
                treeNode = zTree.addNodes(treeNode, { id: (100 + newCount), pId: treeNode.id, isParent: isParent, name: "new node" + (newCount++) });
            } else {
                treeNode = zTree.addNodes(null, { id: (100 + newCount), pId: 0, isParent: isParent, name: "new node" + (newCount++) });
            }
            if (treeNode) {
                zTree.editName(treeNode[0]);
                //新增节点/
                EditTree("new node" + newCount, "", 0);
                ////
            } else {
                alert("叶子节点被锁定，无法增加子节点");
            }
        };

        function addHoverDom(treeId, treeNode) {
            var sObj = $("#" + treeNode.tId + "_span");
            if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
            var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='add node' onfocus='this.blur();'></span>";
            sObj.after(addStr);
            var btn = $("#addBtn_" + treeNode.tId);
            if (btn) btn.bind("click", function () {
                var zTree = $.fn.zTree.getZTreeObj("treeRerouce");
                zTree.addNodes(treeNode, { id: (100 + newCount), pId: treeNode.id, name: "new node" + (newCount++) });
                ///添加到数据库中/
                EditTree("new node" + newCount, "", treeNode.id);
                ///
                return false;
            });
        };
        function removeHoverDom(treeId, treeNode) {
            $("#addBtn_" + treeNode.tId).unbind().remove();
        };
        function selectAll() {
            var zTree = $.fn.zTree.getZTreeObj("treeRerouce");
            zTree.setting.edit.editNameSelectAll = $("#selectAll").attr("checked");
        }

        function beforeClick(treeId, treeNode, clickFlag) {

        }
        function onClick(event, treeId, treeNode, clickFlag) {
            getTreeData(treeNode.id);
        }

        $(document).ready(function () {
            BindNavigationMenu();
            $("#addParent").bind("click", { isParent: true }, add);
        });

        function BindNavigationMenu() {
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
                                if (items[i].PId == 0) node.open = true;
                                zNodes.push(node);
                            }
                            BindTree();
                        }
                    }
                },
                error: function (textStatus) {
                    layer.msg("获取导航出现问题了,请通知管理员!");
                }
            });
        }

        function BindTree() {
            $.fn.zTree.init($("#treeRerouce"), setting, zNodes);
            $("#selectAll").bind("click", selectAll);
        }

        function EditTree(Name, id, pid) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "EditPortalTreeData",
                    "Name": Name,
                    "EnName": "",
                    "Display": 0,
                    "BeforeAfter": 1,
                    "Id": id,
                    "PId": pid,
                    "SortId": 0,
                    "Creator": $("#HUserName").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        zNodes = [];
                        BindNavigationMenu();
                        $("input[type=reset]").trigger("click");
                    }
                },
                error: OnError
            });
        }


        function getTreeData(id) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "GetPortalTreeData",
                    "Id": id
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var item = json.result.retData;
                        if (item != null) {
                            $("#Name").val(item.Name);
                            $('input[name=Display][value=' + item.Display + ']').prop('checked', true);
                            $('input[name=BeforeAfter][value=' + item.BeforeAfter + ']').prop('checked', true);

                            $("#BeforeUrl").val(item.BeforeUrl);
                            if (item.BeforeUrl != null && item.BeforeUrl != "") {
                                
                                if (item.BeforeUrl.toLocaleLowerCase().indexOf("departmentindex") > -1) $('input[name=listshow][value=4]').prop('checked', true);
                                else if (item.BeforeUrl.toLocaleLowerCase().indexOf("departmentbeforeitemlist") > -1) {
                                    if (item.BeforeUrl.toLocaleLowerCase().indexOf("p=all")>-1)
                                        $('input[name=listshow][value=9]').prop('checked', true);
                                    else
                                        $('input[name=listshow][value=5]').prop('checked', true);
                                }
                                else if (item.BeforeUrl.toLocaleLowerCase().indexOf("departmentbeforelist") > -1) $('input[name=listshow][value=6]').prop('checked', true);
                                else if (item.BeforeUrl.toLocaleLowerCase().indexOf("departmentbeforescrolllist") > -1) $('input[name=listshow][value=7]').prop('checked', true);
                                else if (item.BeforeUrl.toLocaleLowerCase().indexOf("departmentbeforeview") > -1) $('input[name=listshow][value=8]').prop('checked', true);

                                else if (item.BeforeUrl.toLocaleLowerCase().indexOf("beforeitemlist") > -1) $('input[name=listshow][value=0]').prop('checked', true);
                                else if (item.BeforeUrl.toLocaleLowerCase().indexOf("beforelist") > -1) $('input[name=listshow][value=1]').prop('checked', true);
                                else if (item.BeforeUrl.toLocaleLowerCase().indexOf("beforeitemlist") > -1 && item.AfterUrl.toLocaleLowerCase().indexOf("aftervideolist") > -1) $('input[name=listshow][value=2]').prop('checked', true);
                                else if (item.BeforeUrl.toLocaleLowerCase().indexOf("beforeview") > -1) $('input[name=listshow][value=3]').prop('checked', true);

                            }
                            $("#EnName").val(item.EnName);
                            $("#AfterUrl").val(item.AfterUrl);
                            $("#TreeId").val(item.Id);
                            $("#HPId").val(item.PId);
                            $("#SortId").val(item.SortId);
                        }
                    }
                },
                error: OnError
            });
        }

        function renTreeData(id, name) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "UpdatePortalTreeData",
                    "Name": name,
                    "Id": id
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        zNodes = [];
                        BindNavigationMenu();
                        $("input[type=reset]").trigger("click");
                    }
                },
                error: OnError
            });
        }

        function saveData() {
            if (!validate()) {
                return false;
            }
            //alert($("#TreeId").val());
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "EditPortalTreeData",
                    "Name": $("#Name").val(),
                    "EnName": $("#EnName").val(),
                    "Display": $("input[name='Display']:checked").val(),
                    "BeforeAfter": $("input[name='BeforeAfter']:checked").val(),
                    "BeforeUrl": $("#BeforeUrl").val(),
                    "AfterUrl": $("#AfterUrl").val(),
                    "Id": $("#TreeId").val(),
                    "PId": $("#HPId").val(),
                    "SortId": $("#SortId").val(),
                    "Creator": $("#HUserName").val(),
                   
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg('操作成功!');
                        zNodes = [];
                        BindNavigationMenu();
                        $("input[type=reset]").trigger("click");
                    }
                },
                error: OnError
            });
        }

        function delData(id, IsDelete) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "UpdatePortalTreeData",
                    "Id": id,
                    "IsDelete": IsDelete
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        zNodes = [];
                        BindNavigationMenu();
                        $("input[type=reset]").trigger("click");
                    }
                },
                error: OnError
            });
        }

        function validate() {
            if ($("#HPId").val() == "" || $("#HPId").val().length == 0) {
                layer.msg("请选择节点信息！");
                return false;
            }
            if ($("#Name").val() == "" || $("#Name").val().length == 0) {
                layer.msg("请填写节点信息！");
                return false;
            }
            return true;
        }

        function changeUrl(p) {
            if ($("#TreeId").val() != "") {
                var sys = "/" + '<%=System.Configuration.ConfigurationManager.AppSettings["SystemWeb"]%>'
                if (p == "font") {
                    if ($("#HPId").val() == "0")
                        $("#BeforeUrl").val(sys + "/SitePages/BeforeItemList.aspx?pid=0&id=" + $("#TreeId").val());
                    else
                        $("#BeforeUrl").val(sys + "/SitePages/BeforeItemList.aspx?id=" + $("#TreeId").val());
                    $("#AfterUrl").val("/Admin/AfterList.aspx?id=" + $("#TreeId").val());
                } else if (p == "img") {
                    $("#BeforeUrl").val(sys + "/SitePages/BeforeList.aspx?id=" + $("#TreeId").val());
                    $("#AfterUrl").val("/Admin/AfterList.aspx?id=" + $("#TreeId").val());
                } else if (p == "video") {
                    $("#BeforeUrl").val(sys + "/SitePages/BeforeItemList.aspx?id=" + $("#TreeId").val());
                    $("#AfterUrl").val("/Admin/AfterVideoList.aspx?id=" + $("#TreeId").val());
                } else if (p == "view") {
                    $("#BeforeUrl").val(sys + "/SitePages/BeforeView.aspx?id=" + $("#TreeId").val());
                    $("#AfterUrl").val("/Admin/AfterEdit.aspx?id=" + $("#TreeId").val());
                } else if (p == "deptschool") {
                    $("#BeforeUrl").val(sys + "/Category/DepartmentIndex.aspx?id=" + $("#TreeId").val());
                    $("#AfterUrl").val("/Admin/SchoolDeptManager.aspx?id=" + $("#TreeId").val());
                } else if (p == "deptfont") {
                    $("#BeforeUrl").val(sys + "/Category/DepartmentBeforeItemList.aspx?id=" + $("#TreeId").val());
                    $("#AfterUrl").val("/Admin/AfterList.aspx?id=" + $("#TreeId").val());
                } else if (p == "deptimg") {
                    $("#BeforeUrl").val(sys + "/Category/DepartmentBeforeList.aspx?id=" + $("#TreeId").val());
                    $("#AfterUrl").val("/Admin/AfterList.aspx?id=" + $("#TreeId").val());
                } else if (p == "deptscroll") {
                    $("#BeforeUrl").val(sys + "/Category/DepartmentBeforeScrollList.aspx?id=" + $("#TreeId").val());
                    $("#AfterUrl").val("/Admin/AfterList.aspx?id=" + $("#TreeId").val());
                } else if (p == "deptview") {
                    
                    var zTree = $.fn.zTree.getZTreeObj("treeRerouce");
                    var nodes = zTree.getSelectedNodes();
                    var issele = false;
                    for (var i = 0; i < nodes.length; i++) {
                        if (nodes[i].name == "专业设置") {
                            $("#BeforeUrl").val(sys + "/Category/DepartmentBeforeView.aspx?id=" + $("#TreeId").val()+"&p=setting");
                            issele = true;
                            break;
                        }
                    }
                    if (!issele) $("#BeforeUrl").val(sys + "/Category/DepartmentBeforeView.aspx?id=" + $("#TreeId").val());
                    $("#AfterUrl").val("/Admin/AfterEdit.aspx?id=" + $("#TreeId").val());
                } else if (p == "deptfontAll") {
                    $("#BeforeUrl").val(sys + "/Category/DepartmentBeforeItemList.aspx?id=" + $("#TreeId").val()+"&p=all");
                    $("#AfterUrl").val("");
                }
            }
        }

    </script>
    <style>
        .ztreea {
            padding:0px 20px 20px 20px;
        }

        .ztree {
            border: 1px solid #ccc;
            border-top: none;
        }

        .ztreea_left {
            width: 20%;
            float: left;
            overflow:auto;
        }

            .ztreea_left h1 {
                background: #37A8E0;
                color: #fff;
                font-size: 16px;
                line-height: 34px;
                padding-left: 10px;
                font-weight: normal;
            }

        .ztreea_right {
            width: 80%;
            box-sizing:border-box;
        }

        #addParent {
            width: 80px;
            height: 35px;
            background: #37A8E0;
            display: block;
            border-radius: 2px;
            text-align: center;
            color: #fff;
            font-size: 14px;
            line-height: 35px;
        }

        .course_form_div {
            margin: 10px 0px;
        }

            .course_form_div label {
                width: 75px;
                text-align: right;
                line-height: 30px;
                display: inline-block;
            }

            .course_form_div input[type=text] {
                width: 400px;
                height: 26px;
                border: none;
                border: 1px solid #ccc;
                border-radius: 2px;
                text-indent: 10px;
            }

            .course_form_div input[type=radio] {
                width: 15px;
                height: 15px;
                margin: 0px 10px;
            }

            .course_form_div .stars {
                color: red;
                margin-left: 10px;
            }

        .course_form_select {
            margin-left: 100px;
        }

            .course_form_select a {
                display: inline-block;
                width: 80px;
                height: 30px;
                background: #0488C9;
                border-radius: 2px;
                font-size: 14px;
                color: #fff;
                margin-top: 30px;
                cursor: pointer;
                text-align: center;
                line-height: 30px;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <input id="HPId" type="hidden" />
                <input id="TreeId" type="hidden" />
                <asp:HiddenField ID="HUserName" runat="server" />
                 <script type="text/javascript">
                    var ptitle = getQueryString("ptitle");
                    var title = getQueryString("title");
                    document.write("<div class=\"crumbs\" style=\"padding: 10px 20px;line-height:20px; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                </script>
                <div class="ztreea clearfix">
                    <div class="ztreea_left">
                        <h1>菜单管理</h1>
                        <div class="scroll-pane">
                            <ul id="treeRerouce" class="ztree"></ul>
                        </div>
                        
                    </div>
                    <div class="fr ztreea_right">
                        <div style="padding:20px;border:1px solid #ccc;margin-left:20px;">
                            <a id="addParent" href="javascript:;" title="增加父节点" onclick="return false;">增加父节点</a>
                            <div style="background: #fff; margin-top: 20px;">
                                <div class="newcourse_dialog_detail">
                                    <div class="course_form_div clearfix">
                                        <label for="">节点名称：</label>
                                        <input type="text" placeholder="节点名称" class="text" id="Name" value="" />
                                        <i class="stars">*</i>
                                    </div>
                                    <div class="course_form_div clearfix">
                                        <label for="">英文名称：</label>
                                        <input type="text" placeholder="英文名称" class="text" id="EnName" value="" />
                                        <i class="stars">*</i>
                                    </div>
                                    <div class="course_form_div clearfix">
                                        <label for="">是否显示：</label>
                                        <input type="radio" name="Display" value="0" checked  />是<input type="radio" name="Display" value="1" />否
                                        <i class="stars">*</i>
                                    </div>
                                    <div class="course_form_div clearfix">
                                        <label for="">展示位置：</label>
                                        <input type="radio" name="BeforeAfter" value="0" checked />前台<input type="radio" name="BeforeAfter" value="1" />后台<input type="radio" name="BeforeAfter" value="2" />全部
                                        <i class="stars">*</i>
                                    </div>
                                    <div class="course_form_div clearfix">
                                        <label for="">排序：</label>
                                        <input type="text" placeholder="排序" class="text" id="SortId" value="" />
                                        <i class="stars">*</i>
                                    </div>
                                    <div class="course_form_div clearfix">
                                        <label for="">展示方式：</label>
                                        <input type="radio" name="listshow" value="0" checked onclick="changeUrl('font')"/>普通文字列表
                                        <input type="radio" name="listshow" value="1" onclick="changeUrl('img')"/>普通图片列表
                                        <input type="radio" name="listshow" value="2" onclick="changeUrl('video')"/>普通视频列表
                                        <input type="radio" name="listshow" value="3" onclick="changeUrl('view')"/>普通单页详细

                                        <%--<input type="radio" name="listshow" value="4" onclick="changeUrl('deptschool')"/>学部首页
                                        <input type="radio" name="listshow" value="5" onclick="changeUrl('deptfont')"/>学部文字列表
                                        <input type="radio" name="listshow" value="6" onclick="changeUrl('deptimg')"/>学部图片列表
                                        <input type="radio" name="listshow" value="7" onclick="changeUrl('deptscroll')"/>学部图片滚动列表
                                        <input type="radio" name="listshow" value="8" onclick="changeUrl('deptview')"/>学部单页详细
                                        <input type="radio" name="listshow" value="9" onclick="changeUrl('deptfontAll')"/>学部文字列表(全部)--%>
                                        <i class="stars">*</i>
                                    </div>
                                    <div class="course_form_div clearfix">
                                        <label for="">前端路径：</label>
                                        <input type="text" placeholder="前端路径" class="text" id="BeforeUrl" value="" />
                                        <i class="stars">*</i>
                                    </div>
                                    <div class="course_form_div clearfix">
                                        <label for="">后端路径：</label>
                                        <input type="text" placeholder="后端路径" class="text" id="AfterUrl" value="" />
                                        <i class="stars">*</i>
                                    </div>
                                    <div style="clear: both"></div>
                                    <div class="course_form_select clearfix">
                                        <a onclick="saveData();" class="course_btn confirm_btn"  id="btnOk">确定</a>
                                        <input type="reset" name="reset" style="display: none;" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
