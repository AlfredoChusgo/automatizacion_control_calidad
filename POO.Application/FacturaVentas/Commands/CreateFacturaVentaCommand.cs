using MediatR;
using POO.Domain;

namespace POO.Application.FacturaVentas.Commands;

//public record CreateFacturaVentaCommand(
//string Sku,
//string SkuAlternante,
//string SkuFabricante,
//string Nombre,
//string NombreExtranjero,
//string CodigoGrupo,
//decimal Peso,
//double Precio,
//string UnidadMedida,
//string CodigoBarra,
//string NombreFabricante,
//string NombreProveedor) : IRequest<FacturaVenta>;

public record CreateFacturaVentaCommand(
int ClienteId,
FormaEntrega FormaEntrega,
CondicionPago CondicionPago,
List<FacturaProductoItem> FacturaProductoItems,
List<FacturaServicioItem> FacturaServicioItems,
bool ApplicarIva) : IRequest<Unit>;

public record FacturaProductoItem(
string ProductoSku,
int Cantidad
    );

public record FacturaServicioItem(int ServicioId);

//public record UpdateFacturaVentaCommand(
//string Sku,
//string SkuAlternante,
//string SkuFabricante,
//string Nombre,
//string NombreExtranjero,
//string CodigoGrupo,
//decimal Peso,
//double Precio,
//string UnidadMedida,
//string CodigoBarra,
//string NombreFabricante,
//string NombreProveedor) : IRequest<FacturaVenta>;

//public record DeleteFacturaVentaCommand(string Sku) : IRequest<FacturaVenta>;