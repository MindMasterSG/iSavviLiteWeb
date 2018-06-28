using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SMSBAL;
using SMSEntities.SMSDBEntities;
using System.ComponentModel.DataAnnotations;
namespace SMS.Models
{
    public class SMSManagementModel
    {
        SMSManagement objSMS = new SMSManagement();

        #region DEPLoymENT
        public List<Deployement> GetDeployements(int currentUserType, int deploymentId, string searchString)
        {
            searchString = searchString.ToString().Trim();
            return string.IsNullOrEmpty(searchString) ? objSMS.GetDeploymentList(currentUserType, deploymentId) : objSMS.GetDeploymentList(currentUserType, deploymentId).Where(s => s.DeploymentName.ToLower().Contains(searchString.ToLower())).ToList();
        }

        public Deployement GetDeploymentByID(int currentUserType, int deploymentId,int ID)
        {
            return objSMS.GetDeploymentByID(ID);
        }

        public int AddDeployment(Deployement p_Deployement)
        {
            return objSMS.AddDeployment(p_Deployement);
        }

        public int ModifyDeployment(Deployement p_Deployement)
        {
            return objSMS.ModifyDeployment(p_Deployement);
        }

        public int RemoveDeployment(int ID)
        {
            return objSMS.RemoveDeployment(ID);
        }
        #endregion

        #region UserTypes
        public int AddUserType(UserTypes p_UserType)
        {
            return objSMS.AddUserType(p_UserType);
        }
        public int ModifyUserType(UserTypes p_UserType)
        {
            return objSMS.ModifyUserType(p_UserType);
        }
        public List<UserTypes> GetUserTypes(int currentUserType, int deploymentId)
        {
            return objSMS.GetUserTypes(currentUserType,deploymentId);
        }
        public UserTypes GetUserTypeByID(int currentUserType, int deploymentId,int ID)
        {
            return objSMS.GetUserTypeByID(currentUserType, deploymentId,ID);
        }
        #endregion

        #region UserInfo

        public UserInfo IsUserExists(UserInfo p_UserInfo)
        {
            return objSMS.IsUserExists(p_UserInfo);
        }

        public List<UserInfo> GetUserByUserTypeID(int currentUserType, int deploymentId,int ID)
        {
            return objSMS.GetUsersByUserTypeID(currentUserType,deploymentId, ID);
        }

        public List<UserViewModel> GetUsersList(int deploymentId,int currentUserType, string searchString)
        {
            searchString = searchString.ToString().Trim();
            List<UserViewModel> objUVMCol = new List<UserViewModel>();
            UserViewModel objUVM = null;
            List<UserInfo> objUserInfo = objSMS.GetUsers(deploymentId,currentUserType);
            if (objUserInfo != null)
            {
                foreach (UserInfo user in objUserInfo)
                {
                    objUVM = new UserViewModel();
                    objUVM.UID = user.UID;
                    objUVM.LoginID = user.LoginID;
                    objUVM.UserName = user.UserName;
                    objUVM.EmailID = user.EmailID;
                    objUVM.DeploymentName = objSMS.GetDeploymentByID(user.DeploymentID).DeploymentName;
                    objUVM.UserType = objSMS.GetUserTypeByID(currentUserType, deploymentId, user.UserTypeID).UserType;
                    objUVMCol.Add(objUVM);
                }
            }
            return string.IsNullOrEmpty(searchString) ? objUVMCol : objUVMCol.Where(s => s.DeploymentName.ToLower().Contains(searchString.ToLower()) ||
                s.EmailID.ToLower().Contains(searchString.ToLower()) || s.LoginID.ToLower().Contains(searchString.ToLower()) || s.UserType.ToLower().Contains(searchString.ToLower()) ||
                s.UserName.ToLower().Contains(searchString.ToLower())).ToList();
        }

        public List<UserViewModel> GetUsersByDeploymentID(int deploymentId)
        {
            List<UserViewModel> objUVMCol = new List<UserViewModel>();
            UserViewModel objUVM = null;
            List<UserInfo> objUserInfo = objSMS.GetUsersByDeploymentID(deploymentId);
            if (objUserInfo != null)
            {
                foreach (UserInfo user in objUserInfo)
                {
                    objUVM = new UserViewModel();
                    objUVM.UID = user.UID;
                    objUVM.LoginID = user.LoginID;
                    objUVM.UserName = user.UserName;
                    objUVM.EmailID = user.EmailID;
                    objUVM.UserTypeID = user.UserTypeID;
                    objUVM.DeploymentID = user.DeploymentID;
                    objUVMCol.Add(objUVM);
                }
            }
            return objUVMCol;
        }

        public UserViewModel GetUserInfo(int currentUserType, int deploymentId)
        {
            UserViewModel objUVM = new UserViewModel();
            objUVM.Deployements = objSMS.GetDeploymentList( currentUserType,  deploymentId);
            objUVM.UserTypes = objSMS.GetUserTypes( currentUserType,  deploymentId);
            return objUVM;
        }

        public UserViewModel GetUserInfo(int currentUserType, int deploymentId,int ID)
        {
            UserViewModel objUVM = new UserViewModel();
            UserInfo objUserInfo = objSMS.GetUserByID(ID);
            if (objUserInfo != null)
            {
                objUVM.UserName = objUserInfo.UserName;
                objUVM.LoginID = objUserInfo.LoginID;
                objUVM.UID = objUserInfo.UID;
                objUVM.DeploymentID = objUserInfo.DeploymentID;
                objUVM.UserTypeID = objUserInfo.UserTypeID;
                objUVM.EmailID = objUserInfo.EmailID;
            }
            objUVM.Deployements = objSMS.GetDeploymentList(currentUserType,  deploymentId);;
            objUVM.UserTypes = objSMS.GetUserTypes(currentUserType,deploymentId);
            return objUVM;
        }

        public int EditUser(UserInfo p_UserInfo)
        {
            return objSMS.EditUserInfo(p_UserInfo);
        }

        public int AddUser(UserInfo p_UserInfo)
        {
            return objSMS.AddUserInfo(p_UserInfo);
        }
        public int RemoveUser(int ID)
        {
            return objSMS.RemoveUser(ID);
        }
        #endregion

