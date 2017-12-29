using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace PMSUtility
{
    public class HashtableCustom : Hashtable
    {
        public  bool Add_Key(string key,HttpRequest request)
        {
            bool result = false;
            if (!string.IsNullOrWhiteSpace(request[key]))
            { 
                if(!this.ContainsKey(key))
                {
                    base.Add(key, request[key]);
                }               
                result = true;
            }
            return result;
        }

        public bool Add_Key(string key)
        {        
            bool result = false;
            if (!string.IsNullOrWhiteSpace(Convert.ToString(this[key])))
            {
                if (this.ContainsKey(key))
                {
                    result = true;
                }
                
            }
            return result;
        }
    }
}
