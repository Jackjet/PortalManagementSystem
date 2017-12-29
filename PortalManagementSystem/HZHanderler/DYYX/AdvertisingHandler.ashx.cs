using PMSModel;
using PMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;

namespace PMSHanderler.DYYX
{
    /// <summary>
    /// AdvertisingHandler 的摘要说明
    /// </summary>
    public class AdvertisingHandler : IHttpHandler
    {

        #region 字段

        static string func = "func";

        static string contentType = "text/plain";

        static string PageIndex = "PageIndex";

        static string PageSize = "PageSize";

        static string isPage = "isPage";

        static string isPush = "isPush";

        static string MenuId = "MenuId";

        static string IsDelete = "IsDelete";

        static string isAll = "isAll";

        static string Advertising = "Advertising";

        static string TableName = "TableName";

        static string NotItem = "NotItem";

        static string MenuIds = "MenuIds";

        static string ImageUrl = "ImageUrl";//

        static string FilePath = "FilePath";

        static string Order = "Order";

        static string SortId = "SortId";

        static string upOrdown = "upOrdown";

        static string PortalTreeData = "PortalTreeData";

        static string ClickNum = "ClickNum";

        static string Sort = "Sort";

        static string Description = "Description";

        static string CreativeHTML = "CreativeHTML";

        static string ModelType = "ModelType";

        static string CreateTime = "CreateTime";

        static string SRC = "SRC";

        static string FileName = "FileName";

        static string ChildId = "ChildId";

        static string Display = "Display";

        static string IsShowIndex = "IsShowIndex";

        static string Id = "Id";

        static string Name = "Name";

        static string Creator = "Creator";

        static string BeforeUrl = "BeforeUrl";

        //static string BeforeAfter = "BeforeAfter";

        static string MenuLevelIndex = "MenuLevelIndex";



        PMSBLL.AdvertisingService BllAdvert = new PMSBLL.AdvertisingService();
        PMSBLL.PortalTreeDataService BllPTDS = new PMSBLL.PortalTreeDataService();

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        #endregion

        #region 缓存资源

        /// <summary>
        /// 菜单缓存
        /// </summary>
        static PMSModel.JsonModel menu = null;

        #endregion

        #region 中心入口点

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                context.Response.ContentType = contentType;
                HttpRequest request = context.Request;
                string action = request[func];
                if (!string.IsNullOrEmpty(action))
                {
                    switch (action)
                    {
                        case "GetPageList": GetPageList(context); break;
                        case "GetAdvertising": GetAdvertising(context); break;
                        case "GetAdvertisingForId": GetAdvertisingForId(context); break;
                        case "EditAdvertising": EditAdvertising(context); break;
                        case "EditAdvertising_Video": EditAdvertising_Video(context); break;
                        case "SetAdvertising_Video": SetAdvertising_Video(context); break;
                        case "UpdateAdvertising": UpdateAdvertising(context); break;
                        case "GetPageListForMenuId": GetPageListForMenuId(context); break;
                        case "UpOrDownAdvert": UpOrDownAdvert(context); break;
                        case "GetStatistics": GetStatistics(context); break;
                        case "GetMenusItemsData": GetMenusItemsData(context); break;
                        case "GetMenuOwnLevel": GetMenuOwnLevel(context); break;
                        case "GetNewData": GetNewData(context); break;
                        case "BatchChangeMenuId": BatchChangeMenuId(context); break;
                        case "SetAdvertisingTop": SetAdvertisingTop(context); break;

                    }
                }
                else
                {
                    context.Response.Write("System Error");
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
            }
        }

        #endregion

        #region 获得新闻或菜单下的分类信息【PageIndex、PageSize、isPage、isAll、MenuId、IsDelete、isPush】

