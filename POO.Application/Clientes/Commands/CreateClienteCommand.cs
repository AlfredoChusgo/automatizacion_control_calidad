using MediatR;
using POO.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Application.Clientes.Commands;

public record CreateClienteCommand(
string Nombre,
string Direccion,
int NumeroDocumentoIdentidad,
string Email,
TipoDocumentoIdentidad TipoDocumentoIdentidad) : IRequest<Unit>;
