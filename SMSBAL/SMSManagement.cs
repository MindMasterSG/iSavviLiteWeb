using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SMSDAL.SMSDB;
using SMSEntities.SMSDBEntities;
using System.Data;
namespace SMSBAL
{
   public class SMSManagement
   {
       #region Local variables
       DeployementDBAccess objDeployment = new DeployementDBAccess();
       UserInfoDBAccess objUserInfo = new UserInfoDBAccess();
       UserTypeDBAccess objUserType = new UserTypeDBAccess();
       KeyDBA objKeyDBA = new KeyDBA();
       GateDBA objGateDBA = new GateDBA();
       EventDBA objEventDBA = new EventDBA();
       LocationDBA objLocationDBA = new LocationDBA();
       VisitorDBA objVisitorDBA = new VisitorDBA();
       VisitorTypeDBA objVisitorTypeDBA = new VisitorTypeDBA();

       CompanyDBA objCompanyDBA = new CompanyDBA();
       PassesDBA objPassesDBA = new PassesDBA();
       IncidentsDBA objIncidentsDBA = new IncidentsDBA();
       OccurancesDBA objOccurancesDBA = new OccurancesDBA();
       EventMasterListDBA objEventMasterListDBA = new EventMasterListDBA();
       KeyStatusesDBA objKeyStatusesDBA = new KeyStatusesDBA();

       LostAndFoundDBA objLostAndFoundDBA = new LostAndFoundDBA();
       VisitorCheckInOutDBA objVisitorCheckInOutDBA = new VisitorCheckInOutDBA();
       VehiclesDBA objVehiclesDBA = new VehiclesDBA();
        VehiclesTypeDBA objVehicleTypesDBA = new VehiclesTypeDBA();
        PurposeDBA objPurposeDBA = new PurposeDBA();
        #endregion

        #region Deployment
        public int AddDeployment(Deployement p_Deployement)
       {return objDeployment.InsertDeployment(p_Deployement); }

       public int ModifyDeployment(Deployement p_Deployement)
       { return objDeployment.UpdateDeployment(p_Deployement); }

       public int RemoveDeployment(int p_DeploymentID)
       {
           return objDeployment.DeleteDeployment(p_DeploymentID);
       }

       public List<Deployement> GetDeploymentList(int currentUserType, int deploymentId)
       { return objDeployment.SeletctDeploymentList(currentUserType,deploymentId);  }

       public Deployement GetDeploymentByID(int ID)
       { return objDeployment.SeletctDeploymentByID(ID); }
       #endregion

       #region Events
       public int AddEvent(Events p_Event)
       {
           return objEventDBA.InsertEvent(p_Event);
       }
       public int ModifyEvent(Events p_Event)
       {
           return objEventDBA.UpdateEvent(p_Event);
       }
       public int RemoveEvent(int p_EventID)
       {
           return objEventDBA.DeleteEvent(p_EventID);
       }
       public List<Events> GetEventsList(int currentUserType, int deploymentId)
       {
           return objEventDBA.SelectEvents( currentUserType,  deploymentId);
       }
       public Events GetEventByID(int p_EventID)
       {
           return objEventDBA.SelectEvent(p_EventID);
       }
       #endregion

       #region Key
       public int AddKey(KEYS p_KEYS)
       {
           return objKeyDBA.InsertKey(p_KEYS);
       }
       public int ModifyKey(KEYS p_KEYS)
       {
           return objKeyDBA.UpadateKey(p_KEYS);
       }
       public int RemoveKey(int p_KeyId)
       {
           return objKeyDBA.DeleteKey(p_KeyId);
       }
       public List<KEYS> GetKeysList(int currentUserType, int deploymentId)
       {
           return objKeyDBA.SelectKEYS( currentUserType,  deploymentId);
       }
       public KEYS GetKeyByID(int p_KeyId)
       {
           return objKeyDBA.SelectKEY(p_KeyId);
       }
       #endregion

