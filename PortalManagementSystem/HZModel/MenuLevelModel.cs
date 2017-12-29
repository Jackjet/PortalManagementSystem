using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMSModel
{
    public class MenuLevelModel:PortalTreeData
    {
        /// <summary>
        /// 是否超过二级
        /// </summary>
        public bool IsMore2Level { get; set; }

        public object ChildList { get; set; }

        /// <summary>
        /// 最后一级的id集合
        /// </summary>
        public object Id_Bottom_List ;
    }
}
