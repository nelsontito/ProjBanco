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
    public class DTipoAtencion
    {
        #region "PATRON SINGLETON"

        private static DTipoAtencion tipoAtencion = null;

        private DTipoAtencion() { }

        public static DTipoAtencion GetInstance()
        {
            if (tipoAtencion == null)
            {
                tipoAtencion = new DTipoAtencion();
            }

            return tipoAtencion;
        }

        #endregion

      
        public RequestDTO<List<ETipoAtencion>> ListarTipoAtencion()
        {
            RequestDTO<List<ETipoAtencion>> respuesta = new RequestDTO<List<ETipoAtencion>>();

            List<ETipoAtencion> lista = new List<ETipoAtencion>();

            try
            {
                using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                {
                    SqlCommand cmd = new SqlCommand("usp_ListarTipoAtencion", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        lista.Add(new ETipoAtencion()
                        {
                            IdTipoAtencion = Convert.ToInt32(dr["IdTipoAtencion"]),
                            NombreTipo = dr["NombreTipo"].ToString(),
                            TiempoMinimo = Convert.ToInt32(dr["TiempoMinimo"]),
                            TiempoMaximo = Convert.ToInt32(dr["TiempoMaximo"]),
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


        public RequestDTO<bool> RegistrarTipoAtencion(ETipoAtencion obj)
        {
            RequestDTO<bool> respuesta = new RequestDTO<bool>();

            try
            {
                using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                {
                    SqlCommand cmd = new SqlCommand("usp_RegistrarTipoAtencion", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@NombreTipo", obj.NombreTipo);
                    cmd.Parameters.AddWithValue("@TiempoMinimo", obj.TiempoMinimo);
                    cmd.Parameters.AddWithValue("@TiempoMaximo", obj.TiempoMaximo);

                    con.Open();

                    cmd.ExecuteNonQuery();
                }

                respuesta.Estado = true;
                respuesta.Data = true;
                respuesta.Mensaje = "Tipo de atención registrado correctamente.";
            }
            catch (Exception ex)
            {
                respuesta.Estado = false;
                respuesta.Data = false;
                respuesta.Mensaje = ex.Message;
            }

            return respuesta;
        }


        public RequestDTO<bool> EditarTipoAtencion(ETipoAtencion obj)
        {
            RequestDTO<bool> respuesta = new RequestDTO<bool>();

            try
            {
                using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                {
                    SqlCommand cmd = new SqlCommand("usp_EditarTipoAtencion", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@IdTipoAtencion", obj.IdTipoAtencion);
                    cmd.Parameters.AddWithValue("@NombreTipo", obj.NombreTipo);
                    cmd.Parameters.AddWithValue("@TiempoMinimo", obj.TiempoMinimo);
                    cmd.Parameters.AddWithValue("@TiempoMaximo", obj.TiempoMaximo);

                    con.Open();

                    cmd.ExecuteNonQuery();
                }

                respuesta.Estado = true;
                respuesta.Data = true;
                respuesta.Mensaje = "Tipo de atención actualizado correctamente.";
            }
            catch (Exception ex)
            {
                respuesta.Estado = false;
                respuesta.Data = false;
                respuesta.Mensaje = ex.Message;
            }

            return respuesta;
        }


        public RequestDTO<bool> EliminarTipoAtencion(int idTipoAtencion)
        {
            RequestDTO<bool> respuesta = new RequestDTO<bool>();

            try
            {
                using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                {
                    SqlCommand cmd = new SqlCommand("usp_EliminarTipoAtencion", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@IdTipoAtencion", idTipoAtencion);

                    con.Open();

                    cmd.ExecuteNonQuery();
                }

                respuesta.Estado = true;
                respuesta.Data = true;
                respuesta.Mensaje = "Tipo de atención eliminado correctamente.";
            }
            catch (Exception ex)
            {
                respuesta.Estado = false;
                respuesta.Data = false;
                respuesta.Mensaje = ex.Message;
            }

            return respuesta;
        }

    }
}
