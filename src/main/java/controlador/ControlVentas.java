package controlador;

import java.sql.SQLException;

import exceptions.ConflictException;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ControlVentas {
    static Connection connection = ConexionBD.getConnection();

    static void registrarCliente(int nit, String nombre, String direccion, String municipio, String departamento) throws SQLException, ConflictException{
        if (departamento == null && municipio != null){
            throw new ConflictException();
        }
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO cliente(nit,nombre,direccion,municipio,departamento) VALUES (?,?,?,?,?)");
        preparedStatement.setString(1, String.valueOf(nit));           
        preparedStatement.setString(2, nombre);           
        preparedStatement.setString(3, direccion);           
        preparedStatement.setString(4, municipio);           
        preparedStatement.setString(5, departamento);           
        preparedStatement.executeUpdate();
    }
}
