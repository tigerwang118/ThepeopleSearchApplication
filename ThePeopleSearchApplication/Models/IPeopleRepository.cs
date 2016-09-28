using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ThePeopleSearchApplication.Models
{
    public interface IPeopleRepository
    {
        IQueryable<PeopleModel> People { get; }
    }
}