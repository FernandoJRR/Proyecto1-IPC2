package controlador;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;

import javax.faces.event.PreDestroyApplicationEvent;

import java.time.LocalDate;

import exceptions.ConflictException;
import exceptions.DuplicadoException;
import exceptions.NoExisteException;

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
    
    static void agregarInstruccionModelo(String nombreModelo, String nombrePieza, int cantidadPieza) throws SQLException, DuplicadoException, ConflictException{
        try {
            PreparedStatement comprobarExistenciaModelo = connection.prepareStatement("SELECT * FROM modelo_mueble WHERE nombre = ?");
            comprobarExistenciaModelo.setString(1, nombreModelo);
            ResultSet resultSetModelo = comprobarExistenciaModelo.executeQuery();
            //Se comprueba que el modelo del mueble exista
            if (!resultSetModelo.next()) {
                throw new ConflictException();
            }
            PreparedStatement comprobarExistenciaPieza = connection.prepareStatement("SELECT * FROM pieza_de_madera WHERE nombre = ?");
            comprobarExistenciaPieza.setString(1, nombrePieza);
            ResultSet resultSetPieza = comprobarExistenciaPieza.executeQuery();
            //Se comprueba que el tipo de pieza exista
            if (!resultSetPieza.next()) {
                throw new ConflictException();
            }
            PreparedStatement comprobarDuplicado = connection.prepareStatement("SELECT * FROM instrucciones_mueble WHERE nombre_mueble = ? AND tipo_pieza = ?");
            comprobarDuplicado.setString(1, nombreModelo);
            comprobarDuplicado.setString(2, nombrePieza);
            ResultSet resultSetDuplicado = comprobarDuplicado.executeQuery();
            //Se comprueba que no exista la misma instruccion
            if (resultSetDuplicado.next()) {
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
        } catch (ConflictException e) {
            throw new ConflictException();
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
        PreparedStatement preparedStatement = connection.prepareStatement("UPDATE modelo_mueble SET nombre = ?, precio_default = ? WHERE nombre = ?");
        preparedStatement.setString(1, nuevoNombre);
        preparedStatement.setString(2, String.valueOf(costeDefault));
        preparedStatement.setString(3, nombreModelo);
        preparedStatement.executeUpdate();
    }
    
    static void eliminarModelo(String nombre) throws SQLException,ConflictException{
        PreparedStatement comprobarExistencia = connection.prepareStatement("SELECT * FROM mueble WHERE nombre_mueble = ?");
        comprobarExistencia.setString(1, nombre);
        ResultSet resultSet = comprobarExistencia.executeQuery();
        //Si existe un mueble del modelo que se quiere borrar se creara un conflicto
        if (resultSet.next()) {
            throw new ConflictException();
        }else{
            try {
                connection.setAutoCommit(false);
                PreparedStatement borrarInstruccionesModelo = connection.prepareStatement("DELETE FROM instrucciones_mueble WHERE nombre_mueble = ?");
                borrarInstruccionesModelo.setString(1, nombre);
                borrarInstruccionesModelo.executeUpdate();
                PreparedStatement borrarModelo = connection.prepareStatement("DELETE FROM modelo_mueble WHERE nombre = ?");
                borrarModelo.setString(1, nombre);
                borrarModelo.executeUpdate();
                connection.commit();
            } catch (SQLException e) {
                connection.rollback();
                throw new SQLException();
            } finally {
                connection.setAutoCommit(true);
            }
        }
    }
    
    static void validarEnsambleMueble(String modeloMueble, Integer...id) throws SQLException,ConflictException, NoExisteException{
        ArrayList<Integer> idPiezas = new ArrayList<>();
        ArrayList<String> piezasIngresadas = new ArrayList<>();
        Collections.addAll(idPiezas, id);
        
        for (int idPieza : idPiezas) { //Se obtendra el nombre de cada pieza asociada a cada ID comprobando que la pieza no pertenezca ya a un mueble
            PreparedStatement piezas = connection.prepareStatement("SELECT nombre FROM pieza_de_madera WHERE id = ? AND mueble IS NULL");
            piezas.setInt(1, idPieza);
            ResultSet piezaIngresada = piezas.executeQuery();
            
            //En caso de que exista una pieza asociada al ID se almacenara en las piezasIngresadas y esta no pertenezca a un mueble se agregara a la lista
            if (piezaIngresada.next()) { 
                piezasIngresadas.add(piezaIngresada.getString("nombre"));
            }else{ //En caso contrario se tirara un error
                throw new ConflictException();
            }
        }
        
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT tipo_pieza, cantidad_pieza FROM instrucciones_mueble WHERE nombre_mueble = ?");
        preparedStatement.setString(1, modeloMueble);
        ResultSet instruccionesMueble = preparedStatement.executeQuery();
        //Se comprueban que hayan instrucciones para un mueble
        if (instruccionesMueble.next()) {
            instruccionesMueble.beforeFirst(); //En caso de que si existan instrucciones se reiniciara el ResultSet
            while (instruccionesMueble.next()) {
                String tipoPieza = instruccionesMueble.getString("tipo_pieza");
                int cantidadPieza = instruccionesMueble.getInt("cantidad_pieza");
                
                //En caso de que las piezas ingresadas sean del tipo y cantidad adecuados estas se eliminaran de la lista de piezas ingresadas
                if(Collections.frequency(piezasIngresadas, tipoPieza)==cantidadPieza) {
                    while (piezasIngresadas.contains(tipoPieza)) {
                        piezasIngresadas.remove(tipoPieza);
                    }
                }else{ //En caso contrario se tirara un error ya que las piezas ingresadas no corresponden a las necesarias
                    throw new ConflictException();
                }
            }
        }else{
            throw new NoExisteException(); //En caso no hayan instrucciones para el modelo se tirara un error
        }
        
    }
    
    static void ensambleMueble(String modeloMueble, String username, LocalDate fechaEnsamble, Integer...id)throws SQLException,ConflictException,NoExisteException{
        validarEnsambleMueble(modeloMueble, id);
        
        //En caso que se hayan pasado las comprobaciones sin errores, se ensamblara el mueble
        try {
            connection.setAutoCommit(false);

            //Se obtiene el precio de venta default del modelo del mueble
            PreparedStatement obtenerPrecioVenta = connection.prepareStatement("SELECT precio_default FROM modelo_mueble WHERE nombre = ?");
            obtenerPrecioVenta.setString(1, modeloMueble);
            ResultSet precioVenta = obtenerPrecioVenta.executeQuery();
            Float precioVentaDefault = null;
            if (precioVenta.next()) {
                precioVentaDefault = precioVenta.getFloat("precio_default");
            }else{
                throw new SQLException();
            }

            //Primero se agrega una nueva fila en la tabla muebles
            PreparedStatement crearMueble = connection.prepareStatement("INSERT INTO mueble(nombre_mueble,precio_venta,usuario_ensamblador,fecha_ensamble) VALUES(?,?,?,?)",
                                                                        Statement.RETURN_GENERATED_KEYS);
            crearMueble.setString(1, modeloMueble);
            crearMueble.setFloat(2, precioVentaDefault);
            crearMueble.setString(3, username);
            crearMueble.setDate(4, Date.valueOf(fechaEnsamble));
            crearMueble.executeUpdate();
            
            //Se obtiene el id del mueble recien agregado
            int idMuebleEnsamblado;
            ResultSet idMueble = crearMueble.getGeneratedKeys();
            if (idMueble.next()) {
                idMuebleEnsamblado = idMueble.getInt(1);
            }else{
                throw new SQLException();
            }

            //Se asigna a las piezas el id del mueble para indicar que pertenecen a dicho
            String statement = "UPDATE pieza_de_madera SET mueble = ? WHERE id IN (";
            for (int i = 0; i < id.length-1; i++) {statement += "?,";}
            statement += "?)";
            PreparedStatement updatePiezas = connection.prepareStatement(statement);
            updatePiezas.setInt(1, idMuebleEnsamblado);
            for (int i = 0; i < id.length; i++) {
                updatePiezas.setInt(i+2, id[i]);
            }
            updatePiezas.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw new SQLException();
        } finally {
            connection.setAutoCommit(true);
        }
    }
    
    static void ensambleMueble(String modeloMueble, String username, LocalDate fechaEnsamble) throws SQLException,NoExisteException{
        try {
            connection.setAutoCommit(false);

            //Se obtiene el precio de venta default del modelo del mueble
            PreparedStatement obtenerPrecioVenta = connection.prepareStatement("SELECT precio_default FROM modelo_mueble WHERE nombre = ?");
            obtenerPrecioVenta.setString(1, modeloMueble);
            ResultSet precioVenta = obtenerPrecioVenta.executeQuery();
            Float precioVentaDefault = null;
            if (precioVenta.next()) {
                precioVentaDefault = precioVenta.getFloat("precio_default");
            }else{
                throw new NoExisteException();
            }
            
            //Primero se agrega una nueva fila en la tabla muebles
            PreparedStatement crearMueble = connection.prepareStatement("INSERT INTO mueble(nombre_mueble,precio_venta,usuario_ensamblador,fecha_ensamble) VALUES(?,?,?,?)",
                                                                        Statement.RETURN_GENERATED_KEYS);
            crearMueble.setString(1, modeloMueble);
            crearMueble.setFloat(2, precioVentaDefault);
            crearMueble.setString(3, username);
            crearMueble.setDate(4, Date.valueOf(fechaEnsamble));
            crearMueble.executeUpdate();
            
            //Se obtiene el id del mueble recien agregado
            int idMuebleEnsamblado;
            ResultSet idMueble = crearMueble.getGeneratedKeys();
            if (idMueble.next()) {
                idMuebleEnsamblado = idMueble.getInt(1);
            }else{
                throw new SQLException();
            }

            //Se buscan piezas que correspondan con las requeridas por el mueble
            //Primero se obtienen las instrucciones del modelo del mueble
            PreparedStatement obtenerInstrucciones = connection.prepareStatement("SELECT tipo_pieza,cantidad_pieza FROM instrucciones_mueble WHERE nombre_mueble = ?");
            obtenerInstrucciones.setString(1, modeloMueble);
            ResultSet instruccionesMueble = obtenerInstrucciones.executeQuery();
            
            //Se comprueba que existan instrucciones para el mueble
            if (instruccionesMueble == null) {
                throw new NoExisteException();
            }
            
            //Se buscan las piezas que cumplan con los requerimientos
            ArrayList<Integer> idPiezas = new ArrayList<>();
            while (instruccionesMueble.next()) {
                String tipoPieza = instruccionesMueble.getString("tipo_pieza");
                int piezasNecesarias = instruccionesMueble.getInt("cantidad_pieza");
                PreparedStatement obtenerPiezas = connection.prepareStatement("SELECT id,nombre,costo FROM pieza_de_madera WHERE nombre = ? AND mueble IS NULL ORDER BY costo ASC");
                obtenerPiezas.setString(1, tipoPieza);
                ResultSet piezas = obtenerPiezas.executeQuery();
                //Obtenemos la cantidad de piezas que cumplen
                int cantidadPiezas;
                if (piezas != null) {
                    piezas.last();
                    cantidadPiezas = piezas.getRow();
                    if(cantidadPiezas < piezasNecesarias){
                        throw new NoExisteException();
                    }else{ //En caso que existan las piezas necesarias se agregaran a un arreglo de id
                        piezas.beforeFirst();
                        int i = 0;
                        while (piezas.next() && i<piezasNecesarias) {
                            int idPieza = piezas.getInt("id");
                            idPiezas.add(idPieza);
                            i++;
                        }
                    }
                }else{
                    throw new NoExisteException();
                }
            }

            //Se asigna a las piezas el id del mueble para indicar que pertenecen a dicho
            String statement = "UPDATE pieza_de_madera SET mueble = ? WHERE id IN (";
            for (int i = 0; i < idPiezas.size()-1; i++) {statement += "?,";}
            statement += "?)";
            PreparedStatement updatePiezas = connection.prepareStatement(statement);
            updatePiezas.setInt(1, idMuebleEnsamblado);
            for (int i = 0; i < idPiezas.size(); i++) {
                updatePiezas.setInt(i+2, idPiezas.get(i));
            }
            updatePiezas.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw new SQLException();
        } catch (NoExisteException e){
            connection.rollback();
            throw new NoExisteException();
        }finally {
            connection.setAutoCommit(true);
        }
    }
    
    static void desensamblarMueble(int idMueble) throws SQLException, NoExisteException{
        //Se verifica que el mueble exista
        PreparedStatement obtenerMueble = connection.prepareStatement("SELECT * FROM mueble WHERE id = ?");
        obtenerMueble.setInt(1, idMueble);
        ResultSet mueble = obtenerMueble.executeQuery();
        if (!mueble.next()) {
            throw new NoExisteException();
        }
        
        //Si el mueble existe se eliminara de la tabla mueble y sus piezas se desvincularan
        try {
            connection.setAutoCommit(false);

            //Se elimina el mueble de la tabla
            PreparedStatement eliminarMueble = connection.prepareStatement("DELETE FROM mueble WHERE id = ?");
            eliminarMueble.setInt(1, idMueble);
            eliminarMueble.executeUpdate();

            //Se desvinculan las piezas
            PreparedStatement desvincularPiezas = connection.prepareStatement("UPDATE pieza_de_madera SET mueble = NULL WHERE mueble = ?");
            desvincularPiezas.setInt(1, idMueble);
            desvincularPiezas.executeUpdate();
            
            //Se aplican los cambios
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw new SQLException();
        } finally {
            connection.setAutoCommit(true);
        }
    }
}
