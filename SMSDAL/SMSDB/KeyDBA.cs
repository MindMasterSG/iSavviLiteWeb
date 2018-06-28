using System;
using System.Collections.Generic;
using SMSEntities.SMSDBEntities;
using System.Data;
using MySql.Data.MySqlClient;

namespace SMSDAL.SMSDB
{
    public class KeyDBA
    {
        public int InsertKey(KEYS p_Key)
        {
            int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_KeyName", p_Key.KeyName),
                new MySqlParameter("p_DeploymentId",p_Key.DeploymentId),
                new MySqlParameter("p_KeyStatusId",p_Key.Status),
                new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddKey", CommandType.StoredProcedure, parameters);
        }

        public int UpadateKey(KEYS p_Key)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_KeyId", p_Key.KeyId),
                new MySqlParameter("p_KeyName", p_Key.KeyName),
                new MySqlParameter("p_DeploymentId",p_Key.DeploymentId),
                new MySqlParameter("p_KeyStatusId",p_Key.Status)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateKey", CommandType.StoredProcedure, parameters);
        }
        public int DeleteKey(int p_KeyId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_KeyId", p_KeyId)};
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteKey", CommandType.StoredProcedure, parameters);
        }

        public List<KEYS> SelectKEYS(int currentUserType, int deploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
            List<KEYS> KEYSCol = new List<KEYS>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetKeys", CommandType.StoredProcedure,parameters);
            KEYS objKEY = null;
            foreach (DataRow dr in dt.Rows)
            {
                objKEY = new KEYS();
                objKEY.KeyId = Convert.ToInt32(dr["KeyId"].ToString());
                objKEY.KeyName = dr["KeyName"].ToString();
                objKEY.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                objKEY.Status = Convert.ToInt32(dr["Status"].ToString());
                KEYSCol.Add(objKEY);
            }
            dt.Clear();
            dt.Dispose();
            return KEYSCol;
        }

        public KEYS SelectKEY(int p_KeyId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_KeyId", p_KeyId)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetKeyByID", CommandType.StoredProcedure, parameters);
            KEYS objKEY = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objKEY = new KEYS();
                objKEY.KeyId = Convert.ToInt32(dr["KeyId"].ToString());
                objKEY.KeyName = dr["KeyName"].ToString();
                objKEY.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                objKEY.Status = Convert.ToInt32(dr["Status"].ToString());
            }
            dt.Clear();
            dt.Dispose();
            return objKEY;
        }
    }
}
