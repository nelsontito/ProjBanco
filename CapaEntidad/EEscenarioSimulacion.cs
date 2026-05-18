using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class EEscenarioSimulacion
    {
        public int IdEscenario { get; set; }

        public string NombreEscenario { get; set; }

        public string TipoEscenario { get; set; }

        public int CantidadClientes { get; set; }

        public int CantidadCajeros { get; set; }

        public int TiempoEntreLlegadas { get; set; }

        public string HoraInicio { get; set; }

        public string HoraFin { get; set; }

        public bool Estado { get; set; }
    }
}
