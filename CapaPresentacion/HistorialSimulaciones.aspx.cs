using CapaEntidad;
using CapaEntidad.DTOs;
using CapaNegocio;
using System;
using System.Collections.Generic;
using System.Linq;

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

        protected string ObtenerEstadoOperativo(object valorSaturacion)
        {
            decimal saturacion = 0;

            if (valorSaturacion != null)
            {
                decimal.TryParse(valorSaturacion.ToString(), out saturacion);
            }

            if (saturacion <= 40)
                return "<span class='badge-estado estado-optimo'>ÓPTIMO</span>";

            if (saturacion <= 60)
                return "<span class='badge-estado estado-moderado'>MODERADO</span>";

            if (saturacion <= 80)
                return "<span class='badge-estado estado-saturado'>SATURADO</span>";

            return "<span class='badge-estado estado-critico'>CRÍTICO</span>";
        }
        private void CargarRanking(List<ESimulacion> lista)
        {
            if (lista == null || lista.Count == 0)
            {
                lblMejorEscenario.Text = "Sin datos";
                lblEscenarioCritico.Text = "Sin datos";
                return;
            }

            var mejor = lista
                .OrderBy(x => x.PorcentajeSaturacion)
                .First();

            var critico = lista
                .OrderByDescending(x => x.PorcentajeSaturacion)
                .First();

            lblMejorEscenario.Text =
                $"{mejor.NombreEscenario} ({mejor.TipoEscenario}) - Saturación: {mejor.PorcentajeSaturacion:0.00}%";

            lblEscenarioCritico.Text =
                $"{critico.NombreEscenario} ({critico.TipoEscenario}) - Saturación: {critico.PorcentajeSaturacion:0.00}%";
        }
        private void ListarHistorial()
        {
            RequestDTO<List<ESimulacion>> respuesta = NSimulacion.GetInstance().ListarSimulaciones();

            if (respuesta.Estado)
            {
                gvHistorial.DataSource = respuesta.Data;
                gvHistorial.DataBind();
                CargarRanking(respuesta.Data);
            }
            else
            {
                Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
            }
        }
    }
}