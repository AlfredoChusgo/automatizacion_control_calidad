using System;
using System.Linq;
using Bogus;
using Microsoft.EntityFrameworkCore;
using POO.Domain;
using POO.Infrastructure.Persistence;

public class DataSeederService
{
    private readonly ApplicationDbContext _context;

    public DataSeederService(ApplicationDbContext context)
    {
        _context = context;
    }

    public void SeedData()
    {
        if (!_context.Productos.Any())
        {
            var faker = new Faker<Producto>("es")
                .RuleFor(p => p.Sku, f => f.Random.AlphaNumeric(8).ToUpper())
                .RuleFor(p => p.SkuAlternante, f => f.Random.AlphaNumeric(8).ToUpper())
                .RuleFor(p => p.SkuFabricante, f => f.Random.AlphaNumeric(8).ToUpper())
                .RuleFor(p => p.Nombre, f => f.Commerce.ProductName())
                .RuleFor(p => p.NombreExtranjero, f => f.Commerce.ProductName())
                .RuleFor(p => p.CodigoGrupo, f => f.Random.AlphaNumeric(4).ToUpper())
                .RuleFor(p => p.Peso, f => f.Random.Decimal(1, 10))
                .RuleFor(p => p.Precio, f => f.Random.Double(10, 100))
                .RuleFor(p => p.UnidadMedida, f => f.PickRandom("KG", "LB", "EA"))
                .RuleFor(p => p.CodigoBarra, f => f.Commerce.Ean13())
                .RuleFor(p => p.NombreFabricante, f => f.Company.CompanyName())
                .RuleFor(p => p.NombreProveedor, f => f.Company.CompanyName());

            
            //_context.SaveChanges();

            var fakerCliente = new Faker<Cliente>("es")
                //.RuleFor(b => b.Id, f => f.IndexFaker)
                .RuleFor(p=>p.Nombre , f=> f.Person.FirstName)
                .RuleFor(p => p.Direccion, f => f.Person.Address.City)
                .RuleFor(p => p.NumeroDocumentoIdentidad, f => f.Random.Number(10000000, 99999999))
                .RuleFor(p=>p.Email, f => f.Person.Email)
                .RuleFor(p=>p.TipoDocumentoIdentidad,f => f.PickRandom<TipoDocumentoIdentidad>())
                ;

            var productosFake = faker.Generate(50); // Generate 100 fake products
            var clientesFake = fakerCliente.Generate(10);

            _context.Productos.AddRange(productosFake);
            _context.Clientes.AddRange(clientesFake);       
            _context.SaveChanges();

            var productos = _context.Productos;
            var clientes =  _context.Clientes;
            //facturaVentaProducto
            //var facturaVentaProductoFaker = new Faker<FacturaVentaProducto>()
            //.RuleFor(x => x.ProductoSku, f => f.Random.AlphaNumeric(5))
            //.RuleFor(x => x.Producto, f=> f.PickRandom<Producto>(productos))
            //.RuleFor(x => x.Cantidad, f => f.Random.Int(1, 10));
            //var facturaVentaProducto = new List<FacturaVentaProducto>(){
            //new FacturaVentaProducto
            //{
            //    ProductoSku = productos.FirstOrDefault().Sku
            //},
            //new FacturaVentaProducto
            //{
            //    ProductoSku = productos.FirstOrDefault().Sku
            //}
            //};

            //facturaVenta
            var fakerFacturaVentas = new Faker<FacturaVenta>("es")
            .CustomInstantiator(f => new FacturaVenta
            {
                Cliente = fakerCliente.Generate(1).First(),
                Fecha = f.Date.Between(DateTime.Now.AddDays(1), DateTime.Now.AddDays(300)),
                FormaEntrega = f.PickRandom<FormaEntrega>(),
                CondicionPago= f.PickRandom<CondicionPago>(),
                FacturasVentasProductos = productos.Take(4).Select(e=> new FacturaVentaProducto { ProductoSku = e.Sku, Producto = e, Cantidad = 5}).ToList(),
                Impuesto = f.Random.Double(0.01, 0.15),
                Total = f.Random.Double(0.0,6000.0)
            })
            ;
            var facturaVentas = fakerFacturaVentas.Generate(0);
            _context.FacturaVentas.AddRange(facturaVentas);
            _context.SaveChanges();
        }
    }
}
