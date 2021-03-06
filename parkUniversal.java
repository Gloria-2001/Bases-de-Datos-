import java.sql.*;
import java.util.*;
import java.awt.event.*;
import java.awt.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.*;


public class parkUniversal extends JFrame implements ActionListener{
    JButton bottonConect,bottonInsert;
    JLabel labelRegistry,labelName, labelRace, labelAge, labelGender, lEmpty1, lEmpty2,labelBoletos,labelPaquete;
    JTextField tableID, tableName, tableApellido, tableNacionalidad,tableBoletos,tablePaquete;
    JPanel pan1,pan2,pan3;

    public parkUniversal(){
        bottonConect = new JButton("Conectar");		
        bottonConect.addActionListener(this);
        bottonInsert = new JButton("Ingresar");		
        bottonInsert.addActionListener(this);
        labelRegistry = new JLabel("Registro del cliente y compra de boletos o paquete");
        lEmpty1 = new JLabel("");
        lEmpty2 = new JLabel("");
        labelName = new JLabel("ID: ");
        tableID = new JTextField(20);
        labelRace = new JLabel("Nombre: ");
        tableName = new JTextField(20);
        labelAge = new JLabel("Apellido: ");
        tableApellido = new JTextField(20);
        labelGender = new JLabel("ID de su nacionalidad: ");
        tableNacionalidad = new JTextField(20);
        labelBoletos = new JLabel("Cuantos boletos quiere ? o indique con un 0 si desea un paquete: ");
        tableBoletos = new JTextField(20);
        labelPaquete = new JLabel("Que paquete desea o indique que NINGUNO: ");
        tablePaquete= new JTextField(20);
        pan1 = new JPanel();
        pan1.setLayout(new GridLayout(7,2,5,5));
        pan1.add(labelName);      
        pan1.add(tableID);
        pan1.add(labelRace);	
        pan1.add(tableName);
        pan1.add(labelAge);	
        pan1.add(tableApellido);
        pan1.add(labelGender);	
        pan1.add(tableNacionalidad);
        pan1.add(labelBoletos);	
        pan1.add(tableBoletos);
        pan1.add(labelPaquete);	
        pan1.add(tablePaquete);
        pan2 = new JPanel();
        pan2.setLayout(new GridLayout(1,2,5,5));
        pan2.add(bottonConect);		
        pan2.add(bottonInsert);
        pan3 = new JPanel();
        pan3.setLayout(new GridLayout(1,3,5,5));
        pan3.add(lEmpty1);		
        pan3.add(labelRegistry);		
        pan3.add(lEmpty2);
        setSize(400,200);
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setVisible(true);
        add("North",pan3);    
        add("Center",pan1);   
        add("South",pan2);    
 
 }

 public static void main(String[] args) {
    new parkUniversal();
}  

public void actionPerformed(ActionEvent e) {                                        
    JButton selected = (JButton)e.getSource();
    String id,name,apellido,idnacionalidad,nombrenacio;
    String boletos,paquetes;
        id=tableID.getText();
        name=tableName.getText();
        apellido=tableApellido.getText();
        idnacionalidad=tableNacionalidad.getText();
        boletos=tableBoletos.getText();
        int a = Integer.parseInt(boletos.trim());
        paquetes=tablePaquete.getText();
        
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
else{
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/park", "root", "20Gerika01");
        Statement stm = con.createStatement();
        stm.executeUpdate("insert into cliente(idCliente,nombre,apellido,idNacionalidad)values('"+id+"','"+name+"','"+apellido+"','"+idnacionalidad+"')");
        tableID.setText("");
        tableName.setText("");
        tableApellido.setText("");
        tableNacionalidad.setText("");
        ResultSet rs = stm.executeQuery("select idCliente,nombre,apellido,idNacionalidad from cliente");
        System.out.println("\nDATOS RECIENTEMENTE INGRESADOS");
        System.out.println("ID: "+id+"\n"+"NOMBRE: "+name+"\n"+"APELLIDO: "+apellido+"\n"+"ID NACIONALIDAD: "+idnacionalidad+"\n"+"BOLETOS COMPRADOS: "+boletos+"\n"+"PAQUETE COMPRADO: "+paquetes+"\n");
        int boletoSum = a * 109;
        System.out.println( "Total cantidad a pagar de los boletos = "+boletoSum+" dolares \n");
        System.out.println( "Paquete deseado = "+paquetes+"\n");
        stm.close();
        con.close();
    } catch (SQLException ex) {
        Logger.getLogger(parkUniversal.class.getName()).log(Level.SEVERE, null, ex);
    }
}
}
}