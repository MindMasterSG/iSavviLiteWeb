using System;
using System.Collections.Generic;
using SMSEntities.SMSDBEntities;
using System.Data;
using MySql.Data.MySqlClient;

namespace SMSDAL.SMSDB
{
    public class EventDBA
    {
        public int InsertEvent(Events p_Event)
        {
            MySqlParameter[] parameters = new MySqlParameter[]{
        new MySqlParameter("p_DeploymentId", p_Event.DeploymentId),
        new MySqlParameter("p_EventName",p_Event.EventName),
        new MySqlParameter("p_EventDate", p_Event.EventDate),
        new MySqlParameter("p_Remarks",p_Event.Remarks)  };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddEvent", CommandType.StoredProcedure, parameters);
        }

        public int UpdateEvent(Events p_Event)
        {
            MySqlParameter[] parameters = new MySqlParameter[]{
                new MySqlParameter("p_EventId",p_Event.EventID),
        new MySqlParameter("p_DeploymentId", p_Event.DeploymentId),
        new MySqlParameter("p_EventName",p_Event.EventName),
        new MySqlParameter("p_EventDate", p_Event.EventDate),
        new MySqlParameter("p_Remarks",p_Event.Remarks)  };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateEvent", CommandType.StoredProcedure, parameters);
        }

        public int DeleteEvent(int p_EventID)
        {
            MySqlParameter[] parameters = new MySqlParameter[]{
                new MySqlParameter("p_EventId",p_EventID)};
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteEvent", CommandType.StoredProcedure, parameters);
        }

        public List<Events> SelectEvents(int currentUserType, int deploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };

            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetEvents", CommandType.StoredProcedure,parameters);
            List<Events> eventsCol = new List<Events>();
            Events objEvent = null;
            foreach (DataRow dr in dt.Rows)
            {
                objEvent = new Events();
                objEvent.EventID = Convert.ToInt32(dr["EventID"].ToString());
                objEvent.EventName = dr["EventName"].ToString();
                objEvent.EventDate = string.IsNullOrEmpty(dr["EventDate"].ToString()) ? (Nullable<DateTime>)null : Convert.ToDateTime(dr["EventDate"].ToString());
                objEvent.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                objEvent.Remarks = dr["Remarks"].ToString();
                eventsCol.Add(objEvent);
            }
            dt.Clear();
            dt.Dispose();
            return eventsCol;
        }

        public Events SelectEvent(int p_EventID)
        {
            MySqlParameter[] parameters = new MySqlParameter[]{
                new MySqlParameter("p_EventId",p_EventID)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetEventByID", CommandType.StoredProcedure, parameters);
            Events objEvent = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objEvent = new Events();
                objEvent.EventID = Convert.ToInt32(dr["EventID"].ToString());
                objEvent.EventName = dr["EventName"].ToString();
                objEvent.EventDate = string.IsNullOrEmpty(dr["EventDate"].ToString()) ? (Nullable<DateTime>)null : Convert.ToDateTime(dr["EventDate"].ToString());
                objEvent.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                objEvent.Remarks = dr["Remarks"].ToString();
            }
            dt.Clear();
            dt.Dispose();
            return objEvent;
        }
    }
}
