using Bogus;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using POO.Domain;
using POO.Infrastructure.Persistence;
using POO.Infrastructure.Persistence.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Database;

namespace Poo.Infrastructure.Test
{
    public class TestFixture : IDisposable
    {
        public ApplicationDbContext DbContext { get; private set; }
        public FacturaRepository FacturaRepository { get; private set; }
        //private readonly IHost _host;

        public TestFixture()
        {
            //_host = new HostBuilder()
            //.ConfigureHostConfiguration(config =>
            //{
            //    // Set environment to "Test"
            //    //config.AddEnvironmentVariables();
            //})
            //.ConfigureServices((hostContext, services) =>
            //{
            //    // Configure services using TestStartup
            //    new TestStartup().ConfigureServices(services);
            //})
            //.Build();
            

            ResetDatabase();
            FacturaRepository = new FacturaRepository(DbContext);
        }

        public void ResetDatabase()
        {
            // Dispose the existing context if it's not null
            DbContext?.Dispose();

            // Create a new in-memory database
            var options = new DbContextOptionsBuilder<ApplicationDbContext>()
                .UseInMemoryDatabase(databaseName: "TestDatabase")
                .Options;

            DbContext = new ApplicationDbContext(options);

            // Seed data
            SeedData();
        }

        private void SeedData()
        {
            // Add sample data to the in-memory database
            //    var productos = new List<Producto>
            //{
            //    new Producto { Sku="a1",Nombre = "Producto1", Precio = 10, SkuAlternante = "ab1",},
            //    new Producto { Nombre = "Producto2", Precio = 20 },
            //    // Add more seed data as needed
            //};

            //    DbContext.Productos.AddRange(productos);
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

            var productos = faker.Generate(100); // Generate 100 fake products

            DbContext.Productos.AddRange(productos);


            var servicios = new List<Servicio>
        {
            new Servicio { Nombre = "Servicio1", Tarifa = 5 },
            new Servicio { Nombre = "Servicio2", Tarifa = 8 },
            // Add more seed data as needed
        };

            DbContext.Servicios.AddRange(servicios);

            var clientes = new List<Cliente>
            {
            new() { Nombre = "Cliente1", Direccion = "Direccion1" },
            new() { Nombre = "Cliente2", Direccion = "Direccion2" },
            // Add more seed data as needed
            };
            DbContext.Clientes.AddRange(clientes);

            // Save changes to persist the seed data in the in-memory database
            DbContext.SaveChanges();
        }

        public void Dispose()
        {
            // Clean up resources after all tests are executed
            DbContext.Dispose();
        }

        public Cliente GetCliente()
        {

            return DbContext.Clientes.FirstOrDefault();
            //return cliente.Id;
        }

        public Producto GetProducto()
        {
            return DbContext.Productos.FirstOrDefault();            
        }

        public Servicio GetServicio()
        {
            return DbContext.Servicios.FirstOrDefault();
            //return servicio.Id;
        }
    }

}
