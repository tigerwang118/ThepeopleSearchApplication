using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace ThePeopleSearchApplication.Models
{
    public class Context:DbContext
    {
        //using repository, Mock to do the unit test
        public DbSet<PeopleModel> People { get; set; }

        public Context()
            : base("UnitTest")
        {

        }

    }
}