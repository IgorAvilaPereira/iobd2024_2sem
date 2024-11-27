/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import negocio.Foto;
import negocio.Veiculo;

/**
 *
 * @author iapereira
 */
public class FotoDAO {

    public void inserirFotos(Veiculo veiculo) throws SQLException {
        for (int i = 0; i < veiculo.getFotos().size(); i++) {
            this.inserir(veiculo.getId(), veiculo.getFotos().get(i));            
        }       
    }

    public boolean deletar(int id) throws SQLException{
        Connection conexao = new ConexaoPostgreSQL().getConexao();
        String sql = "DELETE FROM foto where id = ?";
        PreparedStatement preparedStatement = conexao.prepareStatement(sql);
        preparedStatement.setInt(1, id);
        int linhasAfetadas = preparedStatement.executeUpdate();
        preparedStatement.close();
        conexao.close();
        return linhasAfetadas == 1;
    }
    
    public void inserir(int veiculoID, Foto foto) throws SQLException {
        Connection conexao = new ConexaoPostgreSQL().getConexao();
        String sql = "INSERT INTO foto (arquivo, veiculo_id) values (?,?);";
        PreparedStatement preparedStatement = conexao.prepareStatement(sql);
        preparedStatement.setBytes(1, foto.getArquivo());
        preparedStatement.setInt(2, veiculoID);
        preparedStatement.execute();
        conexao.close();
    }

    public ArrayList<Foto> obterFotosPorVeiculo(Veiculo veiculo) throws SQLException {
        ArrayList<Foto> fotos = new ArrayList<>();
        Connection conexao = new ConexaoPostgreSQL().getConexao();
        String sql = "SELECT * FROM foto where veiculo_id = ?;";
        PreparedStatement preparedStatement = conexao.prepareStatement(sql);
        preparedStatement.setInt(1, veiculo.getId());
        ResultSet rs = preparedStatement.executeQuery();
        while(rs.next()){
            Foto foto = new Foto();
            foto.setId(rs.getInt("id"));
            foto.setArquivo(rs.getBytes("arquivo"));
            fotos.add(foto);            
        }
        conexao.close();
        return fotos;
    }

    public boolean atualizar(Foto foto) throws SQLException {
        String sql = "UPDATE foto SET arquivo = ? WHERE id = ?";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setBytes(1, foto.getArquivo());
        preparedStatement.setInt(2, foto.getId());
        int linhasAfetadas = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();     
        return (linhasAfetadas == 1);
    }

    public void deletarFotosPorVeiculo(int veiculoID) throws SQLException {
        String sql = "DELETE FROM foto WHERE veiculo_id = ?";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, veiculoID);
        int linhasAfetadas = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close(); 
//        return linhasAfetadas > 0;
    }

    
}
