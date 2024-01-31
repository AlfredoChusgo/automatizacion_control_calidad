using POO.Domain;
using System.Collections.Generic;
using System;
using Xunit;
using System.Linq;
using POO.Infrastructure.Persistence.Models;
using FluentAssertions;

namespace Poo.Infrastructure.Test
{
    public class FacturaVentaTests : IClassFixture<TestFixture>
    {
        private readonly TestFixture _testFixture;

        public FacturaVentaTests(TestFixture testFixture)
        {
            //_testFixture = testFixture;
            _testFixture = new TestFixture();
        }
      
        
        [Fact]
        public void FacturaRepository_DeberiaCrearUnaFacturaConIVA()
        {

            var productCount = 2;
            CrearFacturaVentaCommand createCommand = new CrearFacturaVentaCommand(
                ClienteId : _testFixture.GetCliente().Id,
                FormaEntrega : FormaEntrega.Envio,
                CondicionPago : CondicionPago.Qr,
                FacturaProductoItems : new List<FacturaProductoItem>
                {
                    new FacturaProductoItem(_testFixture.GetProducto().Sku,productCount)
                },
                FacturaServicioItems : new List<FacturaServicioItem>
                {
                    new FacturaServicioItem(_testFixture.GetServicio().Id)
                },
                ApplicarIva : true
            );
            double baseTotal = _testFixture.GetProducto().Precio * productCount + _testFixture.GetServicio().Tarifa;
            double totalWithIva = baseTotal + baseTotal * 0.13;

            _testFixture.FacturaRepository.AddFacturaVenta(createCommand);
            
            var facturaVentaFromDb = _testFixture.DbContext.FacturaVentas.LastOrDefault();

            facturaVentaFromDb.Should().NotBeNull();
            facturaVentaFromDb.FacturasVentasProductos.Count.Should().Be(1);
            facturaVentaFromDb.FacturasVentasServicios.Count.Should().Be(1);
            facturaVentaFromDb.Impuesto.Should().Be(0.13);
            facturaVentaFromDb.Total.Should().Be(totalWithIva);
        }

        [Fact]
        public void FacturaRepository_DeberiaCrearUnaFacturaSinIVA()
        {
            var productCount = 2;
            CrearFacturaVentaCommand createCommand = new CrearFacturaVentaCommand(
                ClienteId: _testFixture.GetCliente().Id,
                FormaEntrega: FormaEntrega.Envio,
                CondicionPago: CondicionPago.Qr,
                FacturaProductoItems: new List<FacturaProductoItem>
                {
                    new FacturaProductoItem(_testFixture.GetProducto().Sku,productCount)
                },
                FacturaServicioItems: new List<FacturaServicioItem>
                {
                    new FacturaServicioItem(_testFixture.GetServicio().Id)
                },
                ApplicarIva: false
            );
            double baseTotal = _testFixture.GetProducto().Precio * productCount + _testFixture.GetServicio().Tarifa;
            double totalWithIva = baseTotal + baseTotal * 0.13;

            _testFixture.FacturaRepository.AddFacturaVenta(createCommand);

            var facturaVentaFromDb = _testFixture.DbContext.FacturaVentas.LastOrDefault();

            facturaVentaFromDb.Should().NotBeNull();
            facturaVentaFromDb.FacturasVentasProductos.Count.Should().Be(1);
            facturaVentaFromDb.FacturasVentasServicios.Count.Should().Be(1);
            facturaVentaFromDb.Impuesto.Should().Be(0);
            facturaVentaFromDb.Total.Should().NotBe(totalWithIva);
            facturaVentaFromDb.Total.Should().Be(baseTotal);
        }

        [Fact]
        public void FacturaRepository_ShouldFallarCuandoIdClienteEsInvalido()
        {
            CrearFacturaVentaCommand createCommand = new CrearFacturaVentaCommand(
                ClienteId: 99999,
                FormaEntrega: FormaEntrega.Envio,
                CondicionPago: CondicionPago.Qr,
                FacturaProductoItems: new List<FacturaProductoItem>
                {
                    new FacturaProductoItem(_testFixture.GetProducto().Sku,2)
                },
                FacturaServicioItems: new List<FacturaServicioItem>
                {
                    new FacturaServicioItem(_testFixture.GetServicio().Id)
                },
                ApplicarIva: true
            );

            Action act = ()=> _testFixture.FacturaRepository.AddFacturaVenta(createCommand);
            
            act.Should().Throw<ArgumentException>();            
        }

        [Fact]
        public void FacturaRepository_DeberiaFallarCuandoElProductIdSeaInvalido()
        {
            CrearFacturaVentaCommand createCommand = new CrearFacturaVentaCommand(
                ClienteId: _testFixture.GetCliente().Id,
                FormaEntrega: FormaEntrega.Envio,
                CondicionPago: CondicionPago.Qr,
                FacturaProductoItems: new List<FacturaProductoItem>
                {
                    new FacturaProductoItem("InvalidSku",2)
                },
                FacturaServicioItems: new List<FacturaServicioItem>
                {
                    new FacturaServicioItem(_testFixture.GetServicio().Id)
                },
                ApplicarIva: true
            );

            Action act = () => _testFixture.FacturaRepository.AddFacturaVenta(createCommand);

            act.Should().Throw<ArgumentException>();
        }
    }
}