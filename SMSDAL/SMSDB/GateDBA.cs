using System;
using System.Collections.Generic;
using SMSEntities.SMSDBEntities;
using System.Data;
using MySql.Data.MySqlClient;

namespace SMSDAL.SMSDB
{
    public class GateDBA
    {
        public int InsertGate(Gates p_Gate)
        {
            int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_DeploymentId",p_Gate.DeploymentId),
                new MySqlParameter("p_GateName", p_Gate.GateName),
                new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddGate", CommandType.StoredProcedure, parameters);
        }

        public int UpdateGate(Gates p_Gate)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_GateId", p_Gate.GateId),
                new MySqlParameter("p_DeploymentId",p_Gate.DeploymentId),
                new MySqlParameter("p_GateName", p_Gate.GateName)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateGate", CommandType.StoredProcedure, parameters);
        }
        public int DeleteGate(int p_GateId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_GateId", p_GateId)};
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteGate", CommandType.StoredProcedure, parameters);
        }
        public List<Gates> SelectGates(int currentUserType, int deploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
            List<Gates> gatesCol = new List<Gates>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetGates", CommandType.StoredProcedure,parameters);
            Gates objGate = null;
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    objGate = new Gates();
                    objGate.GateId = Convert.ToInt32(dr["GateId"].ToString());
                    objGate.GateName = dr["GateName"].ToString();
                    objGate.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                    gatesCol.Add(objGate);
                }
            }
            dt.Clear();
            dt.Dispose();
            return gatesCol;
        }

        public Gates SelectGate(int p_GateId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_GateId", p_GateId)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetGateByID", CommandType.StoredProcedure, parameters);
            Gates objGate = null;
            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objGate = new Gates();
                objGate.GateId = Convert.ToInt32(dr["GateId"].ToString());
                objGate.GateName = dr["GateName"].ToString();
                objGate.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
            }
            dt.Clear();
            dt.Dispose();
            return objGate;
        }
    }
}
