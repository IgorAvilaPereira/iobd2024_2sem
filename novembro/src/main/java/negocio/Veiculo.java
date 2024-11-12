/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package negocio;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 *
 * @author iapereira
 */
public class Veiculo {
    private int id;
    private String placa;
    private byte foto[];
    private int ano;

    public int getId() {
        
        return id;
    }

    public void setId(int id) {
      
        this.id = id;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public byte[] getFoto() {
        return foto;
    }

    public void setFoto(byte[] foto) {
        this.foto = foto;
    }
    
    public void setFoto(String path) throws FileNotFoundException, IOException {
        // tranforma o caminho em arquivo (file)
        File f = new File(path);
        // transforma o objeto file (f) em vetor de bytes     
        FileInputStream fileInputStream = new FileInputStream(f);
        // setando o atributo da classe/objeto this.foto (bytes[])
        this.foto = fileInputStream.readAllBytes();
    }

    public int getAno() {
        return ano;
    }

    public void setAno(int ano) {
        this.ano = ano;
    }

    @Override
    public String toString() {
        return "Veiculo{" + "id=" + id + ", placa=" + placa + ", foto=" + foto + ", ano=" + ano + '}';
    }

    
    
    
}
