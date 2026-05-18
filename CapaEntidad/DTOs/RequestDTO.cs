using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaEntidad.DTOs
{
    public class RequestDTO<T>
    {
        public bool Estado { get; set; }

        public string Mensaje { get; set; }

        public T Data { get; set; }
    }
}
