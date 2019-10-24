using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TakePhoto.Model
{
    public class Usuario
    {
        public int iCodUsuario { get; set; }
        public byte[] bFotoUsuario { get; set; }
        public string sFotoUsuarioBase { get; set; }
        public string sDescricaoFoto { get; set; }
        public string sCaminhoFoto { get; set; }
    }
}