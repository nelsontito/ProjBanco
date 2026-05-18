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
    public class NSimulacion
    {
        #region "PATRON SINGLETON"

        private static NSimulacion simulacion = null;

        private NSimulacion() { }

        public static NSimulacion GetInstance()
        {
            if (simulacion == null)
            {
                simulacion = new NSimulacion();
            }

            return simulacion;
        }

        #endregion

        public RequestDTO<int> RegistrarSimulacion(ESimulacion obj)
        {
            return DSimulacion.GetInstance().RegistrarSimulacion(obj);
        }

        public RequestDTO<bool> RegistrarDetalleSimulacion(EDetalleSimulacion obj)
        {
            return DSimulacion.GetInstance().RegistrarDetalleSimulacion(obj);
        }

        public RequestDTO<List<ESimulacion>> ListarSimulaciones()
        {
            return DSimulacion.GetInstance().ListarSimulaciones();
        }

        public RequestDTO<List<EDetalleSimulacion>> ListarDetalleSimulacion(int idSimulacion)
        {
            return DSimulacion.GetInstance().ListarDetalleSimulacion(idSimulacion);
        }
    }
}
