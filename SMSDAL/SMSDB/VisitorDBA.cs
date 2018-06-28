using System;
using System.Collections.Generic;
using SMSEntities.SMSDBEntities;
using System.Data;
using MySql.Data.MySqlClient;

namespace SMSDAL.SMSDB
{
    public class VisitorDBA
    {
        public int InsertVisitor(Visitors p_Visitor)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_DeploymentId",p_Visitor.DeploymentId),
                new MySqlParameter("p_NRIC",p_Visitor.NRIC),
                new MySqlParameter("p_FirstName", p_Visitor.FirstName),
                new MySqlParameter("p_MiddleName",p_Visitor.MiddleName),
                new MySqlParameter("p_LastName",p_Visitor.LastName),
                new MySqlParameter("p_Address",p_Visitor.Address),
                new MySqlParameter("p_ContactNumber",p_Visitor.ContactNumber),
                new MySqlParameter("p_CompanyName",p_Visitor.CompanyName),
                new MySqlParameter("p_IsBlacklisted",p_Visitor.IsBlacklisted),
                new MySqlParameter("p_eventid",p_Visitor.eventid)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddVisitors", CommandType.StoredProcedure, parameters);
        }

        public int UpdateVisitor(Visitors p_Visitor)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_VisitorId", p_Visitor.VisitorId),
                new MySqlParameter("p_DeploymentId",p_Visitor.DeploymentId),
                new MySqlParameter("p_NRIC",p_Visitor.NRIC),
                new MySqlParameter("p_FirstName", p_Visitor.FirstName),
                new MySqlParameter("p_MiddleName",p_Visitor.MiddleName),
                new MySqlParameter("p_LastName",p_Visitor.LastName),
                new MySqlParameter("p_Address",p_Visitor.Address),
                new MySqlParameter("p_ContactNumber",p_Visitor.ContactNumber),
                new MySqlParameter("p_CompanyName",p_Visitor.CompanyName),
                new MySqlParameter("p_IsBlacklisted",p_Visitor.IsBlacklisted)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateVisitors", CommandType.StoredProcedure, parameters);
        }

        public int DeleteVisitor(int p_VisitorId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_VisitorId", p_VisitorId)};
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteVisitor", CommandType.StoredProcedure, parameters);
        }

        public List<Visitors> SelectVisitors(int currentUserType, int deploymentId)
        {
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetVisitors", CommandType.StoredProcedure);
            List<Visitors> VisitorsCol = new List<Visitors>();
            Visitors objVisitor = null;
            foreach (DataRow dr in dt.Rows)
            {
                objVisitor = new Visitors();
                objVisitor.VisitorId = Convert.ToInt32(dr["VisitorId"].ToString());
                objVisitor.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                objVisitor.NRIC = dr["NRIC"].ToString();
                objVisitor.FirstName = dr["FirstName"].ToString();
                objVisitor.MiddleName = dr["MiddleName"].ToString();
                objVisitor.LastName = dr["LastName"].ToString();
                objVisitor.Address = dr["Address"].ToString();
                objVisitor.CompanyName = dr["CompanyName"].ToString();
                objVisitor.ContactNumber = dr["ContactNumber"].ToString();
                VisitorsCol.Add(objVisitor);
            }
            dt.Clear();
            dt.Dispose();
            return VisitorsCol;
        }

        public Visitors SelectVisitor(int currentUserType, int deploymentId,int p_VisitorId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_VisitorId", p_VisitorId)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetVisitorByID", CommandType.StoredProcedure, parameters);
            Visitors objVisitor = null;
            if (dt.Rows.Count >0)
            {
                DataRow dr = dt.Rows[0];
                objVisitor = new Visitors();
                objVisitor.VisitorId = Convert.ToInt32(dr["VisitorId"].ToString());
                objVisitor.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                objVisitor.NRIC = dr["NRIC"].ToString();
                objVisitor.FirstName = dr["FirstName"].ToString();
                objVisitor.MiddleName = dr["MiddleName"].ToString();
                objVisitor.LastName = dr["LastName"].ToString();
                objVisitor.Address = dr["Address"].ToString();
                objVisitor.ContactNumber = dr["ContactNumber"].ToString();
                objVisitor.CompanyName = dr["CompanyName"].ToString();
            }
            dt.Clear();
            dt.Dispose();
            return objVisitor;
        }

        public List<Visitors> SelectParticipantsByEventID(int currentUserType, int deploymentId,int p_EventID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_eventid", p_EventID)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetParticipantsByEventID", CommandType.StoredProcedure, parameters);
            List<Visitors> VisitorsCol = new List<Visitors>();
            Visitors objVisitor = null;
            foreach (DataRow dr in dt.Rows)
            {
                objVisitor = new Visitors();
                objVisitor.VisitorId = Convert.ToInt32(dr["VisitorId"].ToString());
                objVisitor.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                objVisitor.NRIC = dr["NRIC"].ToString();
                objVisitor.FirstName = dr["FirstName"].ToString();
                objVisitor.eventid = Convert.ToInt32(dr["eventid"].ToString());
                //objVisitor.MiddleName = dr["MiddleName"].ToString();
                objVisitor.LastName = dr["LastName"].ToString();
                //objVisitor.Address = dr["Address"].ToString();
                //objVisitor.CompanyName = dr["CompanyName"].ToString();
                //objVisitor.ContactNumber = dr["ContactNumber"].ToString();
                VisitorsCol.Add(objVisitor);
            }
            dt.Clear();
            dt.Dispose();
            return VisitorsCol;
        }
    }
}