       #region Gate
       public int AddGate(Gates p_Gate)
       {
           return objGateDBA.InsertGate(p_Gate);
       }
       public int ModifyGate(Gates p_Gate)
       {
           return objGateDBA.UpdateGate(p_Gate);
       }
       public int RemoveGate(int p_GateId)
       {
           return objGateDBA.DeleteGate(p_GateId);
       }
       public List<Gates> GetGatesList(int currentUserType, int deploymentId)
       {
           return objGateDBA.SelectGates( currentUserType,  deploymentId);
       }
       public Gates GetGateByID(int p_GateId)
       {
           return objGateDBA.SelectGate(p_GateId);
       }
       #endregion

       #region Location
       public int AddLocation(Location p_Location)
       {
           return objLocationDBA.InsertLocation(p_Location);
       }
       public int ModifyLocation(Location p_Location)
       {
           return objLocationDBA.UpadateLocation(p_Location);
       }
       public int RemoveLocation(int p_LocationID)
       {
           return objLocationDBA.DeleteLocation(p_LocationID);
       }
       public List<Location> GetLocationsList(int currentUserType, int deploymentId)
       {
           return objLocationDBA.SelectLocations( currentUserType,  deploymentId);
       }
       public Location GetLocationByID(int p_LocationID)
       {
           return objLocationDBA.SelectLocation(p_LocationID);       
       }
       #endregion

       #region Visitor
       public int AddVisitor(Visitors p_Visitor)
       {
           return objVisitorDBA.InsertVisitor(p_Visitor);
       }
       public int ModifyVisitor(Visitors p_Visitor)
       {
           return objVisitorDBA.UpdateVisitor(p_Visitor);
       }
       public int RemoveVisitor(int p_VisitorID)
       {
           return objVisitorDBA.DeleteVisitor(p_VisitorID);
       }
       public List<Visitors> GetVisitorsList(int currentUserType, int deploymentId)
       {
           return objVisitorDBA.SelectVisitors( currentUserType,  deploymentId);
       }
       public Visitors GetVisitorByID(int currentUserType, int deploymentId,int p_VisitorID)
       {
           return objVisitorDBA.SelectVisitor(currentUserType,  deploymentId,p_VisitorID);
       }
       public List<Visitors> GetParticipantsByEventID(int currentUserType, int deploymentId,int ID)
       {
           return objVisitorDBA.SelectParticipantsByEventID( currentUserType,deploymentId, ID);
       }
       #endregion

       #region VisitorType
       public int AddVisitorType(VisitorTypes p_VisitorType)
       {
           return objVisitorTypeDBA.InsertVisitorType(p_VisitorType);
       }
       public int ModifyVisitorType(VisitorTypes p_VisitorType)
       {
           return objVisitorTypeDBA.UpdateVisitorType(p_VisitorType);
       }
       public int RemoveVisitorType(int p_VisitortypeId)
       {
           return objVisitorTypeDBA.DeleteVisitorType(p_VisitortypeId);
       }
       public List<VisitorTypes> GetVisitorTypes(int currentUserType, int deploymentId)
       {
           return objVisitorTypeDBA.SelectVisitorTypes( currentUserType,  deploymentId);
       }
       public VisitorTypes GetVisitorTypeByID(int p_VisitortypeId)
       {
           return objVisitorTypeDBA.SelectVisitorTypeByID( p_VisitortypeId);
       }
       #endregion

       #region UserInfo
       public UserInfo IsUserExists(UserInfo p_UserInfo)
       {
           return objUserInfo.IsUserExists(p_UserInfo);
       }

       public List<UserInfo> GetUsersByUserTypeID(int currentUserType, int deploymentId,int ID)
       { return objUserInfo.SeletctUsersListByUserTypeID(ID); }

       public List<UserInfo> GetUsers(int deploymentId,int currentUserType)
       { return objUserInfo.SeletctUsersList(deploymentId, currentUserType); }

       public List<UserInfo> GetUsersByDeploymentID(int deploymentId)
       { return objUserInfo.SelectUsersByDeploymentId(deploymentId); }

       public UserInfo GetUserByID(int UID)
       {
           return objUserInfo.SeletctUserInfoByID(UID);
       }
       public int AddUserInfo(UserInfo p_UserInfo)
       {
           return objUserInfo.InsertUserInfo(p_UserInfo);
       }
       public int EditUserInfo(UserInfo p_UserInfo)
       {
           return objUserInfo.UpdateUserInfo(p_UserInfo);
       }
       public int RemoveUser(int UID)
       {
           return objUserInfo.DeleteUser(UID);
       }
       #endregion

