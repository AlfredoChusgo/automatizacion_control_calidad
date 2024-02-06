using MediatR;
using POO.Domain;

namespace POO.Application.FacturaVentas.Commands;


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
