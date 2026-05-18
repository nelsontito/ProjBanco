using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class EDetalleSimulacion
    {
        public int IdDetalle { get; set; }
        public int IdSimulacion { get; set; }
        public int NumeroCliente { get; set; }
        public int IdTipoAtencion { get; set; }
        public int? IdCajero { get; set; }
        public string HoraLlegada { get; set; }
        public int TiempoEspera { get; set; }
        public int TiempoAtencion { get; set; }
        public string EstadoCliente { get; set; }
        // Para mostrar en GridView
        public string NombreTipo { get; set; }
        public string NombreCajero { get; set; }
    }
}
