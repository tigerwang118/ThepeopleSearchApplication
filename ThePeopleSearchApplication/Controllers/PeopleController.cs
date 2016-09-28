using Kendo.Mvc.UI;
using PeopleDAL;
using System;
using System.Collections.Generic;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ThePeopleSearchApplication.Models;

namespace ThePeopleSearchApplication.Controllers
{
    public class PeopleController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult GetPeople([DataSourceRequest] DataSourceRequest request, string searchText)
        {
            try
            {
                IQueryable<PeopleModel> people;
                if (string.IsNullOrEmpty(searchText))
                {
                    people = ent.People
                              .Select (p=> new PeopleModel()
                              {
                                  FirstName = p.FirstName,
                                  LastName = p.LastName,
                                  Interests = p.Interests,
                                  ImageUrl = p.ImageUrl,
                                  Age = DateTime.Now.Year - p.DOB.Value.Year,
                                  Address = p.Address.Street1 + " " + p.Address.City,
                                  Id = SqlFunctions.StringConvert((double)p.PersonID).Trim()
                              }).AsQueryable();
                }
                else
                {
                    people = (from p in ent.People.Where(p => p.FullName.Contains(searchText))
                              select new PeopleModel
                              {
                                  FirstName = p.FirstName,
                                  LastName = p.LastName,
                                  Interests = p.Interests,
                                  ImageUrl = p.ImageUrl,
                                  Age = DateTime.Now.Year - p.DOB.Value.Year,
                                  Address = p.Address.Street1 + " " + p.Address.City,
                                  Id = SqlFunctions.StringConvert((double)p.PersonID).Trim()
                              }).AsQueryable();
                }
                return Json(people, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public ActionResult SavePeople(PeopleModel model)
        {
            bool success = true;
            string message = "";
            try
            {
                var dbPeople = model.Id != null ? ent.People.Find(model.Id) : new Person();
                dbPeople.PersonID = int.Parse(model.Id);
                dbPeople.FirstName = model.FirstName;
                dbPeople.LastName = model.LastName;
                dbPeople.Interests = model.Interests;
                dbPeople.ImageUrl = model.ImageUrl;

                if (model.Id == null)
                {
                    ent.People.Add(dbPeople);
                }
                ent.SaveChanges();
            }
            catch (DbEntityValidationException de)
            {
                success = false;
                message += "-->" + de.Message;
            }
            catch (Exception ex)
            {
                message += "-->" + ex.Message;
                success = false;
            }
            return Json(new { success = success, message = message }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeletePeople(int id)
        {
            bool success = true;
            string message = "";
            try
            {
                var dbPeople = ent.People.Find(id);
                dbPeople.Deleted = true;
                ent.SaveChanges();
            }
            catch (DbEntityValidationException de)
            {
                success = false;
                message += "-->" + de.Message;
            }
            catch (Exception ex)
            {
                message += "-->" + ex.Message;
                success = false;
            }
            return Json(new { success = success, message = message }, JsonRequestBehavior.AllowGet);
        }
    }
}

