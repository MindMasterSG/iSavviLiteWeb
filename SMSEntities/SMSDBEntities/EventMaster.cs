using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace SMSEntities.SMSDBEntities
{
    public class EventMaster
    {
        //`eventmasterlist``eventid``startdate``enddate``locationid``numberofguards`
        //`specialdutyforguard``eventname``notes``optionalguestlist``personinchargename``personinchargenric``personinchargecontactnumber`
        public int eventid { get; set; }
        public DateTime startdate { get; set; }
        public DateTime enddate { get; set; }
        public int locationid { get; set; }
        public int numberofguards { get; set; }
        public string specialdutyforguard { get; set; }
        [Required]
        public string eventname { get; set; }
        public string notes { get; set; }
        public string optionalguestlist { get; set; }
        [Required]
        public string personinchargename { get; set; }
        public string personinchargenric { get; set; }
        [Required]
        public string personinchargecontactnumber { get; set; }
        [Required]
        public int DeploymentId { get; set; }
        public string DeploymentName { get; set; }
        public string Remarks { get; set; }
        #region Othere properties
        public string LocationName { get; set; }
        public List<Location> LocationsList { get; set; }
        public List<Deployement> DeploymentList { get; set; }
        #endregion
    }
}
