using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WNavigation
{
    public class Wnavgationperson
    {
        public int ID { get; set; }
        public string firstname { get; set; }
        public string lastname { get; set; }
        public string qualification { get; set; }
        public string gender { get; set; }
        public string work { get; set; }
        public string email { get; set; }
        public string Name { get; set; }
        public string resulted { get; set; }
    }
    public class autocomplete {
        public string emailid { get; set; }
    }
    public class dropdown {
        public string id { get; set; }
        public string email { get; set; }
        }
    public class products {
        public string product { get; set; }
        public string productcount { get; set; }
    }
}