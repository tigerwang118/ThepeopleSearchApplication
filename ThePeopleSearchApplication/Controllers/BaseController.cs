using PeopleDAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Text;
using System.Web;
using System.Web.Mvc;
using Castle.Core.Logging;namespace ThePeopleSearchApplication.Controllers
{
    public  abstract class BaseController : Controller
    {

        private ILogger logger = NullLogger.Instance;

        public ILogger Logger
        {
            get
            {
                return this.logger;
            }
            set
            {
                this.logger = value;
            }
        }

        HttpClient client = new HttpClient();
        public HttpResponseMessage rest;
        public readonly ThePeopelSearchApplicationEntities ent = new ThePeopelSearchApplicationEntities();
        protected override void Dispose(bool disposing)
        {
            ent.Dispose();
            base.Dispose(disposing);
        }
   
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            System.Threading.Thread.CurrentThread.CurrentUICulture = System.Threading.Thread.CurrentThread.CurrentCulture;

            base.OnActionExecuting(filterContext);
        }


    }
}
