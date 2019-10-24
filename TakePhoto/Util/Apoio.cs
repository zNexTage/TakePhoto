using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace TakePhoto.Util
{
    public class Apoio
    {
        /// <summary>
        ///Chama o script para demonstrar o modal com um mensagem
        /// </summary>
        /// <param name="page"></param>
        /// <param name="type"></param>
        /// <param name="sMensagem"></param>
        public static void DemonstraModalMensagem(Page page, Type type, string sTitulo, string sMensagem)
        {
            ScriptManager.RegisterStartupScript(page, type, "modalMensagem", string.Format("modalMensagem('{0}','{1}')", sTitulo, sMensagem), true);
        }
        
        /// <summary>
        /// Retorna a connection string
        /// </summary>
        /// <returns></returns>
        public static string ReturnConnectionString()
        {
            return ConfigurationManager.AppSettings["DB_ECONTROL"].ToString();
        }
    }

    /// <summary>
    /// Define os nomes da tabela da base de dados
    /// </summary>
    public class Tabelas
    {
        //Tabela de fotos
        public const string TABELA_FOTOS = "TB_FOTOS";
    }
}