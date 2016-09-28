using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThePeopleSearchApplication.Models
{
    public class EFPeopleRepository:IPeopleRepository
    {
        Context con = new Context();
        public IQueryable<PeopleModel> People
        { get { return con.People; } }
        //public PeopleModel Save(PeopleModel,people)
        //{
        //    if(
        //}
    }
}