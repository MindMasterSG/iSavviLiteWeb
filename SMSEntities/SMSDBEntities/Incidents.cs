using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SMSEntities.SMSDBEntities
{
   public class Incidents
    {
       //`incidents``incidentid``reportdate``natureofincident``dateofincident``locationid``particularsofpersons``briefdescription``remarksandactionstaken`
       public int incidentid { get; set; }
       public DateTime reportdate { get; set; }
       public string natureofincident { get; set; }
       public DateTime dateofincident { get; set; }
       public int locationid { get; set; }
       public string particularsofpersons { get; set; }
       public string briefdescription { get; set; }
       public string remarksandactionstaken { get; set; }
       public string snapshotpath { get; set; }
       public int deploymentid { get; set; }

        #region Othere properties
       public string LocationName { get; set; }
       public List<Location> LocationsList { get; set; }
        #endregion
    }
}
