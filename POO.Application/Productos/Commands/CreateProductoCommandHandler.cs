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

public class CreateProductoCommandHandler : IRequestHandler<CreateProductoCommand, Producto>
{
    private readonly IProductoRepository _repository;

    public CreateProductoCommandHandler(IProductoRepository repository)
    {
        _repository = repository;
    }

    public async Task<Producto> Handle(CreateProductoCommand request, CancellationToken cancellationToken)
    {
        await Task.CompletedTask;

        var producto = ProductoMapper.Map(request);

        _repository.AddProducto(producto);

        return producto;
    }
}