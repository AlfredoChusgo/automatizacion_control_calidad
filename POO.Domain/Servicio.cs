using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Domain
{
    public class Servicio
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public double Tarifa { get; set; }

        public List<FacturaVentaServicio> FacturasVentasServicios { get; set; }
    }
}
