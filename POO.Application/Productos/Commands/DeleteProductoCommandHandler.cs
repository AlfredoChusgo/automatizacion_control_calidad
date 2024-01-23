using MediatR;
using POO.Application.Common.Interfaces.Persistence;
using POO.Application.Productos.Mappers;
using POO.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Application.Productos.Commands;

public class DeleteProductoCommandHandler : IRequestHandler<DeleteProductoCommand, Producto>
{
    private readonly IProductoRepository _repository;

    public DeleteProductoCommandHandler(IProductoRepository repository)
    {
        _repository = repository;
    }

    public async Task<Producto> Handle(DeleteProductoCommand request, CancellationToken cancellationToken)
    {
        await Task.CompletedTask;
        var producto = _repository.GetProductoBySku(request.Sku);
        _repository.DeleteProducto(request.Sku);

        return producto;
    }
}