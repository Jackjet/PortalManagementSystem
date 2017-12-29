using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace PMSHanderler
{
    public static class Hander_C
    {
        /// <summary>
        /// js解析
        /// </summary>
        public static System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();

        /// <summary>
        /// web_app_server
        /// </summary>
        public static string web_app_root = ConfigurationManager.AppSettings["web_app_root"];

         /// <summary>
        /// web_app_server
        /// </summary>
        public static string web_app_ip = ConfigurationManager.AppSettings["web_app_ip"];

        

        /// <summary>
        /// ffmpeg图片存储地址
        /// </summary>
        public static string ffmpeg_save_address = ConfigurationManager.AppSettings["ffmpeg_save_address"];
    }


}