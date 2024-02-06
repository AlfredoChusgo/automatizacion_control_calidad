using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POO.Domain; 

public class Cliente
{
    public int Id { get; set; }
    public string Nombre { get; set; }
    public string Direccion { get; set; }
    public int NumeroDocumentoIdentidad{ get; set; }
    public string Email { get; set; }
    public TipoDocumentoIdentidad TipoDocumentoIdentidad { get; set; }
    public List<FacturaVenta> FacturaVentas { get; set; }

}

public enum TipoDocumentoIdentidad
{
    CedulaIdentidad,
    Pasaporte    
}
