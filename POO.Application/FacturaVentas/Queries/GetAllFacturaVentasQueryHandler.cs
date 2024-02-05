using MediatR;
using POO.Application.Common.Interfaces.Persistence;
using POO.Application.FacturaVentas.Queries;
using POO.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Application.FacturaVentas.Queries;


public class GetAllFacturaVentasQueryHandler : IRequestHandler<GetAllFacturaVentasQuery, IEnumerable<FacturaVenta>>
{
    private readonly IFacturaVentaRepository _repository;

    public GetAllFacturaVentasQueryHandler(IFacturaVentaRepository repository)
    {
        _repository = repository;
    }

    public async Task<IEnumerable<FacturaVenta>> Handle(GetAllFacturaVentasQuery request, CancellationToken cancellationToken)
    {
        await Task.CompletedTask;
        var FacturaVentas = _repository.GetAll();

        return FacturaVentas;
    }
}
