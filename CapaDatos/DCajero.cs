using CapaEntidad;
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
            public List<ECajero> ListarCajeros()
            {
                List<ECajero> lista = new List<ECajero>();

                try
                {
                    using (SqlConnection con = ConexionBD.GetInstance().ConexionDB())
                    {
                        using (SqlCommand cmd = new SqlCommand("usp_ListarCajeros", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;

                            con.Open();

                            using (SqlDataReader dr = cmd.ExecuteReader())
                            {
                                while (dr.Read())
                                {
                                    lista.Add(new ECajero()
                                    {
                                        IdCajero = Convert.ToInt32(dr["IdCajero"]),
                                        NombreCajero = dr["NombreCajero"].ToString(),
                                        Estado = Convert.ToBoolean(dr["Estado"])
                                    });
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al listar cajeros: " + ex.Message);
                }

                return lista;
            }
        }
    }
