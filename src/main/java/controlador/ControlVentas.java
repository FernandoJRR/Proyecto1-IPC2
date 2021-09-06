package controlador;

import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

import exceptions.ConflictException;
import exceptions.DuplicadoException;
import exceptions.NoExisteException;
import exceptions.FueraDeFechaException;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ControlVentas {
    static Connection connection = ConexionBD.getConnection();

    public static void registrarCliente(String nit, String nombre, String direccion) throws SQLException, DuplicadoException{
        //Se comprueba que el cliente no exista ya
        PreparedStatement comprobarCliente = connection.prepareStatement("SELECT * FROM cliente WHERE nit = ?");
        comprobarCliente.setString(1, nit);
        ResultSet clientes = comprobarCliente.executeQuery();
        if (clientes.next()) {
            throw new DuplicadoException();
        }

        PreparedStatement registrarCliente = connection.prepareStatement("INSERT INTO cliente(nit,nombre,direccion) VALUES (?,?,?)");
        registrarCliente.setString(1, nit);           
        registrarCliente.setString(2, nombre);           
        registrarCliente.setString(3, direccion);           
        registrarCliente.executeUpdate();
    }

    public static void registrarCliente(String nit, String nombre, String direccion, String municipio, String departamento) throws SQLException, ConflictException, DuplicadoException{
        //Se comprueba que el cliente no exista ya
        PreparedStatement comprobarCliente = connection.prepareStatement("SELECT * FROM cliente WHERE nit = ?");
        comprobarCliente.setString(1, nit);
        ResultSet clientes = comprobarCliente.executeQuery();
        if (clientes.next()) {
            throw new DuplicadoException();
        }

        if ((departamento == null && municipio != null)||(departamento != null && municipio == null)){
            throw new ConflictException();
        }
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO cliente(nit,nombre,direccion,municipio,departamento) VALUES (?,?,?,?,?)");
        preparedStatement.setString(1, nit);           
        preparedStatement.setString(2, nombre);           
        preparedStatement.setString(3, direccion);           
        preparedStatement.setString(4, municipio);           
        preparedStatement.setString(5, departamento);           
        preparedStatement.executeUpdate();
    }
    
    public static void registrarCompra(String nit, String usuario, LocalDate fecha,Integer...idMuebles) throws SQLException, NoExisteException, ConflictException{
        try {
            
            //Se comprueba que no hayan valores duplicados en los id
            for (int i = 0; i < idMuebles.length; i++) {
                for (int j = 0; j < idMuebles.length; j++) {
                    if (idMuebles[i].equals(idMuebles[j]) && i != j) {
                        throw new ConflictException();
                    }
                }
            }
            
            //Se comprueba que los id de todos los muebles existan
            for (Integer idMueble : idMuebles) {
                PreparedStatement obtenerMueble = connection.prepareStatement("SELECT * FROM mueble WHERE id = ?");
                obtenerMueble.setInt(1, idMueble);
                ResultSet mueble = obtenerMueble.executeQuery();
                if (!mueble.next()) {
                    throw new NoExisteException();
                }
            }
            
            //Se comprueba que los id de todos los muebles no han sido vendidos
            String statement = "SELECT mueble_comprado FROM compra WHERE mueble_comprado IN (";
            for (int i = 0; i < idMuebles.length-1; i++) {statement += "?,";}
            statement+="?)";
            PreparedStatement obtenerVentaMueble = connection.prepareStatement(statement);
            for (int i = 0; i < idMuebles.length; i++) {
                obtenerVentaMueble.setInt(i+1, idMuebles[i]);
            }
            ResultSet mueblesVendidos = obtenerVentaMueble.executeQuery();
            if (mueblesVendidos.next()) {
                throw new ConflictException();
            }
            
            connection.setAutoCommit(false);

            //Si ninguno de los muebles ha sido vendido se registraran en una nueva factura
            PreparedStatement crearFactura = connection.prepareStatement("INSERT INTO factura(cliente,encargado,fecha) VALUES (?,?,?)", Statement.RETURN_GENERATED_KEYS);
            crearFactura.setString(1, nit);
            crearFactura.setString(2, usuario);
            crearFactura.setDate(3, Date.valueOf(fecha));
            crearFactura.executeUpdate();
            
            //Los muebles se asignan a la factura
            int idFactura;
            ResultSet id = crearFactura.getGeneratedKeys();
            if (id.next()) {
                idFactura = id.getInt(1);
            }else{
                throw new SQLException();
            }
            
            for (Integer idMueble : idMuebles) {
                //Se obtiene el nombre y precio del mueble actual
                PreparedStatement obtenerDatosMueble = connection.prepareStatement("SELECT nombre_mueble,precio_venta FROM mueble WHERE id = ?");
                obtenerDatosMueble.setInt(1, idMueble);
                ResultSet datosMueble = obtenerDatosMueble.executeQuery();
                if (!datosMueble.next()) {
                    throw new NoExisteException();
                }

                float precioMueble = datosMueble.getFloat("precio_venta");
                String nombreMueble = datosMueble.getString("nombre_mueble");
                
                PreparedStatement venderMueble = connection.prepareStatement("INSERT INTO compra(factura,mueble_comprado,precio,nombre_mueble) VALUES (?,?,?,?)");
                venderMueble.setInt(1, idFactura);
                venderMueble.setInt(2, idMueble);
                venderMueble.setFloat(3, precioMueble);
                venderMueble.setString(4, nombreMueble);
                venderMueble.executeUpdate();
            }
            
            //Se aplican los cambios
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            e.printStackTrace();
            throw new SQLException();
        } finally {
            connection.setAutoCommit(true);
        }       
    }
    
    public static void registrarDevolucion(String nit, String usuario, int idFactura, LocalDate fecha, Integer...idMuebles) throws SQLException, NoExisteException, FueraDeFechaException, ConflictException{
        //Se comprueba que la factura exista
        PreparedStatement obtenerFactura = connection.prepareStatement("SELECT * FROM factura WHERE id = ?");
        obtenerFactura.setInt(1, idFactura);
        ResultSet facturas = obtenerFactura.executeQuery();
        if (!facturas.next()) {
            throw new NoExisteException();
        }
        
        //Si la factura existe se comprararan fechas entre la fecha de compra y la fecha de devolucion
        LocalDate fechaCompra = facturas.getDate("fecha").toLocalDate();
        
        PreparedStatement obtenerDiferencia = connection.prepareStatement("SELECT DATEDIFF(?,?) as dias");
        obtenerDiferencia.setDate(1, Date.valueOf(fechaCompra));
        obtenerDiferencia.setDate(2, Date.valueOf(fecha));
        ResultSet diferencia = obtenerDiferencia.executeQuery();
        if (diferencia.next()) {
            if (diferencia.getInt("dias")< -7) { //En caso de que haya pasado mas de una semana desde la compra se tirara un error
                throw new FueraDeFechaException();
            }
        }
        
        //Se comprueba que no hayan valores duplicados en los id
        for (int i = 0; i < idMuebles.length; i++) {
            for (int j = 0; j < idMuebles.length; j++) {
                if (idMuebles[i].equals(idMuebles[j]) && i != j) {
                    throw new ConflictException();
                }
            }
        }
        
        //Se comprueba que los muebles ingresados pertenezcan a la factura ingresada
        for (Integer idMueble : idMuebles) {
        PreparedStatement obtenerMuebles = connection.prepareStatement("SELECT factura.id, compra.mueble_comprado FROM factura "+
                                                                       "JOIN compra ON factura.id = compra.factura WHERE compra.mueble_comprado = ?");     
            obtenerMuebles.setInt(1, idMueble);
            ResultSet mueble = obtenerMuebles.executeQuery();
            if (!mueble.next()) {
                throw new NoExisteException();
            }
        }
        
        //En caso contrario se creara un nuevo comprobante de devolucion con los muebles devueltos
        try {
            connection.setAutoCommit(false);
            
            //Se comprueba que los id de todos los muebles no han sido devueltos previamente
            String statement = "SELECT mueble_devuelto FROM devolucion WHERE mueble_devuelto IN (";
            for (int i = 0; i < idMuebles.length-1; i++) {statement += "?,";}
            statement+="?)";
            PreparedStatement obtenerDevolucionMueble = connection.prepareStatement(statement);
            for (int i = 0; i < idMuebles.length; i++) {
                obtenerDevolucionMueble.setInt(i+1, idMuebles[i]);
            }
            ResultSet mueblesDevueltos = obtenerDevolucionMueble.executeQuery();
            if (mueblesDevueltos.next()) {
                throw new ConflictException();
            }
            
            //Si ninguno de los muebles ha sido vendido se registraran en un nuevo comprobante de devolucion
            PreparedStatement crearComprobante = connection.prepareStatement("INSERT INTO comprobante_devolucion(cliente,encargado,fecha) VALUES (?,?,?)", Statement.RETURN_GENERATED_KEYS);
            crearComprobante.setString(1, nit);
            crearComprobante.setString(2, usuario);
            crearComprobante.setDate(3, Date.valueOf(fecha));
            crearComprobante.executeUpdate();
            
            //Los muebles se asignan al comprobante
            int idComprobante;
            ResultSet id = crearComprobante.getGeneratedKeys();
            if (id.next()) {
                idComprobante = id.getInt(1);
            }else{
                throw new SQLException();
            }
            
            for (Integer idMueble : idMuebles) {
                //Se obtiene el nombre y costo del mueble actual
                PreparedStatement obtenerDatosMueble = connection.prepareStatement("SELECT SUM(costo) as costo, nombre_mueble FROM pieza_de_madera, mueble "+
                                                                                   "WHERE mueble.id = ? AND pieza_de_madera.mueble = ?");
                obtenerDatosMueble.setInt(1, idMueble);
                obtenerDatosMueble.setInt(2, idMueble);
                ResultSet datosMueble = obtenerDatosMueble.executeQuery();
                if (!datosMueble.next()) {
                    throw new NoExisteException();
                }

                float costoMueble = datosMueble.getFloat("costo");
                String nombreMueble = datosMueble.getString("nombre_mueble");
                
                PreparedStatement venderMueble = connection.prepareStatement("INSERT INTO devolucion(comprobante,mueble_devuelto,costo,nombre_mueble)"+
                                                                             "VALUES (?,?,?,?)");
                venderMueble.setInt(1, idComprobante);
                venderMueble.setInt(2, idMueble);
                venderMueble.setFloat(3, costoMueble);
                venderMueble.setString(4, nombreMueble);
                venderMueble.executeUpdate();

                //Se desasignan las piezas que pertenecian al mueble "desensamblandolo"
                PreparedStatement desasignarPiezas = connection.prepareStatement("UPDATE pieza_de_madera SET mueble = NULL WHERE mueble = ?");
                desasignarPiezas.setInt(1, idMueble);
                desasignarPiezas.executeUpdate();
            }
            
            //Se aplican los cambios
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            e.printStackTrace();
            throw new SQLException();
        } finally {
            connection.setAutoCommit(true);
        }       
    }
    
    public static ResultSet obtenerDatosFactura(int numeroFactura) throws SQLException, NoExisteException{
        PreparedStatement obtenerFactura = connection.prepareStatement("SELECT factura.*, compra.*, devolucion.comprobante FROM factura "+
                                                                       "JOIN compra ON factura.id = compra.factura "+
                                                                       "LEFT JOIN devolucion ON compra.mueble_comprado = devolucion.mueble_devuelto "+
                                                                       "WHERE factura.id = ?");
        obtenerFactura.setInt(1, numeroFactura);
        ResultSet factura = obtenerFactura.executeQuery();
        if (!factura.next()) {
            throw new NoExisteException();
        }
        factura.beforeFirst();
        return factura;
    }
    
    public static ResultSet obtenerMueblesSalaVentas() throws SQLException{
        PreparedStatement obtenerMueblesSalaVentas = connection.prepareStatement("SELECT id, nombre_mueble, precio_venta FROM mueble "+
                                                                                 "WHERE id NOT IN "+
                                                                                 "(SELECT mueble_comprado FROM compra) "+
                                                                                 "AND id IN "+
                                                                                 "(SELECT mueble FROM pieza_de_madera)");
        return obtenerMueblesSalaVentas.executeQuery();
    }
    
    public static ResultSet obtenerComprasCliente(String nitCliente, LocalDate primerFecha, LocalDate segundaFecha) throws SQLException{
        PreparedStatement obtenerCompras = connection.prepareStatement("SELECT mueble_comprado AS id, nombre_mueble, precio, fecha FROM factura "+
                                                                       "JOIN compra ON factura.id = compra.factura "+
                                                                       "WHERE cliente = ? AND fecha BETWEEN ? AND ? ");
        obtenerCompras.setString(1, nitCliente);
        //
        //Si la fecha de inicio esta antes de la del final
        if (primerFecha.isBefore(segundaFecha)) {
            obtenerCompras.setDate(2, Date.valueOf(primerFecha));
            obtenerCompras.setDate(3, Date.valueOf(segundaFecha));
        //Si la fecha del final esta antes de la del principio
        } else if (segundaFecha.isBefore(primerFecha)) {
            obtenerCompras.setDate(2, Date.valueOf(segundaFecha));
            obtenerCompras.setDate(3, Date.valueOf(primerFecha));
        //Si ambas fechas con iguales
        } else {
            obtenerCompras.setDate(2, Date.valueOf(primerFecha));
            obtenerCompras.setDate(3, Date.valueOf(segundaFecha));
        }
        return obtenerCompras.executeQuery();
    }
    
    public static ResultSet obtenerComprasCliente(String nitCliente) throws SQLException{
        PreparedStatement obtenerCompras = connection.prepareStatement("SELECT mueble_comprado AS id, nombre_mueble, precio, fecha "+
                                                                       "FROM factura JOIN compra ON factura.id = compra.factura "+
                                                                       "WHERE cliente = ? ");
        obtenerCompras.setString(1, nitCliente);
        return obtenerCompras.executeQuery();
    }

    public static ResultSet obtenerDevolucionesCliente(String nitCliente, LocalDate primerFecha, LocalDate segundaFecha) throws SQLException{
        PreparedStatement obtenerCompras = connection.prepareStatement("SELECT mueble_devuelto AS id, nombre_mueble, costo, fecha FROM comprobante_devolucion "+
                                                                       "JOIN devolucion ON comprobante_devolucion.id = devolucion.comprobante "+
                                                                       "WHERE cliente = ? AND fecha BETWEEN ? AND ? ");
        obtenerCompras.setString(1, nitCliente);
        //
        //Si la fecha de inicio esta antes de la del final
        if (primerFecha.isBefore(segundaFecha)) {
            obtenerCompras.setDate(2, Date.valueOf(primerFecha));
            obtenerCompras.setDate(3, Date.valueOf(segundaFecha));
        //Si la fecha del final esta antes de la del principio
        } else if (segundaFecha.isBefore(primerFecha)) {
            obtenerCompras.setDate(2, Date.valueOf(segundaFecha));
            obtenerCompras.setDate(3, Date.valueOf(primerFecha));
        //Si ambas fechas con iguales
        } else {
            obtenerCompras.setDate(2, Date.valueOf(primerFecha));
            obtenerCompras.setDate(3, Date.valueOf(segundaFecha));
        }
        return obtenerCompras.executeQuery();
    }
    

    public static ResultSet obtenerDevolucionesCliente(String nitCliente) throws SQLException{
        PreparedStatement obtenerCompras = connection.prepareStatement("SELECT mueble_devuelto AS id, nombre_mueble, costo, fecha FROM comprobante_devolucion "+
                                                                       "JOIN devolucion ON comprobante_devolucion.id = devolucion.comprobante "+
                                                                       "WHERE cliente = ? ");
        obtenerCompras.setString(1, nitCliente);
        return obtenerCompras.executeQuery();
    }
    
    public static ResultSet obtenerNitClientes() throws SQLException{
        PreparedStatement obtenerNit = connection.prepareStatement("SELECT nit FROM cliente");
        return obtenerNit.executeQuery();
    }
    
    public static ResultSet obtenerDetallesFactura(int factura) throws SQLException, NoExisteException{
        //Se comprueba que la factura exista
        PreparedStatement obtenerFactura = connection.prepareStatement("SELECT * FROM factura WHERE id = ?");
        obtenerFactura.setInt(1, factura);
        ResultSet facturaObtenida = obtenerFactura.executeQuery();
        if (!facturaObtenida.next()) {
            throw new NoExisteException();
        }
        facturaObtenida.beforeFirst();
        return facturaObtenida;
    }
    
    public static ResultSet obtenerComprasFactura(int factura) throws SQLException{
        PreparedStatement obtenerCompras = connection.prepareStatement("SELECT * FROM compra WHERE factura = ?");
        obtenerCompras.setInt(1, factura);
        return obtenerCompras.executeQuery();
    }
    
    public static ResultSet ventasDelDia() throws SQLException{
        PreparedStatement obtenerVentas = connection.prepareStatement("SELECT factura, mueble_comprado AS id, precio, nombre_mueble FROM compra "+
                                                                      "JOIN factura ON compra.factura = factura.id WHERE fecha = ?");
        obtenerVentas.setDate(1, Date.valueOf(LocalDate.now()));
        return obtenerVentas.executeQuery();
    }
}
