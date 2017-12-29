using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMSModel
{
    [Serializable]
    public class ID_NameEntity
    {
        public string Id { get; set; }

        public string Name { get; set; }

        public ID_NameEntity(string id, string name)
        {
            this.Id = id;
            this.Name = name;
        }
    }
}
