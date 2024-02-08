using MediatR;
using Microsoft.AspNetCore.Mvc;
using POO.Application.FacturaVentas.Commands;
using POO.Application.FacturaVentas.Queries;
using POO.Domain;
using POO.Infrastructure.Persistence;

namespace POO.WebAPI.Controllers;


[ApiController]
[Route("api/[controller]")]
public class FacturaVentaController : ControllerBase
{
    private readonly IMediator _mediator;
    private ApplicationDbContext DbContext { get; }

    public FacturaVentaController(IMediator mediator, ApplicationDbContext dbContext)
    {
        _mediator = mediator;
        DbContext = dbContext;
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

    [HttpGet("GetSourceDataForFacturaVenta")]
    public async Task<ActionResult<List<FacturaVenta>>> GetSourceDataForFacturaVenta()
    {
        var productos = DbContext.Productos.ToList();
        var clientes = DbContext.Clientes.ToList();

        return new JsonResult(new
        {
            Productos = productos,
            Clientes = clientes,
        });
    }

}