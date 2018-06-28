using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SMSEntities.SMSDBEntities;
using MySql.Data.MySqlClient;
using System.Data;

namespace SMSDAL.SMSDB
{
    public class VehiclesTypeDBA
    {
        public List<VehicleTypes> SelectVehiclesTypes(int currentUserType, int deploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
            List<VehicleTypes> VehiclesTypeCol = new List<VehicleTypes>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetVehicleTypes", CommandType.StoredProcedure, parameters);
            VehicleTypes objVehiclesTypes = null;
            foreach (DataRow dr in dt.Rows)
            {
                objVehiclesTypes = new VehicleTypes();
                objVehiclesTypes.vehicletypeid = Convert.ToInt32(dr["vehicletypeid"].ToString());
                objVehiclesTypes.vehicletype = dr["vehicletype"].ToString();
                objVehiclesTypes.status = Convert.ToInt32(dr["status"].ToString());
                VehiclesTypeCol.Add(objVehiclesTypes);
            }
            dt.Clear();
            dt.Dispose();
            return VehiclesTypeCol;
        }
    }
}
