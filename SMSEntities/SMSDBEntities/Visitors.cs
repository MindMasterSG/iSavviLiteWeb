using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SMSEntities.SMSDBEntities
{
    //``id``DeploymentId``NRIC``FirstName``MiddleName``LastName``Address``ContactNumber``CompanyName``IsBlacklisted``AddedDate``
    public class Visitors
    {
        public int VisitorId { get; set; }
        public int DeploymentId { get; set; }
        public string NRIC { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string Address { get; set; }
        public string ContactNumber { get; set; }
        public string CompanyName { get; set; }
        public Int16 IsBlacklisted { get; set; }
        public Nullable<DateTime> AddedDate { get; set; }
        public int eventid { get; set; }
        public string DeploymentName { get; set; }
        public List<Deployement> Deployements { get; set; }
    }
}
