using CapaEntidad;
using CapaEntidad.DTOs;
using CapaNegocio;
using System;
using System.Collections.Generic;

namespace CapaPresentacion
{
    public partial class HistorialSimulaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListarHistorial();
            }
        }

        private void ListarHistorial()
        {
            RequestDTO<List<ESimulacion>> respuesta = NSimulacion.GetInstance().ListarSimulaciones();

            if (respuesta.Estado)
            {
                gvHistorial.DataSource = respuesta.Data;
                gvHistorial.DataBind();
            }
            else
            {
                Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
            }
        }
    }
}