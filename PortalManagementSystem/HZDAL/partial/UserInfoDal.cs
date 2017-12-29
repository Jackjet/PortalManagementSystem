using PMSIDAL;
using PMSModel;
using PMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMSDAL
{
    public partial class UserInfoDal : DYYX_BaseDal<UserInfo>, IUserInfoDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            RowCount = 0;
            List<SqlParameter> pms = new List<SqlParameter>();
            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
            }
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select u.*,r.RoleName from UserInfo u
                                   left join RoleInfo r on u.RoleId=r.Id where u.IsDelete=0 ");
                if (ht.ContainsKey("LoginName") && !string.IsNullOrEmpty(ht["LoginName"].ToString()))
                {
                    sbSql4org.Append(" and u.LoginName=@LoginName ");
                    pms.Add(new SqlParameter("@LoginName", ht["LoginName"].ToString()));
                }
                if (ht.ContainsKey("LoginPassword") && !string.IsNullOrEmpty(ht["LoginPassword"].ToString()))
                {
                    sbSql4org.Append(" and u.LoginPassword=@LoginPassword ");
                    pms.Add(new SqlParameter("@LoginPassword", ht["LoginPassword"].ToString()));
                }                              
                return SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }

        }
    }
}
