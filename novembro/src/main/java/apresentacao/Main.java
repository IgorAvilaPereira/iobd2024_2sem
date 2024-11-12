/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */
package apresentacao;

import java.awt.FlowLayout;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import negocio.Veiculo;
import persistencia.ConexaoPostgreSQL;
import persistencia.VeiculoDAO;

/**
 *
 * @author iapereira
 */
public class Main {
    
    public static void main(String[] args) throws SQLException, IOException {

        VeiculoDAO veiculoDAO = new VeiculoDAO();
        Veiculo veiculo = veiculoDAO.obter(11);
        System.out.println(veiculo);  
        
        JFrame jFrame = new JFrame();
        jFrame.setLayout(new FlowLayout());
        jFrame.setSize(500, 400);
        JLabel jLabel = new JLabel(new ImageIcon(veiculo.getFoto()));
        jFrame.add(jLabel);
        jFrame.setVisible(true);
        jFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
//        veiculo.setPlaca("ABC5432");
//        veiculoDAO.atualizar(veiculo);
        
//        Veiculo veiculoNovo = new Veiculo();
//        veiculoNovo.setAno(2024);
//        veiculoNovo.setPlaca("IGO1234");
//        veiculoNovo.setFoto("/home/iapereira/uno_de_firma.jpeg");
//        veiculoDAO.inserir(veiculoNovo);
//        System.out.println(veiculoNovo.getId());
        
//        
//        ArrayList<Veiculo> veiculos = veiculoDAO.listar();
//        
//        for (int i = 0; i < veiculos.size(); i++) {
//            
//            System.out.println(veiculos.get(i));
//        }
//        
    }
    
}
