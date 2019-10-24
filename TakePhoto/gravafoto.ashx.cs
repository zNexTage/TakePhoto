using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using TakePhoto.Model;
using Newtonsoft.Json;
using TakePhoto.DAO;

namespace TakePhoto
{
    /// <summary>
    /// Descrição resumida de gravafoto
    /// </summary>
    public class gravafoto : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            DAOUsuario daoUsuario = null;
            string sDateTimeFormat;

            try
            {
                //Instancia a model de usuario
                Usuario usuario = new Usuario();

                //Recebe o json com o base64 da imagem
                string sJson = new StreamReader(context.Request.InputStream).ReadToEnd();

                //Deserializa o json no objeto Usuario
                usuario = JsonConvert.DeserializeObject<Usuario>(sJson);

                //Recebe o Id do usuario
                usuario.iCodUsuario = Convert.ToInt32(context.Request.QueryString["idUsuario"]);

                //Converte a foto do usuario para bytes
                usuario.bFotoUsuario = Convert.FromBase64String(usuario.sFotoUsuarioBase);

                //Converte a data atual para um formato que possa ser utilizado como nome para o arquivo
                sDateTimeFormat = string.Format("{0:yyyyMMddHHmmss}", DateTime.Now);
                
                //Define o nome da imagem
                usuario.sDescricaoFoto = string.Format("ID{0}_{1}.jpg", usuario.iCodUsuario, sDateTimeFormat);
                
                //Adiciona o nome da imagem no caminho para salvar na pasta
                usuario.sCaminhoFoto = string.Format("G:\\UPLOADS\\FOTOS\\{0}", usuario.sDescricaoFoto);               

                //Grava a imagem na pasta
                File.WriteAllBytes(usuario.sCaminhoFoto, usuario.bFotoUsuario);

                //Instancia a daoUsuario
                daoUsuario = new DAOUsuario();

                //Chama o metodo para inserir os dados do usuario
                daoUsuario.InsereDados(usuario);
            }
            catch (Exception err)
            {
                throw err;
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}