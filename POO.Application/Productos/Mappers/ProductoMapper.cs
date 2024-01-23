using POO.Application.Productos.Commands;
using POO.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Application.Productos.Mappers
{
    public class ProductoMapper
    {
        public static Producto Map(CreateProductoCommand command)
        {
            return new Producto
            {
                Sku = command.Sku,
                SkuAlternante = command.SkuAlternante,
                SkuFabricante = command.SkuFabricante,
                Nombre = command.Nombre,
                NombreExtranjero = command.NombreExtranjero,
                CodigoGrupo = command.CodigoGrupo,
                Peso = command.Peso,
                Precio = command.Precio,
                UnidadMedida = command.UnidadMedida,
                CodigoBarra = command.CodigoBarra,
                NombreFabricante = command.NombreFabricante,
                NombreProveedor = command.NombreProveedor
            };
        }

        public static Producto Map(UpdateProductoCommand command)
        {
            return new Producto
            {
                Sku = command.Sku,
                SkuAlternante = command.SkuAlternante,
                SkuFabricante = command.SkuFabricante,
                Nombre = command.Nombre,
                NombreExtranjero = command.NombreExtranjero,
                CodigoGrupo = command.CodigoGrupo,
                Peso = command.Peso,
                Precio = command.Precio,
                UnidadMedida = command.UnidadMedida,
                CodigoBarra = command.CodigoBarra,
                NombreFabricante = command.NombreFabricante,
                NombreProveedor = command.NombreProveedor
            };
        }
    }

}
