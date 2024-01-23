using Microsoft.EntityFrameworkCore;
using POO.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Infrastructure.Persistence
{
    public class ApplicationDbContext : DbContext
    {
        public DbSet<Producto> Productos { get; set; }

        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
        {
            
        }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Producto>().HasKey(p => p.Sku);

            modelBuilder.Entity<Producto>().Property(p=> p.Sku).IsRequired();
            modelBuilder.Entity<Producto>().Property(p=> p.SkuAlternante).IsRequired();
            modelBuilder.Entity<Producto>().Property(p=> p.SkuFabricante).IsRequired();
            modelBuilder.Entity<Producto>().Property(p=> p.Nombre).IsRequired();
            modelBuilder.Entity<Producto>().Property(p=> p.NombreExtranjero).IsRequired();
            modelBuilder.Entity<Producto>().Property(p=> p.CodigoGrupo).IsRequired();
            modelBuilder.Entity<Producto>().Property(p=> p.Peso).IsRequired();
            modelBuilder.Entity<Producto>().Property(p=> p.Precio).IsRequired();
            modelBuilder.Entity<Producto>().Property(p=> p.UnidadMedida).IsRequired();
            modelBuilder.Entity<Producto>().Property(p=> p.CodigoBarra).IsRequired();
            modelBuilder.Entity<Producto>().Property(p=> p.NombreFabricante).IsRequired();
            modelBuilder.Entity<Producto>().Property(p => p.NombreProveedor).IsRequired();


            base.OnModelCreating(modelBuilder);
        }

    }
}
