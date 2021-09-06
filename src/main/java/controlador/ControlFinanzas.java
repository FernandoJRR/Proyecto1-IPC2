package controlador;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

public class ControlFinanzas {
    static Connection connection = ConexionBD.getConnection();
    
    public static ResultSet reporteVentas(LocalDate fechaDesde, LocalDate fechaHasta) throws SQLException{
        PreparedStatement obtenerVentas = connection.prepareStatement("SELECT mueble_comprado AS id, nombre_mueble, precio, factura.fecha AS fecha_venta FROM compra "+ 
                                                                      "JOIN factura ON compra.factura = factura.id WHERE factura.fecha BETWEEN ? AND ?");
        
        //Si la fecha de inicio esta antes de la del final
        if (fechaDesde.isBefore(fechaHasta)) {
            obtenerVentas.setDate(1, Date.valueOf(fechaDesde));
            obtenerVentas.setDate(2, Date.valueOf(fechaHasta));
        //Si la fecha del final esta antes de la del principio
        } else if (fechaHasta.isBefore(fechaDesde)) {
            obtenerVentas.setDate(1, Date.valueOf(fechaHasta));
            obtenerVentas.setDate(2, Date.valueOf(fechaDesde));
        //Si ambas fechas con iguales
        } else {
            obtenerVentas.setDate(1, Date.valueOf(fechaDesde));
            obtenerVentas.setDate(2, Date.valueOf(fechaHasta));
        }
        return obtenerVentas.executeQuery();
    }
    
    public static ResultSet reporteVentas() throws SQLException{
        PreparedStatement obtenerVentas = connection.prepareStatement("SELECT mueble_comprado AS id, nombre_mueble, precio, factura.fecha AS fecha_venta FROM compra "+ 
                                                                      "JOIN factura ON compra.factura = factura.id");
        return obtenerVentas.executeQuery();
    }
    
    public static ResultSet reporteDevoluciones(LocalDate fechaDesde, LocalDate fechaHasta) throws SQLException{
        PreparedStatement obtenerVentas = connection.prepareStatement("SELECT mueble_comprado AS id, nombre_mueble, precio, factura.fecha AS fecha_venta, d.fecha_devolucion, d.perdida "+
                                                                      "FROM compra JOIN factura ON compra.factura = factura.id "+
                                                                      "INNER JOIN "+
                                                                      "( "+
                                                                      "SELECT devolucion.mueble_devuelto AS id_devuelto, ROUND(devolucion.costo/3, 2) AS perdida, comprobante_devolucion.fecha AS fecha_devolucion "+
                                                                      "FROM devolucion "+
                                                                      "JOIN comprobante_devolucion ON devolucion.comprobante = comprobante_devolucion.id "+
                                                                      ") d "+
                                                                      "ON compra.mueble_comprado = d.id_devuelto "+
                                                                      "WHERE d.fecha_devolucion BETWEEN ? AND ?");
        
        //Si la fecha de inicio esta antes de la del final
        if (fechaDesde.isBefore(fechaHasta)) {
            obtenerVentas.setDate(1, Date.valueOf(fechaDesde));
            obtenerVentas.setDate(2, Date.valueOf(fechaHasta));
        //Si la fecha del final esta antes de la del principio
        } else if (fechaHasta.isBefore(fechaDesde)) {
            obtenerVentas.setDate(1, Date.valueOf(fechaHasta));
            obtenerVentas.setDate(2, Date.valueOf(fechaDesde));
        //Si ambas fechas con iguales
        } else {
            obtenerVentas.setDate(1, Date.valueOf(fechaDesde));
            obtenerVentas.setDate(2, Date.valueOf(fechaHasta));
        }
        return obtenerVentas.executeQuery();
    }
    
