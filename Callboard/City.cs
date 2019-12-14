using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Callboard
{
    public class City
    {
        public string ID;
        public string Name;

        public City(string id, string name)
        {
            this.ID = id;
            this.Name = name;
        }
    }
}