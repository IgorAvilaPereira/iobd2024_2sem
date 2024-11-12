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
import negocio.Veiculo;

/**
 *
 * @author iapereira
 */
public class VeiculoDAO {
    
    

    public Veiculo obter(int id) throws SQLException {
        Veiculo veiculo = new Veiculo();

        String sql = "SELECT * FROM ONLY veiculo where id = ?;";
        Connection conexao = new ConexaoPostgreSQL().getConexao();
//        transformando a string sql em sql "executavel"
        PreparedStatement preparedStatement = conexao.prepareStatement(sql);
        preparedStatement.setInt(1, id);

//        o resultado da consulta "cai" em REsult set
        ResultSet rs = preparedStatement.executeQuery();

//        para cada tupla retornada
        if (rs.next()) {
            veiculo.setId(rs.getInt("id"));
            veiculo.setAno(rs.getInt("ano"));
            veiculo.setPlaca(rs.getString("placa"));
            veiculo.setFoto(rs.getBytes("foto"));
        }
        conexao.close();
//       
        return veiculo;
    }

    public ArrayList<Veiculo> listar() throws SQLException {
        ArrayList<Veiculo> vet = new ArrayList<>();

        String sql = "SELECT * FROM ONLY veiculo;";
        Connection conexao = new ConexaoPostgreSQL().getConexao();
//        transformando a string sql em sql "executavel"
        PreparedStatement preparedStatement = conexao.prepareStatement(sql);
//        o resultado da consulta "cai" em REsult set
        ResultSet rs = preparedStatement.executeQuery();

//        para cada tupla retornada
        while (rs.next()) {
            Veiculo veiculo = new Veiculo();
            veiculo.setId(rs.getInt("id"));
            veiculo.setAno(rs.getInt("ano"));
            veiculo.setPlaca(rs.getString("placa"));
            veiculo.setFoto(rs.getBytes("foto"));

//            coloando o novo objeto (tupla) no vetor de objetos de veiculo
            vet.add(veiculo);
        }
        conexao.close();
//       
        return vet;
    }

    public boolean deletar(int id) throws SQLException {
        String sql = "DELETE FROM veiculo WHERE id = ?";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, id);
        int linhasAfetadas = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return linhasAfetadas == 1;

    }

    public boolean atualizar(Veiculo veiculo) throws SQLException {
        String sql = "UPDATE veiculo SET placa = ?, ano = ?, foto = ? WHERE id = ?";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, veiculo.getPlaca());
        preparedStatement.setInt(2, veiculo.getAno());
        preparedStatement.setBytes(3, veiculo.getFoto());
        preparedStatement.setInt(4, veiculo.getId());
        int linhasAfetadas = preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
        return linhasAfetadas == 1;

    }

    public boolean inserir(Veiculo veiculo) throws SQLException {
        String sql = "INSERT INTO veiculo (placa, ano, foto) VALUES(?, ?, ?) RETURNING id;";
        Connection connection = new ConexaoPostgreSQL().getConexao();
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, veiculo.getPlaca());
        preparedStatement.setInt(2, veiculo.getAno());
        preparedStatement.setBytes(3, veiculo.getFoto());
        ResultSet rs = preparedStatement.executeQuery();
        if (rs.next()) {
            veiculo.setId(rs.getInt("id"));
        }
        preparedStatement.close();
        connection.close();
        return ((veiculo.getId() != 0) ? true : false);

    }

}