        #region Gates
        public List<GatesViewModel> GetGates(int currentUserType, int deploymentId, string searchString)
        {
            searchString = searchString.ToString().Trim();
            List<GatesViewModel> objGVMCol = new List<GatesViewModel>();
            GatesViewModel objGVM = null;
            List<Gates> objGatesList = objSMS.GetGatesList(currentUserType,deploymentId);
            if (objGatesList != null)
            {
                foreach (Gates gate in objGatesList)
                {
                    objGVM = new GatesViewModel();
                    objGVM.GateId = gate.GateId;
                    objGVM.DeploymentId = gate.DeploymentId;
                    objGVM.AddedDate = gate.AddedDate;
                    objGVM.GateName = gate.GateName;
                    objGVM.DeploymentName = objSMS.GetDeploymentByID(gate.DeploymentId).DeploymentName;
                    objGVMCol.Add(objGVM);
                }
            }
            return string.IsNullOrEmpty(searchString) ? objGVMCol : objGVMCol.Where(s => s.GateName.ToLower().Contains(searchString.ToLower()) || s.DeploymentName.ToLower().Contains(searchString.ToLower())).ToList();
        }
        public GatesViewModel GetGateByID(int currentUserType, int deploymentId,int ID)
        {
            GatesViewModel objGVM = new GatesViewModel();
            Gates objGates = ID == 0 ? null : objSMS.GetGateByID(ID);
            if (objGates != null)
            {
                objGVM.GateId = objGates.GateId;
                objGVM.DeploymentId = objGates.DeploymentId;
                objGVM.GateName = objGates.GateName;
                objGVM.DeploymentName = objSMS.GetDeploymentByID(objGates.DeploymentId).DeploymentName;
            }
            List<Deployments> objDeploymentsCol = new List<Deployments>();
            List<Deployement> objDeployementCol = objSMS.GetDeploymentList(currentUserType,  deploymentId);;
            Deployments objDeployments = null;
            foreach (Deployement item in objDeployementCol)
            {
                objDeployments = new Deployments();
                objDeployments.DeploymentId = item.DeploymentId;
                objDeployments.DeploymentName = item.DeploymentName;
                objDeploymentsCol.Add(objDeployments);
            }
            objGVM.Deployments = objDeploymentsCol;
            return objGVM;
        }
        public int EditGate(Gates p_Gates)
        {
            return objSMS.ModifyGate(p_Gates);
        }
        public int AddGate(Gates p_Gates)
        {
            return objSMS.AddGate(p_Gates);
        }
        public int RemoveGate(int ID)
        {
            return objSMS.RemoveGate(ID);
        }
        #endregion

        #region Keys
        public List<KeysViewModel> GetKEYS(int currentUserType, int deploymentId, string searchString)
        {
            searchString = searchString.ToString().Trim();
            List<KeysViewModel> objKeyCol = new List<KeysViewModel>();
            KeysViewModel objKVM = null;
            List<KEYS> objKeyList = objSMS.GetKeysList(currentUserType,deploymentId);
            if (objKeyList != null)
            {
                foreach (KEYS key in objKeyList)
                {
                    objKVM = new KeysViewModel();
                    objKVM.KeyId = key.KeyId;
                    objKVM.DeploymentId = key.DeploymentId;
                    objKVM.KeyName = key.KeyName;
                    objKVM.Status = objSMS.GetKeyStatusesByID(key.Status).StatusType;
                    objKVM.DeploymentName = objSMS.GetDeploymentByID(key.DeploymentId).DeploymentName;
                    objKeyCol.Add(objKVM);
                }
            }
            return string.IsNullOrEmpty(searchString) ? objKeyCol : objKeyCol.Where(s => s.DeploymentName.ToLower().Contains(searchString.ToLower()) || s.KeyName.ToLower().Contains(searchString.ToLower())).ToList();
        }
        public KeysViewModel GetKEYSByID(int currentUserType,int deploymentId, int ID)
        {
            KeysViewModel objKVM = new KeysViewModel();
            KEYS objKey = ID == 0 ? null : objSMS.GetKeyByID(ID);
            if (objKey != null)
            {
                objKVM.KeyId = objKey.KeyId;
                objKVM.KeyName = objKey.KeyName;
                objKVM.StatusID = objKey.Status;
                objKVM.Status = objSMS.GetKeyStatusesByID(objKey.Status).StatusType;
                objKVM.DeploymentName = objSMS.GetDeploymentByID(objKey.DeploymentId).DeploymentName;
                objKVM.DeploymentId = objKey.DeploymentId;
            }
            objKVM.Deployements = objSMS.GetDeploymentList(currentUserType,  deploymentId);
            objKVM.KeyStatuses = objSMS.GetKeyStatuses(currentUserType, deploymentId);// GetKeyStatuses();

            return objKVM;
        }
        public int EditKey(KEYS p_KEYS)
        {
            return objSMS.ModifyKey(p_KEYS);
        }
        public int AddKey(KEYS p_Key)
        {
            return objSMS.AddKey(p_Key);
        }
        public int RemoveKey(int ID)
        {
            return objSMS.RemoveKey(ID);
        }
        #endregion

        #region Visitor
        public List<VisitorsViewModel> GetVisitors(int currentUserType, int deploymentId, string searchString)
        {
            searchString = searchString.ToString().Trim();
            List<VisitorsViewModel> objVisitorCol = new List<VisitorsViewModel>();
            VisitorsViewModel objVVM = null;
            List<Visitors> objVisitors = objSMS.GetVisitorsList(currentUserType,deploymentId);
            if (objVisitors != null)
            {
                foreach (Visitors visitor in objVisitors)
                {
                    objVVM = new VisitorsViewModel();
                    objVVM.CompanyName = visitor.CompanyName;
                    objVVM.Address = visitor.Address;
                    objVVM.AddedDate = visitor.AddedDate;
                    objVVM.ContactNumber = visitor.ContactNumber;
                    objVVM.DeploymentId = visitor.DeploymentId;
                    objVVM.DeploymentName = objSMS.GetDeploymentByID(visitor.DeploymentId).DeploymentName;
                    objVVM.FirstName = visitor.FirstName;
                    objVVM.LastName = visitor.LastName;
                    objVVM.MiddleName = visitor.MiddleName;
                    objVVM.VisitorId = visitor.VisitorId;
                    objVVM.NRIC = visitor.NRIC;
                    objVisitorCol.Add(objVVM);
                }
            }
            List<VisitorsViewModel> objVisitorCol1 = new List<VisitorsViewModel>();
            objVisitorCol1 = string.IsNullOrEmpty(searchString) ? objVisitorCol : objVisitorCol.Where(s => s.FirstName.ToLower().Contains(searchString.ToLower())).ToList();
            return string.IsNullOrEmpty(searchString) ? objVisitorCol : objVisitorCol.Where(s => s.FirstName.ToLower().Contains(searchString.ToLower()) ||
                s.MiddleName.Contains(searchString) || s.LastName.ToLower().Contains(searchString.ToLower()) || s.NRIC.ToLower().Contains(searchString.ToLower()) || s.CompanyName.Contains(searchString) || s.DeploymentName.Contains(searchString) || s.ContactNumber.Contains(searchString)).ToList();
        }
        public Visitors GetVisitorsByID(int currentUserType, int deploymentId,int ID)
        {
            Visitors objVVM = new Visitors();
            Visitors objVisitors = ID == 0 ? null : objSMS.GetVisitorByID(currentUserType, deploymentId,ID);
            if (objVisitors != null)
            {
                objVVM = new Visitors();
                objVVM.CompanyName = objVisitors.CompanyName;
                objVVM.Address = objVisitors.Address;
                objVVM.AddedDate = objVisitors.AddedDate;
                objVVM.ContactNumber = objVisitors.ContactNumber;
                objVVM.DeploymentId = objVisitors.DeploymentId;
                objVVM.DeploymentName = objSMS.GetDeploymentByID(objVisitors.DeploymentId).DeploymentName;
                objVVM.FirstName = objVisitors.FirstName;
                objVVM.LastName = objVisitors.LastName;
                objVVM.MiddleName = objVisitors.MiddleName;
                objVVM.VisitorId = objVisitors.VisitorId;
                objVVM.NRIC = objVisitors.NRIC;
            }
            objVVM.Deployements = objSMS.GetDeploymentList(currentUserType,  deploymentId);;
            return objVVM;
        }

