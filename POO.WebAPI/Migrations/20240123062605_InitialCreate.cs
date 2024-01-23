using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace POO.WebAPI.Migrations
{
    public partial class InitialCreate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Productos",
                columns: table => new
                {
                    Sku = table.Column<string>(type: "TEXT", nullable: false),
                    SkuAlternante = table.Column<string>(type: "TEXT", nullable: false),
                    SkuFabricante = table.Column<string>(type: "TEXT", nullable: false),
                    Nombre = table.Column<string>(type: "TEXT", nullable: false),
                    NombreExtranjero = table.Column<string>(type: "TEXT", nullable: false),
                    CodigoGrupo = table.Column<string>(type: "TEXT", nullable: false),
                    Peso = table.Column<decimal>(type: "TEXT", nullable: false),
                    Precio = table.Column<decimal>(type: "TEXT", nullable: false),
                    UnidadMedida = table.Column<string>(type: "TEXT", nullable: false),
                    CodigoBarra = table.Column<string>(type: "TEXT", nullable: false),
                    NombreFabricante = table.Column<string>(type: "TEXT", nullable: false),
                    NombreProveedor = table.Column<string>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Productos", x => x.Sku);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Productos");
        }
    }
}
