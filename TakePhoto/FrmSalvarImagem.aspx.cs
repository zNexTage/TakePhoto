using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TakePhoto.Util;

namespace TakePhoto
{
    public partial class FrmSalvarImagem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        ///// <summary>
        ///// Recupera a foto do usuario e salva na pasta de upload
        ///// </summary>
        ///// <param name="sender"></param>
        ///// <param name="e"></param>
        //protected void btnSalvar_Click(object sender, EventArgs e)
        //{
        //    string sCaminhoImagem = Server.MapPath("upload/");
        //    byte[] bArrayImagem = null;
        //    string sImagemBase;

        //    try
        //    {
        //        sImagemBase = txtBaseImage.Text;
        //        bArrayImagem = Convert.FromBase64String(sImagemBase);
        //        sCaminhoImagem += string.Format("{0}.{1}", "sasasasasa", "png");

        //        File.WriteAllBytes(sCaminhoImagem, bArrayImagem);

        //        Apoio.DemonstraModalMensagem(this, this.GetType(), "Sucesso!", Mensagens.IMAGEM_CADASTRADA);

        //    }
        //    catch (Exception err)
        //    {
        //        throw new Exception(err.Message);
        //    }
        //}
    }
}