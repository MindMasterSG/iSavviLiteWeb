using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MySql.Data.MySqlClient;
using SMSEntities.SMSDBEntities;
using System.Data;

namespace SMSDAL.SMSDB
{
  public class UserTypeDBAccess
    {
      public int InsertUserType(UserTypes p_UserType)
        {
            //if (!IsUserTypeExists(p_UserType.Description))
            //{
            //    //MySqlParameter[] parameters = new MySqlParameter[] { new MySqlParameter("p_UserTypeDescription", p_UserType.Description) };
            //    //return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddDeployement", CommandType.StoredProcedure, parameters);
            //    return true;
            //}
            //else return false;

            MySqlParameter[] parameters = new MySqlParameter[]{
        new MySqlParameter("p_UserType", p_UserType.UserType),
        new MySqlParameter("p_Description",p_UserType.Description),
        new MySqlParameter("p_Parent", p_UserType.Parent),
        new MySqlParameter("p_level",p_UserType.Level)  };
            return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddUsertype", CommandType.StoredProcedure, parameters);
        }

      public int UpdateUserType(UserTypes p_UserType)
      {
          MySqlParameter[] parameters = new MySqlParameter[]{
        new MySqlParameter("p_UserTypeId", p_UserType.UserTypeID),
        new MySqlParameter("p_UserType", p_UserType.UserType),
        new MySqlParameter("p_Description",p_UserType.Description),
        new MySqlParameter("p_Parent", p_UserType.Parent),
        new MySqlParameter("p_level",p_UserType.Level)  };
          return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateUsertype", CommandType.StoredProcedure, parameters);
      }

      public int DeleteUserType(UserTypes p_UserType)
      {
          MySqlParameter[] parameters = new MySqlParameter[]{
        new MySqlParameter("p_UserTypeId", p_UserType.UserTypeID)};
          return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteUsertype", CommandType.StoredProcedure, parameters);
      }

      public bool IsUserTypeExists(string p_UsertypeDesc)
      {
          string sqlQuery = "SELECT `UserTypeId` FROM `usertypes` WHERE `UserType` = '" + p_UsertypeDesc + "'";
          DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand(sqlQuery, CommandType.Text);
          if (dt.Rows.Count > 0) return true;
          return false;
      }

      public List<UserTypes> SeletctUserTypes(int currentUserType, int deploymentId)
      {
          DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetUsertypes", CommandType.StoredProcedure);
          List<UserTypes> usertypetCol = new List<UserTypes>();
          UserTypes usertype;
          foreach (DataRow dr in dt.Rows)
          {
              usertype = new UserTypes();
              usertype.UserTypeID = Convert.ToInt32(dr["UserTypeId"].ToString());
              usertype.UserType = dr["UserType"].ToString();
              usertypetCol.Add(usertype);
          }
          return usertypetCol;
      }
      /// <summary>
      /// To select the all existing deployments
      /// </summary>
      /// <returns>data can return as collection list</returns>
      public UserTypes SeletctUserTypeByID(int currentUserType, int deploymentId, int p_UserTypeID)
      {
          string sqlQuery = "SELECT `UserTypeId` , `UserType` FROM `usertypes` WHERE `UserTypeId` = " + p_UserTypeID;
          DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand(sqlQuery, CommandType.Text);
          UserTypes usertype = null;
          if (dt.Rows.Count > 0)
          {
              DataRow dr = dt.Rows[0];
              usertype = new UserTypes();
              usertype.UserTypeID = Convert.ToInt32(dr["UserTypeId"].ToString());
              usertype.UserType = dr["UserType"].ToString();
          }
          return usertype;
      }
    }
}