        //public List<Visitors> GetNewParticipantVisitors(string searchString)
        //{
        //    searchString = searchString.ToString().Trim();
        //    List<Visitors> objVisitors = objSMS.GetVisitorsList();
        //    return string.IsNullOrEmpty(searchString) ? objVisitors : objVisitors.Where(v => v.FirstName.ToLower().Contains(searchString.ToLower()) || v.LastName.ToLower().Contains(searchString.ToLower()) || v.NRIC.ToLower().Contains(searchString.ToLower())).ToList();
        //}

        public List<Visitors> GetParticipantsByEventID(int currentUserType, int deploymentId,int ID)
        {
            return objSMS.GetParticipantsByEventID(currentUserType,deploymentId, ID);
        }
        public Visitors GetNewParticipantVisitor(int currentUserType, int deploymentId,int ID)
        {
            return ID == 0 ? null : objSMS.GetVisitorByID(currentUserType, deploymentId,ID);
        }
        public int EditVisitor(Visitors p_Visitors)
        {
            return objSMS.ModifyVisitor(p_Visitors);
        }
        public int AddVisitor(Visitors p_Visitors)
        {
            return objSMS.AddVisitor(p_Visitors);
        }
        public int RemoveVisitor(int ID)
        {
            return objSMS.RemoveVisitor(ID);
        }
        #endregion

        #region Location
        public List<LocatonViewModel> GetLocation(int currentUserType, int deploymentId, string searchString)
        {
            searchString = searchString.ToString().Trim();
            List<LocatonViewModel> objLVMCol = new List<LocatonViewModel>();
            LocatonViewModel objLVM = null;
            List<Location> objLocations = objSMS.GetLocationsList(currentUserType,deploymentId);
            if (objLocations != null)
            {
                foreach (Location location in objLocations)
                {
                    objLVM = new LocatonViewModel();
                    objLVM.LocationId = location.LocationId;
                    objLVM.LocationName = location.LocationName;
                    objLVM.DeploymentName = objSMS.GetDeploymentByID(location.DeploymentId).DeploymentName;
                    objLVM.DeploymentId = location.DeploymentId;
                    objLVMCol.Add(objLVM);
                }
            }
            return string.IsNullOrEmpty(searchString) ? objLVMCol : objLVMCol.Where(s => s.DeploymentName.ToLower().Contains(searchString.ToLower()) || s.LocationName.ToLower().Contains(searchString.ToLower())).ToList();
        }
        public LocatonViewModel GetLocationByID(int currentUserType, int deploymentId,int ID)
        {
            LocatonViewModel objLVM = new LocatonViewModel();
            Location objLocation = objSMS.GetLocationByID(ID);
            if (objLocation != null)
            {
                objLVM.LocationId = objLocation.LocationId;
                objLVM.LocationName = objLocation.LocationName;
                objLVM.DeploymentName = objSMS.GetDeploymentByID(objLocation.DeploymentId).DeploymentName;
                objLVM.DeploymentId = objLocation.DeploymentId;
            }
            objLVM.Deployements = objSMS.GetDeploymentList(currentUserType,  deploymentId);;
            return objLVM;
        }
        public int EditLocation(Location p_Location)
        {
            return objSMS.ModifyLocation(p_Location);
        }
        public int AddLocation(Location p_Location)
        {
            return objSMS.AddLocation(p_Location);
        }
        public int RemoveLocation(int currentUserType, int deploymentId,int ID)
        {
            return objSMS.RemoveLocation(ID);
        }
        #endregion

        #region Company
        public List<CompanyViewModel> GetCompanies(int currentUserType, int deploymentId, string searchString)
        {
            searchString = searchString.ToString().Trim();
            List<CompanyViewModel> objCVMCol = new List<CompanyViewModel>();
            CompanyViewModel objCVM = null;
            //var companiesCol = objSMS.GetCompanies( p_UserTypeId, int p_deploymentId);
            List<Companies> objCompanyCol = objSMS.GetCompanies(currentUserType, deploymentId);
            if (objCompanyCol != null)
            {
                foreach (Companies company in objCompanyCol)
                {
                    objCVM = new CompanyViewModel();
                    objCVM.CompanyId = company.CompanyId;
                    objCVM.CompanyName = company.CompanyName;
                    objCVM.Address = company.Address;
                    objCVM.ContactNumber = company.ContactNumber;
                    objCVM.DeploymentId = company.DeploymentId;
                    if (company.DeploymentId != 0)
                        objCVM.DeploymentName = objSMS.GetDeploymentByID(company.DeploymentId).DeploymentName;
                    objCVMCol.Add(objCVM);
                }
            }
            return string.IsNullOrEmpty(searchString) ? objCVMCol : objCVMCol.Where(s => s.CompanyName.ToLower().Contains(searchString.ToLower()) || s.ContactNumber.ToLower().Contains(searchString.ToLower()) || s.Address.ToLower().Contains(searchString.ToLower()) || s.DeploymentName.ToLower().Contains(searchString.ToLower())).ToList();
        }
        public CompanyViewModel GetCompanyByID(int currentUserType, int deploymentId,int ID)
        {
            CompanyViewModel objCVM = new CompanyViewModel();
            Companies company = ID == 0 ? null : objSMS.GetCompanyByID(ID);
            if (company != null)
            {
                objCVM.CompanyId = company.CompanyId;
                objCVM.CompanyName = company.CompanyName;
                objCVM.Address = company.Address;
                objCVM.ContactNumber = company.ContactNumber;
                objCVM.DeploymentId = company.DeploymentId;
                if (company.DeploymentId != 0)
                    objCVM.DeploymentName = objSMS.GetDeploymentByID(company.DeploymentId).DeploymentName;
            }
            objCVM.Deployments = objSMS.GetDeploymentList(currentUserType,  deploymentId);;
            return objCVM;
        }
        public int AddCompany(Companies p_Company)
        {
            return objSMS.AddCompany(p_Company);
        }
        public int EditCompany(Companies p_Company)
        {
            return objSMS.EditCompany(p_Company);
        }
        public int DeleteCompany(int ID)
        {
            return objSMS.RemoveCompany(ID);
        }
        #endregion

