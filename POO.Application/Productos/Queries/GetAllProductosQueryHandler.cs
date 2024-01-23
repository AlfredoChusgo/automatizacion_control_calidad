using MediatR;
using POO.Application.Common.Interfaces.Persistence;
using POO.Application.Productos.Mappers;
using POO.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Application.Productos.Queries
{
    public class GetAllProductosQueryHandler : IRequestHandler<GetAllProductosQuery, IEnumerable<Producto>>
    {
        private readonly IProductoRepository _repository;

        public GetAllProductosQueryHandler(IProductoRepository repository)
        {
            _repository = repository;
        }

        public async Task<IEnumerable<Producto>> Handle(GetAllProductosQuery request, CancellationToken cancellationToken)
        {
            await Task.CompletedTask;
            var productos = _repository.GetAllProductos();

            return productos;
        }
    }
}
