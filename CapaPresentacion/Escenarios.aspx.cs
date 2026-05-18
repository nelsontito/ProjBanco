using CapaEntidad;
using CapaEntidad.DTOs;
using CapaNegocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CapaPresentacion
{
    public partial class Escenarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListarEscenarios();
            }
        }
        private void ListarEscenarios()
        {
            RequestDTO<List<EEscenarioSimulacion>> respuesta = NEscenarioSimulacion.GetInstance().ListarEscenarios();

            if (respuesta.Estado)
            {
                gvEscenarios.DataSource = respuesta.Data;
                gvEscenarios.DataBind();
            }
            else
            {
                Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)

        {
            if (string.IsNullOrWhiteSpace(txtCantidadClientes.Text) ||
        string.IsNullOrWhiteSpace(txtCantidadCajeros.Text) ||
        string.IsNullOrWhiteSpace(txtTiempoEntreLlegadas.Text))
            {
                Response.Write("<script>alert('Complete todos los campos numéricos');</script>");
                return;
            }
                EEscenarioSimulacion obj = new EEscenarioSimulacion
            {
                IdEscenario = string.IsNullOrEmpty(txtIdEscenario.Value) ? 0 : Convert.ToInt32(txtIdEscenario.Value),
                NombreEscenario = txtNombreEscenario.Text.Trim(),
                TipoEscenario = cboTipoEscenario.SelectedValue,
                CantidadClientes = Convert.ToInt32(txtCantidadClientes.Text),
                CantidadCajeros = Convert.ToInt32(txtCantidadCajeros.Text),
                TiempoEntreLlegadas = Convert.ToInt32(txtTiempoEntreLlegadas.Text),
                HoraInicio = txtHoraInicio.Text,
                HoraFin = txtHoraFin.Text
            };


            RequestDTO<bool> respuesta;

            if (obj.IdEscenario == 0)
            {
                respuesta = NEscenarioSimulacion.GetInstance().RegistrarEscenario(obj);
            }
            else
            {
                respuesta = NEscenarioSimulacion.GetInstance().EditarEscenario(obj);
            }

            if (respuesta.Estado)
            {
                Limpiar();
                ListarEscenarios();
                Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
            }
            else
            {
                Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
            }
        }

        protected void gvEscenarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seleccionar")
            {
                int idEscenario = Convert.ToInt32(e.CommandArgument);

                foreach (GridViewRow row in gvEscenarios.Rows)
                {
                    string id = row.Cells[0].Text;

                    if (id == idEscenario.ToString())
                    {
                        txtIdEscenario.Value = idEscenario.ToString();
                        txtNombreEscenario.Text = row.Cells[1].Text;

                        // Como TipoEscenario está en TemplateField, usamos FindControl no es posible directo si es span.
                        // Por eso lo tomamos desde el listado actual:
                        RequestDTO<List<EEscenarioSimulacion>> respuesta = NEscenarioSimulacion.GetInstance().ListarEscenarios();

                        if (respuesta.Estado)
                        {
                            EEscenarioSimulacion escenario = respuesta.Data.Find(x => x.IdEscenario == idEscenario);

                            if (escenario != null)
                            {
                                cboTipoEscenario.SelectedValue = escenario.TipoEscenario;
                                txtCantidadClientes.Text = escenario.CantidadClientes.ToString();
                                txtCantidadCajeros.Text = escenario.CantidadCajeros.ToString();
                                txtTiempoEntreLlegadas.Text = escenario.TiempoEntreLlegadas.ToString();
                                txtHoraInicio.Text = escenario.HoraInicio;
                                txtHoraFin.Text = escenario.HoraFin;
                            }
                        }

                        btnGuardar.Text = "Actualizar Escenario";
                        break;
                    }
                }
            }

            if (e.CommandName == "Eliminar")
            {
                int idEscenario = Convert.ToInt32(e.CommandArgument);

                RequestDTO<bool> respuesta = NEscenarioSimulacion.GetInstance().EliminarEscenario(idEscenario);

                if (respuesta.Estado)
                {
                    Limpiar();
                    ListarEscenarios();
                    Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
                }
                else
                {
                    Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Limpiar();
        }

        private void Limpiar()
        {
            txtIdEscenario.Value = "";
            txtNombreEscenario.Text = "";
            cboTipoEscenario.SelectedIndex = 0;
            txtCantidadClientes.Text = "";
            txtCantidadCajeros.Text = "";
            txtTiempoEntreLlegadas.Text = "";
            txtHoraInicio.Text = "";
            txtHoraFin.Text = "";
            btnGuardar.Text = "Guardar Escenario";
        }
    }
}