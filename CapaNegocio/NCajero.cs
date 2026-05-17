using CapaDatos;
using CapaEntidad;
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
        private static NCajero conexion = null;

        private NCajero() { }

        public static NCajero GetInstance()
        {
            if (conexion == null)
            {
                conexion = new NCajero();
            }
            return conexion;
        }
        #endregion

        public Respuesta<List<ECajero>> ListarCajeros()
        {
            return DCajero.GetInstance().ListarCajeros();
        }
    }
}
