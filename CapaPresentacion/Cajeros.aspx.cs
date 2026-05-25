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
            int idCajero = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Seleccionar")
            {
                RequestDTO<List<ECajero>> respuesta = NCajero.GetInstance().ListarCajeros();

                if (respuesta.Estado)
                {
                    ECajero cajero = respuesta.Data.Find(x => x.IdCajero == idCajero);

                    if (cajero != null)
                    {
                        txtIdCajero.Value = cajero.IdCajero.ToString();
                        txtNombreCajero.Text = cajero.NombreCajero;
                        txtFoto.Value = cajero.Foto;

                        btnGuardar.Text = "Actualizar";
                    }
                }
            }

            if (e.CommandName == "Eliminar")
            {
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
            string rutaFoto = txtFoto.Value;
            if (fuFoto.HasFile)
            {
                string carpeta = Server.MapPath("~/Imagenes/Cajeros/");
                string nombreArchivo = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + fuFoto.FileName;
                string rutaFisica = carpeta + nombreArchivo;
                if (!System.IO.Directory.Exists(carpeta))
                {
                    System.IO.Directory.CreateDirectory(carpeta);
                }
                fuFoto.SaveAs(rutaFisica);

                rutaFoto = "Imagenes/Cajeros/" + nombreArchivo;
            }
            ECajero obj = new ECajero
            {
                IdCajero = string.IsNullOrEmpty(txtIdCajero.Value) ? 0 : Convert.ToInt32(txtIdCajero.Value),
                NombreCajero = txtNombreCajero.Text.Trim(),
                Foto = rutaFoto
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
            txtFoto.Value = "";
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