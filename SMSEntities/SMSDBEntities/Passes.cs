using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SMSEntities.SMSDBEntities
{
   public class Passes
    {
        //`PassId``PassName``PassStatus``VisitortypeId`
        public int PassId { get; set; }
        public string PassName { get; set; }
        public string PassStatus { get; set; }
        public int VisitortypeId { get; set; }
        public int DeploymentId { get; set; }
    }
}
