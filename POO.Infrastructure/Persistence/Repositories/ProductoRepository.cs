using POO.Application.Common.Interfaces.Persistence;
using POO.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Infrastructure.Persistence.Repositories
{
    public class ProductoRepository : IProductoRepository
    {
        private readonly ApplicationDbContext _context;
        public ProductoRepository(ApplicationDbContext context)
        {
            _context = context;
        }
        public void AddProducto(Producto producto)
        {
            _context.Productos.Add(producto);
            _context.SaveChanges();
        }

        public void DeleteProducto(string sku)
        {
            var productToRemove = _context.Productos.Find(sku);

            if (productToRemove == null)
            {
                // Product with the given SKU does not exist, throw an exception or handle appropriately
                throw new ArgumentException($"Producto with SKU {sku} not found.");
            }

            _context.Productos.Remove(productToRemove);
            _context.SaveChanges();
        }

        public IEnumerable<Producto> GetAllProductos()
        {
            return _context.Productos.ToList();
        }

        public Producto GetProductoBySku(string sku)
        {
            return _context.Productos.FirstOrDefault(p => p.Sku == sku);
        }

        public void UpdateProducto(Producto producto)
        {
            var existingProduct = _context.Productos.Find(producto.Sku);

            if (existingProduct == null)
            {
                // Product with the given SKU does not exist, throw an exception or handle appropriately
                throw new ArgumentException($"Product with SKU {producto.Sku} not found.");
            }

            _context.Entry(existingProduct).CurrentValues.SetValues(producto);

            _context.SaveChanges();
        }
    }
}
