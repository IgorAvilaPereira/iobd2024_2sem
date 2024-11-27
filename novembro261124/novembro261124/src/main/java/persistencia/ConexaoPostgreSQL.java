/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistencia;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author iapereira
 */
public class ConexaoPostgreSQL {

    private final String dbname;
    public static String username;
    public static String password;
    private final String port;
    private final String host;
    private final String url;
    
              
     public ConexaoPostgreSQL(){
        dbname  = "novembro";
//        username = "sonpodedeletar";
//        password = "123";
        username = ConexaoPostgreSQL.username;
        password = ConexaoPostgreSQL.password;
        port = "5432";
        host = "localhost";
        url = "jdbc:postgresql://"+host+":"+port+"/"+dbname;

     }
     
     public Connection getConexao() throws SQLException{
        return DriverManager.getConnection(url, username, password);
     }
    
}
