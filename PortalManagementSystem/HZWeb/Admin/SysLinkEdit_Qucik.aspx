<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SysLinkEdit_Qucik.aspx.cs" Inherits="PMSWeb.Admin.SysLinkEdit_Qucik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
     <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="renderer" content="webkit" /> 
    <title></title>

    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/common.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/AdminCss/repository.css" />
    <link href="/Admin/AdminCss/onlinetest.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/ajaxfileupload.js"></script>
    <style>
        #dndArea {
            width: 475px;
        }

        .ui-upload-input {
            position: absolute;
            top: 0px;
            right: 0px;
            height: 100%;
            cursor: pointer;
            opacity: 0;
            filter: alpha(opacity:0);
            z-index: 999;
            font-size: 100px;
        }

        .ui-upload-holder {
            position: relative;
            width: 100px;
            height: 27px;
            border: 1px solid silver;
            overflow: hidden;
            border-radius: 3px;
            cursor: pointer;
        }

        .ui-upload-txt {
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100px;
            height: 27px;
            line-height: 27px;
            text-align: center;
            background: #0097DD none repeat scroll 0% 0%;
            color: #fff;
            font: 12px "微软雅黑";
            vertical-align: middle;
            padding: 5px 0px;
            cursor: pointer;
        }

        .settingsd {
            padding: 20px;
        }

            .settingsd table tr td {
                border: 1px solid #ccc;
                padding: 10px;
            }

        .shgnchuanbottom {
            width: 102px;
            height: 30px;
            margin-left: 70px;
        }


        .h-ico {
            display: inline-block;
        }

        .imgShow {
            width: 80px;
            height: 100px;
        }

        .course_manage .crumbs {
            border: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HId" runat="server" />
        <input type="hidden" id="HShowImgUrl" />
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">
                    <div class="course_form_div clearfix">
                        <label for="">标题：</label>
                        <input type="text" placeholder="标题" class="text" id="Title" value="" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_div clearfix">
                        <label for="">排序：</label>
                        <input type="text" placeholder="排序" class="text" id="SortId" value="" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_div clearfix">
                        <label for="">链接地址：</label>
                        <input type="text" placeholder="链接地址" class="text" id="Href" value="" />
                        <i class="stars"></i>
                    </div>
                    <div class="course_form_div clearfix">
                        <label for="">图片信息：</label>
                        <div class="shangchuan">
                            <div class="shgnchuantop mt5" id="imgshow1">
                                <img src="" id="filemsg" width="100px" height="80px" />
                            </div>
                            <div class="shgnchuanbottom ml20">
                                <div class="ui-upload-holder">
                                    <div class="ui-upload-txt">
                                        点击上传
                                    </div>
                                    <input id="fileToUpload1" type="file" size="45" name="fileToUpload1" class="input ui-upload-input bluebutton dianjisc"
                                        style="margin-top: 0;" />
                                </div>
                            </div>
                            <div id="divUpload1" style="display:none;">
                                <img id="loading1" src="AdminImg/ajaxfileloading.gif" class="img-rounded" />
                            </div>
                        </div>
                        <i class="stars"></i>
                    </div>
                </div>
                <div style="clear: both"></div>

                <div class="course_form_select clearfix">
                    <a class="course_btn confirm_btn" onclick="saveData()" id="btnCreate" style="display: inline-block;">确定</a>
                    <a href="javascript:window.history.go(-1);" class="course_btn confirm_btn" style="display: inline-block;">返回</a>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            initLink();
            $("#fileToUpload1").on("change", function () {
                ajaxFileUpload($(this));
            });
        })

        function initLink() {
            if ($("#HId").val() != "") {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/AdminManagerHandler.ashx",
                        "func": "GetLink",
                        "Id": $("#HId").val()
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            var item = json.result.retData;
                            if (item != null) {
                                $("#Title").val(item.Title);
                                $("#SortId").val(item.SortId);
                                $("#Href").val(item.Href);
                                $("#filemsg").attr("src", item.ImageUrl);
                                $("#HShowImgUrl").val(item.ImageUrl)
                            }
                        }
                    },
                    error: OnError
                });
            }
        }

        function ajaxFileUpload(event) {
            var e = event ? event : (window.event ? window.event : null);
            var uploadId = $(e).attr("id");
            if (!/\.(JPG|jpg|png|PNG|BMP|bmp|GIF|gif|JPEG|jpeg)$/.test($(e).val())) {
                layer.msg("图片类型必须是jpg,png,bmp,gif,jpeg中的一种！");
                return false;
            }
            if (uploadId == "fileToUpload1") {
                $("#divUpload1").show();
                $.ajaxFileUpload(
                    {
                        url: '/Handler/UploadImage.ashx',
                        secureuri: false,
                        fileElementId: 'fileToUpload1',
                        dataType: 'json',
                        data: { action: "UploadImgForLinkContent" },
                        success: function (data, status) {
                            if (data.result) {
                                var imgpath = decodeURIComponent(data.path);
                                $("#HShowImgUrl").val(imgpath);
                                $("#filemsg").attr("src", imgpath);
                                $("#divUpload1").hide();
                            } else {
                                $("#divUpload1").hide();
                                layer.msg(data.desc);
                            }
                        },
                        error: function (data, status, e) {
                            $("#divUpload1").hide();
                            layer.msg(e);
                        }
                    }
                );
            }
        }


        function saveData() {
            if ($.trim($("#Title").val()) == '' || $.trim($("#Title").val()).length == 0) {
                layer.msg("标题不能为空！");
                return false;
            }
            if ($.trim($("#Href").val()) == '' || $.trim($("#Href").val()).length == 0) {
                layer.msg("链接不能为空！");
                return false;
            }
            if ($.trim($("#HShowImgUrl").val()) == '' || $.trim($("#HShowImgUrl").val()).length == 0) {
                layer.msg("请上传图片！");
                return false;
            }
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/AdminManagerHandler.ashx",
                    "func": "EditLink",
                    "Title": $("#Title").val(),
                    "Href": $("#Href").val(),
                    "SortId": $("#SortId").val(),
                    "ImageUrl": $("#HShowImgUrl").val(),
                    "Id": $("#HId").val(),
                    "LinkType": "1"
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg('操作成功!');
                        window.history.go(-1);
                        //parent.getData(1, 10);
                        //parent.CloseIFrameWindow();
                    }
                },
                error: OnError
            });
        }
    </script>
</body>
</html>