        #region Passes
        public List<PassesViewModel> GetPasses(int currentUserType, int deploymentId, string searchString)
        {
            searchString = searchString.ToString().Trim();
            List<PassesViewModel> objPVMCol = new List<PassesViewModel>();
            PassesViewModel objPVM = null;
            List<Passes> objPassesCol = objSMS.GetPasses(currentUserType,deploymentId);
            if (objPassesCol != null)
            {
                foreach (Passes pass in objPassesCol)
                {
                    objPVM = new PassesViewModel();
                    objPVM.PassId = pass.PassId;
                    objPVM.PassName = pass.PassName;
                    objPVM.PassStatus = pass.PassStatus == "1" ? "Active" : "Inactive";
                    objPVM.VisitortypeId = pass.VisitortypeId;
                    objPVM.DeploymentId = pass.DeploymentId;
                    objPVM.VisitorType = objSMS.GetVisitorTypeByID(pass.VisitortypeId).VisitorTypeDescription;
                    objPVM.DeploymentName = objSMS.GetDeploymentByID(pass.DeploymentId).DeploymentName;
                    objPVMCol.Add(objPVM);
                }
            }
            return string.IsNullOrEmpty(searchString) ? objPVMCol : objPVMCol.Where(s => s.DeploymentName.ToLower().Contains(searchString.ToLower()) || s.PassName.ToLower().Contains(searchString.ToLower()) || s.PassStatus.ToLower().Contains(searchString.ToLower()) || s.VisitorType.ToLower().Contains(searchString.ToLower())).ToList();
        }
        public PassesViewModel GetPassByID(int currentUserType, int deploymentId,int ID)
        {
            // List<PassesViewModel> objPVMCol = new List<PassesViewModel>();
            PassesViewModel objPVM = new PassesViewModel();
            Passes objPasses = ID == 0 ? null : objSMS.GetPassByID(currentUserType, deploymentId,ID);
            if (objPasses != null)
            {
                objPVM.PassId = objPasses.PassId;
                objPVM.PassName = objPasses.PassName;
                objPVM.PassStatus = objPasses.PassStatus;
                objPVM.VisitortypeId = objPasses.VisitortypeId;
                objPVM.DeploymentId = objPasses.DeploymentId;
                //objPVM.PassStatusID = GetPassesStatuses().Where(p => p.Status == objPasses.PassStatus).SingleOrDefault().StatusID;
                objPVM.VisitorType = objSMS.GetVisitorTypeByID(objPasses.VisitortypeId).VisitorTypeDescription;
            }
            objPVM.VisitorTypesCol = objSMS.GetVisitorTypes(currentUserType,  deploymentId);
            objPVM.Deployments = objSMS.GetDeploymentList(currentUserType,  deploymentId);;
            objPVM.PassStatuses = GetPassesStatuses();
            return objPVM;
        }
        public int AddPass(Passes p_Passes)
        {
            return objSMS.AddPass(p_Passes);
        }
        public int EditPass(Passes p_Passes)
        {
            return objSMS.EditPass(p_Passes);
        }
        public int RemovePass(int ID)
        {
            return objSMS.RemovePass(ID);
        }
        #endregion

        #region VisitorType
        public List<VisitorTypes> GetVisitorTypes(int currentUserType, int deploymentId, string searchString)
        {
            searchString = searchString.ToString().Trim();
            return string.IsNullOrEmpty(searchString) ? objSMS.GetVisitorTypes(currentUserType,deploymentId) : objSMS.GetVisitorTypes(currentUserType,deploymentId).Where(s => s.VisitorTypeDescription.ToLower().Contains(searchString.ToLower())).ToList();
        }
        public VisitorTypes GetVisitorTypeByID(int currentUserType, int deploymentId,int ID)
        {
            return ID == 0 ? null : objSMS.GetVisitorTypeByID(ID);
        }
        public int EditVisitorType(VisitorTypes p_VisitorTypes)
        {
            return objSMS.ModifyVisitorType(p_VisitorTypes);
        }
        public int AddVisitorType(VisitorTypes p_VisitorTypes)
        {
            return objSMS.AddVisitorType(p_VisitorTypes);
        }
        public int RemoveVisitorType(int ID)
        {
            return objSMS.RemoveVisitorType(ID);
        }
        #endregion

        #region KeyStatuses
        public List<KeyStatuses> GetKeyStatuses(int currentUserType, int deploymentId, string searchString)
        {
            searchString = searchString.ToString().Trim();
            return string.IsNullOrEmpty(searchString) ? objSMS.GetKeyStatuses(currentUserType,deploymentId) : objSMS.GetKeyStatuses(currentUserType,deploymentId).Where(s => s.StatusType.ToLower().Contains(searchString.ToLower())).ToList();
        }
        public KeyStatuses GetKeyStatusByID(int currentUserType, int deploymentId,int ID)
        {
            return ID == 0 ? null : objSMS.GetKeyStatusesByID(ID);
        }
        public int EditKeyStatus(KeyStatuses p_KeyStatus)
        {
            return objSMS.ModifyKeyStatus(p_KeyStatus);
        }
        public int AddKeyStatus(KeyStatuses p_KeyStatus)
        {
            return objSMS.AddKeyStatus(p_KeyStatus);
        }
        public int RemoveKeyStatus(int ID)
        {
            return objSMS.RemoveKeyStatus(ID);
        }
        #endregion

        #region LostAndFound
        public List<LostAndFound> GetLostAndFound(int currentUserType, int deploymentId, string searchString)
        {
            searchString = searchString.ToString().Trim();
            return string.IsNullOrEmpty(searchString) ? objSMS.GetLostAndFounds(currentUserType,deploymentId) : objSMS.GetLostAndFounds(currentUserType,deploymentId).Where(s => s.nameofperson.ToLower().Contains(searchString.ToLower()) || s.nric.ToLower().Contains(searchString.ToLower())).ToList();
        }
        public LostAndFound GetLostAndFoundByID(int currentUserType, int deploymentId,int ID)
        {
            return ID == 0 ? null : objSMS.GetLostAndFoundByID(currentUserType, deploymentId,ID);
        }
        public int EditLostAndFound(LostAndFound p_LostAndFound)
        {
            return objSMS.EditLostAndFound(p_LostAndFound);
        }
        public int AddLostAndFound(LostAndFound p_LostAndFound)
        {
            return objSMS.AddLostAndFound(p_LostAndFound);
        }
        public int RemoveLostAndFound(int ID)
        {
            return objSMS.RemoveLostAndFound(ID);
        }
        #endregion

