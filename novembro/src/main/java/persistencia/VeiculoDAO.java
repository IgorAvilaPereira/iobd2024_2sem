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
    
    public ArrayList<Veiculo> listar() throws SQLException{
        ArrayList<Veiculo> vet = new ArrayList<>();
        
        String sql = "SELECT * FROM ONLY veiculo;";
        Connection conexao = new ConexaoPostgreSQL().getConexao();
//        transformando a string sql em sql "executavel"
        PreparedStatement preparedStatement = conexao.prepareStatement(sql);
//        o resultado da consulta "cai" em REsult set
        ResultSet rs = preparedStatement.executeQuery();
        
//        para cada tupla retornada
        while (rs.next()){
            Veiculo veiculo = new Veiculo();
            veiculo.setId(rs.getInt("id"));
            veiculo.setAno(rs.getInt("ano"));
            veiculo.setPlaca(rs.getString("placa"));
//            coloando o novo objeto (tupla) no vetor de objetos de veiculo
            vet.add(veiculo);
        }
        conexao.close();
//       
        return vet;
    }
//    public void inserir(Veiculo veiculo);
//    public void deletar(int id);
//    public void atualizar(Veiculo veiculo);
    
}
