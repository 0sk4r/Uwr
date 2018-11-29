package Grafika;

import javax.swing.*;
import java.io.File;
import java.util.Scanner;

public class Picture {
    private String text;
    private String name;
    private JFileChooser fc;
    private File file;

    public void OpenFile(){
        fc=new JFileChooser();
        if(fc.showOpenDialog(null)==JFileChooser.APPROVE_OPTION){
            file=fc.getSelectedFile();
            try(Scanner sc=new Scanner(file)){
                while(sc.hasNext())
                    text=text+sc.nextLine()+"\n";

            }catch(Exception e){
                JOptionPane.showMessageDialog(null, e.toString(), "Plik nie zostal utworzony", JOptionPane.ERROR_MESSAGE);
            }
            name=file.getName();
        }
    }
}