    public static ResultSet reporteDevoluciones() throws SQLException{
        PreparedStatement obtenerVentas = connection.prepareStatement("SELECT mueble_comprado AS id, nombre_mueble, precio, factura.fecha AS fecha_venta, d.fecha_devolucion, d.perdida "+
                                                                      "FROM compra JOIN factura ON compra.factura = factura.id "+
                                                                      "INNER JOIN "+
                                                                      "( "+
                                                                      "SELECT devolucion.mueble_devuelto AS id_devuelto, ROUND(devolucion.costo/3, 2) AS perdida, comprobante_devolucion.fecha AS fecha_devolucion "+
                                                                      "FROM devolucion "+
                                                                      "JOIN comprobante_devolucion ON devolucion.comprobante = comprobante_devolucion.id "+
                                                                      ") d "+
                                                                      "ON compra.mueble_comprado = d.id_devuelto");
        return obtenerVentas.executeQuery();
    }
    
    public static ResultSet reporteGanancias(LocalDate fechaDesde, LocalDate fechaHasta) throws SQLException{
        PreparedStatement obtenerVentas = connection.prepareStatement("SELECT compra.mueble_comprado AS id, compra.nombre_mueble, compra.precio, factura.fecha, compra.precio-SUM(pieza_de_madera.costo) AS ganancia "+
                                                                      "FROM compra "+
                                                                      "JOIN factura ON compra.factura = factura.id "+
                                                                      "LEFT JOIN pieza_de_madera ON compra.mueble_comprado = pieza_de_madera.mueble "+
                                                                      "WHERE fecha BETWEEN ? AND ? "+
                                                                      "GROUP BY pieza_de_madera.mueble");
        //Si la fecha de inicio esta antes de la del final
        if (fechaDesde.isBefore(fechaHasta)) {
            obtenerVentas.setDate(1, Date.valueOf(fechaDesde));
            obtenerVentas.setDate(2, Date.valueOf(fechaHasta));
        //Si la fecha del final esta antes de la del principio
        } else if (fechaHasta.isBefore(fechaDesde)) {
            obtenerVentas.setDate(1, Date.valueOf(fechaHasta));
            obtenerVentas.setDate(2, Date.valueOf(fechaDesde));
        //Si ambas fechas con iguales
        } else {
            obtenerVentas.setDate(1, Date.valueOf(fechaDesde));
            obtenerVentas.setDate(2, Date.valueOf(fechaHasta));
        }
        return obtenerVentas.executeQuery();
    }
    
    public static Float obtenerGanancia(LocalDate fechaDesde, LocalDate fechaHasta) throws SQLException{
        PreparedStatement obtenerGanancia = connection.prepareStatement("SELECT precio, compra.precio - SUM(pieza_de_madera.costo) AS ganancia FROM compra "+
                                                                        "JOIN factura ON compra.factura = factura.id "+
                                                                        "LEFT JOIN pieza_de_madera ON compra.mueble_comprado = pieza_de_madera.mueble "+
                                                                        "WHERE fecha BETWEEN ? AND ? "+
                                                                        "GROUP BY pieza_de_madera.mueble");
        //Si la fecha de inicio esta antes de la del final
        if (fechaDesde.isBefore(fechaHasta)) {
            obtenerGanancia.setDate(1, Date.valueOf(fechaDesde));
            obtenerGanancia.setDate(2, Date.valueOf(fechaHasta));
        //Si la fecha del final esta antes de la del principio
        } else if (fechaHasta.isBefore(fechaDesde)) {
            obtenerGanancia.setDate(1, Date.valueOf(fechaHasta));
            obtenerGanancia.setDate(2, Date.valueOf(fechaDesde));
        //Si ambas fechas con iguales
        } else {
            obtenerGanancia.setDate(1, Date.valueOf(fechaDesde));
            obtenerGanancia.setDate(2, Date.valueOf(fechaHasta));
        }
        ResultSet ganancias =  obtenerGanancia.executeQuery();
        float gananciaTotal = 0;
        while (ganancias.next()) {
            if (ganancias.getString("ganancia")==null) {
                gananciaTotal += ganancias.getFloat("precio")/3;
            } else {
                gananciaTotal += ganancias.getFloat("ganancia");
            }
        }
        return gananciaTotal;
    }
    
