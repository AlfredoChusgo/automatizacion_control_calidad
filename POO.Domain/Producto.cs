using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Domain
{
    public class Producto
    {
        //Produccto
        public string Sku { get; set; }
        public string SkuAlternante { get; set; }
        public string SkuFabricante { get; set; }
        public string Nombre { get; set; }
        public string NombreExtranjero { get; set; }
        public string CodigoGrupo { get; set; }
        public decimal Peso { get; set; }
        public decimal Precio { get; set; }
        public string UnidadMedida { get; set; }
        public string CodigoBarra{ get; set; }

        //Fabricante
        public string NombreFabricante { get; set; }

        //Proveedor
        public string NombreProveedor { get; set; }
    }
}