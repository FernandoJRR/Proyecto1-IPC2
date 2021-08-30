/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.sql.*;

import bean.Usuario;

/**
 *
 * @author fernanrod
 */
public class AutenticadorUsuario {
    public static boolean autenticarUsername(String username) {
        try{
            Connection connection = ConexionBD.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM usuario WHERE username = ? AND estado = 'ACTIVO'");
            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();
            return resultSet.next();
        } catch(SQLException e){
            e.printStackTrace();  
        }
        return false;
    }
    
    public static boolean autenticarPassword(String username, String password){
        try{
            Connection connection = ConexionBD.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT * FROM usuario WHERE username = ? AND password = ?");
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();
            return resultSet.next();
        } catch(SQLException e){
            e.printStackTrace();  
        }
        return false;
    }
    
    public static Usuario.tipo darTipoUsuario(String username){
        try {
            Connection connection = ConexionBD.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT tipo_usuario FROM usuario WHERE username = ?");
            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();
	    resultSet.next();
            return Usuario.tipo.valueOf(resultSet.getString("tipo_usuario"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