    public static ResultSet reporteGanancias() throws SQLException{
        PreparedStatement obtenerVentas = connection.prepareStatement("SELECT compra.mueble_comprado AS id, compra.nombre_mueble, compra.precio, factura.fecha, compra.precio-SUM(pieza_de_madera.costo) AS ganancia "+
                                                                      "FROM compra "+
                                                                      "JOIN factura ON compra.factura = factura.id "+
                                                                      "LEFT JOIN pieza_de_madera ON compra.mueble_comprado = pieza_de_madera.mueble "+
                                                                      "GROUP BY pieza_de_madera.mueble");
        return obtenerVentas.executeQuery();
    }
    
    public static Float obtenerGanancia() throws SQLException{
        PreparedStatement obtenerGanancia = connection.prepareStatement("SELECT precio, compra.precio - SUM(pieza_de_madera.costo) AS ganancia FROM compra "+
                                                                        "JOIN factura ON compra.factura = factura.id "+
                                                                        "LEFT JOIN pieza_de_madera ON compra.mueble_comprado = pieza_de_madera.mueble "+
                                                                        "GROUP BY pieza_de_madera.mueble");
        
        ResultSet ganancias = obtenerGanancia.executeQuery();
        float gananciaTotal = 0;
        while (ganancias.next()) {
            if (ganancias.getString("ganancia")==null) {
                gananciaTotal += ganancias.getFloat("precio")/3;
            } else {
                gananciaTotal += ganancias.getFloat("ganancia");
            }
        }
        return gananciaTotal;
    }

    public static ResultSet obtenerRankingVentas(LocalDate fechaDesde, LocalDate fechaHasta) throws SQLException{
        PreparedStatement obtenerRanking = connection.prepareStatement("SELECT usuario.username, COUNT(*) AS ventas FROM usuario "+
                                                                       "JOIN factura ON usuario.username = factura.encargado "+
                                                                       "JOIN compra ON factura.id = compra.factura "+ 
                                                                       "WHERE factura.fecha BETWEEN ? AND ? "+
                                                                       "GROUP BY usuario.username ORDER BY ventas DESC");
        
        //Si la fecha de inicio esta antes de la del final
        if (fechaDesde.isBefore(fechaHasta)) {
            obtenerRanking.setDate(1, Date.valueOf(fechaDesde));
            obtenerRanking.setDate(2, Date.valueOf(fechaHasta));
        //Si la fecha del final esta antes de la del principio
        } else if (fechaHasta.isBefore(fechaDesde)) {
            obtenerRanking.setDate(1, Date.valueOf(fechaHasta));
            obtenerRanking.setDate(2, Date.valueOf(fechaDesde));
        //Si ambas fechas con iguales
        } else {
            obtenerRanking.setDate(1, Date.valueOf(fechaDesde));
            obtenerRanking.setDate(2, Date.valueOf(fechaHasta));
        }

        return obtenerRanking.executeQuery();
    }
    
    public static ResultSet obtenerRankingVentas() throws SQLException{
        PreparedStatement obtenerRanking = connection.prepareStatement("SELECT usuario.username, COUNT(*) AS ventas FROM usuario "+
                                                                       "JOIN factura ON usuario.username = factura.encargado "+
                                                                       "JOIN compra ON factura.id = compra.factura "+ 
                                                                       "GROUP BY usuario.username ORDER BY ventas DESC");
        return obtenerRanking.executeQuery();
    }
    
