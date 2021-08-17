package controlador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.Usuario;
import exceptions.DuplicadoException;

public class ControlUsuarios {
    static Connection connection = ConexionBD.getConnection();

    static void crearUsuario(String username, String password, Usuario.tipo tipoUsuario) throws SQLException, DuplicadoException{
        try {
            PreparedStatement comprobarDuplicado = connection.prepareStatement("SELECT * FROM usuario WHERE username = ?");
            comprobarDuplicado.setString(1, username);
            ResultSet resultSet = comprobarDuplicado.executeQuery();
            if (resultSet.next()) {
                throw new DuplicadoException();
            }else{
                PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO usuario(username, password, tipo_usuario) VALUES (?,?,?)");
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, password);
                preparedStatement.setString(3, tipoUsuario.toString());
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            throw new SQLException();
        } catch (DuplicadoException e) {
            throw new DuplicadoException();
        }
    }
    
    static void eliminarUsuario(String username) throws SQLException{
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM usuario WHERE username = ?");
            preparedStatement.setString(1, username);
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            throw new SQLException();
        }
    }
}
