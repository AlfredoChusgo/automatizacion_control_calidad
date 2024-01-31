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
        public DbSet<Servicio> Servicios{ get; set; }
        public DbSet<Cliente> Clientes { get; set; }
        public DbSet<FacturaVenta> FacturaVentas{ get; set; }

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

            //modelBuilder.Entity<FacturaVenta>()
            //.HasKey(v => v.Id);
            modelBuilder.Entity<FacturaVentaProducto>()
            .HasKey(fvp => new { fvp.FacturaVentaId, fvp.ProductoSku });

            modelBuilder.Entity<FacturaVenta>()
                .HasOne(v => v.Cliente)
                .WithMany(c => c.FacturaVentas)
                .HasForeignKey(v => v.ClienteId);

            modelBuilder.Entity<FacturaVenta>()
                .HasOne(v => v.Cliente)
                .WithMany(c => c.FacturaVentas)
                .HasForeignKey(v => v.ClienteId);

            modelBuilder.Entity<FacturaVenta>()
            .Property(iv => iv.FormaEntrega)
            .HasConversion<string>();

            modelBuilder.Entity<FacturaVenta>()
            .Property(iv => iv.CondicionPago)
            .HasConversion<string>();

            ///

            modelBuilder.Entity<FacturaVentaProducto>()
            .HasOne(fvp => fvp.FacturaVenta)
            .WithMany(fv => fv.FacturasVentasProductos)
            .HasForeignKey(fvp => fvp.FacturaVentaId);

            modelBuilder.Entity<FacturaVentaProducto>()
                .HasOne(fvp => fvp.Producto)
                .WithMany(p => p.FacturasVentasProductos)
                .HasForeignKey(fvp => fvp.ProductoSku);

            // Configure the many-to-many relationship between FacturaVenta and Servicio using the intermediate class
            modelBuilder.Entity<FacturaVentaServicio>()
                .HasKey(fvs => new { fvs.FacturaVentaId, fvs.ServicioId });

            modelBuilder.Entity<FacturaVentaServicio>()
                .HasOne(fvs => fvs.FacturaVenta)
                .WithMany(fv => fv.FacturasVentasServicios)
                .HasForeignKey(fvs => fvs.FacturaVentaId);

            modelBuilder.Entity<FacturaVentaServicio>()
                .HasOne(fvs => fvs.Servicio)
                .WithMany(s => s.FacturasVentasServicios)
                .HasForeignKey(fvs => fvs.ServicioId);


            base.OnModelCreating(modelBuilder);
        }

    }
}
