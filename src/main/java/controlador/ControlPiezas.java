package controlador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import exceptions.ConflictException;
import exceptions.NoExisteException;

public class ControlPiezas {
    static Connection connection = ConexionBD.getConnection();
    
    public static void crearPieza(String nombre, float costo) throws SQLException,ConflictException{
        try {
            //Se comprueba que el precio sea valido
            if (costo<0) {
                throw new ConflictException();
            }

            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO pieza_de_madera(nombre,costo) VALUES (?,?)");
            preparedStatement.setString(1, nombre);
            preparedStatement.setString(2, String.valueOf(costo));
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException();
        }
    };
    
    public static void eliminarPieza(int id) throws SQLException,ConflictException,NoExisteException{
        try {
            //Se comprueba que la pieza exista
            PreparedStatement existenciaPieza = connection.prepareStatement("SELECT * FROM pieza_de_madera WHERE id = ?");
            existenciaPieza.setInt(1, id);
            ResultSet pieza = existenciaPieza.executeQuery();
            if (!pieza.next()) {
                throw new NoExisteException();
            }

            PreparedStatement comprobarMueblePieza = connection.prepareStatement("SELECT * FROM pieza_de_madera WHERE id = ? AND mueble IS NOT NULL");
            comprobarMueblePieza.setString(1, String.valueOf(id));
            ResultSet resultSet = comprobarMueblePieza.executeQuery();
            //Se comprueba si existe algun mueble con dicha pieza
            if (resultSet.next()) {
                throw new ConflictException();
            }
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM pieza_de_madera WHERE id = ?");
            preparedStatement.setString(1, String.valueOf(id));
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException();
        } catch (ConflictException e) {
            throw new ConflictException();
        }
    }
    
    static void modificarPieza(int id, String nombre, float costo) throws SQLException,ConflictException{
        try {
            PreparedStatement comprobarMueblePieza = connection.prepareStatement("SELECT * FROM pieza_de_madera WHERE id = ? AND mueble IS NOT NULL");
            comprobarMueblePieza.setString(1, String.valueOf(id));
            ResultSet resultSet = comprobarMueblePieza.executeQuery();
            //Se comprueba si existe algun mueble con dicha pieza
            if (resultSet.next()) {
                throw new ConflictException();
            }
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE pieza_de_madera SET nombre = ?, costo = ? WHERE id = ?");
            preparedStatement.setString(1, nombre);
            preparedStatement.setString(2, String.valueOf(costo));
            preparedStatement.setString(3, String.valueOf(id));
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException();
        } catch (ConflictException e) {
            throw new ConflictException();
        }
    }
    
    public static ResultSet piezasDisponibles(String patron) throws SQLException{
        PreparedStatement obtenerPiezas = connection.prepareStatement("SELECT * FROM pieza_de_madera WHERE mueble IS NULL AND nombre LIKE ?");
        obtenerPiezas.setString(1, "%" + patron + "%");
        return obtenerPiezas.executeQuery();
    }
    
    public static ResultSet piezasEnUso(String patron) throws SQLException{
        PreparedStatement obtenerPiezas = connection.prepareStatement("SELECT pieza_de_madera.*, mueble.id as id_mueble, mueble.nombre_mueble FROM pieza_de_madera "+
                                                                      "JOIN mueble ON mueble = mueble.id "+ 
                                                                      "WHERE mueble IS NOT NULL AND nombre LIKE ?");
        obtenerPiezas.setString(1, "%" + patron + "%");
        return obtenerPiezas.executeQuery();
    }

    public static ResultSet tipoPiezas() throws SQLException{
        PreparedStatement obtenerTipos = connection.prepareStatement("SELECT DISTINCT nombre FROM pieza_de_madera");
        return obtenerTipos.executeQuery();
    }
    
    public static ResultSet cantidadesPiezas(String patron) throws SQLException{
        PreparedStatement obtenerCantidades = connection.prepareStatement("SELECT nombre, count(*) as cantidad FROM pieza_de_madera "+
                                                                          "WHERE nombre LIKE ? AND mueble IS NULL GROUP BY nombre");
        obtenerCantidades.setString(1, "%" + patron + "%");     
        return obtenerCantidades.executeQuery();
    }
}
