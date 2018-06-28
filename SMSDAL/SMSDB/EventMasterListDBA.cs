using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Data;
using SMSEntities.SMSDBEntities;

namespace SMSDAL.SMSDB
{
   public class EventMasterListDBA
    {
       public int InsertEventMaster(EventMaster p_EventMaster)
        {
           int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_startdate",p_EventMaster.startdate),
                new MySqlParameter("p_enddate",p_EventMaster.enddate),
                new MySqlParameter("p_locationid",p_EventMaster.locationid),
                new MySqlParameter("p_numberofguards",p_EventMaster.numberofguards),
                new MySqlParameter("p_specialdutyforguard",p_EventMaster.specialdutyforguard),
                new MySqlParameter("p_eventname",p_EventMaster.eventname),
                new MySqlParameter("p_notes",p_EventMaster.notes),
                new MySqlParameter("p_optionalguestlist",p_EventMaster.optionalguestlist),
                new MySqlParameter("p_personinchargename",p_EventMaster.personinchargename),
                new MySqlParameter("p_personinchargenric",p_EventMaster.personinchargenric),
                new MySqlParameter("p_personinchargecontactnumber",p_EventMaster.personinchargecontactnumber),
                new MySqlParameter("p_DeploymentId",p_EventMaster.DeploymentId),
                new MySqlParameter("p_Remarks",p_EventMaster.Remarks),
                new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddEventMasterList", CommandType.StoredProcedure, parameters);
        }

        public int UpadateEventMaster(EventMaster p_EventMaster)
        {
            int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_eventid",p_EventMaster.eventid),
                new MySqlParameter("p_startdate",p_EventMaster.startdate),
                new MySqlParameter("p_enddate",p_EventMaster.enddate),
                new MySqlParameter("p_locationid",p_EventMaster.locationid),
                new MySqlParameter("p_numberofguards",p_EventMaster.numberofguards),
                new MySqlParameter("p_specialdutyforguard",p_EventMaster.specialdutyforguard),
                new MySqlParameter("p_eventname",p_EventMaster.eventname),
                new MySqlParameter("p_notes",p_EventMaster.notes),
                new MySqlParameter("p_optionalguestlist",p_EventMaster.optionalguestlist),
                new MySqlParameter("p_personinchargename",p_EventMaster.personinchargename),
                new MySqlParameter("p_personinchargenric",p_EventMaster.personinchargenric),
                new MySqlParameter("p_personinchargecontactnumber",p_EventMaster.personinchargecontactnumber),
                new MySqlParameter("p_DeploymentId",p_EventMaster.DeploymentId),
                new MySqlParameter("p_Remarks",p_EventMaster.Remarks),
                new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateEventMasterList", CommandType.StoredProcedure, parameters);
        }

        public int DeleteEventMaster(int p_EventMasterID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_eventid",p_EventMasterID)};
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteEventMasterList", CommandType.StoredProcedure, parameters);
        }

        public List<EventMaster> SelectEventMasters(int currentUserType, int deploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
            List<EventMaster> OccurancesCol = new List<EventMaster>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetEventMasterList", CommandType.StoredProcedure,parameters);
            EventMaster objEventMaster = null;
            foreach (DataRow dr in dt.Rows)
            {
                objEventMaster = new EventMaster();
                objEventMaster.eventid = Convert.ToInt32(dr["eventid"].ToString());
                objEventMaster.startdate = Convert.ToDateTime(dr["startdate"].ToString());
                objEventMaster.enddate = Convert.ToDateTime(dr["enddate"].ToString());
                objEventMaster.locationid = Convert.ToInt32(dr["locationid"].ToString());
                objEventMaster.numberofguards = Convert.ToInt32(dr["numberofguards"].ToString());
                objEventMaster.specialdutyforguard = dr["specialdutyforguard"].ToString();
                objEventMaster.eventname = dr["eventname"].ToString();
                objEventMaster.notes = dr["notes"].ToString();
                objEventMaster.optionalguestlist = dr["optionalguestlist"].ToString();
                objEventMaster.personinchargename = dr["personinchargename"].ToString();
                objEventMaster.personinchargenric = dr["personinchargenric"].ToString();
                objEventMaster.personinchargecontactnumber = dr["personinchargecontactnumber"].ToString();
                objEventMaster.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                objEventMaster.Remarks = dr["Remarks"].ToString();
                OccurancesCol.Add(objEventMaster);
            }
            dt.Clear();
            dt.Dispose();
            return OccurancesCol;
        }

        public EventMaster SelectEventMasterByID( int p_EventMasterID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_eventid", p_EventMasterID)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetEventMasterListByID", CommandType.StoredProcedure, parameters);
            EventMaster objEventMaster = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objEventMaster = new EventMaster();
                objEventMaster.eventid = Convert.ToInt32(dr["eventid"].ToString());
                objEventMaster.startdate = Convert.ToDateTime(dr["startdate"].ToString());
                objEventMaster.enddate = Convert.ToDateTime(dr["enddate"].ToString());
                objEventMaster.locationid = Convert.ToInt32(dr["locationid"].ToString());
                objEventMaster.numberofguards = Convert.ToInt32(dr["numberofguards"].ToString());
                objEventMaster.specialdutyforguard = dr["specialdutyforguard"].ToString();
                objEventMaster.eventname = dr["eventname"].ToString();
                objEventMaster.notes = dr["notes"].ToString();
                objEventMaster.optionalguestlist = dr["optionalguestlist"].ToString();
                objEventMaster.personinchargename = dr["personinchargename"].ToString();
                objEventMaster.personinchargenric = dr["personinchargenric"].ToString();
                objEventMaster.personinchargecontactnumber = dr["personinchargecontactnumber"].ToString();
                objEventMaster.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                objEventMaster.Remarks = dr["Remarks"].ToString();
            }
            dt.Clear();
            dt.Dispose();
            return objEventMaster;
        }
    }
}
