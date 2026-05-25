using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class ESimulacion
    {
        public int IdSimulacion { get; set; }
        public int IdEscenario { get; set; }
        public string FechaSimulacion { get; set; }
        public int TotalClientes { get; set; }
        public int TotalCajeros { get; set; }
        public decimal TiempoPromedioEspera { get; set; }
        public decimal TiempoPromedioAtencion { get; set; }
        public decimal PorcentajeSaturacion { get; set; }
        public string Recomendacion { get; set; }
        public string NombreEscenario { get; set; }
        public string TipoEscenario { get; set; }
    }
}