       #region UserType
       public int AddUserType(UserTypes p_UserType)
       {
           return objUserType.InsertUserType(p_UserType);
       }
       public int ModifyUserType(UserTypes p_UserType)
       {
           return objUserType.UpdateUserType(p_UserType);
       }
       public List<UserTypes> GetUserTypes(int currentUserType, int deploymentId)
       {
           return objUserType.SeletctUserTypes( currentUserType,  deploymentId);
       }

       public UserTypes GetUserTypeByID(int currentUserType, int deploymentId,int ID)
       {
           return objUserType.SeletctUserTypeByID(currentUserType, deploymentId,ID);
       }
       #endregion

       #region Key Status Type
       public int AddKeyStatus(KeyStatuses p_KeyStatuses)
       {
           return objKeyStatusesDBA.InsertKeyStatuses(p_KeyStatuses);
       }
       public int ModifyKeyStatus(KeyStatuses p_KeyStatuses)
       {
           return objKeyStatusesDBA.UpdateKeyStatuses(p_KeyStatuses);
       }
       public List<KeyStatuses> GetKeyStatuses(int currentUserType, int deploymentId)
       {
           return objKeyStatusesDBA.SelectKeyStatuses( currentUserType,  deploymentId);
       }

       public KeyStatuses GetKeyStatusesByID(int ID)
       {
           return objKeyStatusesDBA.SelectKeyStatusesByID(ID);
       }
       public int RemoveKeyStatus(int ID)
       {
           return objKeyStatusesDBA.DeleteKeyStatuses(ID);
       }
       #endregion

       #region New Methods

       #region Company
       public List<Companies> GetCompanies(int currentUserType, int deploymentId)
       {
           return objCompanyDBA.SelectCompanies(currentUserType, deploymentId);
       }
       public Companies GetCompanyByID(int ID)
       {
           return objCompanyDBA.SelectCompanyByID(ID);
       }
       public int AddCompany(Companies p_CompanyInfo)
       {
           return objCompanyDBA.InsertCompany(p_CompanyInfo);
       }
       public int EditCompany(Companies p_Companies)
       {
           return objCompanyDBA.UpadateCompanies(p_Companies);
       }
       public int RemoveCompany(int ID)
       {
           return objCompanyDBA.DeleteCompany(ID);
       }
       #endregion

       #region Incidents
       public List<Incidents> GetIncidents(int currentUserType, int deploymentId)
       {
           return objIncidentsDBA.SelectIncidents( currentUserType,  deploymentId);
       }
       public List<Incidents> GetIncidentsByFilters(int currentUserType, int deploymentId,int startdate, int startmonth, int startyear, int enddate, int endmonth, int endyear)
       {
           return objIncidentsDBA.SelectIncidentsByFilters( currentUserType,  deploymentId,startdate, startmonth, startyear, enddate, endmonth, endyear);
       }
       public Incidents GetIncidentsByID(int currentUserType, int deploymentId, int ID)
       {
           return objIncidentsDBA.SelectIncidentByID( currentUserType,  deploymentId,ID);
       }
       public int AddIncident(Incidents p_Incident)
       {
           return objIncidentsDBA.InsertIncident(p_Incident);
       }
       public int EditIncident(Incidents p_Incident)
       {
           return objIncidentsDBA.UpadateIncident(p_Incident);
       }
       public int RemoveIncident(int ID)
       {
           return objIncidentsDBA.DeleteIncidents(ID);
       }
       #endregion

       #region Passes
       public List<Passes> GetPasses(int currentUserType, int deploymentId)
       {
           return objPassesDBA.SelectPasses( currentUserType,  deploymentId);
       }
       public List<Passes> GetPassesByVisitorType(int currentUserType, int deploymentId, int visitorTypeId)
       {
           return objPassesDBA.SelectPassesByVisitorType(currentUserType, deploymentId, visitorTypeId);
       }
       public Passes GetPassByID(int currentUserType, int deploymentId, int ID)
       {
           return objPassesDBA.SelectPasseByID( currentUserType,  deploymentId,ID);
       }
       public int AddPass(Passes p_Passes)
       {
           return objPassesDBA.InsertPasses(p_Passes);
       }
       public int EditPass(Passes p_Passes)
       {
           return objPassesDBA.UpadatePasses(p_Passes);
       }
       public int RemovePass(int ID)
       {
           return objPassesDBA.DeletePasses(ID);
       }
       #endregion

