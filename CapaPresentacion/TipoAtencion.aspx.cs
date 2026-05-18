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
    public partial class TipoAtencion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListarTipoAtencion();
            }
        }

        private void ListarTipoAtencion()
        {
            RequestDTO<List<ETipoAtencion>> respuesta = NTipoAtencion.GetInstance().ListarTipoAtencion();

            if (respuesta.Estado)
            {
                gvTipoAtencion.DataSource = respuesta.Data;
                gvTipoAtencion.DataBind();
            }
            else
            {
                Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            ETipoAtencion obj = new ETipoAtencion
            {
                IdTipoAtencion = string.IsNullOrEmpty(txtIdTipoAtencion.Value) ? 0 : Convert.ToInt32(txtIdTipoAtencion.Value),
                NombreTipo = txtNombreTipo.Text.Trim(),
                TiempoMinimo = Convert.ToInt32(txtTiempoMinimo.Text),
                TiempoMaximo = Convert.ToInt32(txtTiempoMaximo.Text)
            };

            RequestDTO<bool> respuesta;

            if (obj.IdTipoAtencion == 0)
            {
                respuesta = NTipoAtencion.GetInstance().RegistrarTipoAtencion(obj);
            }
            else
            {
                respuesta = NTipoAtencion.GetInstance().EditarTipoAtencion(obj);
            }

            if (respuesta.Estado)
            {
                Limpiar();
                ListarTipoAtencion();
                Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
            }
            else
            {
                Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
            }
        }

        protected void gvTipoAtencion_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seleccionar")
            {
                int idTipoAtencion = Convert.ToInt32(e.CommandArgument);

                foreach (GridViewRow row in gvTipoAtencion.Rows)
                {
                    string id = row.Cells[0].Text;

                    if (id == idTipoAtencion.ToString())
                    {
                        txtIdTipoAtencion.Value = idTipoAtencion.ToString();
                        txtNombreTipo.Text = row.Cells[1].Text;

                        txtTiempoMinimo.Text = row.Cells[2].Text.Replace(" min", "").Trim();
                        txtTiempoMaximo.Text = row.Cells[3].Text.Replace(" min", "").Trim();

                        btnGuardar.Text = "Actualizar";
                        break;
                    }
                }
            }

            if (e.CommandName == "Eliminar")
            {
                int idTipoAtencion = Convert.ToInt32(e.CommandArgument);

                RequestDTO<bool> respuesta = NTipoAtencion.GetInstance().EliminarTipoAtencion(idTipoAtencion);

                if (respuesta.Estado)
                {
                    Limpiar();
                    ListarTipoAtencion();
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
            txtIdTipoAtencion.Value = "";
            txtNombreTipo.Text = "";
            txtTiempoMinimo.Text = "";
            txtTiempoMaximo.Text = "";
            btnGuardar.Text = "Guardar";
        }
    }
}