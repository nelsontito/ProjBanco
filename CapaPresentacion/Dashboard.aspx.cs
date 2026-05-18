using CapaEntidad;
using CapaEntidad.DTOs;
using CapaNegocio;
using System;
using System.Collections.Generic;
using System.Linq;

namespace CapaPresentacion
{
    public partial class Dashboard : System.Web.UI.Page
    {
        Random random = new Random();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarEscenarios();
            }
        }

        private void CargarEscenarios()
        {
            var respuesta = NEscenarioSimulacion.GetInstance().ListarEscenarios();

            if (respuesta.Estado)
            {
                cboEscenario.DataSource = respuesta.Data;
                cboEscenario.DataTextField = "NombreEscenario";
                cboEscenario.DataValueField = "IdEscenario";
                cboEscenario.DataBind();

                cboEscenario.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Seleccione escenario...", "0"));
            }
            else
            {
                Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
            }
        }

        protected void cboEscenario_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cboEscenario.SelectedValue == "0")
                return;

            int idEscenario = Convert.ToInt32(cboEscenario.SelectedValue);

            var respuesta = NEscenarioSimulacion.GetInstance().ListarEscenarios();

            if (respuesta.Estado)
            {
                var escenario = respuesta.Data.FirstOrDefault(x => x.IdEscenario == idEscenario);

                if (escenario != null)
                {
                    txtCantidadClientes.Text = escenario.CantidadClientes.ToString();
                    txtCantidadCajeros.Text = escenario.CantidadCajeros.ToString();
                    txtTiempoLlegada.Text = escenario.TiempoEntreLlegadas.ToString();
                    txtHoraInicio.Text = FormatearHora(escenario.HoraInicio);
                    txtHoraFin.Text = FormatearHora(escenario.HoraFin);
                }
            }
        }

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
            if (cboEscenario.SelectedValue == "0")
            {
                Response.Write("<script>alert('Seleccione un escenario');</script>");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtCantidadClientes.Text) ||
                string.IsNullOrWhiteSpace(txtCantidadCajeros.Text) ||
                string.IsNullOrWhiteSpace(txtTiempoLlegada.Text) ||
                string.IsNullOrWhiteSpace(txtHoraInicio.Text) ||
                string.IsNullOrWhiteSpace(txtHoraFin.Text))
            {
                Response.Write("<script>alert('Complete todos los datos del escenario');</script>");
                return;
            }

            int idEscenario = Convert.ToInt32(cboEscenario.SelectedValue);
            int totalClientes = Convert.ToInt32(txtCantidadClientes.Text);
            int totalCajeros = Convert.ToInt32(txtCantidadCajeros.Text);
            int tiempoEntreLlegadas = Convert.ToInt32(txtTiempoLlegada.Text);

            TimeSpan horaInicio = TimeSpan.Parse(txtHoraInicio.Text);
            TimeSpan horaFin = TimeSpan.Parse(txtHoraFin.Text);

            var tiposRespuesta = NTipoAtencion.GetInstance().ListarTipoAtencion();
            var cajerosRespuesta = NCajero.GetInstance().ListarCajeros();

            if (!tiposRespuesta.Estado || tiposRespuesta.Data.Count == 0)
            {
                Response.Write("<script>alert('Debe registrar tipos de atención');</script>");
                return;
            }

            if (!cajerosRespuesta.Estado || cajerosRespuesta.Data.Count == 0)
            {
                Response.Write("<script>alert('Debe registrar cajeros');</script>");
                return;
            }

            List<ETipoAtencion> tipos = tiposRespuesta.Data;
            List<ECajero> cajeros = cajerosRespuesta.Data.Take(totalCajeros).ToList();

            if (cajeros.Count < totalCajeros)
            {
                Response.Write("<script>alert('No existen suficientes cajeros registrados');</script>");
                return;
            }

            int[] tiempoLibreCajero = new int[totalCajeros];
            List<EDetalleSimulacion> detalle = new List<EDetalleSimulacion>();

            int sumaEspera = 0;
            int sumaAtencion = 0;

            for (int i = 1; i <= totalClientes; i++)
            {
                int minutoLlegada = (i - 1) * tiempoEntreLlegadas;
                TimeSpan horaLlegada = horaInicio.Add(TimeSpan.FromMinutes(minutoLlegada));

                ETipoAtencion tipo = tipos[random.Next(tipos.Count)];
                int tiempoAtencion = random.Next(tipo.TiempoMinimo, tipo.TiempoMaximo + 1);

                int indiceCajero = ObtenerCajeroDisponible(tiempoLibreCajero);
                int inicioAtencion = Math.Max(minutoLlegada, tiempoLibreCajero[indiceCajero]);
                int tiempoEspera = inicioAtencion - minutoLlegada;

                tiempoLibreCajero[indiceCajero] = inicioAtencion + tiempoAtencion;

                sumaEspera += tiempoEspera;
                sumaAtencion += tiempoAtencion;

                detalle.Add(new EDetalleSimulacion
                {
                    NumeroCliente = i,
                    IdTipoAtencion = tipo.IdTipoAtencion,
                    NombreTipo = tipo.NombreTipo,
                    IdCajero = cajeros[indiceCajero].IdCajero,
                    NombreCajero = cajeros[indiceCajero].NombreCajero,
                    HoraLlegada = horaLlegada.ToString(@"hh\:mm"),
                    TiempoEspera = tiempoEspera,
                    TiempoAtencion = tiempoAtencion,
                    EstadoCliente = "Atendido"
                });
            }

            decimal promedioEspera = Math.Round((decimal)sumaEspera / totalClientes, 2);
            decimal promedioAtencion = Math.Round((decimal)sumaAtencion / totalClientes, 2);

            decimal minutosOperacion = (decimal)(horaFin - horaInicio).TotalMinutes;

            if (minutosOperacion <= 0)
                minutosOperacion = 1;

            decimal saturacion = Math.Round((sumaAtencion / (minutosOperacion * totalCajeros)) * 100, 2);

            if (saturacion > 100)
                saturacion = 100;

            string recomendacion = GenerarRecomendacion(saturacion, promedioEspera);

            ESimulacion simulacion = new ESimulacion
            {
                IdEscenario = idEscenario,
                TotalClientes = totalClientes,
                TotalCajeros = totalCajeros,
                TiempoPromedioEspera = promedioEspera,
                TiempoPromedioAtencion = promedioAtencion,
                PorcentajeSaturacion = saturacion,
                Recomendacion = recomendacion
            };

            RequestDTO<int> respuestaSimulacion = NSimulacion.GetInstance().RegistrarSimulacion(simulacion);

            if (respuestaSimulacion.Estado)
            {
                int idSimulacion = respuestaSimulacion.Data;

                foreach (var item in detalle)
                {
                    item.IdSimulacion = idSimulacion;
                    NSimulacion.GetInstance().RegistrarDetalleSimulacion(item);
                }

                lblTotalClientes.Text = totalClientes.ToString();
                lblTotalCajeros.Text = totalCajeros.ToString();
                lblPromedioEspera.Text = promedioEspera.ToString();
                lblSaturacion.Text = saturacion.ToString();
                lblRecomendacion.Text = recomendacion;

                gvDetalleSimulacion.DataSource = detalle;
                gvDetalleSimulacion.DataBind();

                Response.Write("<script>alert('Simulación ejecutada correctamente');</script>");
            }
            else
            {
                Response.Write("<script>alert('" + respuestaSimulacion.Mensaje + "');</script>");
            }
        }

        private int ObtenerCajeroDisponible(int[] tiempoLibreCajero)
        {
            int indice = 0;
            int menorTiempo = tiempoLibreCajero[0];

            for (int i = 1; i < tiempoLibreCajero.Length; i++)
            {
                if (tiempoLibreCajero[i] < menorTiempo)
                {
                    menorTiempo = tiempoLibreCajero[i];
                    indice = i;
                }
            }

            return indice;
        }

        private string GenerarRecomendacion(decimal saturacion, decimal promedioEspera)
        {
            if (saturacion >= 85 || promedioEspera >= 15)
            {
                return "Se recomienda habilitar más cajeros, ya que existe alta saturación y tiempos de espera elevados.";
            }

            if (saturacion >= 60 || promedioEspera >= 8)
            {
                return "La atención es aceptable, pero se recomienda reforzar cajeros en horarios pico.";
            }

            return "La cantidad de cajeros es adecuada para este escenario.";
        }

        private string FormatearHora(string hora)
        {
            if (string.IsNullOrEmpty(hora))
                return "";

            TimeSpan tiempo;

            if (TimeSpan.TryParse(hora, out tiempo))
                return tiempo.ToString(@"hh\:mm");

            return hora;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            cboEscenario.SelectedIndex = 0;
            txtCantidadClientes.Text = "0";
            txtCantidadCajeros.Text = "0";
            txtTiempoLlegada.Text = "0";
            txtHoraInicio.Text = "";
            txtHoraFin.Text = "";

            lblTotalClientes.Text = "0";
            lblTotalCajeros.Text = "0";
            lblPromedioEspera.Text = "0";
            lblSaturacion.Text = "0";
            lblRecomendacion.Text = "Ejecute una simulación para generar una recomendación sobre la cantidad adecuada de cajeros.";

            gvDetalleSimulacion.DataSource = null;
            gvDetalleSimulacion.DataBind();
        }
    }
}