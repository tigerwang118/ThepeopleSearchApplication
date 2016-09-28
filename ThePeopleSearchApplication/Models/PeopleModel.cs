using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThePeopleSearchApplication.Models
{
    public class PeopleModel
    {
        public string Id { get; set; }
        public string FirstName { get; set; }
        public string Address { get; set; }
        public string LastName { get; set; }
        public string Interests { get; set; }
        public string ImageUrl { get; set; }
        public int Age { get; set; }
    }
}