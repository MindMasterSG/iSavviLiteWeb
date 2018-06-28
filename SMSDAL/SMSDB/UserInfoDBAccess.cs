using System;
using System.Collections.Generic;
using SMSEntities.SMSDBEntities;
using System.Data;
using MySql.Data.MySqlClient;

namespace SMSDAL.SMSDB
{
  public class UserInfoDBAccess
    {
      public int InsertUserInfo(UserInfo p_UserInfo)
      {
          //if (!IsUserExists(p_UserInfo))
          //{
          int result = 0;
          MySqlParameter[] parameters = new MySqlParameter[] {
              new MySqlParameter("p_DeploymentID", p_UserInfo.DeploymentID),
              new MySqlParameter("p_UserTypeID", p_UserInfo.UserTypeID), 
              new MySqlParameter("p_LoginID", p_UserInfo.LoginID),
              new MySqlParameter("p_UserName",p_UserInfo.UserName),
              new MySqlParameter("p_EmailID",p_UserInfo.EmailID), 
              new MySqlParameter("p_Password",p_UserInfo.Password),
              new MySqlParameter("p_result",MySqlDbType.Int32, 2,ParameterDirection.Output,false,1,1,"Out",DataRowVersion.Default,result)
              };
              return MySQLDB.MySQLDBHelper.ExecuteNonQuery("AddUserDetails", CommandType.StoredProcedure, parameters);
          //}
          //else return false;
      }

      public int UpdateUserInfo(UserInfo p_UserInfo)
      {
          MySqlParameter[] parameters = new MySqlParameter[] {
              new MySqlParameter("p_UID", p_UserInfo.UID),
              new MySqlParameter("p_DeploymentID", p_UserInfo.DeploymentID),
              new MySqlParameter("p_UserTypeID", p_UserInfo.UserTypeID), 
              new MySqlParameter("p_LoginID", p_UserInfo.LoginID),
              new MySqlParameter("p_UserName",p_UserInfo.UserName),
              new MySqlParameter("p_EmailID",p_UserInfo.EmailID), 
              new MySqlParameter("p_Password",p_UserInfo.Password)};
          return MySQLDB.MySQLDBHelper.ExecuteNonQuery("UpdateUserDetails", CommandType.StoredProcedure, parameters);
      }

      public int DeleteUserType(int p_UID)
      {
          //string sqlQuery = "Delete From `userdetails`  WHERE `UserTypeID` = " + p_UserInfo.UserTypeID;
          MySqlParameter[] parameters = new MySqlParameter[] {
              new MySqlParameter("p_UID", p_UID)};
          return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteUserdetail", CommandType.StoredProcedure, parameters);
      }
      public int DeleteUser(int p_UID)
      {
          //string sqlQuery = "Delete From `userdetails`  WHERE `UserTypeID` = " + p_UserInfo.UserTypeID;
          MySqlParameter[] parameters = new MySqlParameter[] {
              new MySqlParameter("p_UID", p_UID)};
          return MySQLDB.MySQLDBHelper.ExecuteNonQuery("DeleteUserdetail", CommandType.StoredProcedure, parameters);
      }
      public UserInfo IsUserExists(UserInfo p_UserInfo)
      {
          MySqlParameter[] parameters = new MySqlParameter[] {
              new MySqlParameter("p_LoginID", p_UserInfo.LoginID),
              new MySqlParameter("p_Password",p_UserInfo.Password)};
          DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("IsUserExists", CommandType.StoredProcedure, parameters);
          UserInfo userdetails = null;
          if (dt.Rows.Count > 0)
          {
              DataRow dr = dt.Rows[0];
              userdetails = new UserInfo();
              userdetails.UID = Convert.ToInt32(dr["UID"]);
              userdetails.UserTypeID = Convert.ToInt32(dr["UserTypeID"].ToString());
              userdetails.UserName = dr["UserName"].ToString();
              userdetails.UserType = dr["UserType"].ToString();
              userdetails.DeploymentID = Convert.ToInt32(dr["DeploymentID"]);
              return userdetails;
          }
          return null;
      }

