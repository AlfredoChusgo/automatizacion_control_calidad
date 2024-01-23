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
                .RuleFor(p => p.Precio, f => f.Random.Decimal(10, 100))
                .RuleFor(p => p.UnidadMedida, f => f.PickRandom("KG", "LB", "EA"))
                .RuleFor(p => p.CodigoBarra, f => f.Commerce.Ean13())
                .RuleFor(p => p.NombreFabricante, f => f.Company.CompanyName())
                .RuleFor(p => p.NombreProveedor, f => f.Company.CompanyName());

            var productos = faker.Generate(100); // Generate 100 fake products

            _context.Productos.AddRange(productos);
            _context.SaveChanges();
        }
    }
}
