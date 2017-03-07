import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.Scanner;

import javax.swing.*;

public class EdytorWydawnictwaCiaglego extends JFrame implements ActionListener, Serializable
{
    public JButton ButtonZapisz, ButtonOtworz;
    public JTextField TextTytul, TextAutor, TextRok;
    public WydawnictwoCiagle K;

    public EdytorWydawnictwaCiaglego(String s)
    {
        initUI();
        K = new WydawnictwoCiagle();

        if(s != "")
        {
            File file = new File(s);
            ReadFromFile(file);
        }
    }

    public void ReadToField()
    {
        TextTytul.setText(K.Tytul);
        TextAutor.setText(K.autor);
        TextRok.setText(Integer.toString(K.wydanie));
    }

    public void WriteToBook()
    {
        K = new WydawnictwoCiagle(TextTytul.getText(), TextAutor.getText(), Integer.parseInt(TextRok.getText()));
    }

    public final void initUI()
    {
        ButtonZapisz = new JButton("Zapisz");
        ButtonOtworz = new JButton("Otwórz");

        ButtonZapisz.setBounds(50, 130, 100 , 30);
        ButtonOtworz.setBounds(160, 130, 100, 30);

        this.setLayout(null);

        getContentPane().add(ButtonZapisz);
        getContentPane().add(ButtonOtworz);
        ButtonZapisz.addActionListener(this);
        ButtonOtworz.addActionListener(this);

        TextTytul = new JTextField("Tytul");
        TextTytul.setBounds(50, 10, 200, 30);
        getContentPane().add(TextTytul);

        TextAutor = new JTextField("Autor");
        TextAutor.setBounds(50, 50, 200, 30);
        getContentPane().add(TextAutor);

        TextRok = new JTextField("Rok Wydania");
        TextRok.setBounds(50, 90, 200, 30);
        getContentPane().add(TextRok);

        setSize(300, 250);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    }

    public void SaveToFile(File file)
    {
        try
        {
            PrintWriter zapis = new PrintWriter(file);
            WriteToBook();
            zapis.println(K.toString());
            zapis.close();
        }
        catch (FileNotFoundException e1) {}
    }

    public void ReadFromFile(File file)
    {
        try
        {
            Scanner in = new Scanner(file);

            String T = in.nextLine();
            String A = in.nextLine();
            String R = in.nextLine();

            K = new WydawnictwoCiagle(T,A,Integer.parseInt(R));
            ReadToField();
            in.close();
        }
        catch (FileNotFoundException e1) {}
    }

    public void actionPerformed(ActionEvent e)
    {
        Object source = e.getSource();

        if( source == ButtonZapisz )
        {
            JFileChooser fileChooser = new JFileChooser();
            if (fileChooser.showSaveDialog(ButtonZapisz) == JFileChooser.APPROVE_OPTION)
            {
                File file = fileChooser.getSelectedFile();
                SaveToFile(file);
            }
        }

        if( source == ButtonOtworz )
        {
            JFileChooser fileChooser = new JFileChooser();

            if (fileChooser.showOpenDialog(ButtonOtworz) == JFileChooser.APPROVE_OPTION)
            {
                File file = fileChooser.getSelectedFile();
                ReadFromFile(file);

            }
        }
    }
}