using CapaEntidad;
using CapaEntidad.DTOs;
using CapaNegocio;
using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace CapaPresentacion
{
    public partial class Cajeros : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListarCajeros();
            }
        }
        protected void gvCajeros_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seleccionar")
            {
                int idCajero = Convert.ToInt32(e.CommandArgument);

                foreach (GridViewRow row in gvCajeros.Rows)
                {
                    string id = row.Cells[0].Text;

                    if (id == idCajero.ToString())
                    {
                        txtIdCajero.Value = idCajero.ToString();
                        txtNombreCajero.Text = row.Cells[1].Text;
                        btnGuardar.Text = "Actualizar";
                        break;
                    }
                }
            }

            if (e.CommandName == "Eliminar")
            {
                int idCajero = Convert.ToInt32(e.CommandArgument);

                RequestDTO<bool> respuesta = NCajero.GetInstance().EliminarCajero(idCajero);

                if (respuesta.Estado)
                {
                    Limpiar();
                    ListarCajeros();
                    Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
                }
                else
                {
                    Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            ECajero obj = new ECajero
            {
                IdCajero = string.IsNullOrEmpty(txtIdCajero.Value) ? 0 : Convert.ToInt32(txtIdCajero.Value),
                NombreCajero = txtNombreCajero.Text.Trim()
            };

            RequestDTO<bool> respuesta;

            if (obj.IdCajero == 0)
            {
                respuesta = NCajero.GetInstance().RegistrarCajero(obj);
            }
            else
            {
                respuesta = NCajero.GetInstance().EditarCajero(obj);
            }

            if (respuesta.Estado)
            {
                Limpiar();
                ListarCajeros();

                Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
            }
            else
            {
                Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
            }
        }

        private void Limpiar()
        {
            txtIdCajero.Value = "";
            txtNombreCajero.Text = "";
            btnGuardar.Text = "Guardar";
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Limpiar();
        }
        private void ListarCajeros()
        {
            RequestDTO<List<ECajero>> respuesta = NCajero.GetInstance().ListarCajeros();

            if (respuesta.Estado)
            {
                gvCajeros.DataSource = respuesta.Data;
                gvCajeros.DataBind();
            }
            else
            {
                Response.Write("<script>alert('" + respuesta.Mensaje + "');</script>");
            }
        }
    }
}