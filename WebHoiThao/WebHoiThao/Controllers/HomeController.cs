using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebHoiThao.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/
        public ActionResult Admin_Page()
        {
            return View();
        }
        public ActionResult User_Page()
        {
            return View();
        }
	}
}