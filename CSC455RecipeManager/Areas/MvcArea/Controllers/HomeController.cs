using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CSC455RecipeManager.Areas.MvcArea.Controllers
{
    public class HomeController : Controller
    {
        // GET: MvcArea/Recipe
        
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Home()
        {
            return RedirectToAction("Index");
        }
    }
}