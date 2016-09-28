using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThePeopleSearchApplication.Models
{
    public class DisplayTypeModel
    {
        public string Name { get; set; }
        public string Value { get; set; }
        public string ImageClass { get; set; }
        public bool Selected { get; set; }
    }
}