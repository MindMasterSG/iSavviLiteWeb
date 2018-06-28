using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MySql.Data.MySqlClient;
using System.Data;
using SMSEntities.SMSDBEntities;

namespace SMSDAL.SMSDB
{
   public class IncidentsDBA
    {
       public int InsertIncident(Incidents p_Incidents)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_reportdate",p_Incidents.reportdate),
                new MySqlParameter("p_natureofincident",p_Incidents.natureofincident),
                new MySqlParameter("p_dateofincident",p_Incidents.dateofincident),
                new MySqlParameter("p_locationid",p_Incidents.locationid),
                new MySqlParameter("p_particularsofpersons",p_Incidents.particularsofpersons),
                new MySqlParameter("p_briefdescription",p_Incidents.briefdescription),
                new MySqlParameter("p_remarksandactionstaken",p_Incidents.remarksandactionstaken),
                new MySqlParameter("p_snapshotpath",p_Incidents.snapshotpath),
                new MySqlParameter("p_deploymentid",p_Incidents.deploymentid)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddIncident", CommandType.StoredProcedure, parameters);
        }

       public int UpadateIncident(Incidents p_Incidents)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_incidentid",p_Incidents.incidentid),
                new MySqlParameter("p_reportdate",p_Incidents.reportdate),
                new MySqlParameter("p_natureofincident",p_Incidents.natureofincident),
                new MySqlParameter("p_dateofincident",p_Incidents.dateofincident),
                new MySqlParameter("p_locationid",p_Incidents.locationid),
                new MySqlParameter("p_particularsofpersons",p_Incidents.particularsofpersons),
                new MySqlParameter("p_briefdescription",p_Incidents.briefdescription),
                new MySqlParameter("p_remarksandactionstaken",p_Incidents.remarksandactionstaken),
                new MySqlParameter("p_snapshotpath",p_Incidents.snapshotpath),
                new MySqlParameter("p_deploymentid",p_Incidents.deploymentid)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateIncident", CommandType.StoredProcedure, parameters);
        }

       public int DeleteIncidents(int p_IncidentID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_IncidentID",p_IncidentID)};
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteIncident", CommandType.StoredProcedure, parameters);
        }

       public List<Incidents> SelectIncidents(int currentUserType, int deploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
            List<Incidents> IncidentsCol = new List<Incidents>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetIncidents", CommandType.StoredProcedure,parameters);
            Incidents objIncident = null;
            foreach (DataRow dr in dt.Rows)
            {
                objIncident = new Incidents();
                objIncident.incidentid = Convert.ToInt32(dr["incidentid"].ToString());
                objIncident.reportdate = Convert.ToDateTime(dr["reportdate"].ToString());
                objIncident.natureofincident = dr["natureofincident"].ToString();
                objIncident.dateofincident = Convert.ToDateTime(dr["dateofincident"].ToString());
                objIncident.locationid = Convert.ToInt32(dr["locationid"].ToString());
                objIncident.particularsofpersons = dr["particularsofpersons"].ToString();
                objIncident.briefdescription = dr["briefdescription"].ToString();
                objIncident.remarksandactionstaken = dr["remarksandactionstaken"].ToString();
                objIncident.snapshotpath = dr["snapshotpath"].ToString();
                objIncident.deploymentid = dr["deploymentid"] != null && dr["deploymentid"].ToString() != "" ? Convert.ToInt32(dr["deploymentid"]) : 0 ;;
                IncidentsCol.Add(objIncident);
            }
            dt.Clear();
            dt.Dispose();
            return IncidentsCol;
        }

       public List<Incidents> SelectIncidentsByFilters(int currentUserType, int deploymentId,int startdate, int startmonth, int startyear, int enddate, int endmonth, int endyear)
       {
           MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
           List<Incidents> IncidentsCol = new List<Incidents>();
           DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetIncidents", CommandType.StoredProcedure,parameters);
           Incidents objIncident = null;

           switch (startmonth)
           {
               case 2:
                   if (startdate > 28)
                   {
                       if (startyear % 4 == 0)
                           startdate = 29;
                       else
                           startdate = 28;
                   }
                   break;
               case 4:
               case 6:
               case 9:
               case 11:
                   if (startdate > 30)
                       startdate = 30;
                   break;
               default:
                   break;
           }

           DateTime startDate = new DateTime();
           try
           {
               startDate = new DateTime(startyear, startmonth, startdate);
           }
           catch (Exception ex)
           {

           }

           switch (endmonth)
           {
               case 2:
                   if (enddate > 28)
                   {
                       if (endyear % 4 == 0)
                           enddate = 29;
                       else
                           enddate = 28;
                   }
                   break;
               case 4:
               case 6:
               case 9:
               case 11:
                   if (enddate > 30)
                       enddate = 30;
                   break;
               default:
                   break;
           }

           DateTime endDate = new DateTime();
           try
           {
               endDate = new DateTime(endyear, endmonth, enddate);
           }
           catch (Exception ex)
           {

           }

           foreach (DataRow dr in dt.Rows)
           {
               DateTime dte = Convert.ToDateTime(dr["reportdate"].ToString());
              if (dte != null)
              {
                    //if (startDate == dte || endDate == dte || (startDate < dte && endDate > dte))
                    if (startDate == dte || endDate == dte || startDate < dte)
                        {
                      objIncident = new Incidents();
                      objIncident.incidentid = Convert.ToInt32(dr["incidentid"].ToString());
                      objIncident.reportdate = Convert.ToDateTime(dr["reportdate"].ToString());
                      objIncident.natureofincident = dr["natureofincident"].ToString();
                      objIncident.dateofincident = Convert.ToDateTime(dr["dateofincident"].ToString());
                      objIncident.locationid = Convert.ToInt32(dr["locationid"].ToString());
                      objIncident.particularsofpersons = dr["particularsofpersons"].ToString();
                      objIncident.briefdescription = dr["briefdescription"].ToString();
                      objIncident.remarksandactionstaken = dr["remarksandactionstaken"].ToString();
                      objIncident.snapshotpath = dr["snapshotpath"].ToString();
                      objIncident.deploymentid = dr["deploymentid"] != null && dr["deploymentid"].ToString() != "" ? Convert.ToInt32(dr["deploymentid"]) : 0; ;
                      IncidentsCol.Add(objIncident);
                  }
              }
           }
           dt.Clear();
           dt.Dispose();
           return IncidentsCol;
       }

       public Incidents SelectIncidentByID(int currentUserType, int deploymentId, int p_IncidentsID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_incidentid", p_IncidentsID)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetIncidentByID", CommandType.StoredProcedure, parameters);
            Incidents objIncident = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objIncident = new Incidents();
                objIncident.incidentid = Convert.ToInt32(dr["incidentid"].ToString());
                objIncident.reportdate = Convert.ToDateTime(dr["reportdate"].ToString());
                objIncident.natureofincident = dr["natureofincident"].ToString();
                objIncident.dateofincident = Convert.ToDateTime(dr["dateofincident"].ToString());
                objIncident.locationid = Convert.ToInt32(dr["locationid"].ToString());
                objIncident.particularsofpersons = dr["particularsofpersons"].ToString();
                objIncident.briefdescription = dr["briefdescription"].ToString();
                objIncident.remarksandactionstaken = dr["remarksandactionstaken"].ToString();
                objIncident.snapshotpath = dr["snapshotpath"].ToString();
                objIncident.deploymentid = dr["deploymentid"] != null && dr["deploymentid"].ToString() != "" ? Convert.ToInt32(dr["deploymentid"]) : 0 ;;
            }
            dt.Clear();
            dt.Dispose();
            return objIncident;
        }
    }
}