      public List<UserInfo> SeletctUsersListByUserTypeID(int p_UserTypeID)
      {
          string sqlQuery = "SELECT `UID`, `UserName` FROM `userdetails` WHERE UserTypeID = " + p_UserTypeID + "";
          DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand(sqlQuery, CommandType.Text);
          List<UserInfo> usertypetCol = new List<UserInfo>();
          UserInfo userdetails;
          foreach (DataRow dr in dt.Rows)
          {
              userdetails = new UserInfo();
              userdetails.UID = Convert.ToInt32(dr["UID"]);
              userdetails.UserName = dr["UserName"].ToString();
              usertypetCol.Add(userdetails);
          }
          return usertypetCol;
      }

      public List<UserInfo> SeletctUsersList(int deploymentId, int currentUserType)
        {
            MySqlParameter[] parameters = new MySqlParameter[] {
                new MySqlParameter("currentUserType", currentUserType),
              new MySqlParameter("p_deploymentId", deploymentId)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetUserdetails", CommandType.StoredProcedure,parameters);
            List<UserInfo> usersCol = new List<UserInfo>();
            UserInfo userdetails;
            foreach (DataRow dr in dt.Rows)
            {
                userdetails = new UserInfo();
                userdetails.UserTypeID = Convert.ToInt32(dr["UserTypeID"].ToString());
                userdetails.DeploymentID = Convert.ToInt32(dr["DeploymentID"]); 
                userdetails.EmailID = dr["EmailID"].ToString();
                userdetails.LoginID = dr["LoginID"].ToString();
                userdetails.UserName = dr["UserName"].ToString();
                userdetails.UID = Convert.ToInt32(dr["UID"]); 
                usersCol.Add(userdetails);
            }
            return usersCol;
        }

      /// To select the all existing deployments
      /// </summary>
      /// <returns>data can return as collection list</returns>
      public List<UserInfo> SelectUsersByDeploymentId(int p_DeployementID)
      {
          MySqlParameter[] parameters = new MySqlParameter[] {
               new MySqlParameter("p_DeploymentId", p_DeployementID)
           };
          DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetUsersByDeploymentID", CommandType.StoredProcedure, parameters);
          List<UserInfo> usersCol = new List<UserInfo>();
          UserInfo userdetails;
          foreach (DataRow dr in dt.Rows)
          {
              userdetails = new UserInfo();
              userdetails.UID = Convert.ToInt32(dr["UID"]);
              userdetails.DeploymentID = Convert.ToInt32(dr["DeploymentID"]);
              userdetails.UserTypeID = Convert.ToInt32(dr["UserTypeID"].ToString());
              userdetails.LoginID = dr["LoginID"].ToString();
              userdetails.UserName = dr["UserName"].ToString();
              userdetails.EmailID = dr["EmailID"].ToString();

              usersCol.Add(userdetails);
          }
          dt.Clear();
          dt.Dispose();
          return usersCol;
      }
        /// <summary>
        /// To select the all existing deployments
        /// </summary>
        /// <returns>data can return as collection list</returns>
        public UserInfo SeletctUserInfoByID(int p_UID)
        {
            //string sqlQuery = "SELECT `DeploymentID`, `EmailID`, `LoginID`, `UID`, `UserName`, `UserTypeID` FROM `userdetails` WHERE `UID` = " + p_UID;
            MySqlParameter[] parameters = new MySqlParameter[] {
              new MySqlParameter("p_UID", p_UID)};
            DataTable dt = MySQLDB.MySQLDBHelper.ExecuteSelectCommand("GetUserdetailByID", CommandType.StoredProcedure, parameters);
            UserInfo userdetails = null;
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                userdetails = new UserInfo();
                userdetails.UserTypeID = Convert.ToInt32(dr["UserTypeID"].ToString());
                userdetails.DeploymentID = Convert.ToInt32(dr["DeploymentID"]); 
                userdetails.EmailID = dr["EmailID"].ToString();
                userdetails.LoginID = dr["LoginID"].ToString();
                userdetails.UserName = dr["UserName"].ToString();
                userdetails.UID = Convert.ToInt32(dr["UID"]);
            }
            return userdetails;
        }
    }
}
