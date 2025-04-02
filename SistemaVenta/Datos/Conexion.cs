using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Conexion
    {
        //cadena conexion
        static string cadena = "Server=localhost;Database=TallerMecanico;Integrade Security=True";
        SqlConnection conexion = new SqlConnection(cadena);
    }
}
