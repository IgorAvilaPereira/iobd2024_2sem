/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */
package apresentacao;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import negocio.Veiculo;
import persistencia.ConexaoPostgreSQL;
import persistencia.VeiculoDAO;

/**
 *
 * @author iapereira
 */
public class Main {
    
    public static void main(String[] args) throws SQLException {

        VeiculoDAO veiculoDAO = new VeiculoDAO();
        
        ArrayList<Veiculo> veiculos = veiculoDAO.listar();
        
        for (int i = 0; i < veiculos.size(); i++) {
            
            System.out.println(veiculos.get(i));
        }
        
    }
    
}
