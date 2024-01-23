using POO.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Application.Common.Interfaces.Persistence
{
    public interface IProductoRepository
    {
        Producto GetProductoBySku(string sku);
        IEnumerable<Producto> GetAllProductos();
        void AddProducto(Producto producto);
        void UpdateProducto(Producto producto);
        void DeleteProducto(string sku);
    }
}