    public static ResultSet obtenerVentasPorUsuario(String username, LocalDate fechaDesde, LocalDate fechaHasta) throws SQLException{
        PreparedStatement obtenerVentas = connection.prepareStatement("SELECT compra.mueble_comprado AS id, nombre_mueble, compra.precio-SUM(pieza_de_madera.costo) AS ganancia, fecha, precio "+
                                                                      "FROM compra JOIN factura ON compra.factura = factura.id "+
                                                                      "LEFT JOIN pieza_de_madera ON compra.mueble_comprado = pieza_de_madera.mueble "+
                                                                      "WHERE encargado = ? AND fecha BETWEEN ? AND ? "+
                                                                      "GROUP BY compra.mueble_comprado");

        obtenerVentas.setString(1, username);
        
        //Si la fecha de inicio esta antes de la del final
        if (fechaDesde.isBefore(fechaHasta)) {
            obtenerVentas.setDate(2, Date.valueOf(fechaDesde));
            obtenerVentas.setDate(3, Date.valueOf(fechaHasta));
        //Si la fecha del final esta antes de la del principio
        } else if (fechaHasta.isBefore(fechaDesde)) {
            obtenerVentas.setDate(2, Date.valueOf(fechaHasta));
            obtenerVentas.setDate(3, Date.valueOf(fechaDesde));
        //Si ambas fechas con iguales
        } else {
            obtenerVentas.setDate(2, Date.valueOf(fechaDesde));
            obtenerVentas.setDate(3, Date.valueOf(fechaHasta));
        }

        return obtenerVentas.executeQuery();
    }
    
    public static ResultSet obtenerVentasPorUsuario(String username) throws SQLException{
        PreparedStatement obtenerVentas = connection.prepareStatement("SELECT compra.mueble_comprado AS id, nombre_mueble, compra.precio-SUM(pieza_de_madera.costo) AS ganancia, fecha, precio "+
                                                                      "FROM compra JOIN factura ON compra.factura = factura.id "+
                                                                      "LEFT JOIN pieza_de_madera ON compra.mueble_comprado = pieza_de_madera.mueble "+
                                                                      "WHERE encargado = ? "+
                                                                      "GROUP BY compra.mueble_comprado");

        obtenerVentas.setString(1, username);
        return obtenerVentas.executeQuery();
    }
    
    public static ResultSet obtenerRankingGanancias(LocalDate fechaDesde, LocalDate fechaHasta) throws SQLException{
        PreparedStatement obtenerRanking = connection.prepareStatement("SELECT usuario.username, SUM(compra.precio) AS ganancia FROM usuario "+
                                                                       "JOIN factura ON usuario.username = factura.encargado "+
                                                                       "JOIN compra ON factura.id = compra.factura "+ 
                                                                       "WHERE factura.fecha BETWEEN ? AND ? "+
                                                                       "GROUP BY usuario.username ORDER BY ganancia DESC");

        //Si la fecha de inicio esta antes de la del final
        if (fechaDesde.isBefore(fechaHasta)) {
            obtenerRanking.setDate(1, Date.valueOf(fechaDesde));
            obtenerRanking.setDate(2, Date.valueOf(fechaHasta));
        //Si la fecha del final esta antes de la del principio
        } else if (fechaHasta.isBefore(fechaDesde)) {
            obtenerRanking.setDate(1, Date.valueOf(fechaHasta));
            obtenerRanking.setDate(2, Date.valueOf(fechaDesde));
        //Si ambas fechas con iguales
        } else {
            obtenerRanking.setDate(1, Date.valueOf(fechaDesde));
            obtenerRanking.setDate(2, Date.valueOf(fechaHasta));
        }
        
        return obtenerRanking.executeQuery();
    }
    
    public static ResultSet obtenerRankingGanancias() throws SQLException{
        PreparedStatement obtenerRanking = connection.prepareStatement("SELECT usuario.username, SUM(compra.precio) AS ganancia FROM usuario "+
                                                                       "JOIN factura ON usuario.username = factura.encargado "+
                                                                       "JOIN compra ON factura.id = compra.factura "+ 
                                                                       "GROUP BY usuario.username ORDER BY ganancia DESC");
        return obtenerRanking.executeQuery();
    }
    