       #region Occurance
       public List<Occurrance> GetOccurrences(int currentUserType, int deploymentId)
       {
           return objOccurancesDBA.SelectOccurrences( currentUserType,  deploymentId);
       }
       public List<Occurrance> GetOccurrencesByFilters(int currentUserType, int deploymentId,int startdate, int startmonth, int startyear, int enddate, int endmonth, int endyear)
       {
           return objOccurancesDBA.SelectOccurrencesByFilters(currentUserType, deploymentId,startdate, startmonth, startyear, enddate, endmonth, endyear);
       }
       public Occurrance GetOccurranceByID(int currentUserType, int deploymentId,int ID)
       {
           return objOccurancesDBA.SelectOccurranceByID(currentUserType, deploymentId,ID);
       }
       public int AddOccurance(Occurrance p_Occurance)
       {
           return objOccurancesDBA.InsertOccurances(p_Occurance);
       }
       public int EditOccurrance(Occurrance p_Occurance)
       {
           return objOccurancesDBA.UpadateOccurrance(p_Occurance);
       }
       public int RemoveOccurance(int ID)
       {
           return objOccurancesDBA.DeleteOccurances(ID);
       }
       #endregion

       #region Vehicles
       public List<Vehicles> GetVehicles(int currentUserType, int deploymentId,string searchString)
       {
           return string.IsNullOrEmpty(searchString) ? objVehiclesDBA.SelectVehicles( currentUserType,  deploymentId) : 
               objVehiclesDBA.SelectVehicles( currentUserType,  deploymentId).Where(v=>v.identificationunit.Contains(searchString)|| v.trailernumber.Contains(searchString) || v.platenumber.Contains(searchString)||v.securityguardname.Contains(searchString)).ToList();
       }
       public Vehicles GetVehicleByID(int currentUserType, int deploymentId, string ID)
       {
           return ID == "" ? null : objVehiclesDBA.SelectVehicleByID(currentUserType, deploymentId,ID);
       }
       public int AddVehicle(Vehicles p_Vehicles)
       {
           return objVehiclesDBA.InsertVehicle(p_Vehicles);
       }
       public int EditVehicle(Vehicles p_Vehicles)
       {
           return objVehiclesDBA.UpadateVehicle(p_Vehicles);
       }
       public int RemoveVehicle(string ID)
       {
           return objVehiclesDBA.DeleteVehicle(ID);
       }
        #endregion

        #region VehiclesTypes
        public List<VehicleTypes> GetVehiclesType(int currentUserType, int deploymentId, string searchString)
        {
            return string.IsNullOrEmpty(searchString) ? objVehicleTypesDBA.SelectVehiclesTypes(currentUserType, deploymentId) :
                objVehicleTypesDBA.SelectVehiclesTypes(currentUserType, deploymentId).Where(v => v.vehicletype.Contains(searchString)).ToList();
        }
        //public Vehicles GetVehicleTypeByID(int currentUserType, int deploymentId, string ID)
        //{
        //    return ID == "" ? null : objVehiclesDBA.SelectVehicleByID(currentUserType, deploymentId, ID);
        //}
        //public int AddVehicleType(Vehicles p_Vehicles)
        //{
        //    return objVehiclesDBA.InsertVehicle(p_Vehicles);
        //}
        //public int EditVehicleType(Vehicles p_Vehicles)
        //{
        //    return objVehiclesDBA.UpadateVehicle(p_Vehicles);
        //}
        //public int RemoveVehicleType(string ID)
        //{
        //    return objVehiclesDBA.DeleteVehicle(ID);
        //}
        #endregion

