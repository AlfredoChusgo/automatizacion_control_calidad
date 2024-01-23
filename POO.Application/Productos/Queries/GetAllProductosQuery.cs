using MediatR;
using POO.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Application.Productos.Queries
{
    public record GetAllProductosQuery() : IRequest<IEnumerable<Producto>>;    
}
