using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace SMSEntities.SMSDBEntities
{
    //`UserTypeId``UserType``Description``CreatedDate``Parent``level`
   public class UserTypes
    {
        public int UserTypeID { get; set; }
       [Required]
       //[("Enter user type.")]
        public string UserType { get; set; }
        public string Description { get; set; }
        public Nullable<DateTime> CreatedDate { get; set; }
        public string Parent { get; set; }
        public Nullable<int> Level { get; set; }
    }
}
