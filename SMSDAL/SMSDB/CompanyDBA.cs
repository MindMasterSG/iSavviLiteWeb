using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MySql.Data.MySqlClient;
using System.Data;
using SMSEntities.SMSDBEntities;

namespace SMSDAL.SMSDB
{
    public class CompanyDBA
    {
        public int InsertCompany(Companies p_Companies)
        {
            int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_CompanyName",p_Companies.CompanyName),
                new MySqlParameter("p_Address",p_Companies.Address),
                new MySqlParameter("p_ContactNumber",p_Companies.ContactNumber),
                new MySqlParameter("p_DeploymentId",p_Companies.DeploymentId),
                new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddCompany", CommandType.StoredProcedure, parameters);
        }

        public int UpadateCompanies(Companies p_Companies)
        {
            int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_CompanyId",p_Companies.CompanyId),
                new MySqlParameter("p_CompanyName",p_Companies.CompanyName),
                new MySqlParameter("p_Address",p_Companies.Address),
                new MySqlParameter("p_ContactNumber",p_Companies.ContactNumber),
                new MySqlParameter("p_DeploymentId",p_Companies.DeploymentId),
                new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateCompany", CommandType.StoredProcedure, parameters);
        }

        public int DeleteCompany(int p_CompaniesID)
        {
            int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_CompanyId",p_CompaniesID),
                new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
            };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteCompany", CommandType.StoredProcedure, parameters);
        }

        public List<Companies> SelectCompanies(int currentUserType, int deploymentId)
        {
            List<Companies> CompanyCol = new List<Companies>();
            MySqlParameter[] parameters = new MySqlParameter[] {
                new MySqlParameter("p_deploymentId", deploymentId),
              new MySqlParameter("currentUserType", currentUserType)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetCompanies", CommandType.StoredProcedure,parameters);
            Companies objCompany = null;
            foreach (DataRow dr in dt.Rows)
            {
                objCompany = new Companies();
                objCompany.CompanyId = Convert.ToInt32(dr["CompanyId"].ToString());
                objCompany.CompanyName = dr["CompanyName"].ToString();
                objCompany.Address = dr["Address"].ToString();
                objCompany.ContactNumber = dr["ContactNumber"].ToString();
                objCompany.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                CompanyCol.Add(objCompany);
            }
            dt.Clear();
            dt.Dispose();
            return CompanyCol;
        }

        public Companies SelectCompanyByID(int p_CompanyID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_CompanyId", p_CompanyID)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetCompanyByID", CommandType.StoredProcedure, parameters);
            Companies objCompany = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objCompany = new Companies();
                objCompany.CompanyId = Convert.ToInt32(dr["CompanyId"].ToString());
                objCompany.CompanyName = dr["CompanyName"].ToString();
                objCompany.Address = dr["Address"].ToString();
                objCompany.ContactNumber = dr["ContactNumber"].ToString();
                objCompany.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
            }
            dt.Clear();
            dt.Dispose();
            return objCompany;
        }
    }
}