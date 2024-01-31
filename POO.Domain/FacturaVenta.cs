using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Domain
{
    public class FacturaVenta
    {
        public int Id { get; set; }

        public int ClienteId { get; set; }
        public Cliente Cliente { get; set; }
        public DateTime Fecha { get; set; }
        public FormaEntrega FormaEntrega { get; set; }
        public CondicionPago CondicionPago {  get; set; }

        public List<FacturaVentaProducto> FacturasVentasProductos { get; set; } = new List<FacturaVentaProducto>();
        public List<FacturaVentaServicio> FacturasVentasServicios { get; set; } = new List<FacturaVentaServicio>();

        public double Impuesto { get; set; }

        public double Total { get; set; }
    }

    public enum FormaEntrega
    {
        Envio,
        RetiroEnTienda
    }

    public enum CondicionPago
    {
        Efectivo,
        Qr
    }

    public class FacturaVentaProducto
    {
        public int FacturaVentaId { get; set; }
        public FacturaVenta FacturaVenta { get; set; }

        public string ProductoSku { get; set; }
        public Producto Producto { get; set; }

        public int Cantidad { get; set; } // Additional property for the join table
    }

    public class FacturaVentaServicio
    {
        public int FacturaVentaId { get; set; }
        public FacturaVenta FacturaVenta { get; set; }

        public int ServicioId { get; set; }
        public Servicio Servicio { get; set; }

        // Additional properties for the join table, if needed
    }
}
