using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.ComponentModel.DataAnnotations;
namespace SMSEntities.SMSDBEntities
{
    public class Deployement
    {
        //`Id``Name``Description``AddedDate`
        #region Properties
        public int DeploymentId { get; set; }

        [Required]
        public string DeploymentName { get; set; }

        public string DeploymentType { get; set; }
        public string Description { get; set; }
        public Nullable<DateTime> AddedDate { get; set; }
        public string ClientName { get; set; }
        public string Address { get; set; }
        #endregion

        //public Deployement()
        //{
        //    DeploymentId = 0;
        //    Description = string.Empty;
        //}
    }
}
