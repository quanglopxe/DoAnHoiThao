﻿using System;
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
<<<<<<< HEAD

        public ActionResult Submission_Page()
        {
            return View();
        }
        [Route("Home/Submission/Details")]
        public ActionResult Details()
        {
            return View();
        }
    }
=======
	}
>>>>>>> 13e90980de457b2b317f2eeb540216ceca657d05
}