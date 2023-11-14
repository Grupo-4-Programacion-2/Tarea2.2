using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SQLite;

namespace Ejercicio2_2.Models
{
    public class BasedeDatos
    {
        readonly SQLiteAsyncConnection dbase;

        // Constructor 
        public BasedeDatos(String dbpath)
        {
            try
            {
                dbase = new SQLiteAsyncConnection(dbpath);

                // Creación de tablas de base de datos
                dbase.CreateTableAsync<Constructor>().Wait(); // Añadido Wait para asegurar la creación antes de continuar
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error al crear la tabla: {ex.Message}");
            }

        }

        public Task<List<Constructor>> listaempleados()
        {

            return dbase.Table<Constructor>().ToListAsync();
        }

        // Buscar empleado por su ID
        public Task<List<Constructor>> ObtenerEmpleado()
        {
            return dbase.Table<Constructor>().ToListAsync();
        }

        public Task<Constructor> obtenerEmple(int pid)
        {
            return dbase.Table<Constructor>()
                .Where(i => i.codigo == pid)
                .FirstOrDefaultAsync();
        }


        // Salvar o actualizar

        public Task<int> EmpleadoGuardar(Constructor emple)
        {
            if (emple.codigo != 0)
            {
                return dbase.UpdateAsync(emple);
            }
            else
            {
                return dbase.InsertAsync(emple);
            }
        }

        //Eliminar 

        public Task<int> EmpleadoBorrar(Constructor emple)
        {
            return dbase.DeleteAsync(emple);
        }
    }
}
