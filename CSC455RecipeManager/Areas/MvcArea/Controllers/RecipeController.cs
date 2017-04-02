using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CSC455RecipeManager.Areas.MvcArea.Controllers
{
    public class RecipeController : Controller
    {
        // GET: MvcArea/Recipe
        public ActionResult Index()
        {
            return RedirectToAction("Index","Home");
        }

        public ActionResult Recipe()
        {
            return View();
        }
    }
}