    public static ResultSet rankingVentasMuebles(boolean orden, LocalDate fechaDesde, LocalDate fechaHasta) throws SQLException{
        String statement = "SELECT nombre_mueble, COUNT(*) as ventas FROM compra "+
                           "JOIN factura ON compra.factura = factura.id "+
                           "WHERE factura.fecha BETWEEN ? AND ? GROUP BY nombre_mueble ORDER BY ventas ";
        
        //Si orden es true significa que se ordenara de manera descendente, caso contrario de manera ascendente
        if (orden) {
            statement += "DESC";
        } else {
            statement += "ASC";
        }
        PreparedStatement obtenerRanking = connection.prepareStatement(statement);
        
        //Si la fecha de inicio esta antes de la del final
        if (fechaDesde.isBefore(fechaHasta)) {
            obtenerRanking.setDate(1, Date.valueOf(fechaDesde));
            obtenerRanking.setDate(2, Date.valueOf(fechaHasta));
        //Si la fecha del final esta antes de la del principio
        } else if (fechaHasta.isBefore(fechaDesde)) {
            obtenerRanking.setDate(1, Date.valueOf(fechaHasta));
            obtenerRanking.setDate(2, Date.valueOf(fechaDesde));
        //Si ambas fechas con iguales
        } else {
            obtenerRanking.setDate(1, Date.valueOf(fechaDesde));
            obtenerRanking.setDate(2, Date.valueOf(fechaHasta));
        }
        
        return obtenerRanking.executeQuery();
    }
    
    public static ResultSet rankingVentasMuebles(boolean orden) throws SQLException{
        String statement = "SELECT nombre_mueble, COUNT(*) as ventas FROM compra "+
                           "JOIN factura ON compra.factura = factura.id "+
                           "GROUP BY nombre_mueble ORDER BY ventas ";
        
        //Si orden es true significa que se ordenara de manera descendente, caso contrario de manera ascendente
        if (orden) {
            statement += "DESC";
        } else {
            statement += "ASC";
        }
        PreparedStatement obtenerRanking = connection.prepareStatement(statement);
        
        return obtenerRanking.executeQuery();
    }
    
    public static ResultSet obtenerVentasMuebles(String nombreModeloMueble, LocalDate fechaDesde, LocalDate fechaHasta) throws SQLException{
        PreparedStatement obtenerVentas = connection.prepareStatement("SELECT mueble_comprado AS id, nombre_mueble, precio, factura.fecha FROM compra "+
                                                                      "JOIN factura ON compra.factura = factura.id "+
                                                                      "WHERE nombre_mueble = ? AND "+
                                                                      "factura.fecha BETWEEN ? AND ?");
        
        obtenerVentas.setString(1, nombreModeloMueble);
        
        //Si la fecha de inicio esta antes de la del final
        if (fechaDesde.isBefore(fechaHasta)) {
            obtenerVentas.setDate(2, Date.valueOf(fechaDesde));
            obtenerVentas.setDate(3, Date.valueOf(fechaHasta));
        //Si la fecha del final esta antes de la del principio
        } else if (fechaHasta.isBefore(fechaDesde)) {
            obtenerVentas.setDate(2, Date.valueOf(fechaHasta));
            obtenerVentas.setDate(3, Date.valueOf(fechaDesde));
        //Si ambas fechas con iguales
        } else {
            obtenerVentas.setDate(2, Date.valueOf(fechaDesde));
            obtenerVentas.setDate(3, Date.valueOf(fechaHasta));
        }
        return obtenerVentas.executeQuery();
    }
    
    public static ResultSet obtenerVentasMuebles(String nombreModeloMueble) throws SQLException{
        PreparedStatement obtenerVentas = connection.prepareStatement("SELECT mueble_comprado AS id, nombre_mueble, precio, factura.fecha FROM compra "+
                                                                      "JOIN factura ON compra.factura = factura.id WHERE nombre_mueble = ?");
        obtenerVentas.setString(1, nombreModeloMueble);
        return obtenerVentas.executeQuery();
    }
    
    public static ResultSet obtenerLineasCargadas() throws SQLException{
        PreparedStatement obtenerLineas = connection.prepareStatement("SELECT * FROM ultimas_lineas_cargadas");
        return obtenerLineas.executeQuery();
    }
    
    public static ResultSet obtenerLineasConError() throws SQLException{
        PreparedStatement obtenerLineas = connection.prepareStatement("SELECT * FROM ultimos_errores");
        return obtenerLineas.executeQuery();
    }
}
