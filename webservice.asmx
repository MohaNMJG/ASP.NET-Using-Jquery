using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Web.Script.Services;

namespace WNavigation
{
    /// <summary>
    /// Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    {

        [WebMethod]
        public void Getnavigation(Wnavgationperson emp)
        {

            string cs = ConfigurationManager.ConnectionStrings["MOHANMJConnectionString1"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {

                SqlCommand cmd = new SqlCommand("SP_FIRSTFORM", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter()
                {

                    ParameterName = "@FIRSTNAME",
                    Value = emp.firstname
                });
                cmd.Parameters.Add(new SqlParameter()
                {

                    ParameterName = "@LASTNAME",
                    Value = emp.lastname
                });
                cmd.Parameters.Add(new SqlParameter()
                {

                    ParameterName = "@QUALIFICATION",
                    Value = emp.qualification
                });
                cmd.Parameters.Add(new SqlParameter()
                {

                    ParameterName = "@GENDER",
                    Value = emp.gender
                });
                cmd.Parameters.Add(new SqlParameter()
                {

                    ParameterName = "@WORK",
                    Value = emp.work
                });
                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Email",
                    Value = emp.email
                });
                con.Open();
                cmd.ExecuteNonQuery();

            }
        }
        [WebMethod]
        public void Getpersonsdetailform()
        {
            List<Wnavgationperson> Listdata = new List<Wnavgationperson>();
            string cs = ConfigurationManager.ConnectionStrings["MOHANMJConnectionString1"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("sp_firstformgetdetails", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    Wnavgationperson resulted = new Wnavgationperson();
                    resulted.ID = Convert.ToInt32(rdr["ID"]);
                    resulted.firstname = rdr["FIRSTNAME"].ToString();
                    resulted.lastname = rdr["LASTNAME"].ToString();
                    resulted.qualification = rdr["QUALIFICATION"].ToString();
                    resulted.gender = rdr["GENDER"].ToString();
                    resulted.work = rdr["WORK"].ToString();
                    resulted.email = rdr["email"].ToString();
                    Listdata.Add(resulted);
                }

            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(Listdata));

        }
        [WebMethod]
        public List<string> autocompletename(string term)
        {
            List<string> lst = new List<string>();
            string cs = ConfigurationManager.ConnectionStrings["MOHANMJConnectionString1"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("AutocompleteEmailid", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter param = new SqlParameter()
                {
                    ParameterName = "@term",
                    Value = term

                };
                cmd.Parameters.Add(param);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    lst.Add(rdr["emailid"].ToString());
                };
                return lst;
            }
        }
        [WebMethod]
        public Wnavgationperson Geteditmode(int empids)
        {
            Wnavgationperson resulted = new Wnavgationperson();
            List<Wnavgationperson> Listdata = new List<Wnavgationperson>();
            string cs = ConfigurationManager.ConnectionStrings["MOHANMJConnectionString1"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("Sp_editmode", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter param = new SqlParameter();
                param.ParameterName = "@id";
                param.Value = empids;
                cmd.Parameters.Add(param);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {


                    resulted.ID = Convert.ToInt32(rdr["ID"]);
                    resulted.firstname = rdr["FIRSTNAME"].ToString();
                    resulted.lastname = rdr["LASTNAME"].ToString();
                    resulted.qualification = rdr["QUALIFICATION"].ToString();
                    resulted.gender = rdr["GENDER"].ToString();
                    resulted.work = rdr["WORK"].ToString();
                    resulted.email = rdr["email"].ToString();

                }

            }

            return resulted;
        }
        [WebMethod]
        public List<Wnavgationperson> searchpagedetails(string searchText)
        {
            List<Wnavgationperson> Listdata = new List<Wnavgationperson>();
            string cs = ConfigurationManager.ConnectionStrings["MOHANMJConnectionString1"].ConnectionString;
            string query = "select ID,FIRSTNAME,LASTNAME,QUALIFICATION,GENDER,WORK,email from FIRSTFORM WHERE (FIRSTNAME LIKE @Name + '%' OR LASTNAME LIKE @Name + '%'OR QUALIFICATION LIKE @Name + '%'OR GENDER LIKE @Name + '%'OR WORK LIKE @Name + '%' or email like @Name+'%') OR @Name IS NULL ORDER BY ID DESC";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                if (!string.IsNullOrEmpty(searchText))
                {
                    cmd.Parameters.AddWithValue("@Name", searchText);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Name", (object)DBNull.Value);
                } con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    Wnavgationperson resulted = new Wnavgationperson();
                    resulted.ID = Convert.ToInt32(rdr["ID"]);
                    resulted.firstname = rdr["FIRSTNAME"].ToString();
                    resulted.lastname = rdr["LASTNAME"].ToString();
                    resulted.qualification = rdr["QUALIFICATION"].ToString();
                    resulted.gender = rdr["GENDER"].ToString();
                    resulted.work = rdr["WORK"].ToString();
                    resulted.email = rdr["email"].ToString();
                    Listdata.Add(resulted);
                }

            }
            return Listdata;

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]

        public void BoostrapAuto1(string Name)
        {

            List<Wnavgationperson> Listdata = new List<Wnavgationperson>();
            string cs = ConfigurationManager.ConnectionStrings["MOHANMJConnectionString1"].ConnectionString;
            string query = "select email from FIRSTFORM WHERE (email LIKE @Name + '%') OR @Name IS NULL ORDER BY ID DESC";
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                if (!string.IsNullOrEmpty(Name))
                {
                    cmd.Parameters.AddWithValue("@Name", Name);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Name", (object)DBNull.Value);
                }
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Wnavgationperson resulted = new Wnavgationperson();
                    resulted.email = rdr["email"].ToString();
                    Listdata.Add(resulted);
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(Listdata));



        }
        [WebMethod]
        public void newone(string Name)
        {

            List<Wnavgationperson> Listdata = new List<Wnavgationperson>();
            string cs = ConfigurationManager.ConnectionStrings["MOHANMJConnectionString1"].ConnectionString;
            //  string query = "select ID, email from FIRSTFORM WHERE (email LIKE @Name + '%') OR @Name IS NULL ORDER BY ID DESC";
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("jsonformat", con);
                cmd.CommandType = CommandType.StoredProcedure;
                //if (!string.IsNullOrEmpty(Name))
                //{
                SqlParameter parms = new SqlParameter();
                parms.ParameterName = "@name";
                parms.Value = Name;
                cmd.Parameters.Add(parms);

                //  }
                //else
                //{
                //    cmd.Parameters.AddWithValue("@Name", (object)DBNull.Value);
                //}
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Wnavgationperson resulted = new Wnavgationperson();
                    // resulted.ID = Convert.ToInt32(rdr["ID"]);
                    resulted.email = rdr["email"].ToString();
                    Listdata.Add(resulted);


                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(Listdata));



        }
        [WebMethod]
        public List<dropdown> Populardrop(string q)
        {
            DataTable dt = new DataTable();
            List<dropdown> list = new List<dropdown>();

            string cs = ConfigurationManager.ConnectionStrings["MOHANMJConnectionString1"].ConnectionString;
            string query = "";
            query += "select ID, email from FIRSTFORM where email like '%" + q + "%'";
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    for (var i = 0; i < dt.Rows.Count; i++)
                    {
                        dropdown info = new dropdown();
                        info.id = (dt.Rows[i]["ID"]).ToString();
                        info.email = (dt.Rows[i]["email"]).ToString();
                        list.Add(info);

                    }


                }
                return list;
            }
        }

        [WebMethod]
        public void productDetails(products pro)
        {

            string cs = ConfigurationManager.ConnectionStrings["MOHANMJConnectionString1"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {

                SqlCommand cmd = new SqlCommand("Update_Product_details", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter()
                {

                    ParameterName = "@productid",
                    Value = pro.product
                });
                cmd.Parameters.Add(new SqlParameter()
                {

                    ParameterName = "@ProductidSold",
                    Value = pro.productcount
                });
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
        [WebMethod]
        public void GetTotalSold()
        {
            List<products> Listdata = new List<products>();
            string cs = ConfigurationManager.ConnectionStrings["MOHANMJConnectionString1"].ConnectionString;
            string query = "SELECT  S.Name ,sum(D.QuantitySold) as QuantitySold  FROM ProductSalesDetails D INNER JOIN ProductS S ON S.id =D.PRODUCT group by Name order by Name desc";


            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
               // cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    products resulted = new products();
                    resulted.product = rdr["Name"].ToString();
                    resulted.productcount = rdr["QuantitySold"].ToString();
                    Listdata.Add(resulted);
                }

            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(Listdata));

        }
     
    }
}