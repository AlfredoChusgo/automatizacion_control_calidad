using MediatR;
using POO.Application.Common.Interfaces.Persistence;
using POO.Application.FacturaVentas.Commands;
using POO.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Application.FacturaVentas.Commands;

public class CreateFacturaVentaCommandHandler : IRequestHandler<CreateFacturaVentaCommand, Unit>
{
    private readonly IFacturaVentaRepository _repository;

    public CreateFacturaVentaCommandHandler(IFacturaVentaRepository repository)
    {
        _repository = repository;
    }

    public async Task<Unit> Handle(CreateFacturaVentaCommand request, CancellationToken cancellationToken)
    {
        
        _repository.AddFacturaVenta(request);

        return await Task.FromResult(Unit.Value);
    }
}
