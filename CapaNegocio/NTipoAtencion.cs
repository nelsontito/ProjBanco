using CapaDatos;
using CapaEntidad;
using CapaEntidad.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaNegocio
{
    public class NTipoAtencion
    {
        #region "PATRON SINGLETON"
        private static NTipoAtencion instancia = null;

        private NTipoAtencion() { }

        public static NTipoAtencion GetInstance()
        {
            if (instancia == null)
            {
                instancia = new NTipoAtencion();
            }
            return instancia;
        }
        #endregion
        public RequestDTO<List<ETipoAtencion>> ListarTipoAtencion()
        {
            return DTipoAtencion.GetInstance().ListarTipoAtencion();
        }

        public RequestDTO<bool> RegistrarTipoAtencion(ETipoAtencion obj)
        {
            return DTipoAtencion.GetInstance().RegistrarTipoAtencion(obj);
        }

        public RequestDTO<bool> EditarTipoAtencion(ETipoAtencion obj)
        {
            return DTipoAtencion.GetInstance().EditarTipoAtencion(obj);
        }

        public RequestDTO<bool> EliminarTipoAtencion(int idTipoAtencion)
        {
            return DTipoAtencion.GetInstance().EliminarTipoAtencion(idTipoAtencion);
        }
    }
}
