<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoticeEdit.aspx.cs" Inherits="PMSWeb.Admin.NoticeEdit" %>

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
    <script src="/Scripts/Common.js"></script>

    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/ajaxfileupload.js"></script>
    <link href="../Scripts/KindUeditor/WordPaster/css/WordPaster.css" rel="stylesheet" />
    <link href="../Scripts/KindUeditor/WordPaster/js/skygqbox.css" rel="stylesheet" />
    <link href="../Scripts/KindUeditor/themes/simple/simple.css" rel="stylesheet" />
    <script src="../Scripts/KindUeditor/kindeditor.js"></script>
    <script src="../Scripts/KindUeditor/lang/zh_CN.js"></script>
    <script src="../Scripts/KindUeditor/WordPaster/js/json2.min.js"></script>
    <script src="../Scripts/KindUeditor/WordPaster/js/WordPaster.js"></script>
    <script src="../Scripts/KindUeditor/WordPaster/js/skygqbox.js"></script>  
     <script src="/Scripts/jquery.cookie.js"></script>
     <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
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

          .course_form_div label,.course_form_diva label{
            width:70px;display:block;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="NoticeId" runat="server" />
        <asp:HiddenField ID="MenuId" runat="server" />
        <input type="hidden" id="HFilePath" />
        <input type="hidden" id="HFileName" />
         <input type="hidden" id="HUserName"  />
        <div style="background: #fff">
            <div class="newcourse_dialog_detail">
                <div class="clearfix">

                    <div class="clearfix">
                        <div class="course_form_div clearfix">
                            <label for="">标题：</label>
                            <input type="text" placeholder="标题" class="text" id="Title" value="" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_diva clearfix">
                            <label for="" class="fl">内容：</label>
                            <div style="width:88%;  float: left;">
                               <textarea id="editor_id" name="content" style="width: 100%; height: 500px;">
                                </textarea>
                              <%--   <script id="editor" type="text/plain" style="width: 100%;">
                            </script>--%>
                            </div>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">是否置顶：</label>
                            <input type="radio" name="Hot" value="1" checked />是<input type="radio" name="Hot" value="0" />否
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">是否发布：</label>
                            <input type="radio" name="isPush" value="1" checked />是<input type="radio" name="isPush" value="0" />否
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">排序：</label>
                            <input type="text" placeholder="排序" class="text" id="SortId" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">点击量：</label>
                            <input type="text" placeholder="点击量" class="text" id="ClickNum" />
                            <i class="stars"></i>
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">文档：</label>
                            <div class="shangchuan">
                                <div class="shgnchuantop fl mt5" id="imgshow1">
                                    <span id="filemsg"></span>
                                </div>
                                <div class="shgnchuanbottoma fl ml20">
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
                        </div>
                        <div class="course_form_div clearfix">
                            <label for="">时间：</label>
                            <input type="text" class="Wdate text" id="StarDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="height: 26px; border: 1px solid #9ec5e2; border-radius: 2px; width: 178px;" runat="server" />
                            <i class="stars"></i>
                        </div>
                        <div style="clear: both"></div>

                        <div class="course_form_select clearfix tc">
                            <a  class="course_btn confirm_btn" onclick="saveData()" id="btnCreate">确定</a>
                            <a href="javascript:window.history.go(-1);" class="course_btn confirm_btn" >返回</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            $("#fileToUpload1").on("change", function () {
                ajaxFileUpload($(this));
            });
            //window.UEDITOR_CONFIG.serverUrl = window.UEDITOR_CONFIG.serverUrl + "?UploadParams=UploadImgForAdvertContent";
            //window.editor = UE.getEditor('editor');
            //iniNotice();
            GetUserInfoCookie();
        })
            var pasterMgr = new WordPasterManager();
            //pasterMgr.Config["PostUrl"] = "http://www.ncmem.com/products/upload_ori.aspx"
            pasterMgr.Config["PostUrl"] = "http://localhost:80/Scripts/KindUeditor/asp.net/upload.aspx";
            pasterMgr.Load();//
            //
            var editor;
            KindEditor.ready(function (K) {
                editor = K.create('#editor_id'
                 ,
                 {
                     items: [
                     'source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'cut', 'copy', 'paste',
                 'plainpaste', 'wordpaste', 'netpaster', '|', 'justifyleft', 'justifycenter', 'justifyright',
                 'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
                 'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
                 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                 'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image',
                 'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'map', 'code', 'pagebreak',
                 'link', 'unlink', '|', 'about']
                 , afterCreate: function () {
                     pasterMgr.SetEditor(this);
                     var self = this;
                     //自定义 Ctrl + V 事件。
                     KindEditor.ctrl(self.edit.doc, 'V', function () { pasterMgr.Paste(); });
                 },
                     afterUpload: function (data) {
                         if (data.result) {
                             //data.url 处理
                         } else {
                             if (data != null && data.message != null) layer.msg(data.message);
                         }
                     },
                     afterError: function (str) {
                         layer.msg('error: ' + str);
                     }
                 });
                iniNotice();
            });
           

        function ajaxFileUpload(event) {
            var e = event ? event : (window.event ? window.event : null);
            var uploadId = $(e).attr("id");
            if (!/\.(doc|docx|xls|xlsx|pdf|ppt|pptx|swf|flv|mp4|rar|zip)$/.test($(e).val().toLowerCase())) {
                layer.alert("必须是文档、音频、视频中的一种类型！");
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
                        data: { action: "UploadWordForContent" },
                        success: function (data, status) {
                            if (data.result) {
                                if (uploadId == "fileToUpload1") {
                                    var imgpath = decodeURIComponent(data.path);
                                    $("#HFilePath").val(imgpath);
                                    $("#HFileName").val(data.name);
                                    $("#filemsg").html(data.name);
                                    $("#divUpload1").hide();
                                }
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
                )
            }
        }

        function iniNotice() {
            if ($("#NoticeId").val() != "") {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "DYYX/NoticesHandler.ashx",
                        "func": "GetNoticeInfo",
                        "Id": $("#NoticeId").val()
                    },
                    success: function (json) {
                        if (json.result.errNum == 0) {
                            var item = json.result.retData;
                            if (item != null) {
                                $("#Title").val(item.Title);
                                editor.html(item.Contents);
                                //editor.setContent(item[0].CreativeHTML);
                                $('input[name=Hot][value=' + item.Hot + ']').prop('checked', true);
                                $('input[name=isPush][value=' + item.isPush + ']').prop('checked', true);
                                $("#SortId").val(item.SortId);
                                $("#HFilePath").val(item.FilePath);
                                $("#HFileName").val(item.FileName);
                                $("#filemsg").html(item.FileName);
                                $("#ClickNum").val(item.ClickNum);
                                $("#StarDate").val(DateTimeConvert(item[0].CreateTime, "yyyy-MM-dd HH:mm:ss"));
                            }

                        }
                    },
                    error: function (data, status, e) {
                        layer.msg(e);
                    }
                });
            }
        }

        function saveData() {
            var desc = editor.html() == "请添加你的描述..." ? "" : encodeURIComponent(editor.html());
            //var desc = encodeURIComponent(editor.getContent());
            if (!$.trim($("#Title").val()) || $.trim($("#Title").val()).length==0) {
                layer.msg('请输入标题');
                return false;
            }
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "DYYX/NoticesHandler.ashx",
                    "func": "EditNotice",
                    "Title": $("#Title").val(),
                    "Contents": desc,
                    "Hot": $("input[name='Hot']:checked").val(),
                    "isPush": $("input[name='isPush']:checked").val(),
                    "SortId": $("#SortId").val(),
                    "ClickNum": $("#ClickNum").val(),
                    "Id": $("#NoticeId").val(),
                    "Creator": $("#HUserName").val(),
                    "FilePath": $("#HFilePath").val(),
                    "FileName": $("#HFileName").val(),
                    "MenuId": $("#MenuId").val(),
                    "CreateTime": $("#StarDate").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg('操作成功!');
                        window.history.go(-1);
                        //parent.getData(1, 10);
                        //parent.CloseIFrameWindow();
                    }
                },
                error: function (data, status, e) {
                    layer.msg(e);
                }
            });
        }

        function GetUserInfoCookie() {
            if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
                if (UserInfo != null) {
                    $("#HUserName").val(UserInfo.LoginName);
                }
            }
        }
    </script>
</body>
</html>
