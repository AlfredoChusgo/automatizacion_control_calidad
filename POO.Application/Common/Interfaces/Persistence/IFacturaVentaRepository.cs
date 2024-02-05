using POO.Application.FacturaVentas.Commands;
using POO.Domain;
//using POO.Infrastructure.Persistence.Models;

namespace POO.Application.Common.Interfaces.Persistence
{
    public interface IFacturaVentaRepository
    {
        public void AddFacturaVenta(CreateFacturaVentaCommand command);
        FacturaVenta GetById(int id);

        IEnumerable<FacturaVenta> GetAll();
    }
}