        #region Incidents
        public List<Incidents> GetIncidents(int currentUserType, int deploymentId, string searchString)
        {
            searchString = searchString.ToString().Trim();
            //return string.IsNullOrEmpty(searchString) ? objSMS.GetIncidents() : objSMS.GetIncidents().Where(s => s.natureofincident.Contains(searchString) || s.briefdescription.Contains(searchString)).ToList();
            List<Incidents> objIncidentsCol = new List<Incidents>();
            List<Incidents> objIncidents = objSMS.GetIncidents(currentUserType,deploymentId);

            Incidents objIncident = null;

            foreach (Incidents incident in objIncidents)
            {
                objIncident = new Incidents();
                objIncident.incidentid = incident.incidentid;
                objIncident.locationid = incident.locationid;

                Location l = objSMS.GetLocationByID(incident.locationid);
                if (l != null)
                    objIncident.LocationName = l.LocationName;
                else
                    objIncident.LocationName = "";
                objIncident.natureofincident = incident.natureofincident;
                objIncident.particularsofpersons = incident.particularsofpersons;
                objIncident.briefdescription = incident.briefdescription;
                objIncident.dateofincident = incident.dateofincident;
                objIncident.snapshotpath = incident.snapshotpath;
                objIncident.deploymentid = incident.deploymentid;
                //objIncident.remarksandactionstaken = incident.remarksandactionstaken;
                //objIncident.reportdate = incident.reportdate;
                objIncidentsCol.Add(objIncident);
            }
            return string.IsNullOrEmpty(searchString) ? objIncidentsCol : objIncidentsCol.Where(i => i.LocationName.ToLower().Contains(searchString.ToLower()) || i.natureofincident.ToLower().Contains(searchString.ToLower()) || i.particularsofpersons.ToLower().Contains(searchString.ToLower())).ToList();
        }

        public List<Incidents> GetIncidentsByFilters(int currentUserType, int deploymentId, int startdate, int startmonth, int startyear, int enddate, int endmonth, int endyear)
        {
            List<Incidents> objIncidentsCol = new List<Incidents>();
            List<Incidents> objIncidents = objSMS.GetIncidentsByFilters(currentUserType,deploymentId, startdate, startmonth, startyear, enddate, endmonth, endyear);

            Incidents objIncident = null;

            foreach (Incidents incident in objIncidents)
            {
                objIncident = new Incidents();
                objIncident.incidentid = incident.incidentid;
                objIncident.locationid = incident.locationid;
                objIncident.LocationName = objSMS.GetLocationByID(incident.locationid).LocationName;
                objIncident.natureofincident = incident.natureofincident;
                objIncident.particularsofpersons = incident.particularsofpersons;
                objIncident.briefdescription = incident.briefdescription;
                objIncident.dateofincident = incident.dateofincident;
                objIncident.snapshotpath = incident.snapshotpath;
                objIncident.deploymentid = incident.deploymentid;
                //objIncident.remarksandactionstaken = incident.remarksandactionstaken;
                //objIncident.reportdate = incident.reportdate;
                objIncidentsCol.Add(objIncident);
            }
            return objIncidentsCol;
        }
        public Incidents GetIncidentByID(int currentUserType, int deploymentId, int ID)
        {
            Incidents objIncident = new Incidents();

            Incidents incident = ID == 0 ? null : objSMS.GetIncidentsByID(currentUserType, deploymentId,ID);
            if (incident != null)
            {
                objIncident.incidentid = incident.incidentid;
                objIncident.briefdescription = incident.briefdescription;
                objIncident.dateofincident = incident.dateofincident;
                objIncident.locationid = incident.locationid;
                objIncident.natureofincident = incident.natureofincident;
                objIncident.particularsofpersons = incident.particularsofpersons;
                objIncident.remarksandactionstaken = incident.remarksandactionstaken;
                objIncident.reportdate = incident.reportdate;
                objIncident.snapshotpath = incident.snapshotpath;
                objIncident.deploymentid = incident.deploymentid;
            }
            objIncident.reportdate = DateTime.Now;
            objIncident.LocationsList = objSMS.GetLocationsList( currentUserType,  deploymentId);
            return objIncident;
        }
        
        public int EditIncident(Incidents p_Incidents)
        {
            return objSMS.EditIncident(p_Incidents);
        }
        
        public int AddIncident(Incidents p_Incidents)
        {
            return objSMS.AddIncident(p_Incidents);
        }
        
        public int RemoveIncidents(int ID)
        {
            return objSMS.RemoveIncident(ID);
        }
        #endregion

        #region Occurance
        public List<Occurrance> GetOccurrences(int currentUserType, int deploymentId)
        {
            return objSMS.GetOccurrences(currentUserType,deploymentId);
        }

        public List<Occurrance> GetOccurrencesByFilters(int currentUserType, int deploymentId,int startdate, int startmonth,int startyear,int enddate,int endmonth,int endyear)
        {
            return objSMS.GetOccurrencesByFilters(currentUserType,deploymentId, startdate,startmonth,startyear,enddate,endmonth,endyear);
        }

        public Occurrance GetOccurranceByID(int currentUserType, int deploymentId,int ID)
        {
            return objSMS.GetOccurranceByID(currentUserType, deploymentId,ID);
        }
        public int AddOccurrance(Occurrance p_Occurance)
        {
            return objSMS.AddOccurance(p_Occurance);
        }
        public int EditOccurrance(Occurrance p_Occurance)
        {
            return objSMS.EditOccurrance(p_Occurance);
        }
        public int DeleteOccurances(int ID)
        {
            return objSMS.RemoveOccurance(ID);
        }
        #endregion