        /// <summary>
        /// 获得新闻或菜单下的分类信息。
        /// </summary>
        /// <param name="context"></param>
        public void GetPageList(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = null;
            HashtableCustom ht = new HashtableCustom();
            try
            {

                bool is_Page = true;
                bool is_All = false;

                ht.Add_Key(PageIndex, request);
                ht.Add_Key(PageSize, request);
                if (!Null_Check(request, isPage)) is_Page = Convert.ToBoolean(request[isPage]);
                if (!Null_Check(request, isAll)) is_All = Convert.ToBoolean(request[isAll]);
                if (is_All)
                {
                    ht.Add_Key(MenuId, request);
                    ht.Add(IsDelete, (int)PMSUtility.SysStatus.正常);
                    ht.Add_Key(isPush, request);
                    jsonModel = BllAdvert.GetAdvertPageList(ht);
                }
                else
                {
                    ht.Add(TableName, Advertising);
                    string where = string.Empty;
                    if (!Null_Check(request, MenuId))
                        where += " and [MenuId]=" + request[MenuId];
                    where += " and IsDelete =" + (int)PMSUtility.SysStatus.正常;
                    if (!Null_Check(request, isPush))
                        where += " and isPush=" + request[isPush].SafeToString();
                    if (!Null_Check(request, MenuIds))
                        where += " and [MenuId] in (" + request[MenuIds].SafeToString() + ")";
                    if (!Null_Check(request, ImageUrl))
                        where += " and(ImageUrl is not null and ImageUrl != '')";
                    ht.Add(Order, " MenuId asc,SortId desc ,CreateTime desc ");
                    jsonModel = BllAdvert.GetPage(ht, is_Page, where);
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                 {
                     errMsg = ex.Message,
                     retData = "",
                     status = "no"
                 };
            }
            finally
            {

                if (jsonModel == null)
                {
                    jsonModel = new PMSModel.JsonModel();
                }
                ht.Clear();
                string js = Hander_C.jss.Serialize(jsonModel);
                context.Response.Write("{\"result\":" + js + "}");
            }
        }

        #endregion

        #region 根据菜单子节点或父节点获得 菜单下的分类信息。【PageIndex、PageSize、isPush、isAll、MenuId】

        /// <summary>
        /// 根据菜单子节点或父节点获得 菜单下的分类信息。
        /// </summary>
        /// <param name="context"></param>
        public void GetPageListForMenuId(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                HashtableCustom ht = new HashtableCustom();
                ht.Add_Key(PageIndex, request);
                ht.Add_Key(PageSize, request);
                ht.Add_Key(isPush, request);
                if (!Null_Check(request, isAll)) ht.Add(isAll, Convert.ToBoolean(request[isAll]));
                if (!Null_Check(request, MenuId))
                {
                    int mid = Convert.ToInt32(request[MenuId]);
                    string pids = GetMenuChild(mid);
                    if (!string.IsNullOrWhiteSpace(pids))
                    {
                        ht.Add(MenuId, pids);
                        jsonModel = BllAdvert.GetAdvertData(ht);
                    }
                }
                else
                {
                    jsonModel = BllAdvert.GetAdvertData(ht);
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
            }
            finally
            {
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 获取最新信息（如新闻导读,根据时间进行排序）【PageIndex、PageSize、isPush】

        public void GetNewData(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                HashtableCustom ht = new HashtableCustom();
                ht.Add_Key(PageIndex, request);
                ht.Add_Key(PageSize, request);
                ht.Add_Key(isPush, request);
                ht.Add_Key(IsDelete, request);

                jsonModel = BllAdvert.GetAdvertData(ht);
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
            }
            finally
            {
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 根据菜单子节点和父节点获得菜单下的分类信息（以及不包括那些节点NotItem）【MenuId】

        /// <summary>
        /// 根据菜单子节点和父节点获得菜单下的分类信息（以及不包括那些节点NotItem）
        /// </summary>
        /// <param name="context"></param>
        public void GetAdvertising(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                HashtableCustom ht = new HashtableCustom();

                string sqlWhere = "";

                var d = request["IsDelete"];

                if (!string.IsNullOrEmpty(request[IsDelete]))
                {
                    sqlWhere += "IsDelete=" + request[IsDelete];
                }
                if (!string.IsNullOrEmpty(request[isPush]))
                {
                    sqlWhere += " and isPush =" + request[isPush];
                }


                if (!Null_Check(request, MenuId))
                {
                    if (string.IsNullOrEmpty(sqlWhere))
                    {
                        jsonModel = BllAdvert.GetEntityListByField(MenuId, request[MenuId]);
                    }
                    else
                    {
                        jsonModel = BllAdvert.GetEntityListByField(MenuId, request[MenuId], sqlWhere);

                    }
                }
                else
                {
                    jsonModel = GetDataHelper(request, ht);
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,

                };
            }
            finally
            {
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }

        }


        private PMSModel.JsonModel GetDataHelper(HttpRequest request, HashtableCustom ht)
        {
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                ht.Add_Key(MenuIds, request);
                ht.Add_Key(IsDelete, request);

                ht.Add_Key(isPush, request);
                ht.Add_Key(PageIndex, request);
                ht.Add_Key(PageSize, request);
                ht.Add_Key(ImageUrl, request);

                ht.Add_Key(NotItem, request);
                ht.Add_Key(ChildId, request);
                ht.Add_Key(isAll, request);

                jsonModel = BllAdvert.GetDataInfo(ht);
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
            }

            return jsonModel;
        }


        #endregion

        #region 根据主菜单获取子菜单的前几条数据（pIDs,IDS）

        /// <summary>
        /// 不需要传IDS和PageSize(根据菜单获取所有数据)
        /// </summary>
        /// <param name="context"></param>
        public void GetMenusItemsData(HttpContext context)
        {
            HttpRequest request = context.Request;
            HashtableCustom ht1 = new HashtableCustom();

            List<IndexModelEntity> IndexModelEntityList = new List<IndexModelEntity>();
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            PMSModel.JsonModel Model = new PMSModel.JsonModel();
            try
            {
                #region 获取首页导读的一级菜单（包括了三级的菜单）||获取指定菜单ID的二级菜单(通过一级菜单的ID去获取)

                ht1.Add(TableName, PortalTreeData);
                string where = string.Empty;
                bool isPage = false;

                if (!string.IsNullOrWhiteSpace(request[Display])) where += " and Display=" + request[Display];
                if (!string.IsNullOrWhiteSpace(request[IsDelete])) where += " and IsDelete=" + request[IsDelete];
                if (!string.IsNullOrWhiteSpace(request[IsShowIndex]))
                {
                    where += " and IsShowIndex=" + request[IsShowIndex];
                }
                else if (!string.IsNullOrWhiteSpace(request[MenuIds]))
                {

                    where += string.Format(" and PId in({0})  ", request[MenuIds]);
                }
                //获取显示在首页导读工作区域的菜单
                ht1.Add(Order, " ShowIndexSort asc, SortId desc ,CreateTime desc ");
                Model = BllPTDS.GetPage(ht1, isPage, where);

                #endregion

                List<Dictionary<string, object>> dic = Model.retData as List<Dictionary<string, object>>;
                if (dic != null)
                {
                    foreach (var item in dic)
                    {

                        IndexModelEntity indexModielEntity = new IndexModelEntity();

                        #region 实体属性

                        indexModielEntity.Id = Convert.ToInt32(item[Id]);
                        indexModielEntity.Name = Convert.ToString(item[Name]);
                        indexModielEntity.CreateTime = Convert.ToDateTime(item[CreateTime]);

                        indexModielEntity.Creator = Convert.ToString(item["Creator"]);
                        indexModielEntity.PId = Convert.ToInt32(item["PId"]);
                        indexModielEntity.BeforeUrl = Convert.ToString(item["BeforeUrl"]);
                        indexModielEntity.BeforeAfter = Convert.ToInt32(item["BeforeAfter"]);
                        indexModielEntity.AfterUrl = Convert.ToString(item["AfterUrl"]);
                        indexModielEntity.SortId = Convert.ToInt32(item[SortId]);


                        indexModielEntity.DisplayCount = Convert.ToInt32(item["DisplayCount"]);
                        indexModielEntity.DisplayType = Convert.ToString(item["DisplayType"]);
                        indexModielEntity.MenuLevelIndex = Convert.ToInt32(item["MenuLevelIndex"]);
                        indexModielEntity.ShowIndexSort = Convert.ToInt32(item["ShowIndexSort"]);


                        #endregion

                        #region 获取导读数据（后台获取限制数据的条数）

                        int displayCount = 0;
                        if (request["DisplayCount"] != null)
                        {
                            displayCount = Convert.ToInt32(request["DisplayCount"]);
                        }
                        else
                        {
                            displayCount = Convert.ToInt32(item["DisplayCount"]);
                        }

                        HashtableCustom ht2 = new HashtableCustom();
                        ht2.Add(MenuIds, item[Id]);
                        ht2.Add(MenuId, item[Id]);
                        ht2.Add(PageSize, displayCount);
                        ht2.Add_Key(IsDelete, request);
                        ht2.Add_Key(isPush, request);
                        ht2.Add(PageIndex, 1);

                        if (!string.IsNullOrWhiteSpace(request[IsShowIndex]))
                        {

                            //获取三级数据，没有则获取二级数据
                            var moder = BllAdvert.GetDataMore_LevelInfo(ht2);
                            indexModielEntity.ListData = moder.retData;
                        }
                        else if (!string.IsNullOrWhiteSpace(request[MenuIds]))
                        {
                            //获取直接二级数据，没有则获取二级数据
                            var moder = BllAdvert.GetAdvertData(ht2);
                            indexModielEntity.ListData = moder.retData;

                        }



                        #endregion

                        IndexModelEntityList.Add(indexModielEntity);
                    }
                }
                jsonModel = new PMSModel.JsonModel() { retData = IndexModelEntityList, errMsg = "success" };


            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,

                };
            }
            finally
            {
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 获取一级菜单（标识包含几级目录）TOP

        public void GetMenuOwnLevel(HttpContext context)
        {
            PMSModel.JsonModel jsonModel = null;
            PMSModel.JsonModel Model = null;
            HttpRequest request = context.Request;

            try
            {
                if (menu == null)
                {
                    HashtableCustom ht1 = new HashtableCustom();

                    ht1.Add(TableName, PortalTreeData);
                    string where = string.Empty;
                    bool isPage = false;
                    if (!string.IsNullOrWhiteSpace(request["MenuLevelIndex"])) where += " and MenuLevelIndex=" + request["MenuLevelIndex"];
                    if (!string.IsNullOrWhiteSpace(request[Display])) where += " and Display=" + request[Display];
                    if (!string.IsNullOrWhiteSpace(request[IsDelete])) where += " and IsDelete=" + request[IsDelete];

                    ht1.Add(Order, " SortId desc ,CreateTime desc,ShowIndexSort desc ");
                    //获取菜单数据
                    Model = BllPTDS.GetPage(ht1, isPage, where);
                    List<Dictionary<string, object>> dic = Model.retData as List<Dictionary<string, object>>;
                    List<MenuLevelModel> menuLevelModelList = new List<MenuLevelModel>();
                    foreach (var item in dic)
                    {
                        #region 获取数据或IDs

                        HashtableCustom ht2 = new HashtableCustom();
                        ht2.Add_Key(Display, request);
                        ht2.Add_Key(IsDelete, request);
                        ht2.Add(TableName, PortalTreeData);
                        ht2.Add(Order, " SortId asc ,CreateTime desc ");
                        string where2 = string.Empty;

                        if (!string.IsNullOrWhiteSpace(request[Display])) where2 += " and Display=" + request[Display];
                        if (!string.IsNullOrWhiteSpace(request[IsDelete])) where2 += " and IsDelete=" + request[IsDelete];

                        //跳级获取，listChild 如果为null 说明只有两级（获取三级数据）
                        where2 = string.Format(" and Id in(select pid from PortalTreeData where pid in(select id from PortalTreeData where PId ={0}) group by PId)", item[Id]);
                        ht2.Add(MenuIds, item[Id]);
                        var moder = BllPTDS.GetPage(ht2, isPage, where2);

                        string ids = BllAdvert.GetIDS(ht2);

                        #endregion

                        //菜单级别数据（携带跳级数据）
                        MenuLevelModel menLevelModel = null;
                        if (Convert.ToString(moder.retData) != string.Empty)
                        {
                            menLevelModel = new MenuLevelModel() { ChildList = moder.retData, IsMore2Level = true };
                        }
                        else
                        {
                            menLevelModel = new MenuLevelModel() { IsMore2Level = false };
                        }

                        menLevelModel.Id_Bottom_List = ids;

                        #region 实体属性

                        menLevelModel.Id = Convert.ToInt32(item[Id]);
                        menLevelModel.Name = Convert.ToString(item[Name]);
                        menLevelModel.CreateTime = Convert.ToDateTime(item[CreateTime]);

                        menLevelModel.Creator = Convert.ToString(item["Creator"]);
                        menLevelModel.PId = Convert.ToInt32(item["PId"]);
                        menLevelModel.BeforeUrl = Convert.ToString(item["BeforeUrl"]);
                        menLevelModel.BeforeAfter = Convert.ToInt32(item["BeforeAfter"]);
                        menLevelModel.AfterUrl = Convert.ToString(item["AfterUrl"]);
                        menLevelModel.SortId = Convert.ToInt32(item[SortId]);

                        menLevelModel.DisplayCount = Convert.ToInt32(item["DisplayCount"]);
                        menLevelModel.DisplayType = Convert.ToString(item["DisplayType"]);
                        menLevelModel.MenuLevelIndex = Convert.ToInt32(item["MenuLevelIndex"]);
                        menLevelModel.ShowIndexSort = Convert.ToInt32(item["ShowIndexSort"]);


                        #endregion

                        menuLevelModelList.Add(menLevelModel);
                    }

                    jsonModel = new PMSModel.JsonModel() { retData = menuLevelModelList, errMsg = "success" };

                    menu = jsonModel;
                }
                else
                {
                    jsonModel = menu;
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
            }
            finally
            {
                if (jsonModel == null)
                {
                    jsonModel = new JsonModel();
                }
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }


        #endregion

        #region 根据ID获得分类信息

        /// <summary>
        /// 根据ID获得分类信息
        /// </summary>
        /// <param name="context"></param>
        public void GetAdvertisingForId(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {

                Hashtable ht = new Hashtable();
                if (!Null_Check(request, "AdvId"))
                {
                    jsonModel = BllAdvert.GetEntityById(int.Parse(request["AdvId"]));
                }
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
            }
            finally
            {
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }


        #endregion

        #region 检测是否为null

        static bool Null_Check(HttpRequest request, string key)
        {
            bool result = true;
            try
            {
                if (!string.IsNullOrWhiteSpace(request[key]))
                    result = false;
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
            }
            return result;
        }

        #endregion

        #region 修改分类信息

        /// <summary>
        /// 修改分类信息
        /// </summary>
        /// <param name="context"></param>
        public void EditAdvertising(HttpContext context)
        {
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            HttpRequest request = context.Request;
            try
            {
                string _Id = request[Id];
                string _Description = request[Description];
                int Menu_Id = int.Parse(request[MenuId]);
                string _CreativeHTML = HttpUtility.UrlDecode(request[CreativeHTML]);
                string _Creator = request["Creator"];
                PMSModel.Advertising advert = new PMSModel.Advertising();
                advert.Description = _Description;
                advert.CreativeHTML = _CreativeHTML;
                advert.ClickNum = Null_Check(request, ClickNum) ? 0 : int.Parse(request[ClickNum]);
                advert.ModelType = Null_Check(request, ModelType) ? 0 : int.Parse(request[ModelType]);
                advert.FileName = request[FileName];
                advert.FilePath = request["FilePath"];
                if (!Null_Check(request, isPush)) advert.isPush = Convert.ToByte(request[isPush]);
                advert.CreateTime = Null_Check(request, CreateTime) ? DateTime.Now : Convert.ToDateTime(request[CreateTime]);
                if (_CreativeHTML.ToUpper().IndexOf(SRC) > -1)
                {
                    string[] imageArry = new HtmlImgRegex().GetHtmlImageUrlList(_CreativeHTML);
                    string imgstr = "";
                    for (int i = 0; i < imageArry.Length; i++)
                    {
                        imgstr += imageArry[i] + ",";
                    }
                    if (imgstr.Length > 0)
                    {
                        advert.ImageUrl = imgstr.Substring(0, imgstr.Length - 1);
                    }
                }
                else
                {
                    advert.ImageUrl = "";
                }
                if (!string.IsNullOrWhiteSpace(_Id))
                {
                    advert.Id = int.Parse(request[Id]);
                    jsonModel = BllAdvert.Update(advert);
                }
                else
                {
                    //advert.CreateTime = DateTime.Now;
                    advert.Creator = _Creator;
                    advert.MenuId = Menu_Id;
                    advert.IsDelete = (int)PMSUtility.SysStatus.正常;
                    //advert.isPush = Convert.ToByte((int)isPush.未发布);
                    jsonModel = BllAdvert.Add(advert);
                    if (jsonModel.errNum == 0)
                    {
                        int advId = Convert.ToInt32(jsonModel.retData);
                        PMSModel.Advertising at = new PMSModel.Advertising();
                        //int preSid = BllAdvert.GetSortIdForAdvert(advId, MenuId);
                        at.Id = advId;
                        at.SortId = advId + 1;
                        BllAdvert.Update(at);
                    }
                }

                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }
        /// <summary>
        /// 添加或修改视频新闻消息
        /// </summary>
        /// <param name="context"></param>
        public void SetAdvertising_Video(HttpContext context)
        {
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            HttpRequest request = context.Request;
            try
            {
                string _Id = request[Id];
                string _Description = request[Description];
                int Menu_Id = int.Parse(request[MenuId]);
                string _CreativeHTML = HttpUtility.UrlDecode(request[CreativeHTML]);
                string _ImageUrl = HttpUtility.UrlDecode(request[ImageUrl]);
                string _FilePath = HttpUtility.UrlDecode(request[FilePath]);
                PMSModel.Advertising advert = new PMSModel.Advertising();
                string Creator = request["Creator"];

                advert.MenuId = Menu_Id;
                advert.Description = _Description;
                advert.CreativeHTML = _CreativeHTML;
                advert.ClickNum = Null_Check(request, ClickNum) ? 0 : int.Parse(request[ClickNum]);
                //advert.ImageUrl = _ImageUrl;
                advert.FilePath = _FilePath;
                advert.ModelType = Null_Check(request, ModelType) ? 0 : int.Parse(request[ModelType]);

                if (!Null_Check(request, isPush)) advert.isPush = Convert.ToByte(request[isPush]);
                advert.CreateTime = Null_Check(request, CreateTime) ? DateTime.Now : Convert.ToDateTime(request[CreateTime]);
                if (_CreativeHTML.ToUpper().IndexOf(SRC) > -1)
                {
                    string[] imageArry = new HtmlImgRegex().GetHtmlImageUrlList(_CreativeHTML);
                    string imgstr = "";
                    for (int i = 0; i < imageArry.Length; i++)
                    {
                        imgstr += imageArry[i] + ",";
                    }
                    if (imgstr.Length > 0)
                    {
                        advert.ImageUrl = imgstr.Substring(0, imgstr.Length - 1);
                    }
                }
                else
                {
                    advert.ImageUrl = "";
                }
                if (!string.IsNullOrWhiteSpace(_Id))
                {
                    advert.Id = int.Parse(request[Id]);
                    jsonModel = BllAdvert.Update(advert);
                }
                else
                {
                    //advert.CreateTime = DateTime.Now;
                    advert.Creator = Creator;
                    advert.MenuId = Menu_Id;
                    advert.IsDelete = (int)PMSUtility.SysStatus.正常;
                    //advert.isPush = Convert.ToByte((int)isPush.未发布);
                    jsonModel = BllAdvert.Add(advert);
                    if (jsonModel.errNum == 0)
                    {
                        int advId = Convert.ToInt32(jsonModel.retData);
                        PMSModel.Advertising at = new PMSModel.Advertising();
                        //int preSid = BllAdvert.GetSortIdForAdvert(advId, MenuId);
                        at.Id = advId;
                        at.SortId = advId + 1;
                        BllAdvert.Update(at);
                    }
                }

                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }
        /// <summary>
        /// 修改分类信息
        /// </summary>
        /// <param name="context"></param>
        public void EditAdvertising_Video(HttpContext context)
        {
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            HttpRequest request = context.Request;
            try
            {
                string _Id = request[Id];
                string _Description = request[Description];
                int Menu_Id = int.Parse(request[MenuId]);
                string _CreativeHTML = HttpUtility.UrlDecode(request[CreativeHTML]);
                PMSModel.Advertising advert = new PMSModel.Advertising();
                if (_CreativeHTML.Contains("src=") && _CreativeHTML.Contains("type="))
                {

                    //替换错误的media_html
                    string media_html = request["media_html"];
                    if (!string.IsNullOrEmpty(media_html))
                    {


                        //获取上传音视频的文件路径
                        int scr1 = media_html.IndexOf("file=") + 5;
                        int scr2 = media_html.IndexOf("src=");
                        advert.FilePath = media_html.Substring(scr1, scr2 - scr1).Replace("\"", string.Empty);


                        string imgPat = "<embed[^>]+/>|<embed[^>]+[^/>]></embed>";
                        _CreativeHTML = Regex.Replace(_CreativeHTML, imgPat, media_html);
                        _CreativeHTML = "<div style='width:750px;margin:10px auto;'><video  class='video-js vjs-default-skin vjs-big-play-centered' controls preload='auto' width='750' height='500'  poster='/PreSchool/images/luntu_01.png'><source src='" + advert.FilePath + "' type='video/mp4' autoplay='autoplay'/></video></div>";
                        //获取文件类型
                        string fileExtension = Path.GetExtension(advert.FilePath).Trim();
                        //暂时只能有一个视频
                        if (fileExtension.Equals(".mp4") || fileExtension.Equals(".avi") || fileExtension.Equals(".rmvb") || fileExtension.Equals(".swf"))
                        {
                            //获取文件名名称
                            string fileName = Path.GetFileName(advert.FilePath);
                            string filename_img = Path.GetFileNameWithoutExtension(advert.FilePath) + ".png";

                            string cmd = string.Format("ffmpeg -i {0} -ss 00:00:04 -r 1 -q:v 2 -f image2 {1}", Hander_C.web_app_ip + Hander_C.web_app_root + fileName, Hander_C.ffmpeg_save_address + filename_img);
                            //获取视频第一帧
                            Execute(cmd);

                            advert.ImageUrl += Hander_C.web_app_root + filename_img + ",";
                        }
                    }


                }
                else
                {
                    advert.FilePath = request["FilePath"];
                }
                string Creator = request["Creator"];

                //
                advert.Description = _Description;
                advert.CreativeHTML = _CreativeHTML;
                advert.ClickNum = Null_Check(request, ClickNum) ? 0 : int.Parse(request[ClickNum]);
                advert.ModelType = Null_Check(request, ModelType) ? 0 : int.Parse(request[ModelType]);
                advert.FileName = request[FileName];

                if (!Null_Check(request, isPush)) advert.isPush = Convert.ToByte(request[isPush]);
                advert.CreateTime = Null_Check(request, CreateTime) ? DateTime.Now : Convert.ToDateTime(request[CreateTime]);
                if (_CreativeHTML.ToUpper().IndexOf(SRC) > -1)
                {
                    string[] imageArry = new HtmlImgRegex().GetHtmlImageUrlList(_CreativeHTML);
                    string imgstr = "";
                    for (int i = 0; i < imageArry.Length; i++)
                    {
                        imgstr += imageArry[i] + ",";
                    }
                    if (imgstr.Length > 0)
                    {
                        advert.ImageUrl = imgstr.Substring(0, imgstr.Length - 1);
                    }
                }
                else
                {
                    advert.ImageUrl = "";
                }
                if (!string.IsNullOrWhiteSpace(_Id))
                {
                    advert.Id = int.Parse(request[Id]);
                    jsonModel = BllAdvert.Update(advert);
                }
                else
                {
                    //advert.CreateTime = DateTime.Now;
                    advert.Creator = Creator;
                    advert.MenuId = Menu_Id;
                    advert.IsDelete = (int)PMSUtility.SysStatus.正常;
                    //advert.isPush = Convert.ToByte((int)isPush.未发布);
                    jsonModel = BllAdvert.Add(advert);
                    if (jsonModel.errNum == 0)
                    {
                        int advId = Convert.ToInt32(jsonModel.retData);
                        PMSModel.Advertising at = new PMSModel.Advertising();
                        //int preSid = BllAdvert.GetSortIdForAdvert(advId, MenuId);
                        at.Id = advId;
                        at.SortId = advId + 1;
                        BllAdvert.Update(at);
                    }
                }

                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 更新分类信息

        /// <summary>
        /// 更新分类信息
        /// </summary>
        /// <param name="context"></param>
        public void UpdateAdvertising(HttpContext context)
        {
            HttpRequest request = context.Request;

            if (!Null_Check(request, Id))
            {
                try
                {
                    PMSModel.Advertising advert = BllAdvert.GetEntityById(int.Parse(request[Id])).retData as PMSModel.Advertising;
                    if (advert != null)
                    {
                        if (!Null_Check(request, IsDelete))
                            advert.IsDelete = Convert.ToByte(request[IsDelete]);
                        if (!Null_Check(request, ClickNum))
                            advert.ClickNum = advert.ClickNum + 1;

                        if (!Null_Check(request, Sort))
                        {
                            advert.SortId = Convert.ToInt64(request[Sort]);
                        }
                        if (!Null_Check(request, isPush))
                            advert.isPush = Convert.ToByte(request[isPush]);

                        PMSModel.JsonModel jsonModel = BllAdvert.Update(advert);
                        jsonModel.status = "yes";
                        context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                    }
                }
                catch (Exception ex)
                {
                    LogHelper.Error(ex);
                    PMSModel.JsonModel jsonModel = new PMSModel.JsonModel()
                    {
                        errMsg = ex.Message,
                        retData = "",
                        status = "no"
                    };
                    context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
                }

            }
        }

        #endregion


        #region 根据菜单父节点ID查询子节点信息

        /// <summary>
        /// 根据菜单父节点ID查询子节点信息
        /// </summary>
        /// <param name=Id></param>
        /// <returns></returns>
        public string GetMenuChild(int id)
        {
            try
            {
                Hashtable ht = new Hashtable();
                string where = string.Empty;
                ht.Add(TableName, PortalTreeData);
                where += " and PId=" + id;
                where += " and IsDelete!=" + (int)SysStatus.删除;
                where += " and (BeforeAfter=" + ((int)BeforeAfter.前台展示) + " or BeforeAfter=" + ((int)BeforeAfter.前后台展示) + ") ";
                ht.Add(Order, " SortId desc ");
                DataTable dt = BllPTDS.GetData(ht, false, where);
                string ids = string.Empty;
                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        ids += row[Id] + ",";
                    }
                    if (!string.IsNullOrWhiteSpace(ids)) ids = ids.Substring(0, ids.Length - 1);
                }
                return ids;
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                return string.Empty;
            }
        }

        #endregion

        #region 新闻导读上移、下移

        /// <summary>
        /// 新闻导读上移、下移
        /// </summary>
        /// <param name="context"></param>
        public void UpOrDownAdvert(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                HashtableCustom ht = new HashtableCustom();
                ht.Add_Key(upOrdown, request);
                if (!Null_Check(request, MenuId))
                    ht.Add(MenuId, GetMenuChild(Convert.ToInt32(request[MenuId])));
                else
                    ht.Add_Key(MenuId, request);


                ht.Add_Key(isPush, request);
                ht.Add_Key(Id, request);
                ht.Add_Key(SortId, request);
                jsonModel = BllAdvert.UpdateAdertSort(ht);
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
            }
            finally
            {
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 统计文章访问率



        /// <summary>
        /// 统计文章访问率
        /// </summary>
        /// <param name="context"></param>
        public void GetStatistics(HttpContext context)
        {
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            HttpRequest request = context.Request;
            try
            {
                HashtableCustom ht = new HashtableCustom();
                ht.Add_Key(PageIndex, request);
                ht.Add_Key(PageSize, request);
                string where = string.Empty;
                ht.Add(TableName, Advertising);

                where += " and IsDelete =" + (int)PMSUtility.SysStatus.正常;

                string notIn = string.Empty;
                string _NotItem = Convert.ToString(request["NotItem"]);
                if (!string.IsNullOrEmpty(_NotItem))
                {
                    notIn = string.Format(" and MenuId not in ({0})", _NotItem);
                }

                if (!Null_Check(request, isPush)) where += " and isPush=" + request[isPush].SafeToString() + notIn;
                ht.Add(Order, "ClickNum desc ");
                jsonModel = BllAdvert.GetPage(ht, true, where);
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                    retData = "",
                    status = "no"
                };
            }
            finally
            {
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion

        #region 批量修改Menuid
        private void BatchChangeMenuId(HttpContext context)
        {
            HttpRequest request = context.Request;
            string[] ids = context.Request["Ids"].Split(',');
            PMSModel.JsonModel jsonModel = BllAdvert.BatchChangeValue("MenuId", request[MenuId], ids);
            context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
        }
        #endregion

        #region 辅助方法

        //dosCommand Dos命令语句  
        public static string Execute(string dosCommand)
        {
            return Execute(dosCommand, 3000);
        }
        /// <summary>  
        /// 执行DOS命令，返回DOS命令的输出  
        /// </summary>  
        /// <param name="dosCommand">dos命令</param>  
        /// <param name="milliseconds">等待命令执行的时间（单位：毫秒），  
        /// 如果设定为0，则无限等待</param>  
        /// <returns>返回DOS命令的输出</returns>  
        public static string Execute(string command, int seconds)
        {
            string output = ""; //输出字符串  
            if (command != null && !command.Equals(""))
            {
                Process process = new Process();//创建进程对象  
                ProcessStartInfo startInfo = new ProcessStartInfo();
                startInfo.FileName = "cmd.exe";//设定需要执行的命令  
                startInfo.Arguments = "/C " + command;//“/C”表示执行完命令后马上退出  
                startInfo.UseShellExecute = false;//不使用系统外壳程序启动  
                startInfo.RedirectStandardInput = false;//不重定向输入  
                startInfo.RedirectStandardOutput = true; //重定向输出  
                startInfo.CreateNoWindow = true;//不创建窗口  
                process.StartInfo = startInfo;
                try
                {
                    if (process.Start())//开始进程  
                    {
                        if (seconds == 0)
                        {
                            process.WaitForExit();//这里无限等待进程结束  
                        }
                        else
                        {
                            process.WaitForExit(seconds); //等待进程结束，等待时间为指定的毫秒  
                        }
                        output = process.StandardOutput.ReadToEnd();//读取进程的输出  
                    }
                }
                catch
                {
                }
                finally
                {
                    if (process != null)
                        process.Close();
                }
            }
            return output;
        }


        public void RunCmd(string cmd, string address)
        {
            if (!string.IsNullOrEmpty(address))
            {
                Thread thread = new Thread(new ThreadStart(() =>
                {
                    cmd = "cd " + address + Environment.NewLine + cmd;

                    Process process = new Process();
                    process.StartInfo.FileName = "cmd.exe";
                    process.StartInfo.UseShellExecute = false;
                    process.StartInfo.CreateNoWindow = true;
                    process.StartInfo.RedirectStandardInput = true;
                    process.StartInfo.RedirectStandardOutput = true;
                    process.StartInfo.RedirectStandardError = true;
                    process.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
                    process.Start();
                    process.StandardInput.WriteLine(cmd);
                    Thread.Sleep(1300);

                    process.Dispose();
                }));
                thread.Start();
            }
        }

        #region 新闻置顶

        public void SetAdvertisingTop(HttpContext context)
        {
            HttpRequest request = context.Request;
            PMSModel.JsonModel jsonModel = new PMSModel.JsonModel();
            try
            {
                HashtableCustom ht = new HashtableCustom();
                ht.Add_Key(MenuId, request);
                ht.Add_Key(Id, request);
                jsonModel = BllAdvert.SetAdvertisingTop(ht);
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                jsonModel = new PMSModel.JsonModel()
                {
                    errMsg = ex.Message,
                };
            }
            finally
            {
                context.Response.Write("{\"result\":" + Hander_C.jss.Serialize(jsonModel) + "}");
            }
        }

        #endregion


        #endregion

    }
}