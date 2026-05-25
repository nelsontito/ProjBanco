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
    public class DSimulacion
    {
        #region "PATRON SINGLETON"
        private static DSimulacion simulacion = null;

        private DSimulacion() { }

        public static DSimulacion GetInstance()
        {
            if (simulacion == null)
            {
                simulacion = new DSimulacion();
            }
            return simulacion;
        }
        #endregion
        public RequestDTO<int> RegistrarSimulacion(ESimulacion obj)
        {
            RequestDTO<int> respuesta = new RequestDTO<int>();

            try
            {
                using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                {
                    SqlCommand cmd = new SqlCommand("usp_RegistrarSimulacion", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@IdEscenario", obj.IdEscenario);
                    cmd.Parameters.AddWithValue("@TotalClientes", obj.TotalClientes);
                    cmd.Parameters.AddWithValue("@TotalCajeros", obj.TotalCajeros);
                    cmd.Parameters.AddWithValue("@TiempoPromedioEspera", obj.TiempoPromedioEspera);
                    cmd.Parameters.AddWithValue("@TiempoPromedioAtencion", obj.TiempoPromedioAtencion);
                    cmd.Parameters.AddWithValue("@PorcentajeSaturacion", obj.PorcentajeSaturacion);
                    cmd.Parameters.AddWithValue("@Recomendacion", obj.Recomendacion);

                    SqlParameter idSalida = new SqlParameter("@IdSimulacion", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };

                    cmd.Parameters.Add(idSalida);

                    con.Open();
                    cmd.ExecuteNonQuery();

                    respuesta.Estado = true;
                    respuesta.Data = Convert.ToInt32(idSalida.Value);
                    respuesta.Mensaje = "Simulación registrada correctamente.";
                }
            }
            catch (Exception ex)
            {
                respuesta.Estado = false;
                respuesta.Data = 0;
                respuesta.Mensaje = ex.Message;
            }

            return respuesta;
        }

        public RequestDTO<bool> RegistrarDetalleSimulacion(EDetalleSimulacion obj)
        {
            RequestDTO<bool> respuesta = new RequestDTO<bool>();

            try
            {
                using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                {
                    SqlCommand cmd = new SqlCommand("usp_RegistrarDetalleSimulacion", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@IdSimulacion", obj.IdSimulacion);
                    cmd.Parameters.AddWithValue("@NumeroCliente", obj.NumeroCliente);
                    cmd.Parameters.AddWithValue("@IdTipoAtencion", obj.IdTipoAtencion);

                    if (obj.IdCajero.HasValue)
                        cmd.Parameters.AddWithValue("@IdCajero", obj.IdCajero.Value);
                    else
                        cmd.Parameters.AddWithValue("@IdCajero", DBNull.Value);

                    cmd.Parameters.AddWithValue("@HoraLlegada", obj.HoraLlegada);
                    cmd.Parameters.AddWithValue("@TiempoEspera", obj.TiempoEspera);
                    cmd.Parameters.AddWithValue("@TiempoAtencion", obj.TiempoAtencion);
                    cmd.Parameters.AddWithValue("@EstadoCliente", obj.EstadoCliente);

                    con.Open();
                    cmd.ExecuteNonQuery();

                    respuesta.Estado = true;
                    respuesta.Data = true;
                    respuesta.Mensaje = "Detalle registrado correctamente.";
                }
            }
            catch (Exception ex)
            {
                respuesta.Estado = false;
                respuesta.Data = false;
                respuesta.Mensaje = ex.Message;
            }

            return respuesta;
        }

        public RequestDTO<List<ESimulacion>> ListarSimulaciones()
        {
            RequestDTO<List<ESimulacion>> respuesta = new RequestDTO<List<ESimulacion>>();
            List<ESimulacion> lista = new List<ESimulacion>();

            try
            {
                using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                {
                    SqlCommand cmd = new SqlCommand("usp_ListarSimulaciones", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        lista.Add(new ESimulacion()
                        {
                            IdSimulacion = Convert.ToInt32(dr["IdSimulacion"]),
                            NombreEscenario = dr["NombreEscenario"].ToString(),
                            TipoEscenario = dr["TipoEscenario"].ToString(),
                            FechaSimulacion = dr["FechaSimulacion"].ToString(),
                            TotalClientes = Convert.ToInt32(dr["TotalClientes"]),
                            TotalCajeros = Convert.ToInt32(dr["TotalCajeros"]),
                            TiempoPromedioEspera = Convert.ToDecimal(dr["TiempoPromedioEspera"]),
                            TiempoPromedioAtencion = Convert.ToDecimal(dr["TiempoPromedioAtencion"]),
                            PorcentajeSaturacion = Convert.ToDecimal(dr["PorcentajeSaturacion"]),
                            Recomendacion = dr["Recomendacion"].ToString()
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

        public RequestDTO<List<EDetalleSimulacion>> ListarDetalleSimulacion(int idSimulacion)
        {
            RequestDTO<List<EDetalleSimulacion>> respuesta = new RequestDTO<List<EDetalleSimulacion>>();
            List<EDetalleSimulacion> lista = new List<EDetalleSimulacion>();

            try
            {
                using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                {
                    SqlCommand cmd = new SqlCommand("usp_ListarDetalleSimulacion", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdSimulacion", idSimulacion);

                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        lista.Add(new EDetalleSimulacion()
                        {
                            IdDetalle = Convert.ToInt32(dr["IdDetalle"]),
                            NumeroCliente = Convert.ToInt32(dr["NumeroCliente"]),
                            NombreTipo = dr["NombreTipo"].ToString(),
                            NombreCajero = dr["NombreCajero"].ToString(),
                            HoraLlegada = dr["HoraLlegada"].ToString(),
                            TiempoEspera = Convert.ToInt32(dr["TiempoEspera"]),
                            TiempoAtencion = Convert.ToInt32(dr["TiempoAtencion"]),
                            EstadoCliente = dr["EstadoCliente"].ToString()
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
