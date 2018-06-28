using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SMSEntities.SMSDBEntities
{
    public class VisitorTypes
    {
        public int VisitortypeId { get; set; }
        public string VisitorTypeDescription { get; set; }
        public Nullable<DateTime> AddedDate { get; set; }
    }
}
