using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SMSEntities.SMSDBEntities
{
    //```Id``KeyName``DeploymentId``Status``AddedDate```
   public class KEYS
    {
           public int KeyId { get; set; }
            public int DeploymentId { get; set; }
            public string KeyName { get; set; }
            public int Status { get; set; }
            //public int KeyStatusId { get; set; }
            public Nullable<DateTime> AddedDate { get; set; }
    }
}
