﻿// <auto-generated />
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using POO.Infrastructure.Persistence;

#nullable disable

namespace POO.WebAPI.Migrations
{
    [DbContext(typeof(ApplicationDbContext))]
    partial class ApplicationDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder.HasAnnotation("ProductVersion", "6.0.26");

            modelBuilder.Entity("POO.Domain.Producto", b =>
                {
                    b.Property<string>("Sku")
                        .HasColumnType("TEXT");

                    b.Property<string>("CodigoBarra")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("CodigoGrupo")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("Nombre")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("NombreExtranjero")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("NombreFabricante")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("NombreProveedor")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<decimal>("Peso")
                        .HasColumnType("TEXT");

                    b.Property<decimal>("Precio")
                        .HasColumnType("TEXT");

                    b.Property<string>("SkuAlternante")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("SkuFabricante")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("UnidadMedida")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.HasKey("Sku");

                    b.ToTable("Productos");
                });
#pragma warning restore 612, 618
        }
    }
}
