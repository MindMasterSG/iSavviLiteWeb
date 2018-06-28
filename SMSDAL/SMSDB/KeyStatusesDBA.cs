using System;
using System.Collections.Generic;
using SMSEntities.SMSDBEntities;
using System.Data;
using MySql.Data.MySqlClient;
namespace SMSDAL.SMSDB
{
   public class KeyStatusesDBA
    {
       public int InsertKeyStatuses(KeyStatuses p_KeyStatuses)
        {
            int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_StatusType",p_KeyStatuses.StatusType),
               new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddKeyStatus", CommandType.StoredProcedure, parameters);
             
            //if (result == 1) return true;
            //else return false;
        }

       public int UpdateKeyStatuses(KeyStatuses p_KeyStatuses)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_StatusID", p_KeyStatuses.StatusID),
                new MySqlParameter("p_StatusType",p_KeyStatuses.StatusType)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateKeyStatus", CommandType.StoredProcedure, parameters);
        }

       public int DeleteKeyStatuses(int p_StatusID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_StatusID", p_StatusID) };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteKeyStatus", CommandType.StoredProcedure, parameters);
        }

       public List<KeyStatuses> SelectKeyStatuses(int currentUserType, int deploymentId)
        {
            List<KeyStatuses> VisitorTypesCol = new List<KeyStatuses>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetKeyStatuses", CommandType.StoredProcedure);
            KeyStatuses objKeyStatus = null;
            foreach (DataRow dr in dt.Rows)
            {
                objKeyStatus = new KeyStatuses();
                objKeyStatus.StatusID = Convert.ToInt32(dr["StatusID"].ToString());
                objKeyStatus.StatusType = dr["StatusType"].ToString();
                VisitorTypesCol.Add(objKeyStatus);
            }
            dt.Clear();
            dt.Dispose();
            return VisitorTypesCol;
        }

       public KeyStatuses SelectKeyStatusesByID(int p_StatusID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_StatusID", p_StatusID) };
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetKeyStatusByID", CommandType.StoredProcedure, parameters);
            KeyStatuses objKeyStatus = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objKeyStatus = new KeyStatuses();
                objKeyStatus.StatusID = Convert.ToInt32(dr["StatusID"].ToString());
                objKeyStatus.StatusType = dr["StatusType"].ToString();
            }
            dt.Clear();
            dt.Dispose();
            return objKeyStatus;
        }
    }
}
