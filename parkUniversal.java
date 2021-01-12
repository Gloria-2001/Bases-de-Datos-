import java.sql.*;
import java.util.*;
import java.awt.event.*;
import java.awt.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.*;


public class parkUniversal extends JFrame implements ActionListener{
    JButton bottonConect;

    public parkUniversal(){
        bottonConect = new JButton("Conectar");		
        bottonConect.addActionListener(this);
        setSize(400,200);
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setVisible(true);
        add("North",bottonConect);    
 
 }

 public static void main(String[] args) {
    new parkUniversal();
}  

public void actionPerformed(ActionEvent e) {                                        
    JButton selected = (JButton)e.getSource();

if(selected == bottonConect){
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
       
    }catch (ClassNotFoundException ex) {
        Logger.getLogger(parkUniversal.class.getName()).log(Level.SEVERE, null, ex);
    }
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/park", "root", "20Gerika01");
    } catch (SQLException ex) {
        Logger.getLogger(parkUniversal.class.getName()).log(Level.SEVERE, null, ex);
    }
        System.out.println("CONEXION ESTABLECIDA SATISFACTORIAMENTE");
}        
}
}