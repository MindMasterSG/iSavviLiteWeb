using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Data;
using SMSEntities.SMSDBEntities;
using System.Globalization;

namespace SMSDAL.SMSDB
{
  public class OccurancesDBA
    {
      public int InsertOccurances(Occurrance p_Occurrance)
      {
          

          MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_serialnumber",p_Occurrance.serialnumber),
                new MySqlParameter("p_reportdate",p_Occurrance.ConvertedDate),
                new MySqlParameter("p_occurancetype",p_Occurrance.occurancetype),
                new MySqlParameter("p_notes",p_Occurrance.notes),
                new MySqlParameter("p_important",p_Occurrance.important),
                new MySqlParameter("p_heading",p_Occurrance.heading),
                new MySqlParameter("p_deploymentid",p_Occurrance.deploymentid)
          };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddOccurance", CommandType.StoredProcedure, parameters);
        }

      public int UpadateOccurrance(Occurrance p_Occurrance)
      {
          MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_occuranceid",p_Occurrance.occuranceid),
                new MySqlParameter("p_serialnumber",p_Occurrance.serialnumber),
                new MySqlParameter("p_reportdate",p_Occurrance.ConvertedDate),
                new MySqlParameter("p_occurancetype",p_Occurrance.occurancetype),
                new MySqlParameter("p_notes",p_Occurrance.notes),
                new MySqlParameter("p_important",p_Occurrance.important),
                new MySqlParameter("p_heading",p_Occurrance.heading),
                new MySqlParameter("p_deploymentid",p_Occurrance.deploymentid)
          };
          return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateOccurance", CommandType.StoredProcedure, parameters);
      }

      public int DeleteOccurances(int p_OccurancesID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_occuranceid",p_OccurancesID)};
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteOccurance", CommandType.StoredProcedure, parameters);
        }

      public List<Occurrance> SelectOccurrences(int currentUserType, int deploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
            List<Occurrance> OccurancesCol = new List<Occurrance>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetOccurances", CommandType.StoredProcedure,parameters);
            Occurrance objOccurance = null;
            int i = 1;
            foreach (DataRow dr in dt.Rows)
            {
                objOccurance = new Occurrance();
                objOccurance.occuranceid = Convert.ToInt32(dr["occuranceid"].ToString());
                objOccurance.serialnumber = i.ToString();
                //DateTime dtime = Convert.ToDateTime(dr["reportdate"]);
                //objOccurance.reportdate = dtime.Month.ToString()+"/"+dtime.Day.ToString()+"/"+dtime.Year.ToString();

                DateTime dte = (DateTime)dr["reportdate"];
                string rdate = String.Format("{0:dd MMM yyyy  HH:mm}", dte);

                objOccurance.reportdate = rdate;
                objOccurance.occurancetype = dr["occurancetype"].ToString();
                objOccurance.notes = dr["notes"].ToString();
                objOccurance.important = dr["important"] == null ? false : Convert.ToBoolean(dr["important"]);
                objOccurance.heading = dr["heading"].ToString();
                objOccurance.deploymentid = dr["deploymentid"] != null && dr["deploymentid"].ToString() != "" ? Convert.ToInt32(dr["deploymentid"]) : 0 ;
                OccurancesCol.Add(objOccurance);
                i = i + 1;
            }
            dt.Clear();
            dt.Dispose();
            return OccurancesCol;
        }

      public List<Occurrance> SelectOccurrencesByFilters(int currentUserType, int deploymentId, int startdate, int startmonth, int startyear, int enddate, int endmonth, int endyear)
      {
          MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
          List<Occurrance> OccurancesCol = new List<Occurrance>();
          DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetOccurances", CommandType.StoredProcedure,parameters);
          Occurrance objOccurance = null;
          int i = 1;

          switch (startmonth)
          {
              case 2:
                  if(startdate > 28)
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
              DateTime dte = (DateTime)dr["reportdate"];
              string rdate = String.Format("{0:dd MMM yyyy  HH:mm}", dte);
              if (dte != null)
              {
                  if (startDate.Date == dte.Date || endDate.Date == dte.Date || (startDate.Date < dte.Date && endDate.Date > dte.Date))
                  {
                      objOccurance = new Occurrance();
                      objOccurance.occuranceid = Convert.ToInt32(dr["occuranceid"].ToString());
                      objOccurance.serialnumber = i.ToString();

                      objOccurance.reportdate = rdate;
                      objOccurance.occurancetype = dr["occurancetype"].ToString();
                      objOccurance.notes = dr["notes"].ToString();
                      objOccurance.important = dr["important"] == null ? false : Convert.ToBoolean(dr["important"]);
                      objOccurance.heading = dr["heading"].ToString();
                      objOccurance.deploymentid = dr["deploymentid"] != null && dr["deploymentid"].ToString() != "" ? Convert.ToInt32(dr["deploymentid"]) : 0;
                      OccurancesCol.Add(objOccurance);
                      i = i + 1;
                  }
              }
          }
          dt.Clear();
          dt.Dispose();
          return OccurancesCol;
      }

      public Occurrance SelectOccurranceByID(int currentUserType, int deploymentId, int p_OccurranceID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] { 
                new MySqlParameter("p_occuranceid", p_OccurranceID)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetOccuranceByID", CommandType.StoredProcedure, parameters);
            Occurrance objOccurance = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objOccurance = new Occurrance();
                objOccurance.occuranceid = Convert.ToInt32(dr["occuranceid"].ToString());
                objOccurance.serialnumber = dr["serialnumber"].ToString();
                //DateTime dtime = Convert.ToDateTime(dr["reportdate"]);
                //objOccurance.reportdate = dtime.Month.ToString() + "/" + dtime.Day.ToString() + "/" + dtime.Year.ToString();
                objOccurance.reportdate = dr["reportdate"].ToString();
                objOccurance.occurancetype = dr["occurancetype"].ToString();
                objOccurance.notes = dr["notes"].ToString();
                objOccurance.important = dr["important"] == null ? false : Convert.ToBoolean(dr["important"].ToString());
                objOccurance.heading = dr["heading"].ToString();
                objOccurance.deploymentid = dr["deploymentid"] != null && dr["deploymentid"].ToString() != "" ? Convert.ToInt32(dr["deploymentid"]) : 0 ;
            }

            if (dt.Rows.Count == 0)
            {
                objOccurance = new Occurrance();
                objOccurance.reportdate = DateTime.Now.ToString();
            }
            dt.Clear();
            dt.Dispose();
            return objOccurance;
        }
    }
}
