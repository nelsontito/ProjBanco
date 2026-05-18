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
    public class DEscenarioSimulacion
    {
        
            #region "PATRON SINGLETON"

            private static DEscenarioSimulacion escenario = null;

            private DEscenarioSimulacion() { }

            public static DEscenarioSimulacion GetInstance()
            {
                if (escenario == null)
                {
                    escenario = new DEscenarioSimulacion();
                }

                return escenario;
            }

            #endregion

            public RequestDTO<List<EEscenarioSimulacion>> ListarEscenarios()
            {
                RequestDTO<List<EEscenarioSimulacion>> respuesta = new RequestDTO<List<EEscenarioSimulacion>>();

                List<EEscenarioSimulacion> lista = new List<EEscenarioSimulacion>();

                try
                {
                    using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                    {
                        SqlCommand cmd = new SqlCommand("usp_ListarEscenarios", con);
                        cmd.CommandType = CommandType.StoredProcedure;

                        con.Open();

                        SqlDataReader dr = cmd.ExecuteReader();

                        while (dr.Read())
                        {
                            lista.Add(new EEscenarioSimulacion()
                            {
                                IdEscenario = Convert.ToInt32(dr["IdEscenario"]),
                                NombreEscenario = dr["NombreEscenario"].ToString(),
                                TipoEscenario = dr["TipoEscenario"].ToString(),
                                CantidadClientes = Convert.ToInt32(dr["CantidadClientes"]),
                                CantidadCajeros = Convert.ToInt32(dr["CantidadCajeros"]),
                                TiempoEntreLlegadas = Convert.ToInt32(dr["TiempoEntreLlegadas"]),
                                HoraInicio = dr["HoraInicio"].ToString(),
                                HoraFin = dr["HoraFin"].ToString(),
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

            public RequestDTO<bool> RegistrarEscenario(EEscenarioSimulacion obj)
            {
                RequestDTO<bool> respuesta = new RequestDTO<bool>();

                try
                {
                    using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                    {
                        SqlCommand cmd = new SqlCommand("usp_RegistrarEscenario", con);
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@NombreEscenario", obj.NombreEscenario);
                        cmd.Parameters.AddWithValue("@TipoEscenario", obj.TipoEscenario);
                        cmd.Parameters.AddWithValue("@CantidadClientes", obj.CantidadClientes);
                        cmd.Parameters.AddWithValue("@CantidadCajeros", obj.CantidadCajeros);
                        cmd.Parameters.AddWithValue("@TiempoEntreLlegadas", obj.TiempoEntreLlegadas);
                        cmd.Parameters.AddWithValue("@HoraInicio", obj.HoraInicio);
                        cmd.Parameters.AddWithValue("@HoraFin", obj.HoraFin);

                        con.Open();

                        cmd.ExecuteNonQuery();
                    }

                    respuesta.Estado = true;
                    respuesta.Data = true;
                    respuesta.Mensaje = "Escenario registrado correctamente.";
                }
                catch (Exception ex)
                {
                    respuesta.Estado = false;
                    respuesta.Data = false;
                    respuesta.Mensaje = ex.Message;
                }

                return respuesta;
            }

            public RequestDTO<bool> EditarEscenario(EEscenarioSimulacion obj)
            {
                RequestDTO<bool> respuesta = new RequestDTO<bool>();

                try
                {
                    using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                    {
                        SqlCommand cmd = new SqlCommand("usp_EditarEscenario", con);
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@IdEscenario", obj.IdEscenario);
                        cmd.Parameters.AddWithValue("@NombreEscenario", obj.NombreEscenario);
                        cmd.Parameters.AddWithValue("@TipoEscenario", obj.TipoEscenario);
                        cmd.Parameters.AddWithValue("@CantidadClientes", obj.CantidadClientes);
                        cmd.Parameters.AddWithValue("@CantidadCajeros", obj.CantidadCajeros);
                        cmd.Parameters.AddWithValue("@TiempoEntreLlegadas", obj.TiempoEntreLlegadas);
                        cmd.Parameters.AddWithValue("@HoraInicio", obj.HoraInicio);
                        cmd.Parameters.AddWithValue("@HoraFin", obj.HoraFin);

                        con.Open();

                        cmd.ExecuteNonQuery();
                    }

                    respuesta.Estado = true;
                    respuesta.Data = true;
                    respuesta.Mensaje = "Escenario actualizado correctamente.";
                }
                catch (Exception ex)
                {
                    respuesta.Estado = false;
                    respuesta.Data = false;
                    respuesta.Mensaje = ex.Message;
                }

                return respuesta;
            }

            public RequestDTO<bool> EliminarEscenario(int idEscenario)
            {
                RequestDTO<bool> respuesta = new RequestDTO<bool>();

                try
                {
                    using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                    {
                        SqlCommand cmd = new SqlCommand("usp_EliminarEscenario", con);
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@IdEscenario", idEscenario);

                        con.Open();

                        cmd.ExecuteNonQuery();
                    }

                    respuesta.Estado = true;
                    respuesta.Data = true;
                    respuesta.Mensaje = "Escenario eliminado correctamente.";
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
