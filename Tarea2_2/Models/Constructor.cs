using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SQLite;

namespace Ejercicio2_2.Models
{
    public class Constructor
    {
        [PrimaryKey, AutoIncrement]
        public int codigo { get; set; }

        [MaxLength(250)]
        public string nombre { get; set; }

        [MaxLength(250)]
        public string descripcion { get; set; }

        public byte[] imageSignature { get; set; }

        [Ignore] 
        public ImageSource Img
        {
            get
            {
                if (imageSignature != null)
                {
                    return ImageSource.FromStream(() => new MemoryStream(imageSignature));
                }
                return null;
            }
        }
    }
}
