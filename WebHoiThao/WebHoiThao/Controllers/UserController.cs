using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebHoiThao.Models;
using BCryptNet = BCrypt.Net.BCrypt;


namespace WebHoiThao.Controllers
{
    public class UserController : Controller
    {
        QuanLyHoiThaoDataContext db = new QuanLyHoiThaoDataContext();

        public static string HashPassword(string password)
        {                        
            var salt = BCrypt.Net.BCrypt.GenerateSalt();
            var hashedPassword = BCrypt.Net.BCrypt.HashPassword(password, salt);           
            return hashedPassword;
        }        

        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(User user)
        {
            if (user == null)
                return View();
            try
            {
                User nd = db.Users.FirstOrDefault(t => t.username == user.username);
                
                if (nd == null)
                {                     
                    ViewBag.ErrorMessage = "Tên tài khoản không tồn tại!";
                    return View();
                }
                string inputPassword = user.password;
                if (!BCrypt.Net.BCrypt.Verify(inputPassword,nd.password))
                {
                    ViewBag.ErrorMessage = "Mật khẩu không đúng.";
                    return View();
                }
                Session["User"] = nd;
                if (nd != null && nd.role == "Admin")
                {
                    return RedirectToAction("Admin_Page", "Home");
                }
                else
                    return RedirectToAction("User_Page", "Home");
            }
            catch (Exception ex)
            {
                return RedirectToAction("Error", "User", new { error = ex.Message });
            }
        }
        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Register(User user)
        {
            string maND = "0" + String.Format("{0:D4}", db.Users.Count() + 1);

            try
            {
                bool isUsernameExists = db.Users.Any(u => u.username == user.username);
                if (isUsernameExists)
                {
                    ViewBag.Message = "Tên đăng nhập đã được sử dụng, vui lòng chọn tên khác!";
                    return View();
                }
                user.user_id = maND;
                user.password = HashPassword(user.password);
                db.Users.InsertOnSubmit(user);
                db.SubmitChanges();
                return RedirectToAction("Login", "User");
            }
            catch (Exception ex)
            {
                return RedirectToAction("Error", "User", new { error = ex.Message });
            }
        }
        public ActionResult EditProfile()
        {
            User user = (User)Session["User"];
            if (user == null)
            {
                return RedirectToAction("Login", "User");
            }
            return View(user);
        }
        [HttpPost]
        public ActionResult EditProfile(User user)
        {
            try
            {
                User nd = db.Users.FirstOrDefault(t => t.user_id == user.user_id);
                nd.user_id = user.user_id;
                nd.full_name = user.full_name;
                nd.email = user.email;
                nd.affiliation = user.affiliation;
                nd.username = user.username;
                nd.password = user.password;
                Session["User"] = nd;
                db.SubmitChanges();
                return RedirectToAction("User_Page", "Home");
            }
            catch (Exception ex)
            {
                return RedirectToAction("Error", "User", new { error = ex.Message });
            }
        }
        public ActionResult Logout()
        {
            Session["User"] = null;
            return RedirectToAction("Login", "User");
        }
        public ActionResult Error(string error = "")
        {
            ViewBag.ErrorMessage = error;
            return View();
        }

	}
}