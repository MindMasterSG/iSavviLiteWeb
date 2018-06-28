using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Data;
using SMSEntities.SMSDBEntities;

namespace SMSDAL.SMSDB
{
    public class PassesDBA
    {
        public int InsertPasses(Passes p_Passes)
        {//p_PassName, p_PassStatus, , p_PassStatus, p_VisitortypeId, p_DeploymentId
            int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_PassName",p_Passes.PassName),
                new MySqlParameter("p_PassStatus",p_Passes.PassStatus),
                new MySqlParameter("p_VisitortypeId",p_Passes.VisitortypeId),
                new MySqlParameter("p_DeploymentId",p_Passes.DeploymentId),
               new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddPass", CommandType.StoredProcedure, parameters);
        }

        public int UpadatePasses(Passes p_Passes)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_PassId",p_Passes.PassId),
                 new MySqlParameter("p_PassName",p_Passes.PassName),
                new MySqlParameter("p_PassStatus",p_Passes.PassStatus),
                new MySqlParameter("p_VisitortypeId",p_Passes.VisitortypeId),
                new MySqlParameter("p_DeploymentId",p_Passes.DeploymentId)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdatePass", CommandType.StoredProcedure, parameters);
        }

        public int DeletePasses(int p_PassesID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_PassId",p_PassesID)};
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeletePass", CommandType.StoredProcedure, parameters);
        }

        public List<Passes> SelectPasses(int currentUserType, int deploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
            List<Passes> passesCol = new List<Passes>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetPasses", CommandType.StoredProcedure,parameters);
            Passes objPass = null;
            foreach (DataRow dr in dt.Rows)
            {
                objPass = new Passes();
                objPass.PassId = Convert.ToInt32(dr["PassId"].ToString());
                objPass.PassName = dr["PassName"].ToString();
                objPass.PassStatus = dr["PassStatus"].ToString();
                objPass.VisitortypeId = Convert.ToInt32(dr["VisitortypeId"].ToString());
                objPass.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                passesCol.Add(objPass);
            }
            dt.Clear();
            dt.Dispose();
            return passesCol;
        }

        public List<Passes> SelectPassesByVisitorType(int currentUserType, int deploymentId, int visitorTypeId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("p_deploymentId", deploymentId),
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_visitorTypeId", visitorTypeId)
           };
            List<Passes> passesCol = new List<Passes>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetPassesByVisitorType", CommandType.StoredProcedure, parameters);
            Passes objPass = null;
            foreach (DataRow dr in dt.Rows)
            {
                objPass = new Passes();
                objPass.PassId = Convert.ToInt32(dr["PassId"].ToString());
                objPass.PassName = dr["PassName"].ToString();
                objPass.PassStatus = dr["PassStatus"].ToString();
                objPass.VisitortypeId = Convert.ToInt32(dr["VisitortypeId"].ToString());
                objPass.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                passesCol.Add(objPass);
            }
            dt.Clear();
            dt.Dispose();
            return passesCol;
        }

        public Passes SelectPasseByID(int currentUserType, int deploymentId, int p_PassesID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_PassId", p_PassesID)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetPassByID", CommandType.StoredProcedure, parameters);
            Passes objPass = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objPass = new Passes();
                objPass.PassId = Convert.ToInt32(dr["PassId"].ToString());
                objPass.PassName = dr["PassName"].ToString();
                objPass.PassStatus = dr["PassStatus"].ToString();
                objPass.VisitortypeId = Convert.ToInt32(dr["VisitortypeId"].ToString());
                objPass.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
            }
            dt.Clear();
            dt.Dispose();
            return objPass;
        }
    }
}