        #region EventMaster
        public List<EventMaster> GetEventMaster(int currentUserType, int deploymentId,string searchString)
        {
            searchString = searchString.ToString().Trim();
            //return string.IsNullOrEmpty(searchString) ? objSMS.GetEventMaster() : objSMS.GetEventMaster().Where(s => s.natureofincident.Contains(searchString) || s.briefdescription.Contains(searchString)).ToList();
            List<EventMaster> objEventMasterCol = new List<EventMaster>();
            List<EventMaster> objEventsMaster = objSMS.GetEventMasters(currentUserType,deploymentId);

            EventMaster objEventMaster = null;

            foreach (EventMaster eventmaster in objEventsMaster)
            {
                objEventMaster = new EventMaster();
                objEventMaster.eventid = eventmaster.eventid;
                objEventMaster.locationid = eventmaster.locationid;
                Location l = objSMS.GetLocationByID(eventmaster.locationid);
                if(l != null)
                    objEventMaster.LocationName = l.LocationName;
                else
                    objEventMaster.LocationName = "";
                objEventMaster.startdate = eventmaster.startdate;
                objEventMaster.enddate = eventmaster.enddate;
                objEventMaster.eventname = eventmaster.eventname;
                objEventMaster.DeploymentId = eventmaster.DeploymentId;
                objEventMaster.DeploymentName = objSMS.GetDeploymentByID(eventmaster.DeploymentId).DeploymentName;
                //objEventMaster.notes = eventmaster.notes;
                //objEventMaster.numberofguards = incident.remarksandactionstaken;
                //objIncident.reportdate = incident.reportdate;
                objEventMasterCol.Add(objEventMaster);
            }
            return string.IsNullOrEmpty(searchString) ? objEventMasterCol : objEventMasterCol.Where(e => e.LocationName.ToLower().Contains(searchString.ToLower()) || e.eventname.ToLower().Contains(searchString.ToLower())).ToList();
        }
        public EventMaster GetEventMasterByID(int currentUserType, int deploymentId,int ID)
        {
            EventMaster objEventMaster = new EventMaster();

            EventMaster eventmaster = ID == 0 ? null : objSMS.GetEventMasterByID(ID);
            if (eventmaster != null)
            {
                objEventMaster.eventid = eventmaster.eventid;
                objEventMaster.locationid = eventmaster.locationid;
                objEventMaster.DeploymentId = eventmaster.DeploymentId;
                objEventMaster.LocationName = objSMS.GetLocationByID(eventmaster.locationid).LocationName;
                objEventMaster.startdate = eventmaster.startdate;
                objEventMaster.enddate = eventmaster.enddate;
                objEventMaster.eventname = eventmaster.eventname;
                objEventMaster.notes = eventmaster.notes;
                objEventMaster.numberofguards = eventmaster.numberofguards;
                objEventMaster.specialdutyforguard = eventmaster.specialdutyforguard;
                objEventMaster.optionalguestlist = eventmaster.optionalguestlist;
                objEventMaster.personinchargecontactnumber = eventmaster.personinchargecontactnumber;
                objEventMaster.personinchargename = eventmaster.personinchargename;
                objEventMaster.personinchargenric = eventmaster.personinchargenric;
            }
            objEventMaster.LocationsList = objSMS.GetLocationsList(currentUserType,deploymentId);
            objEventMaster.DeploymentList = objSMS.GetDeploymentList(currentUserType,  deploymentId);;
            return objEventMaster;
        }
        public int EditEventMaster(EventMaster p_EventMaster)
        {
            return objSMS.EditEventMaster(p_EventMaster);
        }
        public int AddEventMaster(EventMaster p_EventMaster)
        {
            return objSMS.AddEventMaster(p_EventMaster);
        }
        public int RemoveEventMaster(int ID)
        {
            return objSMS.RemoveEventMaster(ID);
        }
        #endregion

        #region VisitorCheckInOut
        public List<VisitorCheckInOut> GetVisitorCheckInOut(int currentUserType, int deploymentId,string searchString)
        {
            searchString = searchString.ToString().Trim();
            //return string.IsNullOrEmpty(searchString) ? objSMS.GetEventMaster() : objSMS.GetEventMaster().Where(s => s.natureofincident.Contains(searchString) || s.briefdescription.Contains(searchString)).ToList();
            List<VisitorCheckInOut> objVisitorCheckInOutCol = new List<VisitorCheckInOut>();
            List<VisitorCheckInOut> objVisitorCheckInOuts = objSMS.GetVisitorCheckInOut(currentUserType,deploymentId);

            VisitorCheckInOut objVisitorCheckInOut = null;

            foreach (VisitorCheckInOut visitorcheckinout in objVisitorCheckInOuts)
            {
                objVisitorCheckInOut = new VisitorCheckInOut();
                objVisitorCheckInOut.nricid = visitorcheckinout.nricid;
                objVisitorCheckInOut.name = visitorcheckinout.name;
                objVisitorCheckInOut.passid = Convert.ToInt32(visitorcheckinout.passid);
                objVisitorCheckInOut.address = visitorcheckinout.address;
                objVisitorCheckInOut.blockorphone = visitorcheckinout.blockorphone;

                objVisitorCheckInOut.checkintime = Convert.ToDateTime(visitorcheckinout.checkintime);
                objVisitorCheckInOut.checkouttime = Convert.ToDateTime(visitorcheckinout.checkouttime);

                if ("01-01-0001 00:00:00".Equals(Convert.ToDateTime(objVisitorCheckInOut.checkouttime).ToString()) || objVisitorCheckInOut.checkouttime.Year == 1)
                    objVisitorCheckInOut.cotime = "";
                else
                    objVisitorCheckInOut.cotime = objVisitorCheckInOut.checkouttime.ToString();

                objVisitorCheckInOut.eventid = Convert.ToInt32(visitorcheckinout.eventid);
                objVisitorCheckInOut.fromcompany = visitorcheckinout.fromcompany;
                objVisitorCheckInOut.gateid = Convert.ToInt32(visitorcheckinout.gateid);
                objVisitorCheckInOut.guardname = visitorcheckinout.guardname;
                objVisitorCheckInOut.keyid = visitorcheckinout.keyid;
                objVisitorCheckInOut.name = visitorcheckinout.name;
                objVisitorCheckInOut.persontovisit = visitorcheckinout.persontovisit;
                objVisitorCheckInOut.remarks = visitorcheckinout.remarks;
                objVisitorCheckInOut.telno = visitorcheckinout.telno;
                objVisitorCheckInOut.temp = Convert.ToInt32(visitorcheckinout.temp);
                objVisitorCheckInOut.tocompany = Convert.ToInt32(visitorcheckinout.tocompany);
                Companies c = objSMS.GetCompanyByID(visitorcheckinout.tocompany);

                if (c != null)
                    objVisitorCheckInOut.CompanyName = c.CompanyName;
                else
                    objVisitorCheckInOut.CompanyName = "";

                EventMaster evm = objSMS.GetEventMasterByID(visitorcheckinout.eventid);

                string evname = "";
                if (evm != null)
                    evname = evm.eventname;

                objVisitorCheckInOut.EventName = visitorcheckinout.eventid == 0 ? "" : evname;
                objVisitorCheckInOut.snapshotpath = visitorcheckinout.snapshotpath;
                objVisitorCheckInOut.deploymentid = visitorcheckinout.deploymentid;
                objVisitorCheckInOutCol.Add(objVisitorCheckInOut);
            }

            return string.IsNullOrEmpty(searchString) ? objVisitorCheckInOutCol : objVisitorCheckInOutCol.Where(e => e.name.ToLower().Contains(searchString.ToLower())
                    || e.CompanyName.ToLower().Contains(searchString.ToLower())
                    || e.nricid.ToLower().Contains(searchString.ToLower()) || e.fromcompany.ToLower().Contains(searchString.ToLower())
                    || e.persontovisit.ToLower().Contains(searchString.ToLower()) || e.EventName.ToLower().Contains(searchString.ToLower())
                    ).ToList();
        }

