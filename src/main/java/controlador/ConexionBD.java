/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author fernanrod
 */
public class ConexionBD {
	final static String url = "jdbc:mariadb://localhost:3306/muebleria_mimuebleria";
	final static String user = "fernanrod";
	final static String pwd = "0contraSeQueL2";
	
    public static Connection getConnection() {
        Connection connection = null;
        try{
	    Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, pwd); 
        } catch(SQLException|ClassNotFoundException e){
            e.printStackTrace();  
        }
        return connection;
    }
}
