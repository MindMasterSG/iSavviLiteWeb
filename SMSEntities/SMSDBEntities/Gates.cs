using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace SMSEntities.SMSDBEntities
{
    public class Gates
    {
        public int GateId { get; set; }
        public int DeploymentId { get; set; }
        [Required]
        public string GateName { get; set; }
        public Nullable<DateTime> AddedDate { get; set; }
    }
}