        public List<VisitorCheckInOut> GetVisitorCheckInOutByFilters(int currentUserType, int deploymentId,int startdate, int startmonth, int startyear, int enddate, int endmonth, int endyear)
        {
            List<VisitorCheckInOut> objVisitorCheckInOutCol = new List<VisitorCheckInOut>();
            List<VisitorCheckInOut> objVisitorCheckInOuts = objSMS.GetVisitorCheckInOutByFilters(currentUserType,deploymentId, startdate, startmonth, startyear, enddate, endmonth, endyear);
            VisitorCheckInOut objVisitorCheckInOut = null;

            foreach (VisitorCheckInOut visitorcheckinout in objVisitorCheckInOuts)
            {
                objVisitorCheckInOut = new VisitorCheckInOut();
                objVisitorCheckInOut.nricid = visitorcheckinout.nricid;
                objVisitorCheckInOut.name = visitorcheckinout.name;
                objVisitorCheckInOut.passid = Convert.ToInt32(visitorcheckinout.passid);
                objVisitorCheckInOut.address = visitorcheckinout.address;
                objVisitorCheckInOut.blockorphone = visitorcheckinout.blockorphone;

                objVisitorCheckInOut.checkintime = Convert.ToDateTime(visitorcheckinout.checkintime);
                objVisitorCheckInOut.checkouttime = Convert.ToDateTime(visitorcheckinout.checkouttime);

                if ("01-01-0001 00:00:00".Equals(Convert.ToDateTime(objVisitorCheckInOut.checkouttime).ToString()) || objVisitorCheckInOut.checkouttime.Year == 1)
                    objVisitorCheckInOut.cotime = "";
                else
                    objVisitorCheckInOut.cotime = objVisitorCheckInOut.checkouttime.ToString();

                objVisitorCheckInOut.eventid = Convert.ToInt32(visitorcheckinout.eventid);
                objVisitorCheckInOut.fromcompany = visitorcheckinout.fromcompany;
                objVisitorCheckInOut.gateid = Convert.ToInt32(visitorcheckinout.gateid);
                objVisitorCheckInOut.guardname = visitorcheckinout.guardname;
                objVisitorCheckInOut.keyid = visitorcheckinout.keyid;
                objVisitorCheckInOut.name = visitorcheckinout.name;
                objVisitorCheckInOut.persontovisit = visitorcheckinout.persontovisit;
                objVisitorCheckInOut.remarks = visitorcheckinout.remarks;
                objVisitorCheckInOut.telno = visitorcheckinout.telno;
                objVisitorCheckInOut.temp = Convert.ToInt32(visitorcheckinout.temp);
                objVisitorCheckInOut.tocompany = Convert.ToInt32(visitorcheckinout.tocompany);

                Companies c = objSMS.GetCompanyByID(visitorcheckinout.tocompany);

                if (c != null)
                    objVisitorCheckInOut.CompanyName = c.CompanyName;
                else
                    objVisitorCheckInOut.CompanyName = "";

                EventMaster evm = objSMS.GetEventMasterByID(visitorcheckinout.eventid);

                string evname = "";
                if (evm != null)
                    evname = evm.eventname;

                objVisitorCheckInOut.EventName = visitorcheckinout.eventid == 0 ? "" : evname;
                objVisitorCheckInOut.snapshotpath = visitorcheckinout.snapshotpath;
                objVisitorCheckInOut.deploymentid = visitorcheckinout.deploymentid;
                objVisitorCheckInOutCol.Add(objVisitorCheckInOut);
            }

            return objVisitorCheckInOutCol;
        }

        public VisitorCheckInOut GetVisitorCheckInOutByID(int currentUserType, int deploymentId, string ID, int p_EventId,int p_VisitorTypeId)
        {
            VisitorCheckInOut objVisitorCheckInOut = new VisitorCheckInOut();

            VisitorCheckInOut visitorcheckinout = ID == "0" ? null : objSMS.GetVisitorCheckInOutdByID(ID, p_EventId);
            if (visitorcheckinout != null)
            {
                objVisitorCheckInOut.nricid = visitorcheckinout.nricid;
                objVisitorCheckInOut.passid = Convert.ToInt32(visitorcheckinout.passid);
                objVisitorCheckInOut.address = visitorcheckinout.address;
                objVisitorCheckInOut.blockorphone = visitorcheckinout.blockorphone;

                objVisitorCheckInOut.checkintime = Convert.ToDateTime(visitorcheckinout.checkintime);
                objVisitorCheckInOut.checkouttime = Convert.ToDateTime(visitorcheckinout.checkouttime);
                objVisitorCheckInOut.eventid = Convert.ToInt32(visitorcheckinout.eventid);
                objVisitorCheckInOut.fromcompany = visitorcheckinout.fromcompany;
                objVisitorCheckInOut.gateid = Convert.ToInt32(visitorcheckinout.gateid);
                objVisitorCheckInOut.guardname = visitorcheckinout.guardname;
                objVisitorCheckInOut.keyid = visitorcheckinout.keyid;
                objVisitorCheckInOut.name = visitorcheckinout.name;
                objVisitorCheckInOut.persontovisit = visitorcheckinout.persontovisit;
                objVisitorCheckInOut.remarks = visitorcheckinout.remarks;
                objVisitorCheckInOut.telno = visitorcheckinout.telno;
                objVisitorCheckInOut.temp = Convert.ToInt32(visitorcheckinout.temp);
                objVisitorCheckInOut.tocompany = Convert.ToInt32(visitorcheckinout.tocompany);
                objVisitorCheckInOut.visitortypeID = visitorcheckinout.visitortypeID;
                objVisitorCheckInOut.snapshotpath = visitorcheckinout.snapshotpath;
            }

            objVisitorCheckInOut.CompaniesList = objSMS.GetCompanies(currentUserType, deploymentId);
            objVisitorCheckInOut.VisitorTypesCol = objSMS.GetVisitorTypes(currentUserType,  deploymentId);
            objVisitorCheckInOut.GatesList = objSMS.GetGatesList(currentUserType,  deploymentId);
            //objVisitorCheckInOut.PassesList = objSMS.GetPasses(currentUserType,  deploymentId);
            objVisitorCheckInOut.PassesList = objSMS.GetPassesByVisitorType(currentUserType, deploymentId, p_VisitorTypeId);
            objVisitorCheckInOut.EventsList = objSMS.GetEventMasters(currentUserType,  deploymentId);
            objVisitorCheckInOut.KeysList = objSMS.GetKeysList(currentUserType,  deploymentId);

            return objVisitorCheckInOut;
        }

