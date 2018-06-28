using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using MySql.Data.MySqlClient;
using SMSEntities.SMSDBEntities;
namespace SMSDAL.SMSDB
{
    public class DeployementDBAccess
    {
        //AddDeployement
        /// <summary>
        /// 
        /// </summary>
        /// <param name="p_Deployement"></param>
        /// <returns></returns>
        public int InsertDeployment(Deployement p_Deployement)
        {
            //if (!IsDeploymentExists(p_Deployement.Description))
            //{
            int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("p_DeploymentName", p_Deployement.DeploymentName),
               new MySqlParameter("p_Description", p_Deployement.Description),
               new MySqlParameter("p_DeploymentType", p_Deployement.DeploymentType),
               new MySqlParameter("p_ClientName", p_Deployement.ClientName),
               new MySqlParameter("p_Address", p_Deployement.Address),
               new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
           };

            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddDeployment", CommandType.StoredProcedure, parameters);
            //if (result == 1) return true;
            //else return false;

            //}
            //else return false;
        }

        public int UpdateDeployment(Deployement p_Deployement)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("p_DeploymentId", p_Deployement.DeploymentId),
               new MySqlParameter("p_DeploymentName", p_Deployement.DeploymentName),
               new MySqlParameter("p_DeploymentType", p_Deployement.DeploymentType),
               new MySqlParameter("p_Description", p_Deployement.Description),
               new MySqlParameter("p_ClientName", p_Deployement.ClientName),
               new MySqlParameter("p_Address", p_Deployement.Address)
           };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateDeployment", CommandType.StoredProcedure, parameters);
        }

        public int DeleteDeployment(int p_DeploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("p_DeploymentId", p_DeploymentId)
           };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteDeployment", CommandType.StoredProcedure, parameters);
        }

        /// <summary>
        /// To select the all existing deployments
        /// </summary>
        /// <returns>data can return as collection list</returns>
        public List<Deployement> SeletctDeploymentList(int currentUserType, int deploymentId)
        {

            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetDeployments", CommandType.StoredProcedure);
            List<Deployement> deployementCol = new List<Deployement>();
            Deployement deployement;
            foreach (DataRow dr in dt.Rows)
            {
                deployement = new Deployement();
                deployement.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                deployement.DeploymentType = dr["deploymenttype"].ToString();
                deployement.DeploymentName = dr["DeploymentName"].ToString();
                deployement.Description = dr["Description"].ToString();
                deployement.ClientName = dr["ClientName"].ToString();
                deployement.Address = dr["Address"].ToString();
                deployementCol.Add(deployement);
            }
            dt.Clear();
            dt.Dispose();
            return deployementCol;
        }

        /// <summary>
        /// To select the all existing deployments
        /// </summary>
        /// <returns>data can return as collection list</returns>
        public Deployement SeletctDeploymentByID(int p_DeployementID)
        {
            //string sqlQuery = "SELECT `Id` , `DeploymentDescription` FROM `test`.`deployements` WHERE `Id` = " + p_DeployementID;
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("p_DeploymentId", p_DeployementID)
           };
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetDeploymentByID", CommandType.StoredProcedure, parameters);
            Deployement deployement = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                deployement = new Deployement();
                deployement.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                deployement.DeploymentName = dr["DeploymentName"].ToString();
                deployement.DeploymentType = dr["deploymenttype"].ToString();
                deployement.Description = dr["Description"].ToString();
                deployement.ClientName = dr["ClientName"].ToString();
                deployement.Address = dr["Address"].ToString();
            }
            dt.Clear();
            dt.Dispose();
            return deployement;
        }

        /// <summary>


        public bool IsDeploymentExists(string p_DeploymentName)
        {
            string sqlQuery = "SELECT `DeploymentId` FROM `deployements` WHERE `DeploymentName` = '" + p_DeploymentName + "'";
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand(sqlQuery, CommandType.Text);
            if (dt.Rows.Count > 0) return true;
            return false;
        }
    }
}
