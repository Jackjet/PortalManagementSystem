using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMSModel
{
    /// <summary>
    /// 显示在首页的数据（导读区域，模块化）
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class PagedDataModel<T>
    {
        //分页数据
        public List<T> PagedData { get; set; }
        //当前页
        public int PageIndex { get; set; }
        //每页多少条
        public int PageSize { get; set; }
        //总页数
        public int PageCount { get; set; }
        //总条数
        public int RowCount { get; set; }
    }   
}