        public int EditVisitorCheckInOut(VisitorCheckInOut p_VisitorCheckInOut)
        {
            return objSMS.EditVisitorCheckInOut(p_VisitorCheckInOut);
        }
        public int AddVisitorCheckInOut(VisitorCheckInOut p_VisitorCheckInOut)
        {
            return objSMS.AddVisitorCheckInOut(p_VisitorCheckInOut);
        }
        public int RemoveVisitorCheckInOut(int ID)
        {
            return objSMS.RemoveVisitorCheckInOut(ID);
        }
        #endregion

        #region Vehicles
        public List<Vehicles> GetVehicles(int currentUserType, int deploymentId,string searchString)
        {
            searchString = searchString.ToString().Trim();
            return objSMS.GetVehicles(currentUserType,deploymentId, searchString);
        }
        public Vehicles GetVehicleByID(int currentUserType, int deploymentId , string ID)
        {
            return objSMS.GetVehicleByID(currentUserType, deploymentId,ID);
        }
        public int AddVehicle(Vehicles p_Vehicles)
        {
            return objSMS.AddVehicle(p_Vehicles);
        }
        public int EditVehicles(Vehicles p_Vehicles)
        {
            return objSMS.EditVehicle(p_Vehicles);
        }
        public int RemoveVehicle(string ID)
        {
            return objSMS.RemoveVehicle(ID);
        }
        #endregion

        public List<ItemStatus> GetPassesStatuses()
        {
            List<ItemStatus> objItemStatusCol = new List<ItemStatus>();
            objItemStatusCol.Add(new ItemStatus { StatusID = 1, Status = "Active" });
            objItemStatusCol.Add(new ItemStatus { StatusID = 2, Status = "Inactive" });
            return objItemStatusCol;
        }
        public List<ItemStatus> GetKeyStatuses()
        {
            List<ItemStatus> keyStatusCol = new List<ItemStatus>();
            keyStatusCol.Add(new ItemStatus { StatusID = 1, Status = "Active" });
            keyStatusCol.Add(new ItemStatus { StatusID = 2, Status = "Broken" });
            keyStatusCol.Add(new ItemStatus { StatusID = 3, Status = "For Repair" });
            keyStatusCol.Add(new ItemStatus { StatusID = 4, Status = "Inactive" });
            keyStatusCol.Add(new ItemStatus { StatusID = 5, Status = "Stolen" });
            return keyStatusCol;
        }
    }

    #region PassesInfo
    public class PassesViewModel
    {
        public int PassId { get; set; }
        public int DeploymentId { get; set; }
        public string DeploymentName { get; set; }
        public string PassName { get; set; }
        public string PassStatus { get; set; }
        public int VisitortypeId { get; set; }
        public string VisitorType { get; set; }
        public int PassStatusID { get; set; }
        public List<VisitorTypes> VisitorTypesCol { get; set; }
        public List<Deployement> Deployments { get; set; }
        public List<ItemStatus> PassStatuses { get; set; }
    }
    #endregion

    #region UserInfo
    public class UserViewModel
    {
        #region Properties
        public int UID { get; set; }
        public int DeploymentID { get; set; }
        public int UserTypeID { get; set; }
        [Required]
        public string LoginID { get; set; }
        [Required]
        public string UserName { get; set; }
        public string EmailID { get; set; }
        [Required]
        public string Password { get; set; }
        #endregion
        public string DeploymentName { get; set; }
        public string UserType { get; set; }
        public List<UserTypes> UserTypes { get; set; }
        public List<Deployement> Deployements { get; set; }
        public UserViewModel()
        {
            UID = 0;
            DeploymentID = 0;
            UserTypeID = 0;
        }
    }
    #endregion

    #region GatesInfo
    public class GatesViewModel
    {
        #region Properties
        public int GateId { get; set; }
        public int DeploymentId { get; set; }
        public string GateName { get; set; }
        public string DeploymentName { get; set; }
        public Nullable<DateTime> AddedDate { get; set; }
        public List<Deployments> Deployments { get; set; }
        #endregion
    }
    #endregion

    #region KeysInfo
    public class KeysViewModel
    {
        #region properties
        public int KeyId { get; set; }
        public int DeploymentId { get; set; }
        public int StatusID { get; set; }
        public string DeploymentName { get; set; }
        public string KeyName { get; set; }
        public string Status { get; set; }
        public Nullable<DateTime> AddedDate { get; set; }
        public List<Deployement> Deployements { get; set; }
        public List<KeyStatuses> KeyStatuses { get; set; }
        #endregion

        public KeysViewModel()
        {
            KeyId = 0;
            DeploymentId = 0;
        }
    }
    #endregion

    #region VisitorsInfo
    public class VisitorsViewModel
    {
        #region properties
        public int VisitorId { get; set; }
        public int DeploymentId { get; set; }
        public string NRIC { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string Address { get; set; }
        public string ContactNumber { get; set; }
        public string CompanyName { get; set; }
        public Int16 IsBlacklisted { get; set; }
        public int eventid { get; set; }
        public Nullable<DateTime> AddedDate { get; set; }
        public string DeploymentName { get; set; }
        public List<Deployement> Deployements { get; set; }
        #endregion
        public VisitorsViewModel()
        {
            VisitorId = 0;
            DeploymentId = 0;
            IsBlacklisted = 0;
        }
    }
    #endregion

    #region LocationInfo
    public class LocatonViewModel
    {
        #region Properties
        public int LocationId { get; set; }
        public int DeploymentId { get; set; }
        public string LocationName { get; set; }
        public string DeploymentName { get; set; }
        public List<Deployement> Deployements { get; set; }
        #endregion
        public LocatonViewModel()
        {
            LocationId = 0;
            DeploymentId = 0;
            LocationName = string.Empty;
        }
    }

    #region Company
    public class CompanyViewModel
    {
        public int CompanyId { get; set; }
        public string CompanyName { get; set; }
        public string Address { get; set; }
        public string ContactNumber { get; set; }
        public int DeploymentId { get; set; }
        public string DeploymentName { get; set; }
        public List<Deployement> Deployments { get; set; }
    }
    #endregion
    #endregion

    #region Status
    public class ItemStatus
    {
        public int StatusID { get; set; }
        public string Status { get; set; }
    }
    #endregion

    public class Deployments
    {
        public int DeploymentId { get; set; }
        public string DeploymentName { get; set; }
    }

}