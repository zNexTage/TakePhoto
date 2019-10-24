using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using TakePhoto.Util;
using System.Text;
using TakePhoto.Model;

namespace TakePhoto.DAO
{
    public class DAOUsuario
    {
        /// <summary>
        /// Realiza a inserção da foto do usuario
        /// </summary>
        public void InsereDados(Usuario usuario)
        {
            SqlConnection sqlCon = null;
            SqlCommand sqlCmd = null;
            StringBuilder sbCommand = new StringBuilder();

            //Cria um objeto de conexao ao banco de dados
            sqlCon = new SqlConnection(Apoio.ReturnConnectionString());

            sbCommand.Append(string.Format(" INSERT INTO {0} (IDFOTOS, DESCRICAO, CAMINHO) ", Tabelas.TABELA_FOTOS));
            sbCommand.Append(" VALUES (@ID, @DESCRICACAO, @CAMINHO) ");

            //Monta o comando
            sqlCmd = new SqlCommand(sbCommand.ToString(), sqlCon);

            //Atribui os comando
            sqlCmd.Parameters.AddWithValue("@ID", usuario.iCodUsuario);
            sqlCmd.Parameters.AddWithValue("@DESCRICACAO", usuario.sDescricaoFoto);
            sqlCmd.Parameters.AddWithValue("@CAMINHO", usuario.sCaminhoFoto);

            //Abre conexão
            sqlCon.Open();

            //Executa o comando
            sqlCmd.ExecuteNonQuery();

            //Fecha a conexão
            sqlCon.Close();
        }        
    }
}