        #region Purposes
        public List<Purpose> GetPurposes(int currentUserType, int deploymentId, string searchString)
        {
            return string.IsNullOrEmpty(searchString) ? objPurposeDBA.SelectPurpose(currentUserType, deploymentId) :
                objPurposeDBA.SelectPurpose(currentUserType, deploymentId).Where(v => v.purpose.Contains(searchString)).ToList();
        }
        //public Vehicles GetVehicleTypeByID(int currentUserType, int deploymentId, string ID)
        //{
        //    return ID == "" ? null : objVehiclesDBA.SelectVehicleByID(currentUserType, deploymentId, ID);
        //}
        //public int AddVehicleType(Vehicles p_Vehicles)
        //{
        //    return objVehiclesDBA.InsertVehicle(p_Vehicles);
        //}
        //public int EditVehicleType(Vehicles p_Vehicles)
        //{
        //    return objVehiclesDBA.UpadateVehicle(p_Vehicles);
        //}
        //public int RemoveVehicleType(string ID)
        //{
        //    return objVehiclesDBA.DeleteVehicle(ID);
        //}
        #endregion

        #region EventMaster
        public List<EventMaster> GetEventMasters(int currentUserType, int deploymentId)
       {
           return objEventMasterListDBA.SelectEventMasters( currentUserType,  deploymentId);
       }
       public EventMaster GetEventMasterByID(int ID)
       {
           return objEventMasterListDBA.SelectEventMasterByID(ID);
       }
       public int AddEventMaster(EventMaster p_EventMaster)
       {
           return objEventMasterListDBA.InsertEventMaster(p_EventMaster);
       }
       public int EditEventMaster(EventMaster p_EventMaster)
       {
           return objEventMasterListDBA.UpadateEventMaster(p_EventMaster);
       }
       public int RemoveEventMaster(int ID)
       {
           return objEventMasterListDBA.DeleteEventMaster(ID);
       }
       #endregion

       #endregion

       #region Guard

       #region Lost And Found
       public List<LostAndFound> GetLostAndFounds(int currentUserType, int deploymentId)
       {
           return objLostAndFoundDBA.SelectLostAndFound( currentUserType,  deploymentId);
       }
       public LostAndFound GetLostAndFoundByID(int currentUserType, int deploymentId,int ID)
       {
           return objLostAndFoundDBA.SelectLostAndFoundById(ID);
       }
       public int AddLostAndFound(LostAndFound p_LostAndFound)
       {
           return objLostAndFoundDBA.InsertLostAndFound(p_LostAndFound);
       }
       public int EditLostAndFound(LostAndFound p_LostAndFound)
       {
           return objLostAndFoundDBA.UpadateLostAndFound(p_LostAndFound);
       }
       public int RemoveLostAndFound(int ID)
       {
           return objLostAndFoundDBA.DeleteLostAndFound(ID);
       }
       #endregion

       #region Visitor Check In - Out
       public List<VisitorCheckInOut> GetVisitorCheckInOut(int currentUserType, int deploymentId)
       {
           return objVisitorCheckInOutDBA.SelectVisitorCheckInOut( currentUserType,  deploymentId);
       }

       public List<VisitorCheckInOut> GetVisitorCheckInOutByFilters(int currentUserType, int deploymentId,int startdate, int startmonth, int startyear, int enddate, int endmonth, int endyear)
       {
           return objVisitorCheckInOutDBA.SelectVisitorCheckInOutByFilters( currentUserType,  deploymentId,startdate, startmonth, startyear, enddate, endmonth, endyear);
       }

       public VisitorCheckInOut GetVisitorCheckInOutdByID(string ID, int p_EventId)
       {
           return objVisitorCheckInOutDBA.SelectVisitorCheckInOutByID(ID,p_EventId);
       }
       public int AddVisitorCheckInOut(VisitorCheckInOut p_VisitorCheckInOut)
       {
           return objVisitorCheckInOutDBA.InsertVisitorCheckInOut(p_VisitorCheckInOut);
       }
       public int EditVisitorCheckInOut(VisitorCheckInOut p_VisitorCheckInOut)
       {
           return objVisitorCheckInOutDBA.UpadateVisitorCheckInOut(p_VisitorCheckInOut);
       }
       public int RemoveVisitorCheckInOut(int ID)
       {
           return objVisitorCheckInOutDBA.DeleteVisitorCheckInOut(ID);
       }
       #endregion
      
       #endregion
   }
}
