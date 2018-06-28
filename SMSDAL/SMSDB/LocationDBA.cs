using System;
using System.Collections.Generic;
using SMSEntities.SMSDBEntities;
using System.Data;
using MySql.Data.MySqlClient;

namespace SMSDAL.SMSDB
{
    public class LocationDBA
    {
        public int InsertLocation(Location p_Location)
        {
            int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_DeploymentId",p_Location.DeploymentId),
                new MySqlParameter("p_LocationName",p_Location.LocationName),
                new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddLocation", CommandType.StoredProcedure, parameters);
        }

        public int UpadateLocation(Location p_Location)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_LocationId", p_Location.LocationId),
                new MySqlParameter("p_DeploymentId",p_Location.DeploymentId),
                new MySqlParameter("p_LocationName",p_Location.LocationName)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateLocation", CommandType.StoredProcedure, parameters);
        }

        public int DeleteLocation(int p_LocationID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_LocationId", p_LocationID)};
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteLocation", CommandType.StoredProcedure, parameters);
        }

        public List<Location> SelectLocations(int currentUserType, int deploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
            List<Location> locationCol = new List<Location>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetLocations", CommandType.StoredProcedure,parameters);
            Location objLocation = null;
            foreach (DataRow dr in dt.Rows)
            {
                objLocation = new Location();
                objLocation.LocationId = Convert.ToInt32(dr["LocationId"].ToString());
                objLocation.LocationName = dr["LocationName"].ToString();
                objLocation.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
                locationCol.Add(objLocation);
            }
            dt.Clear();
            dt.Dispose();
            return locationCol;
        }

        public Location SelectLocation(int p_LocationID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_LocationId", p_LocationID)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetLocationByID", CommandType.StoredProcedure, parameters);
            Location objLocation = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objLocation = new Location();
                objLocation.LocationId = Convert.ToInt32(dr["LocationId"].ToString());
                objLocation.LocationName = dr["LocationName"].ToString();
                objLocation.DeploymentId = Convert.ToInt32(dr["DeploymentId"].ToString());
            }
            dt.Clear();
            dt.Dispose();
            return objLocation;
        }
    }
}
