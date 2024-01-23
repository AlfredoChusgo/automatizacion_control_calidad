using MediatR;
using POO.Application.Common.Interfaces.Persistence;
using POO.Application.Productos.Mappers;
using POO.Domain;

namespace POO.Application.Productos.Commands;

public class UpdateProductoCommandHandler : IRequestHandler<UpdateProductoCommand, Producto>
{
    private readonly IProductoRepository _repository;

    public UpdateProductoCommandHandler(IProductoRepository repository)
    {
        _repository = repository;
    }

    public async Task<Producto> Handle(UpdateProductoCommand request, CancellationToken cancellationToken)
    {
        await Task.CompletedTask;

        var producto = ProductoMapper.Map(request);

        _repository.UpdateProducto(producto);

        return producto;
    }
}