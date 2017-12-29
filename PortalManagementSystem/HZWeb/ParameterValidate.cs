using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace PMSWeb
{
    public static class ParameterValidate
    {
        public static bool IsNumber(string str)
        {
            if (str == null || str.Length == 0)           //验证这个参数是否为空
                return false;                             //是，就返回False
            ASCIIEncoding ascii = new ASCIIEncoding();//new ASCIIEncoding 的实例
            byte[] bytestr = ascii.GetBytes(str);         //把string类型的参数保存到数组里
            foreach (byte c in bytestr)                   //遍历这个数组里的内容
            {
                if (c < 48 || c > 57)                     //判断是否为数字
                {
                    return false;                         //不是，就返回False
                }
            }
            return true;                                  //是，就返回True
        }
        public static bool IsValidInput(ref string input)
        {
            try
            {
                if (string.IsNullOrEmpty(input))
                {
                    //如果是空值,则跳出
                    return true;
                }
                else
                {
                    //替换单引号
                    input = input.Replace("'", "''").Trim();

                    //检测攻击性危险字符串
                    string testString = "and |or |exec |insert |select |delete |update |count |chr |mid |master |truncate |char |declare ";
                    string[] testArray = testString.Split('|');
                    foreach (string testStr in testArray)
                    {
                        if (input.ToLower().IndexOf(testStr) != -1)
                        {
                            //检测到攻击字符串,清空传入的值
                            input = "";
                            return false;
                        }
                    }
                    //未检测到攻击字符串
                    return true;
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}