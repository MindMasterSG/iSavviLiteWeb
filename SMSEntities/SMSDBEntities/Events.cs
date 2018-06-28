using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SMSEntities.SMSDBEntities
{
   public class Events
    {
        //`Id``DeploymentId``EventName``EventDate``Remarks``AddedDate`
        public int EventID { get; set; }
        public int DeploymentId { get; set; }
        public string EventName { get; set; }
        public Nullable<DateTime> EventDate { get; set; }
        public string Remarks { get; set; }
        public Nullable<DateTime> AddedDate { get; set; }
    }
}
