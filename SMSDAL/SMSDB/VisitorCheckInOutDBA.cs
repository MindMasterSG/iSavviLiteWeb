using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SMSEntities.SMSDBEntities;
using MySql.Data.MySqlClient;
using System.Data;
using System.Configuration;

namespace SMSDAL.SMSDB
{
    public class VisitorCheckInOutDBA
    {
        //      `AddVisitorCheckInOut`(IN p_name VARCHAR(100),IN p_address VARCHAR(500), IN p_fromcompany VARCHAR(100),
        //IN p_tocompany INT, IN p_telno VARCHAR(20),IN p_persontovisit VARCHAR(100), IN p_eventid INT, IN p_temp INT, 
        //IN p_visitortype INT, IN p_keys  VARCHAR(100), IN p_passid INT, IN p_gateid INT, IN p_vehicleplatenumber  VARCHAR(20),
        //IN p_guardname VARCHAR(100),IN p_remarks VARCHAR(500), IN p_checkintime DATETIME, IN p_checkouttime DATETIME)
        public int InsertVisitorCheckInOut(VisitorCheckInOut p_VisitorCheckInOut)
        {
            try
            {
                int result = 0;
                MySqlParameter[] parameters = new MySqlParameter[] {
                new MySqlParameter("p_nricid",p_VisitorCheckInOut.nricid),
                new MySqlParameter("p_name",p_VisitorCheckInOut.name),
                new MySqlParameter("p_address",p_VisitorCheckInOut.address),
                new MySqlParameter("p_fromcompany",p_VisitorCheckInOut.fromcompany),
                new MySqlParameter("p_tocompany",p_VisitorCheckInOut.tocompany),
                new MySqlParameter("p_telno",p_VisitorCheckInOut.telno),
                new MySqlParameter("p_persontovisit",p_VisitorCheckInOut.persontovisit),
                new MySqlParameter("p_eventid",p_VisitorCheckInOut.eventid),
                new MySqlParameter("p_temp",p_VisitorCheckInOut.temp),
                new MySqlParameter("p_visitortype",p_VisitorCheckInOut.visitortypeID),
                new MySqlParameter("p_keyid",p_VisitorCheckInOut.keyid),
                new MySqlParameter("p_passid",p_VisitorCheckInOut.passid),
                new MySqlParameter("p_gateid",p_VisitorCheckInOut.gateid),
                new MySqlParameter("p_vehicleplatenumber",p_VisitorCheckInOut.vehicleplatenumber),
                new MySqlParameter("p_guardname",p_VisitorCheckInOut.guardname),
                new MySqlParameter("p_remarks",p_VisitorCheckInOut.remarks),
                new MySqlParameter("p_checkintime",p_VisitorCheckInOut.checkintime),
                new MySqlParameter("p_checkouttime",p_VisitorCheckInOut.checkouttime),
               new MySqlParameter("p_snapshotpath",p_VisitorCheckInOut.snapshotpath),
               new MySqlParameter("p_deploymentid",p_VisitorCheckInOut.deploymentid),
               new MySqlParameter("p_blockorphone",p_VisitorCheckInOut.blockorphone),
               new MySqlParameter("p_fullnricid",p_VisitorCheckInOut.fullnricid),
               //new MySqlParameter("p_visitingcompany",p_VisitorCheckInOut.visitingcompany),
                new MySqlParameter("p_purpose",p_VisitorCheckInOut.purpose),

                new MySqlParameter("p_IsBlockGuest",p_VisitorCheckInOut.IsBlockGuest),
                new MySqlParameter("p_BlockType",p_VisitorCheckInOut.BlockType),
               new MySqlParameter("p_BlockRemarks",p_VisitorCheckInOut.BlockRemarks),
               new MySqlParameter("p_BlockDays",0),
               new MySqlParameter("p_BlockedDate",p_VisitorCheckInOut.BlockedDate),
               new MySqlParameter("p_UnblockedDate",p_VisitorCheckInOut.UnblockedDate),
               new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)

          };
                return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddVisitorCheckInOut", CommandType.StoredProcedure, parameters);
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        public int UpadateVisitorCheckInOut(VisitorCheckInOut p_VisitorCheckInOut)
        {
            int result = 0;
            MySqlParameter[] parameters = new MySqlParameter[] {
                new MySqlParameter("p_nricid",p_VisitorCheckInOut.nricid),
                new MySqlParameter("p_name",p_VisitorCheckInOut.name),
                new MySqlParameter("p_address",p_VisitorCheckInOut.address),
                new MySqlParameter("p_fromcompany",p_VisitorCheckInOut.fromcompany),
                new MySqlParameter("p_tocompany",p_VisitorCheckInOut.tocompany),
                new MySqlParameter("p_telno",p_VisitorCheckInOut.telno),
                new MySqlParameter("p_persontovisit",p_VisitorCheckInOut.persontovisit),
                new MySqlParameter("p_eventid",p_VisitorCheckInOut.eventid),
                new MySqlParameter("p_temp",p_VisitorCheckInOut.temp),
                new MySqlParameter("p_visitortype",p_VisitorCheckInOut.visitortypeID),
                new MySqlParameter("p_keyid",p_VisitorCheckInOut.keyid),
                new MySqlParameter("p_passid",p_VisitorCheckInOut.passid),
                new MySqlParameter("p_gateid",p_VisitorCheckInOut.gateid),
                new MySqlParameter("p_vehicleplatenumber",p_VisitorCheckInOut.vehicleplatenumber),
                new MySqlParameter("p_guardname",p_VisitorCheckInOut.guardname),
                new MySqlParameter("p_remarks",p_VisitorCheckInOut.remarks),
                new MySqlParameter("p_checkintime",p_VisitorCheckInOut.checkintime),
                new MySqlParameter("p_checkouttime",p_VisitorCheckInOut.checkouttime),
                new MySqlParameter("p_snapshotpath",p_VisitorCheckInOut.snapshotpath),
                new MySqlParameter("p_deploymentid",p_VisitorCheckInOut.deploymentid),
                new MySqlParameter("p_blockorphone",p_VisitorCheckInOut.blockorphone),
                 //new MySqlParameter("p_visitingcompany",p_VisitorCheckInOut.visitingcompany),
                new MySqlParameter("p_purpose",p_VisitorCheckInOut.purpose),
                new MySqlParameter("p_IsBlockGuest",Convert.ToBoolean(p_VisitorCheckInOut.IsBlockGuest)),
                new MySqlParameter("p_BlockType",p_VisitorCheckInOut.BlockType),
               new MySqlParameter("p_BlockRemarks",p_VisitorCheckInOut.BlockRemarks),
               new MySqlParameter("p_BlockDays",p_VisitorCheckInOut.BlockDays),
               new MySqlParameter("p_BlockedDate",p_VisitorCheckInOut.BlockedDate),
               new MySqlParameter("p_UnblockedDate",p_VisitorCheckInOut.UnblockedDate),
                              new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
        };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateVisitorCheckInOut", CommandType.StoredProcedure, parameters);
        }

        public int DeleteVisitorCheckInOut(int p_NRICID)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
                new MySqlParameter("p_nricid", p_NRICID)};
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteVisitorCheckInOut", CommandType.StoredProcedure, parameters);
        }

