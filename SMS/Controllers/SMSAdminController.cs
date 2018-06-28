using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SMSBAL;
using SMS.Models;
using SMSEntities.SMSDBEntities;
using System.IO;
using System.Globalization;
using System.Net.Mail;
using System.Data;
using System.Web.Script.Serialization;

namespace SMS.Controllers
{
    public class SMSAdminController : Controller
    {
        SMSManagementModel objSMSModel = new SMSManagementModel();

        #region Login
        public ActionResult Login()
        {
            return View("../SMSAdmin/LoginView");
        }
        [HttpPost]
        public ActionResult Login(UserInfo p_UserInfo)
        {
            UserInfo objUserInfo = null;
            try
            {
                objUserInfo = objSMSModel.IsUserExists(p_UserInfo);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            if (objUserInfo != null)
            {
                //ViewBag.LoginMsg = string.Empty;
                Session["UserName"] = objUserInfo.UserName;
                Session["UserId"] = objUserInfo.UID;
                Session["UserType"] = objUserInfo.UserTypeID;
                Deployement objDeployment = null;
                switch (objUserInfo.UserTypeID)
                {

                    case 1: // Super admin
                        Session["DeploymentId"] = objUserInfo.DeploymentID;
                        SMSEntities.SMSDBEntities.Deployement d = objSMSModel.GetDeploymentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), Convert.ToInt32(Session["DeploymentId"]));
                        Session["DeploymentName"] = d.DeploymentName;
                        Session["DeploymentType"] = d.DeploymentType;
                        return RedirectToAction("Deployment");
                    case 2: // Admin
                        Session["DeploymentId"] = objUserInfo.DeploymentID;
                        SMSEntities.SMSDBEntities.Deployement d1 = objSMSModel.GetDeploymentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), Convert.ToInt32(Session["DeploymentId"]));
                        Session["DeploymentName"] = d1.DeploymentName;

                        Session["DeploymentType"] = d1.DeploymentType;

