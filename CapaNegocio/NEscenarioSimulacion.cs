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
    public class NEscenarioSimulacion
    {
        #region "PATRON SINGLETON"
        private static NEscenarioSimulacion instancia = null;

        private NEscenarioSimulacion() { }

        public static NEscenarioSimulacion GetInstance()
        {
            if (instancia == null)
            {
                instancia = new NEscenarioSimulacion();
            }
            return instancia;
        }
        #endregion
        public RequestDTO<List<EEscenarioSimulacion>> ListarEscenarios()
        {
            return DEscenarioSimulacion.GetInstance().ListarEscenarios();
        }

        public RequestDTO<bool> RegistrarEscenario(EEscenarioSimulacion obj)
        {
            return DEscenarioSimulacion.GetInstance().RegistrarEscenario(obj);
        }

        public RequestDTO<bool> EditarEscenario(EEscenarioSimulacion obj)
        {
            return DEscenarioSimulacion.GetInstance().EditarEscenario(obj);
        }

        public RequestDTO<bool> EliminarEscenario(int idEscenario)
        {
            return DEscenarioSimulacion.GetInstance().EliminarEscenario(idEscenario);
        }
    }
}