        public List<VisitorCheckInOut> SelectVisitorCheckInOut(int currentUserType, int deploymentId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
            List<VisitorCheckInOut> VisitorCheckInOutCol = new List<VisitorCheckInOut>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetVisitorCheckInOut", CommandType.StoredProcedure, parameters);
            VisitorCheckInOut objVisitorCheckInOut = null;
            foreach (DataRow dr in dt.Rows)
            {
                objVisitorCheckInOut = new VisitorCheckInOut();
                objVisitorCheckInOut.visitorid = Convert.ToInt32(dr["visitorid"].ToString());
                objVisitorCheckInOut.nricid = dr["nricid"].ToString();
                objVisitorCheckInOut.passid = dr["passid"] != null && dr["passid"].ToString() != "" ? Convert.ToInt32(dr["passid"].ToString()) : 0;
                objVisitorCheckInOut.address = dr["address"].ToString();
                objVisitorCheckInOut.blockorphone = dr["blockorphone"].ToString();

                objVisitorCheckInOut.checkintime = Convert.ToDateTime(dr["checkintime"].ToString());
                if (dr["checkouttime"].ToString() != null && dr["checkouttime"].ToString() != "")
                {
                    objVisitorCheckInOut.checkouttime = Convert.ToDateTime(dr["checkouttime"].ToString());
                }
                objVisitorCheckInOut.eventid = dr["eventid"] != null && dr["eventid"].ToString() != "" ? Convert.ToInt32(dr["eventid"].ToString()) : 0;

                objVisitorCheckInOut.fromcompany = dr["fromcompany"].ToString();
                objVisitorCheckInOut.gateid = dr["gateid"] != null && dr["gateid"].ToString() != "" ? Convert.ToInt32(dr["gateid"].ToString()) : 0;
                objVisitorCheckInOut.guardname = dr["guardname"].ToString();
                objVisitorCheckInOut.keyid = dr["keyid"] != null && dr["keyid"].ToString() != "" ? Convert.ToInt32(dr["keyid"].ToString()) : 0;
                objVisitorCheckInOut.name = dr["name"].ToString();
                objVisitorCheckInOut.persontovisit = dr["persontovisit"].ToString();
                objVisitorCheckInOut.remarks = dr["remarks"].ToString();
                objVisitorCheckInOut.telno = dr["telno"].ToString();

                objVisitorCheckInOut.temp = dr["temp"] != null && dr["temp"].ToString() != "" ? Convert.ToInt32(dr["temp"].ToString()) : 0;
                //objVisitorCheckInOut.tocompany = Convert.ToInt32(dr["tocompany"].ToString());
                objVisitorCheckInOut.snapshotpath = dr["snapshotpath"].ToString();
                if (dr["NRICFront"].ToString() != null && dr["NRICFront"].ToString() != "")
                {
                    objVisitorCheckInOut.NRICFront = ConfigurationManager.AppSettings["GetNRICPath"] + "/" + dr["NRICFront"].ToString();
                }
                if (dr["NRICBack"].ToString() != null && dr["NRICBack"].ToString() != "")
                {
                    objVisitorCheckInOut.NRICBack = ConfigurationManager.AppSettings["GetNRICPath"] + "/" + dr["NRICBack"].ToString();
                }
                objVisitorCheckInOut.deploymentid = dr["deploymentid"] != null && dr["deploymentid"].ToString() != "" ? Convert.ToInt32(dr["deploymentid"]) : 0;
                // objVisitorCheckInOut.visitortypeID = Convert.ToInt32(dr["visitortypeID"].ToString());
                //objVisitorCheckInOut.visitingcompany = dr["visitingcompany"].ToString();
                objVisitorCheckInOut.purpose = dr["purpose"].ToString();
                objVisitorCheckInOut.IsBlockGuest = dr["IsBlockGuest"] != null && dr["IsBlockGuest"].ToString() != "" ? Convert.ToInt32(dr["IsBlockGuest"]) : 0;
                objVisitorCheckInOut.BlockType = dr["BlockType"].ToString();

                objVisitorCheckInOut.BlockDays = dr["BlockDays"] != null && dr["BlockDays"].ToString() != "" ? Convert.ToInt32(dr["BlockDays"].ToString()) : 0;
                objVisitorCheckInOut.BlockRemarks = dr["BlockRemarks"].ToString();
                if (dr["BlockedDate"].ToString() != null && dr["BlockedDate"].ToString() != "")
                {
                    objVisitorCheckInOut.BlockedDate = Convert.ToDateTime(dr["BlockedDate"]);
                }
                if (dr["UnblockedDate"].ToString() != null && dr["UnblockedDate"].ToString() != "")
                {
                    objVisitorCheckInOut.UnblockedDate = Convert.ToDateTime(dr["UnblockedDate"]);
                }
                VisitorCheckInOutCol.Add(objVisitorCheckInOut);
            }
            dt.Clear();
            dt.Dispose();
            return VisitorCheckInOutCol;
        }

