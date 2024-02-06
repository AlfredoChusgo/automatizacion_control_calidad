using System.Collections.Generic;
using System.Threading.Tasks;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using POO.Application.Clientes.Commands;
using POO.Application.Clientes.Queries;
using POO.Domain;
using POO.Infrastructure.Persistence;

[ApiController]
[Route("api/[controller]")]
public class ClientesController : ControllerBase
{
    private readonly IMediator _mediator;

    private ApplicationDbContext DbContext { get; }

    public ClientesController(IMediator mediator, ApplicationDbContext dbContext)
    {
        _mediator = mediator;
        DbContext = dbContext;
    }

    [HttpGet]
    public ActionResult<List<Cliente>> GetClientes()
    {
        return Ok(DbContext.Clientes.ToList());
    }

    [HttpPost]
    public OkResult CreateCliente(CreateClienteCommand command)
    {
        var newCliente = new Cliente
        {
            Nombre = command.Nombre,
            Direccion = command.Direccion,
            Email = command.Email,
            NumeroDocumentoIdentidad = command.NumeroDocumentoIdentidad,
            TipoDocumentoIdentidad = command.TipoDocumentoIdentidad
        };

        DbContext.Clientes.Add(newCliente);

        return Ok();
    }
}
