using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SMSEntities.SMSDBEntities;
using MySql.Data.MySqlClient;
using System.Data;

namespace SMSDAL.SMSDB
{
    public class VehiclesDBA
    {
        public int InsertVehicle(Vehicles p_Vehicles)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
                new MySqlParameter("p_identificationunit",p_Vehicles.identificationunit),
                new MySqlParameter("p_platenumber", p_Vehicles.platenumber),
                new MySqlParameter("p_containernumber",p_Vehicles.containernumber),
                new MySqlParameter("p_description",p_Vehicles.description),
                new MySqlParameter("p_trailernumber",p_Vehicles.trailernumber),
                new MySqlParameter("p_contractor",p_Vehicles.contractor),
                new MySqlParameter("p_length",p_Vehicles.length),
                new MySqlParameter("p_capacity",p_Vehicles.capacity),
                new MySqlParameter("p_securityguardname",p_Vehicles.securityguardname),
                new MySqlParameter("p_authpersonic",p_Vehicles.authpersonic),
                new MySqlParameter("p_authpersonname",p_Vehicles.authpersonname),
                new MySqlParameter("p_imagepath",p_Vehicles.imagepath),
                new MySqlParameter("p_deploymentid",p_Vehicles.deploymentid),

                 new MySqlParameter("p_VehicleType",p_Vehicles.vehicletype),
                new MySqlParameter("p_Purpose",p_Vehicles.purpose),
                new MySqlParameter("p_Location",p_Vehicles.LocationName)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddVehicle", CommandType.StoredProcedure, parameters);
        }

        public int UpadateVehicle(Vehicles p_Vehicles)
        {
            int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] {
                new MySqlParameter("p_identificationunit",p_Vehicles.identificationunit),
                new MySqlParameter("p_platenumber", p_Vehicles.platenumber),
                new MySqlParameter("p_containernumber",p_Vehicles.containernumber),
                new MySqlParameter("p_description",p_Vehicles.description),
                new MySqlParameter("p_trailernumber",p_Vehicles.trailernumber),
                new MySqlParameter("p_contractor",p_Vehicles.contractor),
                new MySqlParameter("p_length",p_Vehicles.length),
                new MySqlParameter("p_capacity",p_Vehicles.capacity),
                new MySqlParameter("p_securityguardname",p_Vehicles.securityguardname),
                new MySqlParameter("p_authpersonic",p_Vehicles.authpersonic),
                new MySqlParameter("p_authpersonname",p_Vehicles.authpersonname),
                new MySqlParameter("p_imagepath",p_Vehicles.imagepath),
                new MySqlParameter("p_deploymentid",p_Vehicles.deploymentid),

                 new MySqlParameter("p_VehicleType",p_Vehicles.vehicletype),
                new MySqlParameter("p_Purpose",p_Vehicles.purpose),
                new MySqlParameter("p_Location",p_Vehicles.LocationName),
                new MySqlParameter("p_vehicleId",p_Vehicles.vehicleid),
               new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateVehicle", CommandType.StoredProcedure, parameters);
        }
        public int DeleteVehicle(string p_IdentificationUnit)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
                new MySqlParameter("p_identificationunit", p_IdentificationUnit)};
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteVehicle", CommandType.StoredProcedure, parameters);
        }

        public List<Vehicles> SelectVehicles(int currentUserType, int deploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
            List<Vehicles> VehiclesCol = new List<Vehicles>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetVehicles", CommandType.StoredProcedure, parameters);
            Vehicles objVehicles = null;
            foreach (DataRow dr in dt.Rows)
            {
                objVehicles = new Vehicles();
                objVehicles.vehicleid = Convert.ToInt32(dr["vehicleid"].ToString());
                objVehicles.identificationunit = dr["identificationunit"].ToString();
                objVehicles.authpersonic = dr["authpersonic"].ToString();
                objVehicles.authpersonname = dr["authpersonname"].ToString();
                objVehicles.capacity = dr["capacity"].ToString();
                objVehicles.containernumber = dr["containernumber"].ToString();
                objVehicles.contractor = dr["contractor"].ToString();
                objVehicles.description = dr["description"].ToString();
                objVehicles.imagepath = dr["imagepath"].ToString();
                objVehicles.length = dr["length"].ToString();
                objVehicles.platenumber = dr["platenumber"].ToString();
                objVehicles.securityguardname = dr["securityguardname"].ToString();
                objVehicles.trailernumber = dr["trailernumber"].ToString();
                objVehicles.deploymentid = dr["deploymentid"] != null && dr["deploymentid"].ToString() != "" ? Convert.ToInt32(dr["deploymentid"]) : 0;
                objVehicles.vehicletype = dr["vehicletype"].ToString();
                objVehicles.purpose = dr["purpose"].ToString();
                objVehicles.LocationName = dr["Location"].ToString();
                VehiclesCol.Add(objVehicles);
            }
            dt.Clear();
            dt.Dispose();
            return VehiclesCol;
        }

        public Vehicles SelectVehicleByID(int currentUserType, int deploymentId, string p_vehicleid)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
                new MySqlParameter("p_vehicleid", p_vehicleid)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetVehicleByID", CommandType.StoredProcedure, parameters);
            Vehicles objVehicles = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objVehicles = new Vehicles();
                objVehicles.vehicleid = Convert.ToInt32(dr["vehicleid"].ToString());
                objVehicles.identificationunit = dr["identificationunit"].ToString();
                objVehicles.authpersonic = dr["authpersonic"].ToString();
                objVehicles.authpersonname = dr["authpersonname"].ToString();
                objVehicles.capacity = dr["capacity"].ToString();
                objVehicles.containernumber = dr["containernumber"].ToString();
                objVehicles.contractor = dr["contractor"].ToString();
                objVehicles.description = dr["description"].ToString();
                objVehicles.imagepath = dr["imagepath"].ToString();
                objVehicles.length = dr["length"].ToString();
                objVehicles.platenumber = dr["platenumber"].ToString();
                objVehicles.securityguardname = dr["securityguardname"].ToString();
                objVehicles.trailernumber = dr["trailernumber"].ToString();
                objVehicles.deploymentid = dr["deploymentid"] != null && dr["deploymentid"].ToString() != "" ? Convert.ToInt32(dr["deploymentid"]) : 0; ;
                objVehicles.vehicletype = dr["vehicletype"].ToString();
                objVehicles.purpose = dr["purpose"].ToString();
                objVehicles.LocationName = dr["Location"].ToString();
            }
            dt.Clear();
            dt.Dispose();
            return objVehicles;
        }
    }
}
