using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace SMSEntities.SMSDBEntities
{
    public class VisitorCheckInOut
    {
        //`nricid``name``address``fromcompany``tocompany``telno``persontovisit``eventid``temp``visitortype`
        //`keys``passid``gateid``vehicleplatenumber``guardname``remarks``checkintime``checkouttime`
        public Int32 visitorid { get; set; }
        [Required]
        public string nricid { get; set; }
        public string fullnricid { get; set; }
        [Required]
        public string name { get; set; }
        public string address { get; set; }
        [Required]
        public string fromcompany { get; set; }
        public int tocompany { get; set; }
        //public string visitingcompany { get; set; }
        [Required]
        public string telno { get; set; }
        public string persontovisit { get; set; }
        public int eventid { get; set; }
        public int temp { get; set; }
        [Required]
        public int visitortypeID { get; set; }
        public int keyid { get; set; }
        [Required]
        public int passid { get; set; }
        [Required]
        public int gateid { get; set; }
        public string vehicleplatenumber { get; set; }
        [Required]
        public string guardname { get; set; }
        public string remarks { get; set; }
        public string txtPhone { get; set; }
        public string blockorphone { get; set; }
        public DateTime checkintime { get; set; }
        public DateTime checkouttime { get; set; }
        public string cotime { get; set; }
        public string snapshotpath { get; set; }
        public int deploymentid { get; set; }

        public string CompanyName { get; set; }
        public string EventName { get; set; }
        public string CompanyPhone { get; set; }
        public List<Companies> CompaniesList { get; set; }
        public List<VisitorTypes> VisitorTypesCol { get; set; }
        public string GateName { get; set; }
        public List<Gates> GatesList { get; set; }
        public List<KEYS> KeysList { get; set; }
        public List<Passes> PassesList { get; set; }
        public List<EventMaster> EventsList { get; set; }
        public string purpose { get; set; }
        public List<Purpose> PurposeList { get; set; }

        public int IsBlockGuest { get; set; }
        public string BlockType { get; set; }
        public string BlockRemarks { get; set; }

        
              public string NRICBack { get; set; }
        public string NRICFront { get; set; }
        public int BlockDays { get; set; }
        public Nullable<DateTime> BlockedDate { get; set; }
        public Nullable<DateTime> UnblockedDate { get; set; }

        public string strBlockedDate { get; set; }
        public string strUnblockedDate { get; set; }

        public List<BlockGuest> GetBlockGuestType()
        {
            List<BlockGuest> objItemStatusCol = new List<BlockGuest>();
            objItemStatusCol.Add(new BlockGuest { BlockGuestId = 0, BlockGuestName = "No" });
            objItemStatusCol.Add(new BlockGuest { BlockGuestId = 1, BlockGuestName = "Yes" });
            return objItemStatusCol;
        }
        public List<Day> GetDays()
        {
            List<Day> objItemStatusCol = new List<Day>();
            objItemStatusCol.Add(new Day { DayId = 1, DayNumber = "1" });
            objItemStatusCol.Add(new Day { DayId = 2, DayNumber = "2" });
            objItemStatusCol.Add(new Day { DayId = 3, DayNumber = "3" });
            objItemStatusCol.Add(new Day { DayId = 4, DayNumber = "4" });
            objItemStatusCol.Add(new Day { DayId = 5, DayNumber = "5" });
            objItemStatusCol.Add(new Day { DayId = 6, DayNumber = "6" });
            objItemStatusCol.Add(new Day { DayId = 7, DayNumber = "7" });
            objItemStatusCol.Add(new Day { DayId = 8, DayNumber = "8" });
            objItemStatusCol.Add(new Day { DayId = 9, DayNumber = "9" });
            objItemStatusCol.Add(new Day { DayId = 10, DayNumber = "10" });
            objItemStatusCol.Add(new Day { DayId = 11, DayNumber = "11" });
            objItemStatusCol.Add(new Day { DayId = 12, DayNumber = "12" });
            objItemStatusCol.Add(new Day { DayId = 13, DayNumber = "13" });
            objItemStatusCol.Add(new Day { DayId = 14, DayNumber = "14" });
            objItemStatusCol.Add(new Day { DayId = 15, DayNumber = "15" });
            objItemStatusCol.Add(new Day { DayId = 16, DayNumber = "16" });
            objItemStatusCol.Add(new Day { DayId = 17, DayNumber = "17" });
            objItemStatusCol.Add(new Day { DayId = 18, DayNumber = "18" });
            objItemStatusCol.Add(new Day { DayId = 19, DayNumber = "19" });
            objItemStatusCol.Add(new Day { DayId = 20, DayNumber = "20" });
            objItemStatusCol.Add(new Day { DayId = 21, DayNumber = "21" });
            objItemStatusCol.Add(new Day { DayId = 22, DayNumber = "22" });
            objItemStatusCol.Add(new Day { DayId = 23, DayNumber = "23" });
            objItemStatusCol.Add(new Day { DayId = 24, DayNumber = "24" });
            objItemStatusCol.Add(new Day { DayId = 25, DayNumber = "25" });
            objItemStatusCol.Add(new Day { DayId = 26, DayNumber = "26" });
            objItemStatusCol.Add(new Day { DayId = 27, DayNumber = "27" });
            objItemStatusCol.Add(new Day { DayId = 28, DayNumber = "28" });
            objItemStatusCol.Add(new Day { DayId = 29, DayNumber = "29" });
            objItemStatusCol.Add(new Day { DayId = 30, DayNumber = "30" });
            objItemStatusCol.Add(new Day { DayId = 31, DayNumber = "31" });
            return objItemStatusCol;
        }

        public List<Month> GetMonths()
        {
            List<Month> objItemStatusCol = new List<Month>();
            objItemStatusCol.Add(new Month { MonthId = 1, MonthName = "January" });
            objItemStatusCol.Add(new Month { MonthId = 2, MonthName = "February" });
            objItemStatusCol.Add(new Month { MonthId = 3, MonthName = "March" });
            objItemStatusCol.Add(new Month { MonthId = 4, MonthName = "April" });
            objItemStatusCol.Add(new Month { MonthId = 5, MonthName = "May" });
            objItemStatusCol.Add(new Month { MonthId = 6, MonthName = "June" });
            objItemStatusCol.Add(new Month { MonthId = 7, MonthName = "July" });
            objItemStatusCol.Add(new Month { MonthId = 8, MonthName = "August" });
            objItemStatusCol.Add(new Month { MonthId = 9, MonthName = "September" });
            objItemStatusCol.Add(new Month { MonthId = 10, MonthName = "October" });
            objItemStatusCol.Add(new Month { MonthId = 11, MonthName = "November" });
            objItemStatusCol.Add(new Month { MonthId = 12, MonthName = "December" });
            return objItemStatusCol;
        }

        public List<Year> GetYears()
        {
            List<Year> objItemStatusCol = new List<Year>();
            objItemStatusCol.Add(new Year { YearId = 1, YearNumber = "2013" });
            objItemStatusCol.Add(new Year { YearId = 2, YearNumber = "2014" });
            objItemStatusCol.Add(new Year { YearId = 3, YearNumber = "2015" });
            objItemStatusCol.Add(new Year { YearId = 4, YearNumber = "2016" });
            objItemStatusCol.Add(new Year { YearId = 5, YearNumber = "2017" });
            objItemStatusCol.Add(new Year { YearId = 6, YearNumber = "2018" });
            objItemStatusCol.Add(new Year { YearId = 7, YearNumber = "2019" });
            objItemStatusCol.Add(new Year { YearId = 8, YearNumber = "2020" });
            objItemStatusCol.Add(new Year { YearId = 9, YearNumber = "2021" });
            objItemStatusCol.Add(new Year { YearId = 10, YearNumber = "2022" });
            objItemStatusCol.Add(new Year { YearId = 11, YearNumber = "2023" });
            objItemStatusCol.Add(new Year { YearId = 12, YearNumber = "2024" });
            objItemStatusCol.Add(new Year { YearId = 13, YearNumber = "2025" });
            objItemStatusCol.Add(new Year { YearId = 14, YearNumber = "2026" });
            objItemStatusCol.Add(new Year { YearId = 15, YearNumber = "2027" });
            objItemStatusCol.Add(new Year { YearId = 16, YearNumber = "2028" });
            objItemStatusCol.Add(new Year { YearId = 17, YearNumber = "2029" });
            objItemStatusCol.Add(new Year { YearId = 18, YearNumber = "2030" });
            return objItemStatusCol;
        }
    }


    public class Day
    {
        public int DayId { get; set; }
        public string DayNumber { get; set; }
    }
    public class BlockGuest
    {
        public int BlockGuestId { get; set; }
        public string BlockGuestName { get; set; }
    }

    public class Month
    {
        public int MonthId { get; set; }
        public string MonthName { get; set; }
    }
    public class Year
    {
        public int YearId { get; set; }
        public string YearNumber { get; set; }
    }
}
