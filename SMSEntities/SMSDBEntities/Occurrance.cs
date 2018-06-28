using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SMSEntities.SMSDBEntities
{
   public class Occurrance
    {
        //`occuranceid``serialnumber``reportdate``occurancetype``notes`,`important`,`heading`
        public int occuranceid { get; set; }
        public string serialnumber { get; set; }
        public string reportdate { get; set; }
        public string occurancetype { get; set; }
        public string notes { get; set; }
        public bool important { get; set; }
        public string  heading { get; set; }
        public DateTime ConvertedDate { get; set; }
        public int SelectedMonth { get; set; }
        public int SelectedYear { get; set; }
        public int deploymentid { get; set; }
    }
}
