using MediatR;
using POO.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Application.Clientes.Queries;

public record GetAllClientesQuery() : IRequest<IEnumerable<Cliente>>;
