using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SMSEntities.SMSDBEntities
{
   public class LostAndFound
    {
       //`lostandfoundreportid``nameofperson``nric``reporteddate``remarks`
        public int lostandfoundreportid { get; set; }
        public string nameofperson { get; set; }
        public string nric { get; set; }
        public DateTime reporteddate { get; set; }
        public string remarks { get; set; }

        public int deploymentid { get; set; }
    }
}
