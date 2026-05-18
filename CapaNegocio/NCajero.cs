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
    public class NCajero
    {
        #region "PATRON SINGLETON"
        private static NCajero instancia = null;

        private NCajero() { }

        public static NCajero GetInstance()
        {
            if (instancia == null)
            {
                instancia = new NCajero();
            }
            return instancia;
        }
        #endregion

        public RequestDTO<bool> EditarCajero(ECajero obj)
        {
            return DCajero.GetInstance().EditarCajero(obj);
        }
        public RequestDTO<bool> EliminarCajero(int idCajero)
        {
            return DCajero.GetInstance().EliminarCajero(idCajero);
        }

        public RequestDTO<bool> RegistrarCajero(ECajero obj)
        {
            return DCajero.GetInstance().RegistrarCajero(obj);
        }

        public RequestDTO<List<ECajero>> ListarCajeros()
        {
            return DCajero.GetInstance().ListarCajeros();
        }
    }
}
