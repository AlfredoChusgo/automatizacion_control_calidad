using MediatR;
using POO.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Application.FacturaVentas.Queries
{
    public record GetAllFacturaVentasQuery() : IRequest<IEnumerable<FacturaVenta>>;
}