                        return RedirectToAction("GetVisitorCheckInOut");
                    case 3: // Supervisor.
                    case 4: //  Guard
                        Session["DeploymentId"] = objUserInfo.DeploymentID;
                        SMSEntities.SMSDBEntities.Deployement d2 = objSMSModel.GetDeploymentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), Convert.ToInt32(Session["DeploymentId"]));
                        Session["DeploymentName"] = d2.DeploymentName;
                        Session["DeploymentType"] = d2.DeploymentType;
                        if (Session["DeploymentType"].ToString().ToLower() != "condo")
                        {
                            return RedirectToAction("AddClubVisitorCheckInOut");
                        }
                        else
                        {
                            return RedirectToAction("AddVisitorCheckInOut");
                        }
                    default:
                        return View("../SMSAdmin/LoginView");
                }


            }
            else
            {
                ModelState.AddModelError("", "");
                return View("../SMSAdmin/LoginView");
            }
        }
        public ActionResult Logout()
        {
            Session["UserName"] = null;
            Session["UserType"] = null;
            Session["DeploymentId"] = null;
            Session["Incidents"] = null;
            Session["Occurrences"] = null;
            Session["Visitors"] = null;

            return RedirectToAction("Login");
        }
        #endregion

        #region Deployment

        public ActionResult Deployment()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetDeployements(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty));
        }
        [HttpPost]
        public ActionResult Deployment(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            return View(objSMSModel.GetDeployements(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString.Trim()));
        }
        public ActionResult DeploymentEdit(int id)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            var obj = objSMSModel.GetDeploymentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), id);
            ViewBag.deploymentType = obj.DeploymentType;
            return View(obj);
        }
        [HttpPost]
        public ActionResult DeploymentEdit(Deployement objDeployement)
        {
            List<Deployement> ds = objSMSModel.GetDeployements(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), String.Empty);

            bool isDeploymentExists = false;
            for (int i = 0; i < ds.Count; i++)
            {
                Deployement d = ds[i];
                if (d.DeploymentId != objDeployement.DeploymentId && d.DeploymentName.Equals(objDeployement.DeploymentName))
                    isDeploymentExists = true;
            }

            if (isDeploymentExists == true)
            {
                ModelState.AddModelError("", "Deployment name already exists. Please enter a different name.");
                return View(objSMSModel.GetDeploymentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), objDeployement.DeploymentId));
            }
            else
            {
                int result = objSMSModel.ModifyDeployment(objDeployement);

                if (result == 1)
                {
                    return RedirectToAction("Deployment");
                }
                else
                {
                    ModelState.AddModelError("", "Unable to update the Deployment now. Please try later");
                    return View(objSMSModel.GetDeploymentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), objDeployement.DeploymentId));
                }
            }
        }

        public ActionResult DeleteDeployment(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");

            int result = objSMSModel.RemoveDeployment(ID);
            if (result == 1)
            {
                return RedirectToAction("Deployment");
            }
            else
            {
                ModelState.AddModelError("", "Some problem with the Deployment deletion. Please try later.");
                return RedirectToAction("Deployment");
                //return View(objSMSModel.GetDeploymentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
            }
        }
        public ActionResult DeploymentAdd()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");

            return View(objSMSModel.GetDeploymentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult DeploymentAdd(Deployement objDeployement)
        {
            int result = objSMSModel.AddDeployment(objDeployement);
            if (result == 1)
            {
                return RedirectToAction("Deployment");
            }
            else
            {
                ModelState.AddModelError("", "Same deployment " + objDeployement.DeploymentName + " already exists.");
                return View(objSMSModel.GetDeploymentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }
        }

        #endregion

        #region Users
        public ActionResult CreateUser()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetUserInfo(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult CreateUser(FormCollection frmCol)
        {
            UserInfo uinfo = new UserInfo();
            uinfo.UserName = frmCol["UserName"];
            uinfo.Password = frmCol["Password"];
            uinfo.LoginID = frmCol["LoginID"];
            uinfo.EmailID = frmCol["EmailID"];
            //uinfo.DeploymentID = Convert.ToInt32(frmCol["Deployements"].ToString());
            uinfo.UserTypeID = Convert.ToInt32(frmCol["ddlUserTypes"].ToString());

            if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                uinfo.DeploymentID = Convert.ToInt32(frmCol["Deployements"]);
            else
                uinfo.DeploymentID = Convert.ToInt32(Session["DeploymentId"].ToString());

            int currentUserType = Convert.ToInt32(Session["UserType"].ToString());
            int deploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());
            List<UserViewModel> ds = objSMSModel.GetUsersList(deploymentId, currentUserType, String.Empty);

            bool isUserExists = false;
            for (int i = 0; i < ds.Count; i++)
            {
                UserViewModel d = ds[i];
                if ((!d.UserName.Equals(uinfo.UserName) || !d.EmailID.Equals(uinfo.EmailID)) && d.LoginID.Equals(uinfo.LoginID))
                    isUserExists = true;
            }

            if (isUserExists == true)
            {
                ModelState.AddModelError("", "Login ID '" + uinfo.LoginID + "' already exists. Please try using a new Login Id.");
                return View(objSMSModel.GetUserInfo(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }
            else
            {
                int result = objSMSModel.AddUser(uinfo);
                if (result == 1)
                {
                    return RedirectToAction("UsersList");
                }
                else
                {
                    ModelState.AddModelError("", "Unable to add the user now. Please try after sometime.");
                    return View(objSMSModel.GetUserInfo(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
                }
            }
        }
        public ActionResult UsersList()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            int currentUserType = Convert.ToInt32(Session["UserType"].ToString());
            int deploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());
            return View(objSMSModel.GetUsersList(deploymentId, currentUserType, string.Empty));
        }
        [HttpPost]
        public ActionResult UsersList(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            int currentUserType = Convert.ToInt32(Session["UserType"].ToString());
            int deploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());
            return View(objSMSModel.GetUsersList(deploymentId, currentUserType, searchString.Trim()));
        }
        public ActionResult EditUser(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetUserInfo(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditUser(FormCollection frmCol)
        {
            UserInfo uinfo = new UserInfo();
            uinfo.UserName = frmCol["UserName"];
            uinfo.UID = Convert.ToInt32(frmCol["UID"].ToString());
            uinfo.Password = frmCol["Password"];
            uinfo.LoginID = frmCol["LoginID"];
            uinfo.EmailID = frmCol["EmailID"];
            //uinfo.DeploymentID = Convert.ToInt32(frmCol["ddlDeployements"].ToString());

            if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                uinfo.DeploymentID = Convert.ToInt32(frmCol["ddlDeployements"]);
            else
                uinfo.DeploymentID = Convert.ToInt32(Session["DeploymentId"].ToString());

            uinfo.UserTypeID = Convert.ToInt32(frmCol["ddlUserTypes"].ToString());
            int result = objSMSModel.EditUser(uinfo);
            if (result == 1)
            {
                return RedirectToAction("UsersList");
            }
            else
            {
                ModelState.AddModelError("", "Unable to update the Deployment now. Please try later");
                return View(objSMSModel.GetUserInfo(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), uinfo.UID));
            }
        }

        public ActionResult RemoveUser(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            int result = objSMSModel.RemoveUser(ID);
            if (result == 1)
            {
                return RedirectToAction("UsersList");
            }
            else
            {
                ModelState.AddModelError("", "Some problem with the User deletion. Please try later.");
                return View(objSMSModel.GetDeploymentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
            }
        }
        #endregion

        #region Gates
        public ActionResult GatesList()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetGates(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty));
        }
        [HttpPost]
        public ActionResult GatesList(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            return View(objSMSModel.GetGates(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString.Trim()));
        }
        public ActionResult CreateGate()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetGateByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult CreateGate(FormCollection frmCol)
        {
            Gates objgate = new Gates();
            objgate.GateName = frmCol["GateName"];
            //objgate.DeploymentId = Convert.ToInt32(frmCol["Deployments"]);

            if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                objgate.DeploymentId = Convert.ToInt32(frmCol["Deployments"]);
            else
                objgate.DeploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());


            int result = objSMSModel.AddGate(objgate);
            if (result == 1)
            {
                return RedirectToAction("GatesList");
            }
            else
            {
                ModelState.AddModelError("", "Same gate " + objgate.GateName + " already exists.");
                return View(objSMSModel.GetGateByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }
        }
        public ActionResult EditGate(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetGateByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditGate(FormCollection frmCol)
        {
            Gates objgate = new Gates();
            objgate.GateId = Convert.ToInt32(frmCol["GateId"]);
            objgate.GateName = frmCol["GateName"];
            //objgate.DeploymentId = Convert.ToInt32(frmCol["ddlDeployements"]);

            if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                objgate.DeploymentId = Convert.ToInt32(frmCol["ddlDeployements"]);
            else
                objgate.DeploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());

            List<GatesViewModel> ds = objSMSModel.GetGates(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), String.Empty);

            bool isGateExists = false;
            for (int i = 0; i < ds.Count; i++)
            {
                GatesViewModel d = ds[i];
                if (d.GateId != objgate.GateId && d.GateName.Equals(objgate.GateName))
                    isGateExists = true;
            }

            if (isGateExists == true)
            {
                ModelState.AddModelError("", "Gate name already exists. Please enter a different name.");
                return View(objSMSModel.GetGateByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), objgate.GateId));
            }
            else
            {
                int result = objSMSModel.EditGate(objgate);
                if (result == 1)
                {
                    return RedirectToAction("GatesList");
                }
                else
                {
                    ModelState.AddModelError("", "Unable to update the Gate now. Please try later.");
                    return View(objSMSModel.GetGateByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), objgate.GateId));
                }
            }
        }
        public ActionResult RemoveGate(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            objSMSModel.RemoveGate(ID);
            return RedirectToAction("GatesList");
        }
        #endregion

        #region Keys
        public ActionResult GetKeysList()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetKEYS(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty));
        }
        [HttpPost]
        public ActionResult GetKeysList(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            return View(objSMSModel.GetKEYS(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString.Trim()));
        }
        public ActionResult CreateKey()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetKEYSByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult CreateKey(FormCollection frmCol)
        {
            KEYS objKey = new KEYS();
            objKey.KeyName = frmCol["KeyName"];
            //objKey.DeploymentId = Convert.ToInt32(frmCol["Deployements"]);

            if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                objKey.DeploymentId = Convert.ToInt32(frmCol["Deployements"]);
            else
                objKey.DeploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());

            objKey.Status = frmCol["KeyStatuses"] != null && frmCol["KeyStatuses"] != "" ? Convert.ToInt32(frmCol["KeyStatuses"]) : 0;

            int result = objSMSModel.AddKey(objKey);
            if (result == 1)
            {
                return RedirectToAction("GetKeysList");
            }
            else
            {
                ModelState.AddModelError("", "Same key " + objKey.KeyName + " already exists.");
                return View(objSMSModel.GetKEYSByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }
        }
        public ActionResult EditKey(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetKEYSByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditKey(FormCollection frmCol)
        {
            KEYS objKey = new KEYS();
            objKey.KeyId = Convert.ToInt32(frmCol["KeyId"]);
            objKey.KeyName = frmCol["KeyName"];
            //objKey.DeploymentId = Convert.ToInt32(frmCol["ddlDeployements"]);

            if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                objKey.DeploymentId = Convert.ToInt32(frmCol["ddlDeployements"]);
            else
                objKey.DeploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());


            objKey.Status = frmCol["ddlKeyStatuses"] != null && frmCol["ddlKeyStatuses"] != "" ? Convert.ToInt32(frmCol["ddlKeyStatuses"]) : 0;

            int result = objSMSModel.EditKey(objKey);

            if (result == 1)
            {
                return RedirectToAction("GetKeysList");
            }
            else
            {
                ModelState.AddModelError("", "Unable to update the Key now. Please try later.");
                return View(objSMSModel.GetGateByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), objKey.KeyId));
            }
        }
        public ActionResult RemoveKey(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            int result = objSMSModel.RemoveKey(ID);
            return RedirectToAction("GetKeysList");
        }
        #endregion

        #region Location
        public ActionResult GetLocationsList()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetLocation(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty));
        }
        [HttpPost]
        public ActionResult GetLocationsList(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            return View(objSMSModel.GetLocation(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString.Trim()));
        }
        public ActionResult CreateLocation()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetLocationByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult CreateLocation(FormCollection frmCol)
        {
            Location objLocation = new Location();

            if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                objLocation.DeploymentId = Convert.ToInt32(frmCol["Deployements"]);
            else
                objLocation.DeploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());

            objLocation.LocationName = frmCol["LocationName"];
            int result = objSMSModel.AddLocation(objLocation);
            if (result == 1)
            {
                return RedirectToAction("GetLocationsList");
            }
            else
            {
                ModelState.AddModelError("", "Same Location " + objLocation.LocationName + " already exists.");
                return View(objSMSModel.GetLocationByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }
        }
        public ActionResult EditLocation(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetLocationByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditLocation(FormCollection frmCol)
        {
            Location objLocation = new Location();
            objLocation.LocationId = Convert.ToInt32(frmCol["LocationId"]);
            if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                objLocation.DeploymentId = Convert.ToInt32(frmCol["ddlDeployements"]);
            else
                objLocation.DeploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());

            objLocation.LocationName = frmCol["LocationName"];

            int result = objSMSModel.EditLocation(objLocation);

            if (result == 1)
            {
                return RedirectToAction("GetLocationsList");
            }
            else
            {
                ModelState.AddModelError("", "Unable to update the Location now. Please try later.");
                return View(objSMSModel.GetGateByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), objLocation.LocationId));
            }

        }
        public ActionResult RemoveLocation(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            int result = objSMSModel.RemoveLocation(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID);
            return RedirectToAction("GetLocationsList");
        }
        #endregion

        #region Company
        public ActionResult GetCompaniesList()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetCompanies(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty));
        }
        [HttpPost]
        public ActionResult GetCompaniesList(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            return View(objSMSModel.GetCompanies(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString.Trim()));
        }
        public ActionResult AddCompany()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetCompanyByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult AddCompany(FormCollection frmCol)
        {
            Companies objCompany = new Companies();
            objCompany.Address = frmCol["Address"];
            objCompany.ContactNumber = frmCol["ContactNumber"];
            objCompany.CompanyName = frmCol["CompanyName"];

            if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                objCompany.DeploymentId = Convert.ToInt32(frmCol["Deployments"]);
            else
                objCompany.DeploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());

            int result = objSMSModel.AddCompany(objCompany);
            if (result == 1)
            {
                return RedirectToAction("GetCompaniesList");
            }
            else
            {
                ModelState.AddModelError("", "Same company " + objCompany.CompanyName + " already exists.");
                return View(objSMSModel.GetCompanyByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }
        }
        public ActionResult EditCompany(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetCompanyByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditCompany(FormCollection frmCol)
        {
            Companies objCompany = new Companies();
            objCompany.CompanyId = Convert.ToInt32(frmCol["CompanyId"]);
            objCompany.Address = frmCol["Address"];
            objCompany.ContactNumber = frmCol["ContactNumber"];
            objCompany.CompanyName = frmCol["CompanyName"];

            if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                objCompany.DeploymentId = Convert.ToInt32(frmCol["ddlDeployments"]);
            else
                objCompany.DeploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());

            int result = objSMSModel.EditCompany(objCompany);

            if (result == 1)
            {
                return RedirectToAction("GetCompaniesList");
            }
            else
            {
                ModelState.AddModelError("", "Unable to update the Company now. Please try later.");
                return View(objSMSModel.GetGateByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), objCompany.CompanyId));
            }
        }
        public ActionResult DeleteCompany(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            int result = objSMSModel.DeleteCompany(ID);
            return RedirectToAction("GetCompaniesList");
        }
        #endregion

        #region Visitors
        public ActionResult GetVisitorsList()
        {
            return View(objSMSModel.GetVisitors(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty));
        }
        [HttpPost]
        public ActionResult GetVisitorsList(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            return View(objSMSModel.GetVisitors(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString));
        }
        public ActionResult CreateVisitor()
        {
            return View(objSMSModel.GetVisitorsByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult CreateVisitor(FormCollection frmCol)
        {
            Visitors objVisitor = new Visitors();
            objVisitor.FirstName = frmCol["FirstName"];
            objVisitor.MiddleName = frmCol["MiddleName"];
            objVisitor.LastName = frmCol["LastName"];
            objVisitor.Address = frmCol["Address"];
            objVisitor.CompanyName = frmCol["CompanyName"];
            objVisitor.ContactNumber = frmCol["ContactNumber"];
            objVisitor.DeploymentId = Convert.ToInt32(frmCol["Deployements"]);
            objVisitor.NRIC = frmCol["NRIC"];

            int result = objSMSModel.AddVisitor(objVisitor);

            if (result == 1)
            {
                return RedirectToAction("GetVisitorsList");
            }
            else
            {
                ModelState.AddModelError("", "Unable to update the Visitor now. Please try later.");
                return View(objSMSModel.GetGateByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), objVisitor.VisitorId));
            }

        }
        public ActionResult EditVisitor(int ID)
        {
            return View(objSMSModel.GetVisitorsByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditVisitor(FormCollection frmCol)
        {
            Visitors objVisitor = new Visitors();
            objVisitor.VisitorId = Convert.ToInt32(frmCol["VisitorId"]);
            objVisitor.FirstName = frmCol["FirstName"];
            objVisitor.MiddleName = frmCol["MiddleName"];
            objVisitor.LastName = frmCol["LastName"];
            objVisitor.Address = frmCol["Address"];
            objVisitor.CompanyName = frmCol["CompanyName"];
            objVisitor.ContactNumber = frmCol["ContactNumber"];
            objVisitor.DeploymentId = Convert.ToInt32(frmCol["Deployements"]);
            objVisitor.NRIC = frmCol["NRIC"];
            int result = objSMSModel.EditVisitor(objVisitor);

            if (result == 1)
            {
                return RedirectToAction("GetVisitorsList");
            }
            else
            {
                ModelState.AddModelError("", "Unable to update the Visitor now. Please try later.");
                return View(objSMSModel.GetGateByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), objVisitor.VisitorId));
            }
        }
        public ActionResult RemoveVisitor(int ID)
        {
            int result = objSMSModel.RemoveVisitor(ID);
            return RedirectToAction("GetVisitorsList");
        }
        #endregion

        #region Passes
        public ActionResult GetPassesViewModel()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetPasses(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty));
        }
        [HttpPost]
        public ActionResult GetPassesViewModel(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            return View(objSMSModel.GetPasses(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString.Trim()));
        }
        public ActionResult CreatePass()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetPassByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult CreatePass(FormCollection frmCol)
        {
            Passes objPass = new Passes();
            //objPass.DeploymentId = Convert.ToInt32(frmCol["Deployments"]);

            if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                objPass.DeploymentId = Convert.ToInt32(frmCol["Deployments"]);
            else
                objPass.DeploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());

            objPass.PassName = frmCol["PassName"];
            objPass.PassStatus = frmCol["PassStatuses"];
            objPass.VisitortypeId = Convert.ToInt32(frmCol["VisitorTypesCol"]);
            int result = objSMSModel.AddPass(objPass);
            if (result == 1)
            {
                return RedirectToAction("GetPassesViewModel");
            }
            else
            {
                ModelState.AddModelError("", "Same pass " + objPass.PassName + " already exists.");
                return View(objSMSModel.GetPassByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }
        }
        public ActionResult EditPass(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetPassByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditPass(FormCollection frmCol)
        {
            Passes objPass = new Passes();
            objPass.PassId = Convert.ToInt32(frmCol["PassId"]);
            //objPass.DeploymentId = Convert.ToInt32(frmCol["ddlDeployments"]);

            if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                objPass.DeploymentId = Convert.ToInt32(frmCol["ddlDeployments"]);
            else
                objPass.DeploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());

            objPass.PassName = frmCol["PassName"];
            objPass.PassStatus = frmCol["ddlPassStatus"];
            objPass.VisitortypeId = Convert.ToInt32(frmCol["ddlVisitorTypes"]);

            int result = objSMSModel.EditPass(objPass);
            if (result == 1)
            {
                return RedirectToAction("GetPassesViewModel");
            }
            else
            {
                ModelState.AddModelError("", "Unable to update the pass now. Please try later.");
                return View(objSMSModel.GetPassByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), objPass.PassId));
            }
        }
        public ActionResult RemovePass(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            int result = objSMSModel.RemovePass(ID);
            return RedirectToAction("GetPassesViewModel");
        }
        #endregion

        #region UserTypes
        public ActionResult UserTypesList()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View();
        }
        public ActionResult CreateUserType()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View();
        }
        [HttpPost]
        public ActionResult CreateUserType(UserTypes p_UserType)
        {
            int result = objSMSModel.AddUserType(p_UserType);
            if (result == 1)
            {
                ViewBag.ErrorMessage = string.Empty;
                return View("../SMSAdmin/UserTypesList", objSMSModel.GetUserTypes(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString())));
            }
            else
            {
                ModelState.AddModelError("", "Usertype already exists");
                return View("../SMSAdmin/CreateUserType", objSMSModel.GetUserTypes(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString())));
            }
        }
        public ActionResult EditUserType(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetUserTypeByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditUserType(UserTypes p_UserType)
        {
            int result = objSMSModel.ModifyUserType(p_UserType);
            if (result == 1)
            {
                ViewBag.ErrorMessage = string.Empty;
                return View("../SMSAdmin/UserTypesList", objSMSModel.GetUserTypes(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString())));
            }
            else
            {
                ModelState.AddModelError("", "Error occured while modifying user type");
                return View("../SMSAdmin/EditUserType", objSMSModel.GetUserTypeByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), p_UserType.UserTypeID));
            }
        }

        #endregion

        #region Visitor Types
        public ActionResult GetVisitorTypes()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetVisitorTypes(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty));
        }
        [HttpPost]
        public ActionResult GetVisitorTypes(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            return View(objSMSModel.GetVisitorTypes(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString.Trim()));
        }
        public ActionResult AddVisitorType()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetVisitorTypeByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult AddVisitorType(VisitorTypes p_VisitorTypes)
        {
            int result = objSMSModel.AddVisitorType(p_VisitorTypes);
            if (result == 1)
            {
                return RedirectToAction("GetVisitorTypes");
            }
            else
            {
                ModelState.AddModelError("", "Visitor type " + p_VisitorTypes.VisitorTypeDescription + " already exists.");
                return View(objSMSModel.GetVisitorTypeByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }
        }
        public ActionResult EditVisitorType(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetVisitorTypeByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditVisitorType(VisitorTypes p_VisitorTypes)
        {
            int result = objSMSModel.EditVisitorType(p_VisitorTypes);
            if (result == 1)
            {
                return RedirectToAction("GetVisitorTypes");
            }
            else
            {
                ModelState.AddModelError("", "Visitor type " + p_VisitorTypes.VisitorTypeDescription + " already exists.");
                return View(objSMSModel.GetVisitorTypeByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), p_VisitorTypes.VisitortypeId));
            }
        }
        public ActionResult DeleteVisitorType(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            int result = objSMSModel.RemoveVisitorType(ID);
            return RedirectToAction("GetVisitorTypes");
        }
        #endregion

        #region KeyStatuses
        public ActionResult GetKeyStatuses()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetKeyStatuses(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty));
        }
        [HttpPost]
        public ActionResult GetKeyStatuses(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            return View(objSMSModel.GetKeyStatuses(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString.Trim()));
        }
        public ActionResult AddKeyStatus()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetKeyStatusByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult AddKeyStatus(KeyStatuses p_KeyStatus)
        {
            try
            {
                int result = objSMSModel.AddKeyStatus(p_KeyStatus);
                if (result == 1)
                {
                    return RedirectToAction("GetKeyStatuses");
                }
                else
                {
                    ModelState.AddModelError("", "Same KeyStatus " + p_KeyStatus.StatusType + " already exists.");
                    return View(objSMSModel.GetKeyStatusByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Error occured while creating Key Status");
                return View();
            }

        }
        public ActionResult EditKeyStatus(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetKeyStatusByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditKeyStatus(KeyStatuses p_KeyStatus)
        {
            int result = objSMSModel.EditKeyStatus(p_KeyStatus);
            if (result == 1)
            {
                return RedirectToAction("GetKeyStatuses");
            }
            else
            {
                ModelState.AddModelError("", "Unable to update the Key status now. Please try again later.");
                return View(objSMSModel.GetKeyStatusByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), p_KeyStatus.StatusID));
            }
        }
        public ActionResult RemoveKeyStatus(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            int result = objSMSModel.RemoveKeyStatus(ID);
            return RedirectToAction("GetKeyStatuses");
        }
        #endregion

        #region LostAndFound
        public ActionResult GetLostAndFound()
        {
            return View(objSMSModel.GetLostAndFound(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty));
        }
        [HttpPost]
        public ActionResult GetLostAndFound(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            return View(objSMSModel.GetLostAndFound(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString.Trim()));
        }
        public ActionResult AddLostAndFound()
        {
            return View(objSMSModel.GetLostAndFoundByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult AddLostAndFound(FormCollection frmCol)
        {
            try
            {

                LostAndFound p_LostAndFound = new LostAndFound();
                p_LostAndFound.nameofperson = frmCol["nameofperson"];
                p_LostAndFound.nric = frmCol["nric"];
                string reportedDate = frmCol["reporteddate"]; //frmCol["date_reported_Month"] + "/" + frmCol["date_reported_Day"] + "/" + frmCol["date_reported_Year"];
                p_LostAndFound.reporteddate = Convert.ToDateTime(reportedDate);
                p_LostAndFound.remarks = frmCol["remarks"];

                if (Session["DeploymentId"] != null && Session["DeploymentId"].ToString() != "")
                    p_LostAndFound.deploymentid = Convert.ToInt32(Session["DeploymentId"]);

                int result = objSMSModel.AddLostAndFound(p_LostAndFound);
                if (result == 1)
                {
                    return RedirectToAction("GetLostAndFound");
                }
                else
                {
                    ModelState.AddModelError("", "Same Lost And Found already exists");
                    return View(objSMSModel.GetLostAndFoundByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Error occured while creating Lost And Found");
                return View();
            }

        }
        public ActionResult EditLostAndFound(int ID)
        {
            return View(objSMSModel.GetLostAndFoundByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditLostAndFound(FormCollection frmCol)
        {
            try
            {
                LostAndFound p_LostAndFound = new LostAndFound();
                p_LostAndFound.lostandfoundreportid = Convert.ToInt32(frmCol["lostandfoundreportid"]);
                p_LostAndFound.nameofperson = frmCol["nameofperson"];
                p_LostAndFound.nric = frmCol["nric"];
                string reportedDate = frmCol["reporteddate"]; //frmCol["date_reported_Month"] + "/" + frmCol["date_reported_Day"] + "/" + frmCol["date_reported_Year"];
                p_LostAndFound.reporteddate = Convert.ToDateTime(reportedDate);
                p_LostAndFound.remarks = frmCol["remarks"];

                if (Session["DeploymentId"] != null && Session["DeploymentId"].ToString() != "")
                    p_LostAndFound.deploymentid = Convert.ToInt32(Session["DeploymentId"]);

                int result = objSMSModel.EditLostAndFound(p_LostAndFound);
                if (result == 1)
                {
                    return RedirectToAction("GetLostAndFound");
                }
                else
                {
                    ModelState.AddModelError("", "Unable to update Lost and found. Please try again later.");
                    return View(objSMSModel.GetLostAndFoundByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Error occured while creating Lost And Found");
                return View();
            }
        }
        public ActionResult RemoveLostAndFound(int ID)
        {
            int result = objSMSModel.RemoveLostAndFound(ID);
            return RedirectToAction("GetLostAndFound");
        }
        #endregion

        #region Incidents
        public ActionResult GetIncidents()
        {
            InitializeDateFilters();
            Session["SelectedFilter"] = "Incidents";
            Session["SnapshotPath"] = null;
            List<Incidents> lstOcc = objSMSModel.GetIncidents(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty);
            lstOcc = objSMSModel.GetIncidentsByFilters(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), Convert.ToInt16(Session["StartDay"]), Convert.ToInt16(Session["StartMonth"]), Convert.ToInt16(Session["StartYear"]), Convert.ToInt16(Session["EndDay"]), Convert.ToInt16(Session["EndMonth"]), Convert.ToInt16(Session["EndYear"]));
            Session["Incidents"] = lstOcc;
            return View(lstOcc);
        }

        [HttpPost]
        public ActionResult GetIncidents(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            List<Incidents> lstOcc = objSMSModel.GetIncidents(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), String.Empty);

            if (searchString != null && searchString.Trim() != "")
            {
                return View(objSMSModel.GetIncidents(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString.Trim()));
            }
            else
            {
                if (frmCol["button"] != null)
                {
                    string clickedButton = frmCol["button"].ToString();

                    switch (clickedButton)
                    {
                        case "Download":
                            DataTable dtr = DownloadData("Incidents");
                            lstOcc = (List<Incidents>)Session["Incidents"];
                            break;
                        case "Go":
                            DataTable dt1 = new DataTable();
                            int startdate = Convert.ToInt32(frmCol["startdate"]);
                            int startmonth = Convert.ToInt32(frmCol["startmonth"]);
                            int startyear = Convert.ToInt32(frmCol["startyear"]);

                            int enddate = Convert.ToInt32(frmCol["enddate"]);
                            int endmonth = Convert.ToInt32(frmCol["endmonth"]);
                            int endyear = Convert.ToInt32(frmCol["endyear"]);

                            DateTime startDate = new DateTime(startyear, startmonth, startdate);
                            DateTime endDate = new DateTime(endyear, endmonth, enddate);

                            lstOcc = objSMSModel.GetIncidentsByFilters(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), startdate, startmonth, startyear, enddate, endmonth, endyear);
                            Session["Occurrences"] = lstOcc;

                            Session["SelectedFilter"] = "Incidents : " + startDate.ToShortDateString() + " to " + endDate.ToShortDateString();

                            //string sMonth = "";
                            //string eMonth = "";
                            //sMonth = startmonth, sMonth);
                            //eMonth = GetMonth(endmonth, eMonth);

                            Session["StartDay"] = startdate;
                            Session["StartMonth"] = startmonth;
                            Session["StartYear"] = startyear;
                            Session["EndDay"] = enddate;
                            Session["EndMonth"] = endmonth;
                            Session["EndYear"] = endyear;

                            break;
                        default:
                            lstOcc = objSMSModel.GetIncidents(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), String.Empty);
                            break;
                    }
                }

                return View(lstOcc);
            }
        }
        public ActionResult AddIncident()
        {
            return View(objSMSModel.GetIncidentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult AddIncident(FormCollection frmCol)
        {
            try
            {
                Incidents p_Incidents = new Incidents();
                p_Incidents.briefdescription = frmCol["briefdescription"];

                int hours = 0, minutes = 0;

                if (frmCol["incidentHour"] != null)
                    hours = Convert.ToInt32(frmCol["incidentHour"]);
                if (frmCol["incidentMin"] != null)
                    minutes = Convert.ToInt32(frmCol["incidentMin"]);

                string incidentDate = frmCol["date_reported_Day"] + "/" + frmCol["date_reported_Month"] + "/" + frmCol["date_reported_Year"];
                DateTime dt = DateTime.Parse(incidentDate);
                p_Incidents.dateofincident = dt.AddHours(hours).AddMinutes(minutes);
                p_Incidents.locationid = Convert.ToInt32(frmCol["ddlLocations"]);
                p_Incidents.natureofincident = frmCol["natureofincident"];
                p_Incidents.particularsofpersons = frmCol["particularsofpersons"];
                p_Incidents.remarksandactionstaken = frmCol["remarksandactionstaken"];
                p_Incidents.reportdate = Convert.ToDateTime(frmCol["reportdate"]);

                if (Session["DeploymentId"] != null && Session["DeploymentId"].ToString() != "")
                    p_Incidents.deploymentid = Convert.ToInt32(Session["DeploymentId"]);

                LocatonViewModel l = objSMSModel.GetLocationByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), p_Incidents.locationid);
                p_Incidents.LocationName = l.LocationName;

                string incidentPath = "";
                if (Session["SnapshotPath"] != null)
                {
                    incidentPath = Session["SnapshotPath"].ToString();
                    Session["SnapshotPath"] = null;
                }
                else
                {
                    if (p_Incidents.snapshotpath == null || p_Incidents.snapshotpath.Equals("")) // Nothing selected // Add scenario
                    {
                        incidentPath = "~/Content/images/incident.jpg";//Dummy path
                    }
                    else
                    {
                        incidentPath = p_Incidents.snapshotpath;
                    }
                }

                p_Incidents.snapshotpath = incidentPath;

                int result = objSMSModel.AddIncident(p_Incidents);
                if (result == 1)
                {
                    // TODO: Send out an email to administrator or somebody.
                    List<UserViewModel> lst = objSMSModel.GetUsersByDeploymentID(Convert.ToInt32(Session["DeploymentId"]));

                    UserViewModel u = new UserViewModel();
                    foreach (UserViewModel item in lst)
                    {
                        if (item.UserTypeID == 2)
                            u = item;
                    }

                    SendEmail(u, p_Incidents);
                    Session["SnapshotPath"] = null;
                    return RedirectToAction("GetIncidents");
                }
                else
                {
                    ModelState.AddModelError("", "Unable to add the incident now. Please contact Administrator.");
                    return View(objSMSModel.GetIncidentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Error occured while creating Incident.");
                return View(objSMSModel.GetIncidentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }

        }

        private static void SendEmail(UserViewModel u, Incidents i)
        {
            try
            {
                MailMessage mailMessage = new MailMessage();
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                smtpClient.EnableSsl = true;
                smtpClient.Credentials = new System.Net.NetworkCredential("organizerwork@gmail.com", "myorganizer"); // User id and password.
                mailMessage.From = new MailAddress("organizerwork@gmail.com");
                mailMessage.To.Add(new MailAddress("organizerwork@gmail.com"));
                mailMessage.To.Add(new MailAddress(u.EmailID));
                mailMessage.Subject = "Incident occurred";
                mailMessage.Body = "Dear admin, \n\nPlease find the incident details : " + i.briefdescription + "\n location : " + i.LocationName + "\n Incident date : " + i.dateofincident + "\n Nature of incident : " + i.natureofincident;
                smtpClient.Send(mailMessage);
            }
            catch (Exception exe)
            {
            }
        }

        public ActionResult EditIncident(int ID)
        {
            return View(objSMSModel.GetIncidentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditIncident(FormCollection frmCol)
        {
            try
            {
                Incidents p_Incidents = new Incidents();
                p_Incidents.incidentid = Convert.ToInt32(frmCol["incidentid"]);
                p_Incidents.briefdescription = frmCol["briefdescription"];
                string incidentDate = frmCol["date_reported_Month"] + "/" + frmCol["date_reported_Day"] + "/" + frmCol["date_reported_Year"];
                string tempDt = frmCol["dateofincident"];
                DateTime dtEdit = new DateTime();
                try
                {
                    dtEdit = DateTime.Parse(tempDt);
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "Please enter a valid date.");
                    return View(objSMSModel.GetIncidentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), p_Incidents.incidentid));
                }

                p_Incidents.dateofincident = dtEdit;
                p_Incidents.locationid = Convert.ToInt32(frmCol["ddlLocations"]);
                p_Incidents.natureofincident = frmCol["natureofincident"];
                p_Incidents.particularsofpersons = frmCol["particularsofpersons"];
                p_Incidents.remarksandactionstaken = frmCol["remarksandactionstaken"];
                p_Incidents.reportdate = Convert.ToDateTime(frmCol["reportdate"]);

                if (Session["DeploymentId"] != null && Session["DeploymentId"].ToString() != "")
                    p_Incidents.deploymentid = Convert.ToInt32(Session["DeploymentId"]);

                // If there exists some session for Snapshot path, then the path needs to be updated in the database.

                if (Session["SnapshotPath"] != null)
                {
                    p_Incidents.snapshotpath = Session["SnapshotPath"].ToString();
                }
                //else
                //{
                //    incidentPath = p_Incidents.snapshotpath;
                //}

                //p_Incidents.snapshotpath = incidentPath;

                int result = objSMSModel.EditIncident(p_Incidents);
                if (result == 1)
                {
                    return RedirectToAction("GetIncidents");
                }
                else
                {
                    ModelState.AddModelError("", "Unable to update the incident now. Please contact Administrator.");
                    return View(objSMSModel.GetIncidentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), p_Incidents.incidentid));
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "There is some problem with the database. Please contact Administrator.");
                return View(objSMSModel.GetIncidentByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), Convert.ToInt32(frmCol["incidentid"])));
            }
        }
        public ActionResult RemoveIncident(int ID)
        {
            int result = objSMSModel.RemoveIncidents(ID);
            return RedirectToAction("GetIncidents");
        }
        #endregion

        #region EventsMaster
        public ActionResult GetEventsMaster()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            return View(objSMSModel.GetEventMaster(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty));
        }
        [HttpPost]
        public ActionResult GetEventsMaster(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            return View(objSMSModel.GetEventMaster(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString));
        }
        public ActionResult AddEventsMaster()
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            ViewBag.Currentyear = DateTime.Now.DayOfYear;
            ViewBag.currentMonth = DateTime.Now.Month;
            ViewBag.Currentdate = DateTime.Now.Date;

            return View(objSMSModel.GetEventMasterByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult AddEventsMaster(FormCollection frmCol)
        {
            EventMaster objEventMaster = new EventMaster();
            try
            {
                // objEventMaster.eventid = Convert.ToInt32(frmCol["eventid"]);
                objEventMaster.locationid = Convert.ToInt32(frmCol["ddlLocations"]);

                try
                {
                    objEventMaster.locationid = Convert.ToInt32(frmCol["ddlLocations"]);
                }
                catch (Exception esx)
                {
                    objEventMaster.locationid = 0;
                }

                int starthours = 0, startminutes = 0, endhours = 0, endminutes = 0;

                if (frmCol["startincidentHour"] != null)
                    starthours = Convert.ToInt32(frmCol["startincidentHour"]);
                if (frmCol["startincidentMin"] != null)
                    startminutes = Convert.ToInt32(frmCol["startincidentMin"]);
                if (frmCol["endincidentHour"] != null)
                    endhours = Convert.ToInt32(frmCol["endincidentHour"]);
                if (frmCol["startincidentMin"] != null)
                    endminutes = Convert.ToInt32(frmCol["endincidentMin"]);

                // to populate the drop downs.
                EventMaster e = objSMSModel.GetEventMasterByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0);

                string sDate = frmCol["event_start_Day"] + "/" + frmCol["event_start_Month"] + "/" + frmCol["event_start_Year"];
                DateTime dtStart = DateTime.Parse(sDate);
                objEventMaster.startdate = dtStart.AddHours(starthours).AddMinutes(startminutes);

                string eDate = frmCol["event_end_Day"] + "/" + frmCol["event_end_Month"] + "/" + frmCol["event_end_Year"];
                DateTime dtEnd = DateTime.Parse(eDate);
                objEventMaster.enddate = dtEnd.AddHours(endhours).AddMinutes(endminutes);

                objEventMaster.eventname = frmCol["eventname"];
                objEventMaster.notes = frmCol["notes"];
                objEventMaster.numberofguards = Convert.ToInt32(frmCol["numberofguards"]);
                objEventMaster.specialdutyforguard = frmCol["specialdutyforguard"];
                objEventMaster.optionalguestlist = frmCol["optionalguestlist"];
                objEventMaster.personinchargecontactnumber = frmCol["personinchargecontactnumber"];
                objEventMaster.personinchargename = frmCol["personinchargename"];
                objEventMaster.personinchargenric = frmCol["personinchargenric"];
                //objEventMaster.DeploymentId = Convert.ToInt32((frmCol["DeploymentList"].ToString()));

                if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                    objEventMaster.DeploymentId = Convert.ToInt32(frmCol["DeploymentList"]);
                else
                    objEventMaster.DeploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());

                objEventMaster.Remarks = frmCol["Remarks"].ToString();

                Session["EventDeploymentId"] = objEventMaster.DeploymentId;

                objEventMaster.LocationsList = e.LocationsList;
                objEventMaster.DeploymentList = e.DeploymentList;

                if (objEventMaster.locationid == 0 || objEventMaster.eventname == "" || objEventMaster.DeploymentId == 0 || objEventMaster.personinchargename == ""
                    || objEventMaster.personinchargecontactnumber == "")
                {
                    ModelState.AddModelError("", "Please enter all the mandatory fields.");
                    return View(objEventMaster);
                }
                else
                {
                    // Validations
                    if (objEventMaster.startdate >= objEventMaster.enddate)
                    {
                        ModelState.AddModelError("", "Start date-time cannot be greater than end date-time.");
                        return View(objEventMaster);
                    }

                    if (objEventMaster.startdate <= DateTime.Now)
                    {
                        ModelState.AddModelError("", "You cannot create an event with the specified start/end time.");
                        return View(objEventMaster);
                    }

                    int result = objSMSModel.AddEventMaster(objEventMaster);
                    if (result == 1)
                    {
                        return RedirectToAction("GetEventsMaster");
                    }
                    else
                    {
                        ModelState.AddModelError("", "Unable to update the event now. Please contact Administrator.");
                        return View(objSMSModel.GetEventMasterByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
                    }
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Error occured while creating Event Master");
                return View(objSMSModel.GetEventMasterByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }
        }
        public ActionResult EditEventsMaster(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            var res = objSMSModel.GetEventMasterByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID);
            ViewBag.starYear = res.startdate.Year;
            ViewBag.startMonth = res.startdate.Month;
            ViewBag.startday = res.startdate.Day;
            ViewBag.startHour = res.startdate.Hour;
            ViewBag.startMinute = res.startdate.Minute;

            ViewBag.endYear = res.enddate.Year;
            ViewBag.endMonth = res.enddate.Month;
            ViewBag.endday = res.enddate.Day;
            ViewBag.endHour = res.enddate.Hour;
            ViewBag.endMinute = res.enddate.Minute;
            return View(res);
        }
        [HttpPost]
        public ActionResult EditEventsMaster(FormCollection frmCol)
        {
            EventMaster objEventMaster = new EventMaster();

            try
            {
                objEventMaster.eventid = Convert.ToInt32(frmCol["eventid"]);
                try
                {
                    objEventMaster.locationid = Convert.ToInt32(frmCol["ddlLocations"]);
                }
                catch (Exception esx)
                {
                    objEventMaster.locationid = 0;
                }


                // to populate the drop downs.
                EventMaster e = objSMSModel.GetEventMasterByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), objEventMaster.eventid);

                int starthours = 0, startminutes = 0, endhours = 0, endminutes = 0;

                if (frmCol["startincidentHour"] != null)
                    starthours = Convert.ToInt32(frmCol["startincidentHour"]);
                if (frmCol["startincidentMin"] != null)
                    startminutes = Convert.ToInt32(frmCol["startincidentMin"]);
                if (frmCol["endincidentHour"] != null)
                    endhours = Convert.ToInt32(frmCol["endincidentHour"]);
                if (frmCol["startincidentMin"] != null)
                    endminutes = Convert.ToInt32(frmCol["endincidentMin"]);

                string sDate = frmCol["event_start_Day"] + "/" + frmCol["event_start_Month"] + "/" + frmCol["event_start_Year"];
                DateTime dtStart = DateTime.Parse(sDate);
                objEventMaster.startdate = dtStart.AddHours(starthours).AddMinutes(startminutes);

                string eDate = frmCol["event_end_Day"] + "/" + frmCol["event_end_Month"] + "/" + frmCol["event_end_Year"];
                DateTime dtEnd = DateTime.Parse(eDate);
                objEventMaster.enddate = dtEnd.AddHours(endhours).AddMinutes(endminutes);
                objEventMaster.eventname = frmCol["eventname"];
                objEventMaster.notes = frmCol["notes"];
                objEventMaster.numberofguards = Convert.ToInt32(frmCol["numberofguards"]);
                objEventMaster.specialdutyforguard = frmCol["specialdutyforguard"];
                objEventMaster.optionalguestlist = frmCol["optionalguestlist"];
                objEventMaster.personinchargecontactnumber = frmCol["personinchargecontactnumber"];
                objEventMaster.personinchargename = frmCol["personinchargename"];
                objEventMaster.personinchargenric = frmCol["personinchargenric"];
                //objEventMaster.DeploymentId = Convert.ToInt32((frmCol["ddlDeployments"].ToString()));

                if (Convert.ToInt32(Session["UserType"].ToString()) == 1)
                    objEventMaster.DeploymentId = Convert.ToInt32(frmCol["ddlDeployments"]);
                else
                    objEventMaster.DeploymentId = Convert.ToInt32(Session["DeploymentId"].ToString());

                objEventMaster.Remarks = frmCol["Remarks"].ToString();
                objEventMaster.LocationsList = e.LocationsList;
                objEventMaster.DeploymentList = e.DeploymentList;

                if (objEventMaster.eventid == 0 || objEventMaster.locationid == 0 || objEventMaster.eventname == "" || objEventMaster.DeploymentId == 0 || objEventMaster.personinchargename == ""
                    || objEventMaster.personinchargecontactnumber == "")
                {
                    objEventMaster.startdate = e.startdate;
                    objEventMaster.enddate = e.enddate;

                    ModelState.AddModelError("", "Please enter all the mandatory fields.");
                    return View(objEventMaster);
                }
                else
                {
                    int result = objSMSModel.EditEventMaster(objEventMaster);

                    if (result == 1)
                    {
                        return RedirectToAction("GetEventsMaster");
                    }
                    else
                    {
                        ModelState.AddModelError("", "Unable to update the event now. Please contact Administrator.");
                        return View(objEventMaster);
                    }
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Unable to update the event now. Please contact Administrator.");
                return View(objEventMaster);
            }

        }
        public ActionResult RemoveEventsMaster(int ID)
        {
            if (Session["UserType"] == null || (Session["UserType"].ToString().Equals("4"))) // Should not allow guard to access this page.
                return View("../SMSAdmin/LoginView");
            int result = objSMSModel.RemoveEventMaster(ID);
            return RedirectToAction("GetEventsMaster");
        }
        #endregion

        #region VisitorCheckInOut
        public ActionResult GetVisitorCheckInOut()
        {
            InitializeDateFilters();
            Session["SelectedFilter"] = "Visitors";

            List<VisitorCheckInOut> lstOcc = objSMSModel.GetVisitorCheckInOut(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty);
            lstOcc = objSMSModel.GetVisitorCheckInOutByFilters(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), Convert.ToInt16(Session["StartDay"]), Convert.ToInt16(Session["StartMonth"]), Convert.ToInt16(Session["StartYear"]), Convert.ToInt16(Session["EndDay"]), Convert.ToInt16(Session["EndMonth"]), Convert.ToInt16(Session["EndYear"]));
            Session["Visitors"] = lstOcc;
            //if (Session["DeploymentType"].ToString().ToLower() == "condo")
            //    return View(lstOcc);
            //else
            //    RedirectToAction("GetClubVisitorCheckInOut", lstOcc);
            return View(lstOcc);
        }
        public ActionResult VisitorsDetails(int? id)
        {
            InitializeDateFilters();
            Session["SelectedFilter"] = "Visitors";

            List<VisitorCheckInOut> lstOcc = objSMSModel.GetVisitorCheckInOut(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty);
            lstOcc = lstOcc.Where(a => a.visitorid == id).ToList();
            var list= lstOcc.Where(a => a.visitorid == id).FirstOrDefault();
            Session["Visitors"] = lstOcc;
            ViewBag.Visitors = new JavaScriptSerializer().Serialize(lstOcc);
            var passList=objSMSModel.GetPassByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), list.passid);
            if (passList != null)
            {
                ViewBag.pass = passList.PassName;
            }
            var keyList = objSMSModel.GetKEYSByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), list.keyid);
            if (keyList != null)
            {
                ViewBag.key = keyList.KeyName;
            }
            var gateList = objSMSModel.GetGateByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), list.gateid);
            if (gateList != null)
            {
                ViewBag.gate = gateList.GateName;
            }
            var visitorList = objSMSModel.GetVisitorTypeByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), list.visitortypeID);
            if (visitorList!=null) {
                ViewBag.VisitorType = visitorList.VisitorTypeDescription;
            }
            if (lstOcc[0].IsBlockGuest==1)
            {
                ViewBag.IsBlockGuest = "true";
            }
            return View();

        }

        [HttpPost]
        public ActionResult VisitorsDetails(FormCollection frmCol)
        {
            VisitorCheckInOut visitordetails = objSMSModel.GetVisitorCheckInOutByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), frmCol["NRIC"].ToString(),0,0);
            if (visitordetails != null)
            {
                visitordetails.IsBlockGuest = frmCol["IsBlockGuest"] == null || frmCol["IsBlockGuest"] == "" ? 0 : Convert.ToInt32(frmCol["IsBlockGuest"]);
                visitordetails.BlockType = frmCol["BlockType"];
                visitordetails.BlockDays = frmCol["BlockDays"] == null || frmCol["BlockDays"] == "" ? 0 : Convert.ToInt32(frmCol["BlockDays"]);
                visitordetails.BlockRemarks = frmCol["BlockRemarks"];
                if (frmCol["BlockedDate"] != null && frmCol["BlockedDate"] != "")
                {
                    var date = frmCol["BlockedDate"].ToString();
                    visitordetails.BlockedDate = DateTime.ParseExact(date, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                }
                if (frmCol["UnblockedDate"] != null && frmCol["UnblockedDate"] != "")
                {
                    var date = frmCol["UnblockedDate"].ToString();
                    visitordetails.UnblockedDate = DateTime.ParseExact(date, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                }
                var res = objSMSModel.EditVisitorCheckInOut(visitordetails);
                return RedirectToAction("GetVisitorCheckInOut");
            }

            return View();
        }
        //public ActionResult GetClubVisitorCheckInOut(VisitorCheckInOut lstOcc)
        //{
        //    return View(lstOcc);
        //}
        [HttpPost]
        public ActionResult GetVisitorCheckInOut(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];

            if (searchString != null && searchString.Trim() != "")
            {
                return View(objSMSModel.GetVisitorCheckInOut(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString));
            }
            else
            {
                List<VisitorCheckInOut> lstOcc = objSMSModel.GetVisitorCheckInOut(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), String.Empty);

                if (frmCol["button"] != null)
                {
                    string clickedButton = frmCol["button"].ToString();

                    switch (clickedButton)
                    {
                        case "Download":
                            DataTable dtr = DownloadData("Visitors");
                            lstOcc = (List<VisitorCheckInOut>)Session["Visitors"];
                            break;
                        case "Go":
                            DataTable dt1 = new DataTable();
                            int startdate = Convert.ToInt32(frmCol["startdate"]);
                            int startmonth = Convert.ToInt32(frmCol["startmonth"]);
                            int startyear = Convert.ToInt32(frmCol["startyear"]);

                            int enddate = Convert.ToInt32(frmCol["enddate"]);
                            int endmonth = Convert.ToInt32(frmCol["endmonth"]);
                            int endyear = Convert.ToInt32(frmCol["endyear"]);

                            DateTime startDate = new DateTime(startyear, startmonth, startdate);
                            DateTime endDate = new DateTime(endyear, endmonth, enddate);

                            lstOcc = objSMSModel.GetVisitorCheckInOutByFilters(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), startdate, startmonth, startyear, enddate, endmonth, endyear);
                            Session["Occurrences"] = lstOcc;

                            Session["SelectedFilter"] = "Visitors : " + startDate.ToShortDateString() + " to " + endDate.ToShortDateString();

                            //string sMonth = "";
                            //string eMonth = "";
                            //sMonth = startmonth, sMonth);
                            //eMonth = GetMonth(endmonth, eMonth);

                            Session["StartDay"] = startdate;
                            Session["StartMonth"] = startmonth;
                            Session["StartYear"] = startyear;
                            Session["EndDay"] = enddate;
                            Session["EndMonth"] = endmonth;
                            Session["EndYear"] = endyear;

                            break;
                        default:
                            lstOcc = objSMSModel.GetVisitorCheckInOut(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), String.Empty);
                            break;
                    }
                }

                return View(lstOcc);
            }
        }

        public string GetVisitingCompanyPhoneNumber(int id)
        {
            string result = "";
            if (id != 0)
            {
                // Get the vsiting company phone number.
                CompanyViewModel cvm = objSMSModel.GetCompanyByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), id);
                result = cvm.ContactNumber.ToString();
            }
            return result;
        }
        //public ActionResult AddVisitorCheckInOut()
        //{
        //    return View(objSMSModel.GetVisitorCheckInOutByID("0", 0));
        //}

        public ActionResult AddVisitorCheckInOut(string ID)
        {
            if (ID == null) ID = "0";
            return View(objSMSModel.GetVisitorCheckInOutByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID.ToString(), 0, 0));
        }
        [HttpPost]
        public ActionResult AddVisitorCheckInOut(FormCollection frmCol)
        {
            try
            {
                if (frmCol["button"] == null)
                {
                    if (frmCol["nricid"] != null)
                    {
                        string ID = frmCol["nricid"].ToString();

                        VisitorCheckInOut v = new VisitorCheckInOut();
                        v = PopulateVisitorCheckInOutObject(frmCol, v);

                        //VisitorCheckInOut v = objSMSModel.GetVisitorCheckInOutByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID.ToString(), 0, 0);
                        v = PopulateDropdowns(v);

                        //if (v.nricid != null && v.nricid != "" && v.name != null && v.name != "" && frmCol["txtPhone"] != null && frmCol["txtPhone"] != "")
                        //{
                        //    v.txtPhone = GetVisitingCompanyPhoneNumber(v.tocompany);
                        //}

                        return View(v);
                    }
                    else
                    {
                        VisitorCheckInOut v1 = objSMSModel.GetVisitorCheckInOutByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), "0", 0, 0);
                        return View(v1);
                    }
                }
                else
                {
                    //string clickedButton = frmCol["button"].ToString();

                    VisitorCheckInOut o = new VisitorCheckInOut();
                    o = PopulateVisitorCheckInOutObject(frmCol, o);

                    VisitorCheckInOut v = objSMSModel.GetVisitorCheckInOutByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), o.nricid, o.eventid, o.visitortypeID);

                    //if (String.IsNullOrEmpty(o.nricid) || String.IsNullOrEmpty(o.name) || String.IsNullOrEmpty(o.telno) || String.IsNullOrEmpty(o.fromcompany) ||
                    //    String.IsNullOrEmpty(o.tocompany.ToString()) || String.IsNullOrEmpty(o.visitortypeID.ToString())
                    //    || String.IsNullOrEmpty(o.passid.ToString()))
                    //{
                    //    o.CompaniesList = v.CompaniesList;
                    //    o.GatesList = v.GatesList;
                    //    o.PassesList = v.PassesList;
                    //    o.VisitorTypesCol = v.VisitorTypesCol;
                    //    o.EventsList = v.EventsList;
                    //    o.KeysList = v.KeysList;

                    //    ModelState.AddModelError("", "All the * marked fields are compulsory.");
                    //    return View(o);
                    //}
                    //else
                    //{
                    string path = "";
                    // If there exists some session for Snapshot path, then the path needs to be updated in the database.
                    if (Session["SnapshotPath"] != null)
                    {
                        path = Session["SnapshotPath"].ToString();
                    }
                    else
                    {
                        if (v.snapshotpath == null || v.snapshotpath.Equals("")) // Nothing selected // Add scenario
                        {
                            path = "~/Content/images/default_person.jpg";//Dummy path
                        }
                        else
                        {
                            path = v.snapshotpath;
                        }
                    }

                    o.snapshotpath = path;

                    int result = objSMSModel.AddVisitorCheckInOut(o);

                    if (result == 1) // Guest not in guest list for the event.
                    {
                        //VisitorCheckInOut v = objSMSModel.GetVisitorCheckInOutByID(0);
                        o.CompaniesList = v.CompaniesList;
                        o.GatesList = v.GatesList;
                        o.PassesList = v.PassesList;
                        o.VisitorTypesCol = v.VisitorTypesCol;
                        o.EventsList = v.EventsList;
                        o.KeysList = v.KeysList;

                        //Session["SnapshotPath"] = null;
                        ModelState.AddModelError("", "This visitor does not belong to the event's guest List");
                        return View(o);
                    }
                    else if (result == 2) // Already checked in - so write logic for checkout.
                    {
                        Session["SnapshotPath"] = null;
                        // TODO : Add the checkout date into the db.
                        o.checkouttime = DateTime.Now;

                        int checkoutUpdateResult = objSMSModel.AddVisitorCheckInOut(o);
                        return RedirectToAction("GetVisitorCheckInOut");
                    }
                    else
                    {
                        Session["SnapshotPath"] = null;
                        return RedirectToAction("GetVisitorCheckInOut");
                    }
                    //}
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "An error occured while checking in/out. Please contact administrator.");
                return View(objSMSModel.GetVisitorCheckInOutByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), "0", 0, 0));
            }
        }

        public ActionResult AddClubVisitorCheckInOut(string ID)
        {
            if (ID == null) ID = "0";
            return View(objSMSModel.GetVisitorCheckInOutByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID.ToString(), 0, 0));
        }
        [HttpPost]
        public ActionResult AddClubVisitorCheckInOut(FormCollection frmCol)
        {
            try
            {
                if (frmCol["button"] == null)
                {
                    if (frmCol["nricid"] != null)
                    {
                        string ID = frmCol["nricid"].ToString();

                        VisitorCheckInOut v = new VisitorCheckInOut();
                        v = PopulateVisitorCheckInOutObject(frmCol, v);

                        //VisitorCheckInOut v = objSMSModel.GetVisitorCheckInOutByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID.ToString(), 0, 0);
                        v = PopulateDropdowns(v);

                        //if (v.nricid != null && v.nricid != "" && v.name != null && v.name != "" && frmCol["txtPhone"] != null && frmCol["txtPhone"] != "")
                        //{
                        //    v.txtPhone = GetVisitingCompanyPhoneNumber(v.tocompany);
                        //}

                        return View(v);
                    }
                    else
                    {
                        VisitorCheckInOut v1 = objSMSModel.GetVisitorCheckInOutByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), "0", 0, 0);
                        return View(v1);
                    }
                }
                else
                {
                    //string clickedButton = frmCol["button"].ToString();

                    VisitorCheckInOut o = new VisitorCheckInOut();
                    o = PopulateVisitorCheckInOutObject(frmCol, o);

                    VisitorCheckInOut v = objSMSModel.GetVisitorCheckInOutByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), o.nricid, o.eventid, o.visitortypeID);

                    //if (String.IsNullOrEmpty(o.nricid) || String.IsNullOrEmpty(o.name) || String.IsNullOrEmpty(o.telno) || String.IsNullOrEmpty(o.fromcompany) ||
                    //    String.IsNullOrEmpty(o.tocompany.ToString()) || String.IsNullOrEmpty(o.visitortypeID.ToString())
                    //    || String.IsNullOrEmpty(o.passid.ToString()))
                    //{
                    //    o.CompaniesList = v.CompaniesList;
                    //    o.GatesList = v.GatesList;
                    //    o.PassesList = v.PassesList;
                    //    o.VisitorTypesCol = v.VisitorTypesCol;
                    //    o.EventsList = v.EventsList;
                    //    o.KeysList = v.KeysList;

                    //    ModelState.AddModelError("", "All the * marked fields are compulsory.");
                    //    return View(o);
                    //}
                    //else
                    //{
                    string path = "";
                    // If there exists some session for Snapshot path, then the path needs to be updated in the database.
                    if (Session["SnapshotPath"] != null)
                    {
                        path = Session["SnapshotPath"].ToString();
                    }
                    else
                    {
                        if (v.snapshotpath == null || v.snapshotpath.Equals("")) // Nothing selected // Add scenario
                        {
                            path = "~/Content/images/default_person.jpg";//Dummy path
                        }
                        else
                        {
                            path = v.snapshotpath;
                        }
                    }

                    o.snapshotpath = path;

                    int result = objSMSModel.AddVisitorCheckInOut(o);

                    if (result == 1) // Guest not in guest list for the event.
                    {
                        //VisitorCheckInOut v = objSMSModel.GetVisitorCheckInOutByID(0);
                        o.CompaniesList = v.CompaniesList;
                        o.GatesList = v.GatesList;
                        o.PassesList = v.PassesList;
                        o.VisitorTypesCol = v.VisitorTypesCol;
                        o.EventsList = v.EventsList;
                        o.KeysList = v.KeysList;

                        //Session["SnapshotPath"] = null;
                        ModelState.AddModelError("", "This visitor does not belong to the event's guest List");
                        return View(o);
                    }
                    else if (result == 2) // Already checked in - so write logic for checkout.
                    {
                        Session["SnapshotPath"] = null;
                        // TODO : Add the checkout date into the db.
                        o.checkouttime = DateTime.Now;

                        int checkoutUpdateResult = objSMSModel.AddVisitorCheckInOut(o);
                        return RedirectToAction("GetVisitorCheckInOut");
                    }
                    else
                    {
                        Session["SnapshotPath"] = null;
                        return RedirectToAction("GetVisitorCheckInOut");
                    }
                    //}
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "An error occured while checking in/out. Please contact administrator.");
                return View(objSMSModel.GetVisitorCheckInOutByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), "0", 0, 0));
            }
        }
        private VisitorCheckInOut PopulateVisitorCheckInOutObject(FormCollection frmCol, VisitorCheckInOut o)
        {
            string nric = frmCol["nricid"];
            o.nricid = frmCol["nricid"];
            o.fullnricid = frmCol["nricid"];

            // Do not allow NRIC to go more than 9 characters.
            if (nric.Length > 9)
                o.nricid = nric.Substring(0, 9);
            if (frmCol["ddlPasses"] != null)
                o.passid = string.IsNullOrEmpty(frmCol["ddlPasses"].ToString()) ? 0 : Convert.ToInt32(frmCol["ddlPasses"]);
            o.address = frmCol["address"];
            o.blockorphone = frmCol["txtPhone"];
            o.txtPhone = frmCol["txtPhone"];
            o.checkintime = DateTime.Now;
            o.checkouttime = Convert.ToDateTime(frmCol["checkouttime"]);
            //o.eventid = string.IsNullOrEmpty(frmCol["ddlEventsList"].ToString()) ? 0 : Convert.ToInt32(frmCol["ddlEventsList"]);
            o.fromcompany = frmCol["fromcompany"];
            o.gateid = frmCol["ddlGates"] == null || frmCol["ddlGates"] == "" ? 0 : Convert.ToInt32(frmCol["ddlGates"]);
            o.guardname = frmCol["guardname"];
            o.keyid = frmCol["ddlKeys"] == null || frmCol["ddlKeys"] == "" ? 0 : Convert.ToInt32(frmCol["ddlKeys"]);
            o.name = frmCol["name"];
            o.persontovisit = frmCol["persontovisit"];
            o.remarks = frmCol["remarks"];
            o.telno = frmCol["telno"];
            o.temp = frmCol["temp"] == null || frmCol["temp"] == "" ? 0 : Convert.ToInt32(frmCol["temp"]);
            //o.tocompany = string.IsNullOrEmpty(frmCol["ddlCompaniesList"].ToString()) ? 0 : Convert.ToInt32(frmCol["ddlCompaniesList"]);
            o.visitortypeID = frmCol["ddlVisitorTypes"] == null || frmCol["ddlVisitorTypes"] == "" ? 0 : Convert.ToInt32(frmCol["ddlVisitorTypes"]);
            //o.visitingcompany = frmCol["visitingcompany"];
            o.purpose = frmCol["purpose"];
            if (Session["DeploymentId"] != null && Session["DeploymentId"].ToString() != "")
                o.deploymentid = Convert.ToInt32(Session["DeploymentId"]);

            o.IsBlockGuest = frmCol["IsBlockGuest"] == null || frmCol["IsBlockGuest"] == "" ? 0 : Convert.ToInt32(frmCol["IsBlockGuest"]);
            o.BlockType = frmCol["BlockType"];
            o.BlockDays = frmCol["BlockDays"] == null || frmCol["BlockDays"] == "" ? 0 : Convert.ToInt32(frmCol["BlockDays"]);
            o.BlockRemarks = frmCol["BlockRemarks"];
            if (frmCol["BlockedDate"] != null && frmCol["BlockedDate"] != "")
            {
                var date = frmCol["BlockedDate"].ToString();
                o.BlockedDate = DateTime.ParseExact(date, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            }
            if (frmCol["UnblockedDate"] != null && frmCol["UnblockedDate"] != "")
            {
                var date = frmCol["UnblockedDate"].ToString();
                o.UnblockedDate = DateTime.ParseExact(date, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            }

            return o;
        }

        private VisitorCheckInOut PopulateDropdowns(VisitorCheckInOut o)
        {
            VisitorCheckInOut v1 = objSMSModel.GetVisitorCheckInOutByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), "0", 0, o.visitortypeID);
            o.CompaniesList = v1.CompaniesList;
            o.GatesList = v1.GatesList;
            o.PassesList = v1.PassesList;
            o.VisitorTypesCol = v1.VisitorTypesCol;
            o.EventsList = v1.EventsList;
            o.KeysList = v1.KeysList;
            return o;
        }

        public ActionResult EditVisitorCheckInOut(int ID, int p_EventId)
        {
            return View(objSMSModel.GetVisitorCheckInOutByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID.ToString(), p_EventId, 0));
        }
        [HttpPost]
        public ActionResult EditVisitorCheckInOut(VisitorCheckInOut p_VisitorCheckInOut)
        {
            int result = objSMSModel.EditVisitorCheckInOut(p_VisitorCheckInOut);
            return RedirectToAction("GetVisitorCheckInOut");
        }
        public ActionResult DeleteVisitorCheckInOut(int ID)
        {
            int result = objSMSModel.RemoveVisitorCheckInOut(ID);
            return RedirectToAction("GetVisitorCheckInOut");
        }

        #endregion

        #region Vehicle
        public ActionResult GetVehicles()
        {
            return View(objSMSModel.GetVehicles(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), string.Empty));
        }
        [HttpPost]
        public ActionResult GetVehicles(FormCollection frmCol)
        {
            string searchString = frmCol["txtSearchString"];
            return View(objSMSModel.GetVehicles(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), searchString.Trim()));
        }
        public ActionResult AddVehicle()
        {
            return View(objSMSModel.GetVehicleByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ""));
        }
        [HttpPost]
        public ActionResult AddVehicle(Vehicles p_Vehicle, FormCollection frm)
        {
            try
            {
                p_Vehicle.purpose = Convert.ToString(frm["PurposeList"]);
                p_Vehicle.vehicletype = Convert.ToString(frm["VehicleTypesList"]);
                if (Session["DeploymentId"] != null && Session["DeploymentId"].ToString() != "")
                    p_Vehicle.deploymentid = Convert.ToInt32(Session["DeploymentId"]);

                int result = objSMSModel.AddVehicle(p_Vehicle);
                if (result == 1)
                {
                    return RedirectToAction("GetVehicles");
                }
                else
                {
                    ModelState.AddModelError("", "Unable to add the vehicle now. Please contact Administrator.");
                    return View(objSMSModel.GetVehicleByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ""));
                }
            }
            catch (Exception ex)
            {
                string x = ex.Message;
                return View(objSMSModel.GetVehicleByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ""));
            }
        }
        public ActionResult EditVehicle(string ID)
        {
            Vehicles vehicle = objSMSModel.GetVehicleByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID);
            ViewBag.purpsose = vehicle.purpose;
            ViewBag.vType = vehicle.vehicletype;
            ViewBag.vehicleid = vehicle.vehicleid;
            return View(vehicle);
        }
        [HttpPost]
        public ActionResult EditVehicle(Vehicles p_Vehicle, FormCollection frm)
        {
            try
            {
                p_Vehicle.purpose = Convert.ToString(frm["PurposeList"]);
                p_Vehicle.vehicletype = Convert.ToString(frm["VehicleTypesList"]);
                //if (frm["vehicleid"] != null && frm["vehicleid"] != "")
                //    p_Vehicle.vehicleid = Convert.ToInt32(frm["vehicleid"]);
                if (Session["DeploymentId"] != null && Session["DeploymentId"].ToString() != "")
                    p_Vehicle.deploymentid = Convert.ToInt32(Session["DeploymentId"]);

                int result = objSMSModel.EditVehicles(p_Vehicle);
                if (result == 1)
                {
                    return RedirectToAction("GetVehicles");
                }
                else
                {
                    ModelState.AddModelError("", "Unable to update the vehicle now. Please contact Administrator.");
                    return View(objSMSModel.GetVehicleByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ""));
                }
            }
            catch (Exception ex)
            {
                string x = ex.Message;
                return View();
            }
        }
        public ActionResult RemoveVehicle(string ID)
        {
            try
            {
                int result = objSMSModel.RemoveVehicle(ID);
                return RedirectToAction("GetVehicles");
            }
            catch (Exception ex)
            {
                string x = ex.Message;
                return View();
            }
        }
        #endregion

        #region New Participent
        public ActionResult NewParticipants(int ID)
        {
            Session["EventID"] = ID;

            EventMaster evm = objSMSModel.GetEventMasterByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID);
            Session["EventDeploymentId"] = evm.DeploymentId;

            return View(objSMSModel.GetParticipantsByEventID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }

        public ActionResult AddNewParticipent()
        {
            return View(objSMSModel.GetVisitorsByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult AddNewParticipent(FormCollection frmCol)
        {
            try
            {
                Visitors objVisitor = new Visitors();
                objVisitor.FirstName = frmCol["FirstName"];
                objVisitor.LastName = frmCol["LastName"];
                objVisitor.NRIC = frmCol["NRIC"];
                objVisitor.eventid = Session["EventID"] == null ? 0 : Convert.ToInt32(Session["EventID"].ToString());
                objVisitor.DeploymentId = Convert.ToInt32(Session["EventDeploymentId"]);//Convert.ToInt32(frmCol["Deployements"]);

                if (objVisitor.DeploymentId == 0)
                {
                    ModelState.AddModelError("", "Unable to add the participant now as there is some problem in event. Please contact Administrator.");
                    return RedirectToAction("NewParticipants/" + Convert.ToInt32(Session["EventID"].ToString()));
                }
                int result = objSMSModel.AddVisitor(objVisitor);
                if (result == 1)
                {
                    return RedirectToAction("NewParticipants/" + Convert.ToInt32(Session["EventID"].ToString()));
                }
                else
                {
                    ModelState.AddModelError("", "Unable to add the participant now. Please contact Administrator.");
                    return View(objSMSModel.GetParticipantsByEventID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), objVisitor.eventid));
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Unable to add the participant now. Please contact Administrator.");
                return View(objSMSModel.GetParticipantsByEventID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), Convert.ToInt32(Session["EventID"].ToString())));
            }
        }
        public ActionResult EditNewParticipent(int ID)
        {
            return View(objSMSModel.GetVisitorsByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditNewParticipent(FormCollection frmCol)
        {
            try
            {
                Visitors objVisitor = new Visitors();
                objVisitor.NRIC = frmCol["NRIC"];
                objVisitor.FirstName = frmCol["FirstName"];
                objVisitor.LastName = frmCol["LastName"];
                objVisitor.VisitorId = Convert.ToInt32(frmCol["VisitorId"]);
                objVisitor.DeploymentId = Convert.ToInt32(Session["EventDeploymentId"]); //Convert.ToInt32(frmCol["Deployements"]);
                int result = objSMSModel.EditVisitor(objVisitor);
                if (result == 1)
                {
                    return RedirectToAction("NewParticipants/" + Convert.ToInt32(Session["EventID"].ToString()));
                }
                else
                {
                    ModelState.AddModelError("", "Unable to update the participant now. Please contact Administrator.");
                    return View(objSMSModel.GetVisitorsByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Unable to update the participant now. Please contact Administrator." + ex.Message);
                return View(objSMSModel.GetVisitorsByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }
        }
        public ActionResult RemoveNewParticipent(int ID)
        {
            try
            {
                int result = objSMSModel.RemoveVisitor(ID);
                if (result == 1)
                {
                    return RedirectToAction("NewParticipants/" + Convert.ToInt32(Session["EventID"].ToString()));
                }
                else
                {
                    ModelState.AddModelError("", "Unable to update the participant now. Please contact Administrator.");
                    return View(objSMSModel.GetVisitorsByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Unable to delete the participant now. Please contact Administrator." + ex.Message);
                return View(objSMSModel.GetVisitorsByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }
        }
        #endregion

        #region Occurances
        public ActionResult GetOccurrences()
        {
            InitializeDateFilters();
            Session["SelectedFilter"] = "Occurrences";

            List<Occurrance> lstOcc = objSMSModel.GetOccurrences(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()));
            lstOcc = objSMSModel.GetOccurrencesByFilters(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), Convert.ToInt16(Session["StartDay"].ToString()), Convert.ToInt16(Session["StartMonth"].ToString()), Convert.ToInt16(Session["StartYear"].ToString()), Convert.ToInt16(Session["EndDay"].ToString()), Convert.ToInt16(Session["EndMonth"].ToString()), Convert.ToInt16(Session["EndYear"].ToString()));
            Session["Occurrences"] = lstOcc;
            return View(lstOcc);
        }

        private void InitializeDateFilters()
        {
            Session["SelectedFilter"] = null;
            var currentdate = DateTime.Now;
            Session["StartDay"] = currentdate.Day;
            Session["StartMonth"] = currentdate.Month;
            Session["StartYear"] = currentdate.Year;
            Session["EndDay"] = currentdate.Day;
            Session["EndMonth"] = currentdate.Month;
            Session["EndYear"] = currentdate.Year;
        }

        [HttpPost]
        public ActionResult GetOccurrences(FormCollection frmCol)
        {
            List<Occurrance> lstOcc = objSMSModel.GetOccurrences(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()));

            if (frmCol["button"] != null)
            {
                string clickedButton = frmCol["button"].ToString();

                switch (clickedButton)
                {
                    case "Download":
                        DataTable dtr = DownloadData("Occurrences");
                        lstOcc = (List<Occurrance>)Session["Occurrences"];
                        break;
                    case "Go":
                        DataTable dt1 = new DataTable();
                        int startdate = Convert.ToInt32(frmCol["startdate"]);
                        int startmonth = Convert.ToInt32(frmCol["startmonth"]);
                        int startyear = Convert.ToInt32(frmCol["startyear"]);

                        int enddate = Convert.ToInt32(frmCol["enddate"]);
                        int endmonth = Convert.ToInt32(frmCol["endmonth"]);
                        int endyear = Convert.ToInt32(frmCol["endyear"]);

                        DateTime startDate = new DateTime(startyear, startmonth, startdate);
                        DateTime endDate = new DateTime(endyear, endmonth, enddate);

                        lstOcc = objSMSModel.GetOccurrencesByFilters(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), startdate, startmonth, startyear, enddate, endmonth, endyear);
                        Session["Occurrences"] = lstOcc;

                        Session["SelectedFilter"] = "Occurrences : " + startDate.ToShortDateString() + " to " + endDate.ToShortDateString();

                        //string sMonth = "";
                        //string eMonth = "";
                        //sMonth = startmonth, sMonth);
                        //eMonth = GetMonth(endmonth, eMonth);

                        Session["StartDay"] = startdate;
                        Session["StartMonth"] = startmonth;
                        Session["StartYear"] = startyear;
                        Session["EndDay"] = enddate;
                        Session["EndMonth"] = endmonth;
                        Session["EndYear"] = endyear;

                        break;
                    default:
                        lstOcc = objSMSModel.GetOccurrences(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()));
                        break;
                }
            }

            return View(lstOcc);
        }

        private static string GetMonth(int startmonth, string sMonth)
        {
            switch (startmonth)
            {
                case 1:
                    sMonth = "January";
                    break;
                case 2:
                    sMonth = "February";
                    break;
                case 3:
                    sMonth = "March";
                    break;
                case 4:
                    sMonth = "April";
                    break;
                case 5:
                    sMonth = "May";
                    break;
                case 6:
                    sMonth = "June";
                    break;
                case 7:
                    sMonth = "July";
                    break;
                case 8:
                    sMonth = "August";
                    break;
                case 9:
                    sMonth = "September";
                    break;
                case 10:
                    sMonth = "October";
                    break;
                case 11:
                    sMonth = "November";
                    break;
                case 12:
                    sMonth = "December";
                    break;
                default:
                    break;
            }
            return sMonth;
        }

        private DataTable DownloadData(string downloadwhat)
        {

            List<Occurrance> lstOccurrences = null;
            List<Incidents> lstIncidents = null;
            List<VisitorCheckInOut> lstVisitors = null;
            DataTable dt = new DataTable();

            string CsvFpath = null; Server.MapPath("~/downloads/occurrences.csv");

            switch (downloadwhat)
            {
                case "Occurrences":
                    lstOccurrences = (List<Occurrance>)Session["Occurrences"];
                    dt = CreateAndFillOccurrencesTable(lstOccurrences, dt);
                    CsvFpath = Server.MapPath("~/downloads/occurrences.csv");
                    break;
                case "Incidents":
                    lstIncidents = (List<Incidents>)Session["Incidents"];
                    dt = CreateAndFillIncidentsTable(lstIncidents, dt);
                    CsvFpath = Server.MapPath("~/downloads/incidents.csv");
                    break;
                case "Visitors":
                    lstVisitors = (List<VisitorCheckInOut>)Session["Visitors"];
                    dt = CreateAndFillVisitorsTable(lstVisitors, dt);
                    CsvFpath = Server.MapPath("~/downloads/visitors.csv");
                    break;
                default:
                    break;
            }

            try
            {
                StreamWriter sw = new StreamWriter(CsvFpath, false);

                int iColCount = dt.Columns.Count;
                for (int i = 0; i < iColCount; i++)
                {
                    sw.Write(dt.Columns[i]);
                    if (i < iColCount - 1)
                        sw.Write(",");
                }

                sw.Write(sw.NewLine);
                foreach (DataRow dr in dt.Rows)
                {
                    for (int i = 0; i < iColCount; i++)
                    {
                        if (!Convert.IsDBNull(dr[i]))
                            sw.Write(dr[i].ToString());
                        if (i < iColCount - 1)
                            sw.Write(",");
                    }
                    sw.Write(sw.NewLine);
                }
                sw.Close();

                Response.Clear();
                Response.ContentType = "application/csv";
                switch (downloadwhat)
                {
                    case "Occurrences":
                        Response.AddHeader("Content-Disposition", "attachment; filename=occurrences.csv");
                        break;
                    case "Incidents":
                        Response.AddHeader("Content-Disposition", "attachment; filename=incidents.csv");
                        break;
                    case "Visitors":
                        Response.AddHeader("Content-Disposition", "attachment; filename=visitors.csv");
                        break;
                    default:
                        break;
                }

                Response.WriteFile(CsvFpath);
                Response.Flush();
                Response.End();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dt;
        }

        private DataTable CreateAndFillOccurrencesTable(List<Occurrance> lst, DataTable dt)
        {
            dt.Columns.Add("S.No.", typeof(int));
            dt.Columns.Add("Date/Time", typeof(string));
            dt.Columns.Add("Heading", typeof(string));
            dt.Columns.Add("Occurrence", typeof(string));

            for (int i = 0; i < lst.Count; i++)
            {
                Occurrance o = (Occurrance)lst[i];
                dt.Rows.Add(o.serialnumber, o.reportdate, o.heading, o.notes);
            }

            return dt;
        }

        private DataTable CreateAndFillIncidentsTable(List<Incidents> lst, DataTable dt)
        {
            dt.Columns.Add("Incident type", typeof(string));
            dt.Columns.Add("Location", typeof(string));
            dt.Columns.Add("Incident Date", typeof(string));
            dt.Columns.Add("Description", typeof(string));

            for (int i = 0; i < lst.Count; i++)
            {
                Incidents o = (Incidents)lst[i];
                dt.Rows.Add(o.natureofincident, o.LocationName, o.dateofincident, o.briefdescription);
            }

            return dt;
        }

        private DataTable CreateAndFillVisitorsTable(List<VisitorCheckInOut> lst, DataTable dt)
        {
            dt.Columns.Add("NRIC", typeof(string));
            dt.Columns.Add("Name", typeof(string));
            dt.Columns.Add("From company", typeof(string));
            dt.Columns.Add("Visiting company", typeof(string));
            dt.Columns.Add("Contact number", typeof(string));
            dt.Columns.Add("Check in", typeof(string));
            dt.Columns.Add("Check out", typeof(string));
            dt.Columns.Add("Event", typeof(string));

            for (int i = 0; i < lst.Count; i++)
            {
                VisitorCheckInOut o = (VisitorCheckInOut)lst[i];
                dt.Rows.Add(o.nricid, o.name, o.fromcompany, o.CompanyName, o.telno, o.checkintime, o.cotime, o.EventName);
            }

            return dt;
        }

        public ActionResult AddOccurrence()
        {
            return View(objSMSModel.GetOccurranceByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
        }
        [HttpPost]
        public ActionResult AddOccurrence(Occurrance p_Occurrance)
        {
            if (p_Occurrance.heading != null && !String.IsNullOrEmpty(p_Occurrance.heading))
            {
                // Put the formatted date into converted date.
                p_Occurrance.ConvertedDate = Convert.ToDateTime(p_Occurrance.reportdate);

                if (Session["DeploymentId"] != null && Session["DeploymentId"].ToString() != "")
                    p_Occurrance.deploymentid = Convert.ToInt32(Session["DeploymentId"]);

                int result = objSMSModel.AddOccurrance(p_Occurrance);
                if (result == 1)
                {
                    return RedirectToAction("GetOccurrences");
                }
                else
                {
                    ModelState.AddModelError("", "Unable to add the occurance now. Please contact Administrator.");
                    return View(objSMSModel.GetOccurranceByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
                }
            }
            else
            {
                ModelState.AddModelError("", "'*' marked fields are compulsory.");
                return View(objSMSModel.GetOccurranceByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }
        }
        public ActionResult EditOccurrence(int ID)
        {
            return View(objSMSModel.GetOccurranceByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }
        [HttpPost]
        public ActionResult EditOccurrence(Occurrance p_Occurrance)
        {
            if (p_Occurrance.heading != null && !String.IsNullOrEmpty(p_Occurrance.heading))
            {
                // Put the formatted date into converted date.
                p_Occurrance.ConvertedDate = Convert.ToDateTime(p_Occurrance.reportdate);

                if (Session["DeploymentId"] != null && Session["DeploymentId"].ToString() != "")
                    p_Occurrance.deploymentid = Convert.ToInt32(Session["DeploymentId"]);

                int result = objSMSModel.EditOccurrance(p_Occurrance);
                if (result == 1)
                {
                    return RedirectToAction("GetOccurrences");
                }
                else
                {
                    ModelState.AddModelError("", "Unable to update the occurance now. Please contact Administrator.");
                    return View(objSMSModel.GetOccurranceByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), p_Occurrance.occuranceid));
                }
            }
            else
            {
                ModelState.AddModelError("", "'*' marked fields are compulsory.");
                return View(objSMSModel.GetOccurranceByID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), 0));
            }
        }
        public ActionResult RemoveOccurrence(int ID)
        {
            int result = objSMSModel.DeleteOccurances(ID);
            return RedirectToAction("GetOccurrences");
        }
        #endregion

        #region Helpers
        public JsonResult GetUsersByID(int ID)
        {
            return Json(objSMSModel.GetUserByUserTypeID(Convert.ToInt32(Session["UserType"].ToString()), Convert.ToInt32(Session["DeploymentId"].ToString()), ID));
        }

        public ActionResult cam()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Upload(string image)
        {
            image = image.Substring("data:image/png;base64,".Length);
            var buffer = Convert.FromBase64String(image);

            string id = DateTime.Now.Year.ToString() + "" + DateTime.Now.Month.ToString() + "" + DateTime.Now.Day.ToString() + "" + DateTime.Now.Hour.ToString()
                + "" + DateTime.Now.Minute.ToString() + "" + DateTime.Now.Second.ToString() + "" + DateTime.Now.Millisecond.ToString();

            System.IO.File.WriteAllBytes(Server.MapPath("../Snapshots/" + id + ".png"), buffer);

            Session["SnapshotPath"] = "../Snapshots/" + id + ".png";

            return Json(new { success = true });
        }
        #endregion
    }
}
