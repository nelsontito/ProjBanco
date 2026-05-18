using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad
{
    public class ETipoAtencion
    {
        public int IdTipoAtencion { get; set; }

        public string NombreTipo { get; set; }

        public int TiempoMinimo { get; set; }

        public int TiempoMaximo { get; set; }

        public bool Estado { get; set; }
    }
}
