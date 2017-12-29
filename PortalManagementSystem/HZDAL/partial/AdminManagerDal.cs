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
    public partial class AdminManagerDal
    {
        public DataTable GetLeftNavigationMenu(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select * from PortalTreeData where 1=1");
                if (ht.ContainsKey("Display") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["Display"])))
                {
                    sbSql4org.Append(" and [Display]=@Display");
                    List.Add(new SqlParameter("@Display", ht["Display"].ToString()));
                }
                if (ht.ContainsKey("IsDelete") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["IsDelete"])))
                {
                    sbSql4org.Append(" and IsDelete=@IsDelete");
                    List.Add(new SqlParameter("@IsDelete", ht["IsDelete"].ToString()));
                }
                if (ht.ContainsKey("BeforeAfter") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["BeforeAfter"])))
                {
                    sbSql4org.Append(" and (BeforeAfter=@BeforeAfter or BeforeAfter=" + (int)BeforeAfter.前后台展示 + ")");
                    List.Add(new SqlParameter("@BeforeAfter", ht["BeforeAfter"].ToString()));
                }
                if (ht.ContainsKey("PId") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["PId"])))
                {
                    sbSql4org.Append(" and [PId]=@PId");
                    List.Add(new SqlParameter("@PId", ht["PId"].ToString()));
                }
                //string sys = System.Configuration.ConfigurationManager.AppSettings["SystemWeb"];
                //if (sys == "YQYZ")
                //{
                //    sbSql4org.Append(" and ([Name]!='风采展示') ");
                //}
                sbSql4org.Append(" Order by SortId desc,CreateTime asc");
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        #region 更改菜单模块（是否伪删除、是否显示、是否设置条目【附加条目样式】，三选一）

        /// <summary>
        /// 更改菜单模块（是否伪删除、是否显示、是否设置条目【附加条目样式】）
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int UpdatePortalTreeData(Hashtable ht, SqlTransaction trans)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("update PortalTreeData ");
                //如果是纯粹删除，其余都不用
                if (ht.ContainsKey("IsDelete") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["IsDelete"])))
                {
                    sbSql4org.Append("set IsDelete=@IsDelete ");
                    List.Add(new SqlParameter("@IsDelete", ht["IsDelete"].ToString()));
                }
                else if (ht.ContainsKey("Display") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["Display"])))
                {
                    sbSql4org.Append("set Display=@Display ");
                    List.Add(new SqlParameter("@Display", ht["Display"].ToString()));
                }
                //只有显示条目和显示样式的设置
                else if (ht.ContainsKey("DisplayCount") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["DisplayCount"])))
                {
                    sbSql4org.Append("set DisplayCount=@DisplayCount ");
                    List.Add(new SqlParameter("@DisplayCount", ht["DisplayCount"].ToString()));

                    if (ht.ContainsKey("DisplayType") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["DisplayType"])))
                    {
                        sbSql4org.Append(",DisplayType=@DisplayType ");
                        List.Add(new SqlParameter("@DisplayType", ht["DisplayType"].ToString()));
                    }
                }
                sbSql4org.Append(" where 1=1 ");
                if (ht.ContainsKey("ids") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["ids"])))
                {
                    sbSql4org.Append(" and Id in (" + ht["ids"].ToString() + ") ");
                }
                int number = SQLHelp.ExecuteNonQuery(trans, CommandType.Text, sbSql4org.ToString(), List.ToArray());
                return number;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        #endregion

        public DataTable GetPortalTreeData(Hashtable ht, SqlTransaction trans)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();

                sbSql4org.Append("select * from PortalTreeData where PId=@Id ");
                sbSql4org.Append("  Order by SortId desc,CreateTime asc");
                SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@Id",ht["Id"])
            };
                DataTable dt = SQLHelp.ExecuteDataTable(trans, sbSql4org.ToString(), CommandType.Text, param);
                return dt;
            }
            catch (Exception)
            {

                return null;
            }
        }

        /// <summary>
        /// 获取父菜单中的子菜单
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataTable GetPortalTreeDataForChildId(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();

                //不在某个项内【加工】
                string notIn = string.Empty;
                //不在某个项内【其实不需要通过这种通过方式】
                string _NotItem = Convert.ToString(ht["NotItem"]);
                if (!string.IsNullOrEmpty(_NotItem))
                {
                    notIn = string.Format(" and Id not in ({0})", _NotItem);
                }

                //判断获取不为前端或后端显示的内容
                string BeforeAfterNot = Convert.ToString(ht["BeforeAfterNot"]);
                string _beforeafter = string.Empty;
                if (!string.IsNullOrEmpty(BeforeAfterNot))
                {
                    _beforeafter = string.Format(" and BeforeAfter !='{0}'", BeforeAfterNot);
                }
                sbSql4org.Append(" select * from PortalTreeData where IsDelete!=" + ((int)PMSUtility.SysStatus.删除) + _beforeafter + notIn + " and Display=" + ((int)PMSUtility.Display.显示) + "  and (ID in (select Pid from PortalTreeData where ID=@Id and IsDelete!=" + ((int)PMSUtility.SysStatus.删除) + "  and Display=" + ((int)PMSUtility.Display.显示) + ")");
                sbSql4org.Append(" or pid in (select Pid from PortalTreeData where ID=@Id and  IsDelete!=" + ((int)PMSUtility.SysStatus.删除) + " and Display=" + ((int)PMSUtility.Display.显示) + ")) order by SortId desc");
                SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@Id",ht["Id"])
            };
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, param);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }


        }

        public DataTable GetPortalTreeDataForParentId(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();

                //不在某个项内【其实不需要通过这种通过方式】
                string notIn = string.Empty;
                string _NotItem = Convert.ToString(ht["NotItem"]);
                if (!string.IsNullOrEmpty(_NotItem))
                {
                    notIn = string.Format(" and Id not in ({0})", _NotItem);
                }

                //判断获取不为前端或后端显示的内容
                string BeforeAfterNot = Convert.ToString(ht["BeforeAfterNot"]);
                string _beforeafter = string.Empty;
                if (!string.IsNullOrEmpty(BeforeAfterNot))
                {
                    _beforeafter = string.Format(" and BeforeAfter !='{0}'", BeforeAfterNot);
                }

                sbSql4org.Append(" select * from PortalTreeData where IsDelete!=" + ((int)PMSUtility.SysStatus.删除) + _beforeafter + notIn + " and Display=" + ((int)PMSUtility.Display.显示) + " and (ID=@Id or PId=@Idd) Order by SortId desc,CreateTime asc");
                SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@Id",ht["Id"]),
                new SqlParameter("@Idd",ht["Id"])
            };
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, param);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public DataTable GetMenuParent(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select * from PortalTreeData where Display=@Display and PId=0 and (BeforeAfter=@BA or BeforeAfter=@BeforeAfter) or ([Name]='校园资讯' and PId=0)");
                List.Add(new SqlParameter("@Display", ((int)Display.显示).ToString()));
                List.Add(new SqlParameter("@BA", ((int)BeforeAfter.前后台展示).ToString()));
                List.Add(new SqlParameter("@BeforeAfter", ((int)BeforeAfter.前台展示).ToString()));
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetTreeOfRole(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select id,name,pId from PortalTreeData where 1=1");
                sbSql4org.Append(" and [Display]=@Display");
                List.Add(new SqlParameter("@Display", ((int)Display.显示).ToString()));
                sbSql4org.Append(" and IsDelete=@IsDelete");
                List.Add(new SqlParameter("@IsDelete", ((int)SysStatus.正常).ToString()));
                sbSql4org.Append(" and (BeforeAfter=@BeforeAfter or BeforeAfter=@BA)");
                List.Add(new SqlParameter("@BeforeAfter", ((int)BeforeAfter.前后台展示).ToString()));
                List.Add(new SqlParameter("@BA", ((int)BeforeAfter.后台展示).ToString()));
                sbSql4org.Append(" Order by SortId desc,CreateTime desc");
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception)
            {
                return null;
            }

        }

        public DataTable GetVoteDetails(Hashtable ht)
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sb.Append(@"select vd.Id,vd.[Title],count(vr.Count) [Count],vd.VoteId from [dbo].[System_VoteDetails] vd left join [dbo].[System_VoteRecord] vr
on vd.id=vr.[DetailsId]  where 1=1 ");
                if (ht.ContainsKey("VoteId") && !string.IsNullOrWhiteSpace(ht["VoteId"].SafeToString()))
                {
                    sb.Append(" and vd.VoteId=@VoteId");
                    List.Add(new SqlParameter("@VoteId", ht["VoteId"].SafeToString()));
                }
                sb.Append(" group by vd.Id,vd.[Title],vd.VoteId");
                DataTable dt = SQLHelp.ExecuteDataTable(sb.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public bool DelVote(Hashtable ht)
        {
            using (SqlTransaction tans = SQLHelp.BeginTransaction())
            {
                try
                {
                    string sql = "delete from System_Vote where Id=@Id";
                    if (ht.ContainsKey("Id") && !string.IsNullOrWhiteSpace(ht["Id"].SafeToString()))
                    {
                        SqlParameter[] param = new SqlParameter[]{
                            new SqlParameter("@Id",ht["Id"].ToString())
                        };
                        int number = SQLHelp.ExecuteNonQuery(sql, CommandType.Text, param);
                        if (number < 0) tans.Rollback();
                        sql = "select * from System_VoteDetails where VoteId=@Id";
                        SqlParameter[] param_sel = new SqlParameter[]{
                            new SqlParameter("@Id",ht["Id"].ToString())
                        };
                        DataTable dt = SQLHelp.ExecuteDataTable(sql, CommandType.Text, param_sel);
                        sql = "delete from System_VoteDetails where VoteId=@Id";
                        SqlParameter[] param_del = new SqlParameter[]{
                            new SqlParameter("@Id",ht["Id"].ToString())
                        };
                        int num = SQLHelp.ExecuteNonQuery(sql, CommandType.Text, param_del);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            string detailsId = "";
                            foreach (DataRow row in dt.Rows)
                            {
                                detailsId += row["Id"].ToString() + ",";
                            }
                            if (detailsId.Length > 0)
                            {
                                detailsId = detailsId.Substring(0, detailsId.Length - 1);
                                sql = "delete from System_VoteRecord where DetailsId in (" + detailsId + ")";
                                int ok = SQLHelp.ExecuteNonQuery(sql, CommandType.Text, null);
                                tans.Commit();
                                return true;
                            }
                        }
                        else
                        {
                            tans.Commit();
                            return true;
                        }
                    }
                    return false;
                }
                catch (Exception)
                {
                    tans.Rollback();
                    return false;
                }

            }
        }

        public DataTable GetMoreChildTree(Hashtable ht)
        {
            try
            {
                if (ht.ContainsKey("Id") && !string.IsNullOrWhiteSpace(ht["Id"].SafeToString()))
                {
                    string sql = "select *　from [dbo].[PortalTreeData] where pid=@Id and Display=@Display and IsDelete=@IsDelete union select *　from [dbo].[PortalTreeData] where pid in (select id from  [dbo].[PortalTreeData] where pid=@Id2 and Display=@Display2 and IsDelete=@IsDelete2)";
                    SqlParameter[] param = new SqlParameter[] {
                        new SqlParameter("@Id",ht["Id"].SafeToString()),
                        new SqlParameter("@Id2",ht["Id"].SafeToString()),
                        new SqlParameter("@Display",ht["Display"].SafeToString()),
                        new SqlParameter("@Display2",ht["Display"].SafeToString()),
                        new SqlParameter("@IsDelete",ht["IsDelete"].SafeToString()),
                        new SqlParameter("@IsDelete2",ht["IsDelete"].SafeToString())
                    };
                    DataTable dt = SQLHelp.ExecuteDataTable(sql, CommandType.Text, param);
                    return dt;
                }
                return null;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetLevelTree(Hashtable ht)
        {
            try
            {
                string sql = "select * from [dbo].[PortalTreeData] where pid=(select pid from [dbo].[PortalTreeData] where id=@Id) and Display=@Display and IsDelete=@IsDelete";
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@Id",ht["Id"].SafeToString()),
                    new SqlParameter("@Display",ht["Display"].SafeToString()),
                    new SqlParameter("@IsDelete",ht["IsDelete"].SafeToString())
                };
                DataTable dt = SQLHelp.ExecuteDataTable(sql, CommandType.Text, param);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetPreTreeDataForChildId(Hashtable ht)
        {
            try
            {
                string sql = "select * from [dbo].[PortalTreeData] where id=(select pid from [dbo].[PortalTreeData] where id=@Id) and Display=@Display and IsDelete=@IsDelete";
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@Id",ht["Id"].SafeToString()),
                    new SqlParameter("@Display",ht["Display"].SafeToString()),
                    new SqlParameter("@IsDelete",ht["IsDelete"].SafeToString())
                };
                DataTable dt = SQLHelp.ExecuteDataTable(sql, CommandType.Text, param);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}
