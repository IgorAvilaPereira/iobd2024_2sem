/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package negocio;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author iapereira
 */
public class Foto {
    private int id;
    private byte[] arquivo;

    public Foto(String path) {
        try {
            this.arquivo =  this.pathToByteArray(path);
        } catch (IOException ex) {
            Logger.getLogger(Foto.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Foto() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public byte[] getArquivo() {
        return arquivo;
    }

    public void setArquivo(byte[] arquivo) {
        this.arquivo = arquivo;
    }
    
     public byte[] pathToByteArray(String path) throws FileNotFoundException, IOException {
        // tranforma o caminho em arquivo (file)
        File f = new File(path);
        // transforma o objeto file (f) em vetor de bytes     
        FileInputStream fileInputStream = new FileInputStream(f);
        // setando o atributo da classe/objeto this.foto (bytes[])
//        this.foto = fileInputStream.readAllBytes();
        return fileInputStream.readAllBytes();

    }
    
    
    
}
