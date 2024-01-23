using MediatR;
using POO.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Application.Productos.Commands;

public record CreateProductoCommand(
string Sku,
string SkuAlternante,
string SkuFabricante,
string Nombre,
string NombreExtranjero,
string CodigoGrupo,
decimal Peso,
decimal Precio,
string UnidadMedida,
string CodigoBarra,
string NombreFabricante,
string NombreProveedor) : IRequest<Producto>;


public record UpdateProductoCommand(
string Sku,
string SkuAlternante,
string SkuFabricante,
string Nombre,
string NombreExtranjero,
string CodigoGrupo,
decimal Peso,
decimal Precio,
string UnidadMedida,
string CodigoBarra,
string NombreFabricante,
string NombreProveedor) : IRequest<Producto>;

public record DeleteProductoCommand(string Sku) : IRequest<Producto>;