using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;
namespace SMSDAL.MySQLDB
{
   public class MySQLDBHelper
    {
        // This function will be used to execute operation of parameterless commands
       internal static DataTable ExecuteSelectCommand(string p_CommandText, CommandType p_CommandType)
       {
           string MySQLConncetionString = ConfigurationManager.ConnectionStrings["strMySQLConnection"].ToString();
           
           DataTable table = null;
           using (MySqlConnection conn = new MySqlConnection(MySQLConncetionString))
           {
               using (MySqlCommand cmd = conn.CreateCommand())
               {
                   cmd.CommandText = p_CommandText;
                   cmd.CommandType = p_CommandType;
                   try
                   {
                       if (conn.State != ConnectionState.Open) conn.Open();
                       using (MySqlDataAdapter dap = new MySqlDataAdapter(cmd))
                       {
                           table = new DataTable();
                           dap.Fill(table);
                       }
                   }
                   catch (Exception ex)
                   {
                       string x = ex.Message;
                   }
               }
           }
           return table;
       }

        // This function will be used to execute R(CRUD) operation of parameterized commands
       internal static DataTable ExecuteSelectCommand(string p_CommandText, CommandType p_CommandType, MySqlParameter[] p_Parameters)
       {
           string MySQLConncetionString = ConfigurationManager.ConnectionStrings["strMySQLConnection"].ToString();
           DataTable table = null;  
           using (MySqlConnection conn = new MySqlConnection(MySQLConncetionString))
           {
               using (MySqlCommand cmd = conn.CreateCommand())
               {
                   cmd.CommandText = p_CommandText;
                   cmd.CommandType = p_CommandType;
                   cmd.Parameters.AddRange(p_Parameters);
                   try
                   {
                       if (conn.State != ConnectionState.Open) conn.Open();
                       using (MySqlDataAdapter dap = new MySqlDataAdapter(cmd))
                       {
                           table = new DataTable();
                           dap.Fill(table);
                       }
                   }
                   catch (Exception ex)
                   {
                       string x = ex.Message;
                   }
               }
           }
           return table;
       }

        // This function will be used to execute CUD(CRUD) operation of parameterized commands
       internal static int ExecuteNonQuery(string p_CommandText, CommandType p_CommandType, MySqlParameter[] p_Parameters)
       {
           string MySQLConncetionString = ConfigurationManager.ConnectionStrings["strMySQLConnection"].ToString();
           int result = 0;
           using (MySqlConnection conn = new MySqlConnection(MySQLConncetionString))
           {
               using (MySqlCommand cmd = conn.CreateCommand())
               {
                   cmd.CommandText = p_CommandText;
                   cmd.CommandType = p_CommandType;
                   cmd.Parameters.AddRange(p_Parameters);
                   try
                   {
                       if (conn.State != ConnectionState.Open) conn.Open();
                       result = cmd.ExecuteNonQuery();
                       if (cmd.Parameters.Contains("p_result"))
                       {
                           result = (Int32)cmd.Parameters["p_result"].Value;
                       }
                   }
                   catch (Exception ex)
                   {
                       string x = ex.Message;
                   }
               }
           }
           return result;   
       }

       // This function will be used to execute CUD(CRUD) operation of parameterized commands
       internal static bool ExecuteNonQuery(string p_CommandText, CommandType p_CommandType)
       {
           string MySQLConncetionString = ConfigurationManager.ConnectionStrings["strMySQLConnection"].ToString();
           int result = 0;
           using (MySqlConnection conn = new MySqlConnection(MySQLConncetionString))
           {
               using (MySqlCommand cmd = conn.CreateCommand())
               {
                   cmd.CommandText = p_CommandText;
                   cmd.CommandType = p_CommandType;
                   try
                   {
                       if (conn.State != ConnectionState.Open) conn.Open();
                       result = cmd.ExecuteNonQuery();
                   }
                   catch (Exception ex)
                   {
                       string x = ex.Message;
                   }
               }
           }
           return (result > 0);
       }
    }
}
