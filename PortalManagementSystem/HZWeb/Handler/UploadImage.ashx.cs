using PMSUtility;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace PMSWeb.Handler
{
    /// <summary>
    /// UploadImage 的摘要说明
    /// </summary>
    public class UploadImage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["action"];
            if (!string.IsNullOrEmpty(action))
            {
                UploadFileForImg(context, action);
            }
        }

        public void UploadFileForImg(HttpContext context, string action)
        {
            try
            {
                string newFileName = string.Empty;
                HttpFileCollection files = context.Request.Files;
                if (files == null || files.Count == 0)
                    context.Response.Write("{ result :false, desc : '附件不能为空！' }");
                //1.获取文件信息
                var fileToUpload = files[0];
                //if (fileToUpload.ContentLength > 102400000000)
                //{
                //    context.Response.Write("{ \"result\" :false, \"desc\": \"文件过大！\",\"error\":1,\"message\":\"文件大小不能超过2MB！\" }");
                //    return;
                //}

                if (fileToUpload.FileName.LastIndexOf(".") != -1)
                {
                    string file_Type = Path.GetExtension(fileToUpload.FileName).ToLower();
                    if (file_Type == ".swf" || file_Type == ".flv" || file_Type == ".mp4" || file_Type == ".mp3" || file_Type == ".txt"||
                        file_Type == ".doc"|| file_Type == ".docx" || file_Type == ".xls" || file_Type == ".xlsx"|| file_Type == ".pdf" || file_Type == ".ppt" || 
                        file_Type == ".pptx" || file_Type == ".rar" || file_Type == ".zip" || file_Type == ".jpg" || file_Type == ".gif" || file_Type == ".png")
                    {
                        string path = string.Empty;
                        switch (action)
                        {
                            case "UploadImgForNoticeShowBg":
                                path = System.Configuration.ConfigurationManager.AppSettings["NoticeImgShowBgPath"];
                                break;
                            case "UploadImgForSchoolStyle":
                                path = System.Configuration.ConfigurationManager.AppSettings["SchoolStylePath"];
                                break;
                            case "UploadImgForAdvertContent":
                                path = System.Configuration.ConfigurationManager.AppSettings["AdvertImgContentPath"];
                                break;
                            case "UploadImgForLinkContent":
                                path = System.Configuration.ConfigurationManager.AppSettings["LinkImgContentPath"];
                                break;
                            case "UploadImgForMessageContent":
                                path = System.Configuration.ConfigurationManager.AppSettings["MessageImgContentPath"];
                                break;
                            case "UploadWordForContent":
                                path = System.Configuration.ConfigurationManager.AppSettings["WordContentPath"];
                                break;
                        }
                        string serverPath = context.Server.MapPath("~" + path);
                        //2.判断文件目录是否存在
                        if (!Directory.Exists(serverPath))
                        {
                            Directory.CreateDirectory(serverPath);
                        }
                        switch (action)
                        {
                            case "UploadImgForNoticeShowBg":
                                newFileName = "NoticeShowBg" + DateTime.Now.ToString("yyyyMMddhhmmss") + Path.GetFileName(fileToUpload.FileName);
                                break;
                            case "UploadImgForSchoolStyle":
                                newFileName = "SchoolStyle" + DateTime.Now.ToString("yyyyMMddhhmmss") + Path.GetFileName(fileToUpload.FileName);
                                break;
                            case "UploadImgForAdvertContent":
                                newFileName = "AdvertContent" + DateTime.Now.ToString("yyyyMMddhhmmss") + Path.GetFileName(fileToUpload.FileName);
                                break;
                            case "UploadImgForLinkContent":
                                newFileName = "LinkContent" + DateTime.Now.ToString("yyyyMMddhhmmss") + Path.GetFileName(fileToUpload.FileName);
                                break;
                            case "UploadImgForMessageContent":
                                newFileName = "MessageCotent" + DateTime.Now.ToString("yyyyMMddhhmmss") + Path.GetFileName(fileToUpload.FileName);
                                break;
                            case "UploadWordForContent":
                                newFileName = "WordCotent" + DateTime.Now.ToString("yyyyMMddhhmmss") + Path.GetFileName(fileToUpload.FileName);
                                break;
                            default:
                                break;
                        }

                        newFileName = newFileName.Replace(' ', '_');
                        string filePath = Path.Combine(serverPath, newFileName);
                        string saveUrl = string.Empty;
                        try
                        {
                            fileToUpload.SaveAs(filePath);
                            //saveUrl = System.Configuration.ConfigurationManager.AppSettings["ServerUrl"] + path + "/" + newFileName;
                            saveUrl = path + "/" + newFileName;
                            switch (action)
                            {
                                case "UploadImgForNoticeShowBg":
                                case "UploadImgForSchoolStyle":
                                case "UploadImgForLinkContent":
                                case "UploadImgForMessageContent":
                                case "UploadWordForContent":
                                    context.Response.Write("{ result : true, name : '" + fileToUpload.FileName + "', path : '" + HttpUtility.UrlEncode(saveUrl) + "' }");
                                    break;
                                case "UploadImgForAdvertContent":
                                    if (file_Type == ".swf" || file_Type == ".flv" || file_Type == ".mp4")
                                    {
                                        string applictionPath = context.Server.MapPath("~/Handler");
                                        string name = newFileName.Substring(0, newFileName.LastIndexOf(".")) + ".jpg";
                                        string targetImgPath = serverPath + "/" + name;
                                        this.ConverToImg(applictionPath, filePath, targetImgPath);
                                        context.Response.Write("{ result : true, imgpath : '" + HttpUtility.UrlEncode(path + "/" + name) + "', filepath : '" + HttpUtility.UrlEncode(saveUrl) + "' }");
                                    }
                                    else
                                    {
                                        context.Response.Write("{\"error\":0,\"url\":\"" + saveUrl + "\"}");
                                    }
                                    break;
                            }
                            //context.Response.Write("{ error : 0, name : '" + fileToUpload.FileName + "', url : '" + HttpUtility.UrlEncode(saveUrl) +  "' }");
                        }
                        catch (Exception ex)
                        {
                            LogHelper.Error(ex);
                            context.Response.Write("{result:false,error:1}");
                        }
                    }
                    else
                    {
                        context.Response.Write("只能上传文档、图片以及音视频文件，暂不支持:" + file_Type);
                    }
                }
            }
            catch (Exception ex)
            {
            }
        }
        /// <summary>  
        /// 从视频中截取img格式图片  
        /// </summary>  
        /// <param name="applicationPath">ffmpeg.exe文件路径</param>  
        /// <param name="fileNamePath">视频文件路径（带文件名）</param>  
        /// <param name="targetImgNamePath">生成img图片路径（带文件名）</param>  
        private void ConverToImg(string applicationPath, string fileNamePath, string targetImgNamePath)
        {

            //string c = applicationPath + @"\ffmpeg.exe -i" + fileNamePath + targetImgNamePath+"-ss 00:00:05  -r 1 -vframes 1 -an -vcodec mjpeg " ;  
            string c = applicationPath + @"\ffmpeg.exe -ss 00:00:05 -i" + " " + fileNamePath + " " + targetImgNamePath + " " + "-r 1 -vframes 1 -an -vcodec mjpeg ";//速度快  
            Cmd(c);
            //-i:设定输入文件名  
            //-r：设定帧 此处设为1帧  
            //-f:设定输出格式  
            //-ss 从指定时间截图  
            //-vcodec：设定影像解码器，没有输入时为文件原来相同的解码器  
            //-vframes 设置转换多少桢(frame)的视频  
            //-an 不处理声音  
        }

        /// <summary>  
        /// 程序中调用CMD.exe程序，并且不显示命令行窗口界面  
        /// </summary>  
        /// <param name="c">执行的cmd命令</param>  
        private void Cmd(string c)
        {
            try
            {
                System.Diagnostics.Process process = new System.Diagnostics.Process();
                process.StartInfo.CreateNoWindow = true; //不显示程序窗口                  
                process.StartInfo.FileName = "cmd.exe";//要执行的程序名称   
                process.StartInfo.UseShellExecute = false;
                //process.StartInfo.RedirectStandardError = true;  
                process.StartInfo.RedirectStandardOutput = true;//由调用程序获取输出信息   
                process.StartInfo.RedirectStandardInput = true; //可能接受来自调用程序的输入信息   
                process.Start();//启动程序   
                process.StandardInput.WriteLine(c);
                process.StandardInput.AutoFlush = true;
                process.StandardInput.WriteLine("exit");

            }
            catch { }
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}