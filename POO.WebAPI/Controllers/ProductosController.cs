using System.Collections.Generic;
using System.Threading.Tasks;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using POO.Application.Productos.Commands;
using POO.Application.Productos.Queries;
using POO.Domain;

[ApiController]
[Route("api/[controller]")]
public class ProductosController : ControllerBase
{
    private readonly IMediator _mediator;

    public ProductosController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet]
    public async Task<ActionResult<List<Producto>>> GetProductos()
    {
        var query = new GetAllProductosQuery();
        var result = await _mediator.Send(query);

        return Ok(result);
    }

    [HttpPost]
    public async Task<ActionResult<Producto>> CreateProducto(CreateProductoCommand command)
    {
        var producto = await _mediator.Send(command);
        return CreatedAtAction(nameof(GetProductos), new { }, producto);
    }

    [HttpPut("{sku}")]
    public async Task<ActionResult<Producto>> UpdateProducto(string sku, UpdateProductoCommand command)
    {        
        var newCommand = command with { Sku = sku };
        var producto = await _mediator.Send(newCommand);

        if (producto == null)
        {
            return NotFound();
        }

        return Ok(producto);
    }

    [HttpDelete("{sku}")]
    public async Task<IActionResult> DeleteProducto(string sku)
    {
        var command = new DeleteProductoCommand (sku);
        var result = await _mediator.Send(command);

        if (result is not null)
        {
            return NoContent();
        }

        return NotFound();
    }
}
