using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using ThePeopleSearchApplication;
using ThePeopleSearchApplication.Controllers;
using System.Web.Script.Serialization;

namespace ThePeopleSearchApplication.Tests.Controllers
{
    //using repository, Mock to do the unit test
    [TestClass]
    public class HomeControllerTest
    {
        [TestMethod]
        public void Index()
        {
            // Arrange
            HomeController controller = new HomeController();

            // Act
            ViewResult result = controller.Index() as ViewResult;
            JsonResult jResult=controller.GetPeople("t") as JsonResult;
            var CountSearch = controller.GetPeople("kent") as JsonResult;
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            // Assert
            Assert.AreEqual("For test.", result.ViewBag.Message);
            Assert.IsNotNull(result);
            Assert.IsNotNull(jResult);
        }      
    }
}
