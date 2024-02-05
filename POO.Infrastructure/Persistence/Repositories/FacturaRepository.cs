using Microsoft.EntityFrameworkCore;
using POO.Application.Common.Interfaces.Persistence;
using POO.Application.FacturaVentas.Commands;
using POO.Domain;
using POO.Infrastructure.Persistence.Models;

namespace POO.Infrastructure.Persistence.Repositories
{
    public class FacturaRepository : IFacturaVentaRepository
    {
        private readonly ApplicationDbContext _context;
        private const double IVA = 0.13;
        public FacturaRepository(ApplicationDbContext context)
        {
            _context = context;
        }
        public void AddFacturaVenta(CreateFacturaVentaCommand command)
        {
            ValidarCrearFacturaVentaCommand(command);

            GenerarFactura(command);
        }

        private void GenerarFactura(CreateFacturaVentaCommand command)
        {
            double total = 0;
            var facturaVenta = new FacturaVenta()
            {
                ClienteId = command.ClienteId,
                Fecha = DateTime.Now,
                FormaEntrega = command.FormaEntrega,
                CondicionPago = command.CondicionPago,
                Impuesto = command.ApplicarIva ? IVA : 0.0,
            };

            command.FacturaProductoItems.ForEach(item =>
            {
                var producto = _context.Productos.FirstOrDefault(e => e.Sku == item.ProductoSku);
                total = total + (double)(producto.Precio * item.Cantidad);

                facturaVenta.FacturasVentasProductos.Add(new FacturaVentaProducto()
                {
                    ProductoSku = item.ProductoSku,
                    Cantidad = item.Cantidad,
                });
            });

            command.FacturaServicioItems.ForEach(item =>
            {
                var servicio = _context.Servicios.FirstOrDefault(e => e.Id == item.ServicioId);

                total = total + (double)(servicio.Tarifa);

                facturaVenta.FacturasVentasServicios.Add(new FacturaVentaServicio()
                {
                    ServicioId = item.ServicioId,
                });
            });

            facturaVenta.Total = command.ApplicarIva ? (total + total * IVA) : total;

            _context.FacturaVentas.Add(facturaVenta);
            _context.SaveChanges();
        }

        private void ValidarCrearFacturaVentaCommand(CreateFacturaVentaCommand command)
        {
            if(command.ClienteId == 0)
            {
                throw new ArgumentException("ClienteId invalido");
            }
            var cliente = _context.Clientes.Where(c=> c.Id == command.ClienteId).FirstOrDefault();
            if(cliente is null)
            {
                throw new ArgumentException("Cliente no valido");
            }

            if(command.FacturaProductoItems.Count() == 0 && command.FacturaServicioItems.Count() == 0) {
                throw new ArgumentException("debe existir al menos un producto o servicio en la factura");
            }

            command.FacturaProductoItems.ForEach(item =>
            {
                var producto = _context.Productos.Where(c => c.Sku == item.ProductoSku).FirstOrDefault();
                if (producto is null)
                {
                    throw new ArgumentException("Producto no valido");
                }
            });

            command.FacturaServicioItems.ForEach(item =>
            {
                var servicio = _context.Servicios.Where(c => c.Id== item.ServicioId).FirstOrDefault();
                if (servicio is null)
                {
                    throw new ArgumentException($"Servicio ${item.ServicioId} no valido");
                }
            });
        }

        public FacturaVenta GetById(int id)
        {
            var facturaVentaFromDb = _context.FacturaVentas.FirstOrDefault(e=>e.Id == id);
            return facturaVentaFromDb ?? throw new Exception($"Not found with id ${id}");
        }

        public IEnumerable<FacturaVenta> GetAll()
        {
            return _context.FacturaVentas.ToList();
        }
    }
}
