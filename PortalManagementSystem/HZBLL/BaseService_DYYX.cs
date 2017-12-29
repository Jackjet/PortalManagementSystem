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

namespace PMSBLL
{
    public abstract class BaseService_DYYX<T> where T : class ,new()
    {
        #region 字段
        
        public IBaseDal_DYYX<T> CurrentDal;//依赖抽象的接口。

        private T currentEntity;

        public T CurrentEntity
        {
            get { return new T(); }
        }

        #endregion

        #region 构造函数
        
        public BaseService_DYYX()
        {
            //执行给当前CurrentDal赋值。
            //强迫子类给当前类的CurrentDal属性赋值。
            SetCurrentDal();//调用了一个抽象方法。
        }

        #endregion

        #region 纯抽象方法：子类必须重写此方法。
        
        //纯抽象方法：子类必须重写此方法。
        public abstract void SetCurrentDal();

        #endregion

        #region 增
        
        public virtual JsonModel Add(T entity)
        {
            JsonModel jsonModel = null;
            try
            {
                int result = CurrentDal.Add(entity);
                if (result > 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = result
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 5,
                        errMsg = "名称重复",
                        retData = result
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }

        }

        #endregion

        #region 改
        
        /// <summary>
        /// 更新单挑数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual JsonModel Update(T entity, SqlTransaction trans = null)
        {
            JsonModel jsonModel = null;
            try
            {
                bool result = CurrentDal.Update(entity, trans);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }

        }

        #endregion

        #region 伪删除单条数据
       
        /// <summary>
        /// 伪删除单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual JsonModel DeleteFalse(int id)
        {
            JsonModel jsonModel = null;
            try
            {
                bool result = CurrentDal.DeleteFalse(CurrentEntity, id);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }

        }

        #endregion

        #region 批量伪删除数据
        
        /// <summary>
        /// 批量伪删除数据
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public virtual JsonModel DeleteBatchFalse(params int[] ids)
        {
            JsonModel jsonModel = null;
            try
            {
                int result = CurrentDal.DeleteBatchFalse(CurrentEntity, ids);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }

        }

        #endregion

        #region 删除单条数据

        /// <summary>
        /// 删除单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual JsonModel Delete(int id)
        {
            JsonModel jsonModel = null;
            try
            {
                bool result = CurrentDal.Delete(CurrentEntity, id);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }

        #endregion

        #region 批量删除数据

        /// <summary>
        /// 批量删除数据
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public virtual JsonModel DeleteBatch(params string[] ids)
        {
            JsonModel jsonModel = null;
            try
            {
                int result = CurrentDal.DeleteBatch(CurrentEntity, ids);
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
            //return CurrentDal.DeleteBatch(CurrentEntity, ids);

        }

        #endregion

        #region 获取实体

        public virtual JsonModel GetEntityById(int id)
        {
            JsonModel jsonModel = null;
            try
            {
                T entity = CurrentDal.GetEntityById(CurrentEntity, id);
                if (entity != null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = entity
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "success",
                        retData = null
                    };
                }

                return jsonModel;
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }

        public virtual JsonModel GetEntityById(int id,string whereSql)
        {
            JsonModel jsonModel = null;
            try
            {
                T entity = CurrentDal.GetEntityById(CurrentEntity, id, whereSql);
                if (entity != null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = entity
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "success",
                        retData = null
                    };
                }

                return jsonModel;
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        
        public virtual JsonModel GetEntityListByField(string filed, string value)
        {
            JsonModel jsonModel = null;
            try
            {
                List<T> list = CurrentDal.GetEntityListByField(CurrentEntity, filed, value);
                if (list != null && list.Count == 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = list
                    };
                    return jsonModel;
                }
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = list
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }

        public virtual JsonModel GetEntityListByField(string filed, string value,string sqlWhere)
        {
            JsonModel jsonModel = null;
            try
            {
                List<T> list = CurrentDal.GetEntityListByField(CurrentEntity, filed, value, sqlWhere);
                if (list != null && list.Count == 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = list
                    };
                    return jsonModel;
                }
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = list
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }

        #endregion

        #region 删除
        /// <summary>
        /// 分页查询
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        /* public JsonModel GetEntityOfPage(int pageIndex, int pagesize, string fdname, string filedName, string WhereStr, string OrderByStr, out int pageCount, out int recordcount)
         {
             pageCount = 0;
             recordcount = 0;
             JsonModel jsonModel = null;
             try
             {
                 DataTable dt = CurrentDal.GetEntityOfPage(pageIndex, pagesize, fdname, filedName, CurrentEntity, WhereStr, OrderByStr, out pageCount, out recordcount);

                 jsonModel = new JsonModel()
                 {
                     errNum = 0,
                     errMsg = "success",
                     retData = dt
                 };
                 return jsonModel;
             }
             catch (Exception ex)
             {
                 jsonModel = new JsonModel()
                 {
                     errNum = 400,
                     errMsg = ex.Message,
                     retData = ""
                 };
                 return jsonModel;
             }
         }*/

        /// <summary>
        /// 根据条件获取所有数据
        /// </summary>
        /// <param name="entity">实体类</param>
        /// <param name="where">条件（例如：id>1）</param>
        /// <param name="order">排序（例如：createtime desc）</param>
        /// <returns></returns>
        //public virtual JsonModel GetData(string where, string order)
        //{
        //    JsonModel jsonModel = null;
        //    try
        //    {
        //        DataTable dt = CurrentDal.GetData(CurrentEntity, where, order);

        //        jsonModel = new JsonModel()
        //        {
        //            errNum = 0,
        //            errMsg = "success",
        //            retData = dt
        //        };
        //        return jsonModel;
        //    }
        //    catch (Exception ex)
        //    {
        //        jsonModel = new JsonModel()
        //        {
        //            errNum = 400,
        //            errMsg = ex.Message,
        //            retData = ""
        //        };
        //        return jsonModel;
        //    }
        //}
        #endregion

        #region 批量修改字段值
        /// <summary>
        /// 批量修改字段值
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public virtual JsonModel BatchChangeValue(string field, string fieldValue, params string[] ids)
        {
            JsonModel jsonModel = null;
            try
            {
                int result = CurrentDal.BatchChangeValue(CurrentEntity, field, fieldValue, ids);

                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        #endregion

        #region 判断名称是否已存在
        /// <summary>
        /// 判断名称是否已存在
        /// </summary>
        /// <param name="fieldvalue">字段值</param>
        /// <param name="fieldname">字段名称</param>
        /// <param name="Id">主键</param>
        /// <returns></returns>
        public JsonModel IsNameExists(string where, List<SqlParameter> pms)
        {
            JsonModel jsonModel = null;
            try
            {
                bool result = CurrentDal.IsNameExists(CurrentEntity, where, pms);
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = result
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        #endregion

        #region 获取数据

        public virtual JsonModel GetPage(Hashtable ht, bool IsPage = true, string where = "")
        {
            int RowCount = 0;
            BLLCommon common = new BLLCommon();
            try
            {
                int PageIndex = 0;
                int PageSize = 0;
                if (IsPage)
                {
                    //增加起始条数、结束条数
                    ht = common.AddStartEndIndex(ht);
                    PageIndex = Convert.ToInt32(ht["PageIndex"]);
                    PageSize = Convert.ToInt32(ht["PageSize"]);
                }

                DataTable modList = CurrentDal.GetListByPage(ht, out RowCount, IsPage, where);

                //定义分页数据实体
                PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (modList == null || modList.Rows.Count <= 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return jsonModel;
                }
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                list = common.DataTableToList(modList);

                if (IsPage)
                {

                    //list.Add(common.DataTableToJson(modList));
                    //总条数
                    //int RowCount = modList.Rows.Count;// CurrentDal.GetRecordCount(ht, null);

                    //总页数
                    int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
                    //将数据封装到PagedDataModel分页数据实体中
                    pagedDataModel = new PagedDataModel<Dictionary<string, object>>()
                    {
                        PageCount = PageCount,
                        PagedData = list,
                        PageIndex = PageIndex,
                        PageSize = PageSize,
                        RowCount = RowCount
                    };
                    //将分页数据实体封装到JSON标准实体中
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = pagedDataModel
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = list
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        public virtual DataTable GetData(Hashtable ht, bool IsPage = true, string where = "")
        {
            DataTable modList = null;
            int RowCount = 0;
            BLLCommon common = new BLLCommon();
            try
            {
                modList = new DataTable();
                int PageIndex = 0;
                int PageSize = 0;
                if (IsPage)
                {
                    //增加起始条数、结束条数
                    ht = common.AddStartEndIndex(ht);
                    PageIndex = Convert.ToInt32(ht["PageIndex"]);
                    PageSize = Convert.ToInt32(ht["PageSize"]);
                }

                modList = CurrentDal.GetListByPage(ht, out RowCount, IsPage, where);
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
            }
            return modList;
        }
   
        public virtual bool GetInfoById(int id)
        {
            bool Flag = CurrentDal.GetInfoById(currentEntity, id);
            return Flag;
        }


        #endregion
     
    }
}
