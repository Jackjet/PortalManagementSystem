using PMSBLL;
using PMSHanderler.DYYX;
using PMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Windows.Forms;

namespace AppTest
{
    static class Program
    {
        #region 字段

        static PMSBLL.AdvertisingService BllAdvert = new PMSBLL.AdvertisingService();
        //static  PMSBLL.PortalTreeDataService BllPTDS = new PMSBLL.PortalTreeDataService();



        #endregion
        static AdminManagerService BllAMS = new AdminManagerService();
        static System_LinkService BllLS = new System_LinkService();
        static PortalTreeDataService BllPTDS = new PortalTreeDataService();
        static RoleManagerService BLLRMS = new RoleManagerService();
        static System_VoteService BllSVS = new System_VoteService();
        static System_VoteDetailsService BllSVDS = new System_VoteDetailsService();
        static System_VoteRecordService BllVRS = new System_VoteRecordService();
        /// <summary>
        /// 应用程序的主入口点。
        /// </summary>
        [STAThread]
        static void Main()
        {
            //Application.EnableVisualStyles();
            //Application.SetCompatibleTextRenderingDefault(false);
            //Application.Run(new Form1());
            HashtableCustom ht = new HashtableCustom();

            ht.Add("PageIndex", "1");
            ht.Add("PageSize", "7");
            ht.Add("ImgUrl", "/Common.ashx");

            ht.Add("IsDelete", "0");
            ht.Add("MenuIdList", "11,20,35,45");




            Dictionary<string, object> diclist = new Dictionary<string, object>();
            PMSModel.JsonModel jsonModel = null;
            try
            {
               


                var menuids = ht["MenuIdList"].ToString().Split(new char[] { ',' });
                if (menuids.Length > 0)
                {
                    foreach (var item in menuids)
                    {
                        var moder = BllAdvert.GetDataInfo(ht);                    
                        diclist.Add(item, moder.retData);
                    }
                }

            }
            catch (Exception ex)
            {
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,

                };
            }




        }


    }
}