        public List<VisitorCheckInOut> SelectVisitorCheckInOutByFilters(int currentUserType, int deploymentId, int startdate, int startmonth, int startyear, int enddate, int endmonth, int endyear)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("currentUserType", currentUserType),
               new MySqlParameter("p_deploymentId", deploymentId)
           };
            List<VisitorCheckInOut> VisitorCheckInOutCol = new List<VisitorCheckInOut>();
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetVisitorCheckInOut", CommandType.StoredProcedure, parameters);
            VisitorCheckInOut objVisitorCheckInOut = null;
            int i = 1;

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

                DateTime dte = Convert.ToDateTime(dr["checkintime"].ToString());

                if (dte != null)
                {
                    //if (startDate == dte || endDate == dte || (startDate < dte && endDate > dte))
                    if (startDate == dte || endDate == dte || startDate < dte)
                    {

                        objVisitorCheckInOut = new VisitorCheckInOut();
                        objVisitorCheckInOut.visitorid = Convert.ToInt32(dr["visitorid"].ToString());
                        objVisitorCheckInOut.nricid = dr["nricid"].ToString();
                        objVisitorCheckInOut.passid = dr["passid"] != null && dr["passid"].ToString() != "" ? Convert.ToInt32(dr["passid"].ToString()) : 0;
                        objVisitorCheckInOut.address = dr["address"].ToString();
                        objVisitorCheckInOut.blockorphone = dr["blockorphone"].ToString();
                        objVisitorCheckInOut.checkintime = Convert.ToDateTime(dr["checkintime"].ToString());
                        if (dr["checkouttime"].ToString() != null && dr["checkouttime"].ToString() != "")
                        {
                            objVisitorCheckInOut.checkouttime = Convert.ToDateTime(dr["checkouttime"].ToString());
                        }
                        objVisitorCheckInOut.eventid = dr["eventid"] != null && dr["eventid"].ToString() != "" ? Convert.ToInt32(dr["eventid"].ToString()) : 0;
                        objVisitorCheckInOut.fromcompany = dr["fromcompany"].ToString();
                        objVisitorCheckInOut.gateid = dr["gateid"] != null && dr["gateid"].ToString() != "" ? Convert.ToInt32(dr["gateid"].ToString()) : 0;
                        objVisitorCheckInOut.guardname = dr["guardname"].ToString();
                        objVisitorCheckInOut.keyid = dr["keyid"] != null && dr["keyid"].ToString() != "" ? Convert.ToInt32(dr["keyid"]) : 0;
                        objVisitorCheckInOut.name = dr["name"].ToString();
                        objVisitorCheckInOut.persontovisit = dr["persontovisit"].ToString();
                        objVisitorCheckInOut.remarks = dr["remarks"].ToString();
                        objVisitorCheckInOut.telno = dr["telno"].ToString();
                        objVisitorCheckInOut.temp = dr["temp"] != null && dr["temp"].ToString() != "" ? Convert.ToInt32(dr["temp"].ToString()) : 0;
                        //objVisitorCheckInOut.tocompany = Convert.ToInt32(dr["tocompany"].ToString());
                        objVisitorCheckInOut.snapshotpath = dr["snapshotpath"].ToString();
                        objVisitorCheckInOut.deploymentid = dr["deploymentid"] != null && dr["deploymentid"].ToString() != "" ? Convert.ToInt32(dr["deploymentid"]) : 0;
                        //objVisitorCheckInOut.visitingcompany = dr["visitingcompany"].ToString();
                        objVisitorCheckInOut.purpose = dr["purpose"].ToString();

                        objVisitorCheckInOut.IsBlockGuest = dr["IsBlockGuest"] != null && dr["IsBlockGuest"].ToString() != "" ? Convert.ToInt32(dr["IsBlockGuest"].ToString()) : 0;
                        objVisitorCheckInOut.BlockType = dr["BlockType"].ToString();
                        objVisitorCheckInOut.BlockDays = dr["BlockDays"] != null && dr["BlockDays"].ToString() != "" ? Convert.ToInt32(dr["BlockDays"].ToString()) : 0; ;
                        objVisitorCheckInOut.BlockRemarks = dr["BlockRemarks"].ToString();
                        if (dr["BlockedDate"].ToString() != null && dr["BlockedDate"].ToString() != "")
                        {
                            objVisitorCheckInOut.BlockedDate = Convert.ToDateTime(dr["BlockedDate"]);
                        }
                        if (dr["UnblockedDate"].ToString() != null && dr["UnblockedDate"].ToString() != "")
                        {
                            objVisitorCheckInOut.UnblockedDate = Convert.ToDateTime(dr["UnblockedDate"]);
                        }
                        VisitorCheckInOutCol.Add(objVisitorCheckInOut);

                        i = i + 1;
                    }
                }
            }
            dt.Clear();
            dt.Dispose();
            return VisitorCheckInOutCol;
        }

        public VisitorCheckInOut SelectVisitorCheckInOutByID(String p_NRICID, int p_EventId)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
                new MySqlParameter("p_nricid", p_NRICID),
            new MySqlParameter("p_EventId", p_EventId)};

            string sqlQuery = "SELECT 	`nricid`,`name`,`address`,`fromcompany`,`tocompany`,`telno`,`persontovisit`,`eventid`,`temp`,`visitortype`,`keyid`,`passid`,`gateid`,`vehicleplatenumber`,`guardname`,`remarks`,`checkintime`,`checkouttime`,`snapshotpath`,`deploymentid`,`Purpose`,`IsBlockGuest`,`BlockType`,`BlockRemarks`,`BlockDays`,`BlockedDate`,`UnblockedDate` FROM	`visitorcheckinout` WHERE `nricid` = '" + p_NRICID + "' AND `eventid` = " + p_EventId + " ORDER BY `checkintime` DESC;";
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand(sqlQuery, CommandType.Text);

            //DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetVisitorCheckInOutByID", CommandType.StoredProcedure, parameters);
            VisitorCheckInOut objVisitorCheckInOut = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                objVisitorCheckInOut = new VisitorCheckInOut();
                objVisitorCheckInOut.nricid = dr["nricid"].ToString();
                objVisitorCheckInOut.passid = dr["passid"] != null && dr["passid"].ToString() != "" ? Convert.ToInt32(dr["passid"]) : 0;
                objVisitorCheckInOut.address = dr["address"].ToString();
                //objVisitorCheckInOut.blockorphone = dr["blockorphone"].ToString();

                objVisitorCheckInOut.checkintime = Convert.ToDateTime(dr["checkintime"].ToString());
                if (dr["checkouttime"].ToString() == null && dr["checkouttime"].ToString() == "")
                {
                    objVisitorCheckInOut.checkouttime = Convert.ToDateTime(dr["checkouttime"].ToString());
                }
                //objVisitorCheckInOut.eventid = Convert.ToInt32(dr["eventid"].ToString());
                objVisitorCheckInOut.fromcompany = dr["fromcompany"].ToString();
                objVisitorCheckInOut.gateid = dr["gateid"] != null && dr["gateid"].ToString() != "" ? Convert.ToInt32(dr["gateid"]) : 0;
                objVisitorCheckInOut.guardname = dr["guardname"].ToString();
                objVisitorCheckInOut.keyid = dr["keyid"] != null && dr["keyid"].ToString() != "" ? Convert.ToInt32(dr["keyid"]) : 0;
                objVisitorCheckInOut.name = dr["name"].ToString();
                objVisitorCheckInOut.persontovisit = dr["persontovisit"].ToString();
                objVisitorCheckInOut.remarks = dr["remarks"].ToString();
                objVisitorCheckInOut.telno = dr["telno"].ToString();
                objVisitorCheckInOut.temp = dr["temp"] != null && dr["temp"].ToString() != "" ? Convert.ToInt32(dr["temp"].ToString()) : 0;
                //objVisitorCheckInOut.tocompany = Convert.ToInt32(dr["tocompany"].ToString());
                objVisitorCheckInOut.snapshotpath = dr["snapshotpath"].ToString();
                objVisitorCheckInOut.deploymentid = dr["deploymentid"] != null && dr["deploymentid"].ToString() != "" ? Convert.ToInt32(dr["deploymentid"]) : 0;
                objVisitorCheckInOut.visitortypeID = dr["visitortype"] != null && dr["visitortype"].ToString() != "" ? Convert.ToInt32(dr["visitortype"]) : 0;
                //objVisitorCheckInOut.visitingcompany = dr["visitingcompany"].ToString();
                objVisitorCheckInOut.purpose = dr["purpose"].ToString();

                objVisitorCheckInOut.IsBlockGuest = dr["IsBlockGuest"] != null && dr["IsBlockGuest"].ToString() != "" ? Convert.ToInt32(dr["IsBlockGuest"]) : 0;
                objVisitorCheckInOut.BlockType = dr["BlockType"].ToString();
                objVisitorCheckInOut.BlockDays = dr["BlockDays"] != null && dr["BlockDays"].ToString() != "" ? Convert.ToInt32(dr["BlockDays"].ToString()) : 0;
                objVisitorCheckInOut.BlockRemarks = dr["BlockRemarks"].ToString();
                if (dr["BlockedDate"].ToString() == null && dr["BlockedDate"].ToString() == "")
                {
                    objVisitorCheckInOut.BlockedDate = Convert.ToDateTime(dr["BlockedDate"]);
                }
                if (dr["UnblockedDate"].ToString() == null && dr["UnblockedDate"].ToString() == "")
                {
                    objVisitorCheckInOut.UnblockedDate = Convert.ToDateTime(dr["UnblockedDate"]);
                }
            }
            dt.Clear();
            dt.Dispose();
            return objVisitorCheckInOut;
        }

    }
}
