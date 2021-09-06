package controlador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.Usuario;
import exceptions.ConflictException;
import exceptions.DuplicadoException;
import exceptions.NoExisteException;

public class ControlUsuarios {
    static Connection connection = ConexionBD.getConnection();

    public static void crearUsuario(String username, String password, Usuario.tipo tipoUsuario) throws SQLException, DuplicadoException, ConflictException{
        try {
            //En caso de que el password tenga menos de 6 caracteres se lanzara un error
            if (password.length()<6) {
                throw new ConflictException();
            }

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
    
    public static void eliminarUsuario(String username) throws SQLException, NoExisteException{
        try {
            //Se verifica que el usuario a eliminar existe
            PreparedStatement obtenerUsuario = connection.prepareStatement("SELECT * FROM usuario WHERE username = ?");
            obtenerUsuario.setString(1, username);
            ResultSet usuario = obtenerUsuario.executeQuery();
            //En caso de que no se lanzara un error
            if (!usuario.next()) {
                throw new NoExisteException();
            }

            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE usuario SET estado = 'CANCELADO' WHERE username = ?");
            preparedStatement.setString(1, username);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException();
        }
    }
    
    public static ResultSet obtenerUsuarios(String patron) throws SQLException{
        PreparedStatement obtenerUsuarios = connection.prepareStatement("SELECT * FROM usuario WHERE username LIKE ? ORDER BY tipo_usuario");
        obtenerUsuarios.setString(1, "%" + patron + "%");
        return obtenerUsuarios.executeQuery();
    }

    public static ResultSet obtenerDatosUsuario(String nit) throws SQLException, NoExisteException{
        PreparedStatement obtenerUsuario = connection.prepareStatement("SELECT * FROM cliente WHERE nit = ?");
        obtenerUsuario.setString(1, nit);
        ResultSet usuario = obtenerUsuario.executeQuery();
        if (!usuario.next()) {
            throw new NoExisteException();
        }
        usuario.beforeFirst();
        return usuario;
    }
}
