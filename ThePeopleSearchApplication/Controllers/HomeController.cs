using System;
using System.Collections.Generic;
using System.Data.Entity.SqlServer;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ThePeopleSearchApplication.Models;
namespace ThePeopleSearchApplication.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
            ViewBag.Message = "For test.";

            return View();
        }
        public ActionResult Angular()
        {
            return View();
        }
        public ActionResult AngularJs()
        {
            return View();
        }
        public ActionResult Knockout(PeopleSearchModel model)
        {
            model.PageSize = 10;
                var sortColumns = new List<SelectListItem>()
            {
                new SelectListItem(){ Text = "First Name", Value = "FirstName" },
                new SelectListItem(){ Text = "Last Name", Value = "LastName" },
            };
               model.SortColumns = new SelectList(sortColumns, "Value", "Text", model.SortColumn);
            IEnumerable<PeopleModel> people = (from p in ent.People
                      select new PeopleModel
                      {
                          FirstName = p.FirstName,
                          LastName = p.LastName,
                          Interests = p.Interests,
                          ImageUrl = p.ImageUrl,
                          Age = DateTime.Now.Year - p.DOB.Value.Year,
                          Address = p.Address.Street1 + " " + p.Address.City,
                          Id = SqlFunctions.StringConvert((double)p.PersonID).Trim()
                      }).ToList();
            model.People = people.ToList();
            return View("Knockout", model);
        }
        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public JsonResult GetPeople(string searchText)
        {
            try
            {
                var people = new List<PeopleModel>();
                if (string.IsNullOrEmpty(searchText))
                {
                    people= (from p in ent.People
                            select new PeopleModel
                            {
                                FirstName=p.FirstName,
                                LastName=p.LastName,
                                Interests=p.Interests,
                                ImageUrl=p.ImageUrl,
                                Age=DateTime.Now.Year-p.DOB.Value.Year,
                                Address = p.Address.Street1+" " +p.Address.City,
                                Id = SqlFunctions.StringConvert((double)p.PersonID).Trim()
                            }).ToList();
                }
                else
                {
                    people = (from p in ent.People.Where(p=>p.FullName.Contains(searchText))
                              select new PeopleModel
                              {
                                  FirstName = p.FirstName,
                                  LastName = p.LastName,
                                  Interests = p.Interests,
                                  ImageUrl = p.ImageUrl,
                                  Age = DateTime.Now.Year - p.DOB.Value.Year,
                                  Address = p.Address.Street1 + " " + p.Address.City,
                                  Id = SqlFunctions.StringConvert((double)p.PersonID).Trim()
                              }).ToList();
                }
                return Json(people,JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex);
            }
        }
        public JsonResult GetPeopleKnockout(PeopleSearchModel pm)
        {
            try
            {
               // pm.PageSize = 10;
          
                var sortColumns = new List<SelectListItem>()
            {
                new SelectListItem(){ Text = "First Name", Value = "FirstName" },
                new SelectListItem(){ Text = "Last Name", Value = "LastName" },
            };
               pm.SortColumns = new SelectList(sortColumns, "Value", "Text", pm.SortColumn);
               var displaySizeValues = new List<SelectListItem>(){
                new SelectListItem(){ Text = "All", Value = "" },
                new SelectListItem(){ Text = "10", Value = "10" },
                new SelectListItem(){ Text = "25", Value = "25" },
                new SelectListItem(){ Text = "50", Value = "50" },
                new SelectListItem(){ Text = "100", Value = "100" }
            };
               if (Request.Browser.Browser == "IE" && Request.Browser.MajorVersion <= 8)
               {
                   displaySizeValues = displaySizeValues.Where(x => x.Value != "" && x.Value != "100").ToList();
               }
               pm.DisplaySizeValues = new SelectList(displaySizeValues, "Value", "Text", pm.PageSize);

               //pm.PageSize = 20;
               IEnumerable<PeopleModel> people = new List<PeopleModel>();
                if (string.IsNullOrEmpty(pm.SearchText))
                {
                    people = (from p in ent.People
                              select new PeopleModel
                              {
                                  FirstName = p.FirstName,
                                  LastName = p.LastName,
                                  Interests = p.Interests,
                                  ImageUrl = p.ImageUrl,
                                  Age = DateTime.Now.Year - p.DOB.Value.Year,
                                  Address = p.Address.Street1 + " " + p.Address.City,
                                  Id = SqlFunctions.StringConvert((double)p.PersonID).Trim()
                              }).ToList();
                }
                else
                {
                    people = (from p in ent.People.Where(p => p.FullName.ToLower().Contains(pm.SearchText.ToLower().Trim()))
                              select new PeopleModel
                              {
                                  FirstName = p.FirstName,
                                  LastName = p.LastName,
                                  Interests = p.Interests,
                                  ImageUrl = p.ImageUrl,
                                  Age = DateTime.Now.Year - p.DOB.Value.Year,
                                  Address = p.Address.Street1 + " " + p.Address.City,
                                  Id = SqlFunctions.StringConvert((double)p.PersonID).Trim()
                              }).AsEnumerable<PeopleModel>();
                }
                if(!string.IsNullOrEmpty(pm.SortColumn))
                {
                    var sort = pm.SortColumn.ToLower();
                    var sortOrder=pm.SortOrder.ToLower();
                    switch (sort)
                    {
                        case "firstname":
                            people = sortOrder == "asc" ? people.OrderBy(p => p.FirstName) : people.OrderByDescending(p => p.FirstName);
                            break;
                        case "lastname":
                            people = sortOrder == "asc" ? people.OrderBy(p => p.LastName) : people.OrderByDescending(p => p.LastName);
                            break;
                        default:
                            people = sortOrder == "asc" ? people.OrderBy(p => p.LastName) : people.OrderByDescending(p => p.LastName);
                            break;
                    }
                }
                pm.TotalPeople = people.Count();
                if (pm.PageSize.HasValue)
                {
                    people = people.Skip((pm.PageNumber - 1) * pm.PageSize.Value).Take(pm.PageSize.Value);
                }
                pm.People = people.ToList();              
                return Json(pm, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(ex);
            }
        }
    }
}
