using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMSModel
{
    [Serializable]
    public class IndexModelEntity:PortalTreeData
    {    
        /// <summary>
        /// 首页导读所带的数据（默认为8条）
        /// </summary>
        public object ListData ;

        ///// <summary>
        ///// 获取菜单（带ID和name值）
        ///// </summary>

        //public List<ID_NameEntity> dicList;
      
    }
}
