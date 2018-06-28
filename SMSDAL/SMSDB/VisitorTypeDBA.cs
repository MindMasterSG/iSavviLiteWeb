using System;
using System.Collections.Generic;
using SMSEntities.SMSDBEntities;
using System.Data;
using MySql.Data.MySqlClient;

namespace SMSDAL.SMSDB
{
    public class VisitorTypeDBA
    {
        public int InsertVisitorType(VisitorTypes p_VisitorType)
        {
            int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_VisitorTypeDescription",p_VisitorType.VisitorTypeDescription),
                new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddVisitorTypes", CommandType.StoredProcedure, parameters);
        }

        public int UpdateVisitorType(VisitorTypes p_VisitorType)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_VisitortypeId", p_VisitorType.VisitortypeId),
                new MySqlParameter("p_VisitorTypeDescription",p_VisitorType.VisitorTypeDescription)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateVisitorTypes", CommandType.StoredProcedure, parameters);
        }

        public int DeleteVisitorType(int p_VisitortypeId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_VisitortypeId", p_VisitortypeId) };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteVisitortype", CommandType.StoredProcedure, parameters);
        }

        public List<VisitorTypes> SelectVisitorTypes(int currentUserType, int deploymentId)
        {
            List<VisitorTypes> VisitorTypesCol = new List<VisitorTypes>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetVisitortypes", CommandType.StoredProcedure);
            VisitorTypes objVisitorType = null;
            foreach (DataRow dr in dt.Rows)
            {
                objVisitorType = new VisitorTypes();
                objVisitorType.VisitortypeId = Convert.ToInt32(dr["VisitortypeId"].ToString());
                objVisitorType.VisitorTypeDescription = dr["VisitorTypeDescription"].ToString();
                VisitorTypesCol.Add(objVisitorType);
            }
            dt.Clear();
            dt.Dispose();
            return VisitorTypesCol;
        }

        public VisitorTypes SelectVisitorTypeByID(int p_VisitortypeId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_VisitortypeId", p_VisitortypeId) };
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetVisitortypeByID", CommandType.StoredProcedure, parameters);
            VisitorTypes objVisitorType = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objVisitorType = new VisitorTypes();
                objVisitorType.VisitortypeId = Convert.ToInt32(dr["VisitortypeId"].ToString());
                objVisitorType.VisitorTypeDescription = dr["VisitorTypeDescription"].ToString();
            }
            dt.Clear();
            dt.Dispose();
            return objVisitorType;
        }
    }
}
