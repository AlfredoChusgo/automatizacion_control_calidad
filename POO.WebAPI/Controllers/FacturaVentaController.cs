using MediatR;
using Microsoft.AspNetCore.Mvc;
using POO.Application.FacturaVentas.Commands;
using POO.Application.FacturaVentas.Queries;
using POO.Domain;

namespace POO.WebAPI.Controllers;


[ApiController]
[Route("api/[controller]")]
public class FacturaVentaController : ControllerBase
{
    private readonly IMediator _mediator;

    public FacturaVentaController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost]
    public async Task<ActionResult<List<Producto>>> Create(CreateFacturaVentaCommand command)
    {        
        var result = await _mediator.Send(command);

        return Ok(result);
    }

    [HttpGet]
    public async Task<ActionResult<List<FacturaVenta>>> GetFacturaVentas()
    {
        var query = new GetAllFacturaVentasQuery();
        var result = await _mediator.Send(query);

        return Ok(result);
    }

}