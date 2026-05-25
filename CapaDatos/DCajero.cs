using CapaEntidad;
using CapaEntidad.DTOs;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaDatos
{
    public class DCajero
    {

        #region "PATRON SINGLETON"
        private static DCajero conexion = null;

        private DCajero() { }

        public static DCajero GetInstance()
        {
            if (conexion == null)
            {
                conexion = new DCajero();
            }
            return conexion;
        }
        #endregion
        public RequestDTO<bool> EliminarCajero(int idCajero)
        {
            RequestDTO<bool> respuesta = new RequestDTO<bool>();

            try
            {
                using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                {
                    SqlCommand cmd = new SqlCommand("usp_EliminarCajero", con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdCajero", idCajero);


                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                respuesta.Estado = true;
                respuesta.Data = true;
                respuesta.Mensaje = "Cajero eliminado correctamente.";
            }
            catch (Exception ex)
            {
                respuesta.Estado = false;
                respuesta.Data = false;
                respuesta.Mensaje = ex.Message;
            }

            return respuesta;
        }

        public RequestDTO<bool> EditarCajero(ECajero obj)
        {
            RequestDTO<bool> respuesta = new RequestDTO<bool>();

            try
            {
                using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                {
                    SqlCommand cmd = new SqlCommand("usp_EditarCajero", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@IdCajero", obj.IdCajero);
                    cmd.Parameters.AddWithValue("@NombreCajero", obj.NombreCajero);
                    cmd.Parameters.AddWithValue("@Foto", obj.Foto);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                respuesta.Estado = true;
                respuesta.Data = true;
                respuesta.Mensaje = "Cajero editado correctamente.";
            }
            catch (Exception ex)
            {
                respuesta.Estado = false;
                respuesta.Data = false;
                respuesta.Mensaje = ex.Message;
            }

            return respuesta;
        }

        public RequestDTO<bool> RegistrarCajero(ECajero obj)
        {
            RequestDTO<bool> respuesta = new RequestDTO<bool>();

            try
            {
                using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                {
                    SqlCommand cmd = new SqlCommand("usp_RegistrarCajero", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@NombreCajero", obj.NombreCajero);
                    cmd.Parameters.AddWithValue("@Foto", obj.Foto);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                respuesta.Estado = true;
                respuesta.Data = true;
                respuesta.Mensaje = "Cajero registrado correctamente.";
            }
            catch (Exception ex)
            {
                respuesta.Estado = false;
                respuesta.Data = false;
                respuesta.Mensaje = ex.Message;
            }

            return respuesta;
        }
        public RequestDTO<List<ECajero>> ListarCajeros()
        {
            RequestDTO<List<ECajero>> respuesta = new RequestDTO<List<ECajero>>();

            List<ECajero> lista = new List<ECajero>();

            try
            {
                using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                {
                    SqlCommand cmd = new SqlCommand("usp_ListarCajeros", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        lista.Add(new ECajero()
                        {
                            IdCajero = Convert.ToInt32(dr["IdCajero"]),
                            NombreCajero = dr["NombreCajero"].ToString(),
                            Foto = dr["Foto"] == DBNull.Value ? "" : dr["Foto"].ToString(),
                            Estado = Convert.ToBoolean(dr["Estado"])
                        });
                    }
                }

                respuesta.Estado = true;
                respuesta.Data = lista;
            }
            catch (Exception ex)
            {
                respuesta.Estado = false;
                respuesta.Mensaje = ex.Message;
            }

            return respuesta;
        }
    }
}
