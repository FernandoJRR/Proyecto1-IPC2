package controlador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import exceptions.ConflictException;
import exceptions.DuplicadoException;

public class ControlEnsamble {
    static Connection connection = ConexionBD.getConnection();
    
    static void crearModeloMueble(String nombre, float costeDefault)throws SQLException, DuplicadoException{
        try {
            PreparedStatement comprobarDuplicado = connection.prepareStatement("SELECT * FROM modelo_mueble WHERE nombre = ?");
            comprobarDuplicado.setString(1, nombre);
            ResultSet resultSet = comprobarDuplicado.executeQuery();
            if (resultSet.next()) {
                throw new DuplicadoException();
            }else{
                PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO modelo_mueble(nombre, precio_default) VALUES (?,?)");
                preparedStatement.setString(1, nombre);
                preparedStatement.setString(2, String.valueOf(costeDefault));
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            throw new SQLException();
        } catch (DuplicadoException e) {
            throw new DuplicadoException();
        }
    }
    
    static void agregarInstruccionModelo(String nombreModelo, String nombrePieza, int cantidadPieza) throws SQLException, DuplicadoException{
        try {
            PreparedStatement comprobarDuplicado = connection.prepareStatement("SELECT * FROM instrucciones_mueble WHERE nombre_mueble = ? AND tipo_pieza = ?");
            comprobarDuplicado.setString(1, nombreModelo);
            comprobarDuplicado.setString(2, nombrePieza);
            ResultSet resultSet = comprobarDuplicado.executeQuery();
            if (resultSet.next()) {
                throw new DuplicadoException();
            }else{
                PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO instrucciones_mueble(nombre_mueble,tipo_pieza,cantidad_pieza) VALUES (?,?,?)");
                preparedStatement.setString(1, nombreModelo);
                preparedStatement.setString(2, nombrePieza);
                preparedStatement.setString(3, String.valueOf(cantidadPieza));
                preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            throw new SQLException();
        } catch (DuplicadoException e) {
            throw new DuplicadoException();
        }
    }
    
    static void eliminarInstruccionesMueble(String nombreModelo, String nombrePieza) throws SQLException{
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM instrucciones_mueble WHERE nombre_mueble = ? AND tipo_pieza = ?");
            preparedStatement.setString(1, nombreModelo);
            preparedStatement.setString(2, nombrePieza);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException();
        } 
    }
    
    static void modificarModelo(String nombreModelo, String nuevoNombre, float costeDefault) throws SQLException{
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE modelo_mueble SET nombre = ?, costeDefault = ? WHERE nombre = ?");
            preparedStatement.setString(1, nuevoNombre);
            preparedStatement.setString(2, String.valueOf(costeDefault));
            preparedStatement.setString(3, nombreModelo);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException();
        }
    }
    
    static void eliminarModelo(String nombre) throws SQLException,ConflictException{
        try {
            PreparedStatement comprobarExistencia = connection.prepareStatement("SELECT * FROM mueble WHERE nombre = ?");
            comprobarExistencia.setString(1, nombre);
            ResultSet resultSet = comprobarExistencia.executeQuery();
            //Si existe un mueble del modelo que se quiere borrar se creara un conflicto
            if (resultSet.next()) {
                throw new ConflictException();
            }else{
                PreparedStatement borrarInstruccionesModelo = connection.prepareStatement("DELETE FROM instrucciones_mueble WHERE nombre_mueble = ?");
                borrarInstruccionesModelo.setString(1, nombre);
                PreparedStatement borrarModelo = connection.prepareStatement("DELETE FROM modelo_mueble WHERE nombre = ?");
                borrarModelo.setString(1, nombre);
                borrarInstruccionesModelo.executeUpdate();
                borrarModelo.executeUpdate();
            }
        } catch (SQLException e) {
            throw new SQLException();
        } catch (ConflictException e) {
            throw new ConflictException();
        }
    }
}
