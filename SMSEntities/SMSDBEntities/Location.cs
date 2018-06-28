using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SMSEntities.SMSDBEntities
{
    //`Id``DeploymentId``LocationName`
   public class Location
    {
       public int LocationId { get; set; }
        public int DeploymentId { get; set; }
        public string LocationName { get; set; }
    }
}
