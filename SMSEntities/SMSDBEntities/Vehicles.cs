using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace SMSEntities.SMSDBEntities
{
    public class Vehicles
    {
        //`identificationunit``platenumber``containernumber``description`
        //`trailernumber``contractor``length``capacity``securityguardname``authpersonic``authpersonname``imagepath`
        public int vehicleid { get; set; }
        public string identificationunit { get; set; }
        public string platenumber { get; set; }
        public string containernumber { get; set; }
        public string description { get; set; }
        public string trailernumber { get; set; }
        public string contractor { get; set; }
        public string length { get; set; }
        public string capacity { get; set; }
        public string securityguardname { get; set; }
        public string authpersonic { get; set; }
        public string authpersonname { get; set; }
        public string imagepath { get; set; }
        public int deploymentid { get; set; }
        public int vehicletypeid { get; set; }
        public string vehicletype { get; set; }
        //public int LocationId { get; set; }
        public string LocationName { get; set; }
        public string purpose { get; set; }
        public List<VehicleTypes> VehicleTypesList { get; set; }
        public List<Purpose> PurposeList { get; set; }

        //public List<Location> LocationList { get; set; }
    }
}
