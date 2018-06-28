using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace SMSEntities.SMSDBEntities
{
    public class UserInfo
    {
        public int UID { get; set; }
        public int DeploymentID { get; set; }
        public int UserTypeID { get; set; }
        [Required]
        [StringLength(100, ErrorMessage = "LoginID is required")]
        public string LoginID { get; set; }
        [Required]
        public string UserName { get; set; }
        [Required]
        public string EmailID { get; set; }
        [Required]
        [StringLength(100, ErrorMessage = "Password is required")]
        public string Password { get; set; }
        public string UserType { get; set; }
    }
}
