/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */
package apresentacao;

import java.awt.FlowLayout;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import negocio.Foto;
import negocio.Veiculo;
import persistencia.ConexaoPostgreSQL;
import persistencia.VeiculoDAO;

/**
 *
 * @author iapereira
 */
public class Main {

    public static void exibeFoto(byte[] foto) {
        JFrame jFrame = new JFrame();
        jFrame.setLayout(new FlowLayout());
        jFrame.setSize(500, 400);
        JLabel jLabel = new JLabel(new ImageIcon(foto));
        jFrame.add(jLabel);
        jFrame.setVisible(true);
        jFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    public static void main(String[] args) throws SQLException, IOException {
        Scanner entrada = new Scanner(System.in);
        System.out.println("Username:");
        String username = entrada.nextLine();
        System.out.println("Password:");
        String password = entrada.nextLine();
        ConexaoPostgreSQL.username = username;
        ConexaoPostgreSQL.password = password;
        VeiculoDAO veiculoDAO = new VeiculoDAO();

//      inserir
        Veiculo veiculoNovo = new Veiculo();
        veiculoNovo.setAno(2024);
        veiculoNovo.setPlaca("IXO1234");
        veiculoNovo.getFotos().add(new Foto("/home/iapereira/foto1.png"));
        veiculoNovo.getFotos().add(new Foto("/home/iapereira/foto2.png"));
        veiculoDAO.inserir(veiculoNovo);

//        atualizar
        Veiculo v = veiculoDAO.obter(4);
        v.getFotos().remove(0);
        veiculoDAO.atualizar(v);

//        listar
//        ArrayList<Veiculo> veiculos = veiculoDAO.listar();
//        for (int i = 0; i < veiculos.size(); i++) {
//            Veiculo veiculo = veiculos.get(i);
//            System.out.println(veiculo.getPlaca());
//            if (!veiculo.getFotos().isEmpty()){
//                exibeFoto(veiculo.getFotos().get(0).getArquivo());
//            } 
//        }
//        deletar    
//        veiculoDAO.deletar(5);

//        atualizar       
//        Veiculo veiculo = veiculoDAO.obter(4);
//        veiculo.setFotos(new ArrayList());
//        veiculo.getFotos().add(new Foto("/home/iapereira/brasilia.png"));
//        System.out.println(veiculo.getPlaca());          
//        exibeFoto(veiculo.getFotos().get(0).getArquivo());        
//        exibeFoto(veiculo.getFotos().get(1).getArquivo());
//        veiculoDAO.atualizar(veiculo);
    }

}
