using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MySql.Data.MySqlClient;
using System.Data;
using SMSEntities.SMSDBEntities;

namespace SMSDAL.SMSDB
{
   public class LostAndFoundDBA
    {
       public int InsertLostAndFound(LostAndFound p_LostAndFound)
       {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_nameofperson",p_LostAndFound.nameofperson),
                new MySqlParameter("p_nric",p_LostAndFound.nric),
                new MySqlParameter("p_reporteddate",p_LostAndFound.reporteddate),
                new MySqlParameter("p_remarks",p_LostAndFound.remarks),
                new MySqlParameter("p_deploymentid",p_LostAndFound.deploymentid)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddLostandfound", CommandType.StoredProcedure, parameters);
        }

       public int UpadateLostAndFound(LostAndFound p_LostAndFound)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
                new MySqlParameter("p_lostandfoundreportid", p_LostAndFound.lostandfoundreportid),
                new MySqlParameter("p_nameofperson",p_LostAndFound.nameofperson),
                new MySqlParameter("p_nric",p_LostAndFound.nric),
                new MySqlParameter("p_reporteddate",p_LostAndFound.reporteddate),
                new MySqlParameter("p_remarks",p_LostAndFound.remarks),
                new MySqlParameter("p_deploymentid",p_LostAndFound.deploymentid)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateLostandfound", CommandType.StoredProcedure, parameters);
        }

        public int DeleteLostAndFound(int p_LostAndFoundID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_lostandfoundreportid",p_LostAndFoundID)};
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteLostandfound", CommandType.StoredProcedure, parameters);
        }

        public List<LostAndFound> SelectLostAndFound(int currentUserType, int deploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
            List<LostAndFound> LostAndFoundCol = new List<LostAndFound>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetLostandfounds", CommandType.StoredProcedure,parameters);
            LostAndFound objLostAndFound = null;
            foreach (DataRow dr in dt.Rows)
            {
                objLostAndFound = new LostAndFound();
                objLostAndFound.lostandfoundreportid = Convert.ToInt32(dr["lostandfoundreportid"].ToString());
                objLostAndFound.nameofperson = dr["nameofperson"].ToString();
                objLostAndFound.nric = dr["nric"].ToString();
                objLostAndFound.reporteddate = Convert.ToDateTime(dr["reporteddate"].ToString());
                objLostAndFound.remarks = dr["remarks"].ToString();
                objLostAndFound.deploymentid = dr["deploymentid"] != null && dr["deploymentid"].ToString() != "" ? Convert.ToInt32(dr["deploymentid"]) : 0 ;
                LostAndFoundCol.Add(objLostAndFound);
            }
            dt.Clear();
            dt.Dispose();
            return LostAndFoundCol;
        }

        public LostAndFound SelectLostAndFoundById(int p_LostAndFoundID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_lostandfoundreportid", p_LostAndFoundID)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetLostandfoundByID", CommandType.StoredProcedure, parameters);
            LostAndFound objLostAndFound = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objLostAndFound = new LostAndFound();
                objLostAndFound.lostandfoundreportid = Convert.ToInt32(dr["lostandfoundreportid"].ToString());
                objLostAndFound.nameofperson = dr["nameofperson"].ToString();
                objLostAndFound.nric = dr["nric"].ToString();
                objLostAndFound.reporteddate = Convert.ToDateTime(dr["reporteddate"].ToString());
                objLostAndFound.remarks = dr["remarks"].ToString();
                objLostAndFound.deploymentid = dr["deploymentid"] != null && dr["deploymentid"].ToString() != "" ? Convert.ToInt32(dr["deploymentid"]) : 0 ;
            }
            dt.Clear();
            dt.Dispose();
            return objLostAndFound;
        }
    }
}
