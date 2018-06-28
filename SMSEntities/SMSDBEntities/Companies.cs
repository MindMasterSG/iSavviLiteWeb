using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SMSEntities.SMSDBEntities
{
  public class Companies
    {
        public int CompanyId { get; set; }
        public string CompanyName { get; set; }
        public string Address { get; set; }
        public string ContactNumber { get; set; }
        public int DeploymentId { get; set; }
    }
}
