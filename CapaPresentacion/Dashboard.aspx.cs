using CapaEntidad;
using CapaEntidad.DTOs;
using CapaNegocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;

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
            lblEscenarioActual.Text = cboEscenario.SelectedItem.Text;
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
                int finAtencion = inicioAtencion + tiempoAtencion;

                TimeSpan horaFinAtencion = horaInicio.Add(TimeSpan.FromMinutes(finAtencion));

                if (horaFinAtencion > horaFin)
                {
                    detalle.Add(new EDetalleSimulacion
                    {
                        NumeroCliente = i,
                        IdTipoAtencion = tipo.IdTipoAtencion,
                        NombreTipo = tipo.NombreTipo,
                        IdCajero = null,
                        NombreCajero = "Sin atención",
                        HoraLlegada = horaLlegada.ToString(@"hh\:mm"),
                        TiempoEspera = tiempoEspera,
                        TiempoAtencion = 0,
                        EstadoCliente = "No atendido"
                    });
                }
                else
                {
                    tiempoLibreCajero[indiceCajero] = finAtencion;

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
            }

            int clientesAtendidos = detalle.Count(x => x.EstadoCliente == "Atendido");
            int clientesNoAtendidos = detalle.Count(x => x.EstadoCliente == "No atendido");

            // Solo clientes atendidos que tuvieron que esperar
            int clientesEnCola = detalle.Count(x => x.EstadoCliente == "Atendido" && x.TiempoEspera > 0);
            decimal promedioEspera = clientesAtendidos > 0
                ? Math.Round((decimal)sumaEspera / clientesAtendidos, 2)
                : 0;

            decimal promedioAtencion = clientesAtendidos > 0
                ? Math.Round((decimal)sumaAtencion / clientesAtendidos, 2)
                : 0;

            decimal minutosOperacion = (decimal)(horaFin - horaInicio).TotalMinutes;

            if (minutosOperacion <= 0)
                minutosOperacion = 1;

            decimal saturacion = Math.Round((sumaAtencion / (minutosOperacion * totalCajeros)) * 100, 2);

            if (saturacion > 100)
                saturacion = 100;

            string recomendacion = GenerarRecomendacion(saturacion, promedioEspera, clientesNoAtendidos);

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
            
                lblRecomendacion.Text = recomendacion;
                lblClientesAtendidos.Text = clientesAtendidos.ToString();
                lblClientesNoAtendidos.Text = clientesNoAtendidos.ToString();
                lblClientesCola.Text = clientesEnCola.ToString();
         
                hdnClientesAtendidosAnimacion.Value = clientesAtendidos.ToString();
                hdnClientesNoAtendidosAnimacion.Value = clientesNoAtendidos.ToString();
                hdnTotalCajerosAnimacion.Value = totalCajeros.ToString();
                hdnTotalClientesAnimacion.Value = totalClientes.ToString();
                hdnTotalCajerosAnimacion.Value = totalCajeros.ToString();

                pnlClientesCola.Controls.Clear();
                pnlCajerosVisual.Controls.Clear();
                pnlClientesAtendidos.Controls.Clear();

                //pnlClientesCola.Controls.Add(new LiteralControl("<span class='text-muted'>Listo para iniciar animación</span>"));
                //pnlCajerosVisual.Controls.Add(new LiteralControl("<span class='text-muted'>Presione iniciar animación</span>"));
                //pnlClientesAtendidos.Controls.Add(new LiteralControl("<span class='text-muted'>Esperando atención</span>"));


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

        private string GenerarRecomendacion(decimal saturacion, decimal promedioEspera, int clientesNoAtendidos)
        {
            if (clientesNoAtendidos > 0)
            {
                return "El tiempo de atención no fue suficiente. Existen clientes no atendidos; se recomienda habilitar más cajeros o ampliar el horario de atención.";
            }

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
                              lblRecomendacion.Text = "Ejecute una simulación para generar una recomendación sobre la cantidad adecuada de cajeros.";
            lblClientesAtendidos.Text = "0";
            lblClientesNoAtendidos.Text = "0";
            lblClientesCola.Text = "0";

                }
        private void PintarModeloVisual(int totalClientes, int totalCajeros, int clientesEnCola, int clientesAtendidos)
        {
            pnlClientesCola.Controls.Clear();
            pnlCajerosVisual.Controls.Clear();
            pnlClientesAtendidos.Controls.Clear();

            int maxMostrarCola = clientesEnCola > 12 ? 12 : clientesEnCola;
            int maxMostrarAtendidos = clientesAtendidos > 12 ? 12 : clientesAtendidos;

            for (int i = 1; i <= maxMostrarCola; i++)
            {
                pnlClientesCola.Controls.Add(new System.Web.UI.LiteralControl(
                    "<span class='cliente-icono'><i class='fas fa-user'></i></span>"
                ));
            }

            if (clientesEnCola > 12)
            {
                pnlClientesCola.Controls.Add(new System.Web.UI.LiteralControl(
                    "<div class='mt-2 text-muted'>+" + (clientesEnCola - 12) + " clientes esperando</div>"
                ));
            }

            for (int i = 1; i <= totalCajeros; i++)
            {
                string estado = i <= totalCajeros ? "Ocupado" : "Libre";

                pnlCajerosVisual.Controls.Add(new System.Web.UI.LiteralControl(
                    "<div class='cajero-box cajero-ocupado'>" +
                    "<strong><i class='fas fa-user-tie'></i> Cajero " + i + "</strong><br/>" +
                    "<small class='text-danger'>Atendiendo cliente</small>" +
                    "</div>"
                ));
            }

            for (int i = 1; i <= maxMostrarAtendidos; i++)
            {
                pnlClientesAtendidos.Controls.Add(new System.Web.UI.LiteralControl(
                    "<span class='cliente-icono' style='background:#16a34a;'><i class='fas fa-user-check'></i></span>"
                ));
            }

            if (clientesAtendidos > 12)
            {
                pnlClientesAtendidos.Controls.Add(new System.Web.UI.LiteralControl(
                    "<div class='mt-2 text-muted'>+" + (clientesAtendidos - 12) + " clientes atendidos</div>"
                ));
            }
        }
    }

}