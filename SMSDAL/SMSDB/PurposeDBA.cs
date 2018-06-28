using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SMSEntities.SMSDBEntities;
using MySql.Data.MySqlClient;
using System.Data;

namespace SMSDAL.SMSDB
{
    public class PurposeDBA
    {
        public List<Purpose> SelectPurpose(int currentUserType, int deploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
            List<Purpose> PurposeCol = new List<Purpose>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetPurpose", CommandType.StoredProcedure, parameters);
            Purpose objPurpose = null;
            foreach (DataRow dr in dt.Rows)
            {
                objPurpose = new Purpose();
                objPurpose.purposeid = Convert.ToInt32(dr["purposeid"].ToString());
                objPurpose.purpose = dr["purpose"].ToString();
                objPurpose.status = Convert.ToInt32(dr["status"].ToString());
                PurposeCol.Add(objPurpose);
            }
            dt.Clear();
            dt.Dispose();
            return PurposeCol;
        }
    }
}
