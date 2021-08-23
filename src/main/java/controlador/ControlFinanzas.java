package controlador;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

import org.mariadb.jdbc.internal.util.dao.PrepareResult;

public class ControlFinanzas {
    static Connection connection = ConexionBD.getConnection();
    
    static ResultSet reporteVentas(LocalDate fechaDesde, LocalDate fechaHasta) throws SQLException{
        PreparedStatement obtenerVentas = connection.prepareStatement("SELECT mueble_comprado AS id, nombre_mueble, precio, factura.fecha AS fecha_venta FROM compra"+ 
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
    
    static ResultSet reporteDevoluciones(LocalDate fechaDesde, LocalDate fechaHasta) throws SQLException{
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
    
    static ResultSet reporteGanancias(LocalDate fechaDesde, LocalDate fechaHasta) throws SQLException{
        PreparedStatement obtenerVentas = connection.prepareStatement("SELECT compra.mueble_comprado AS id, compra.nombre_mueble, compra.precio, factura.fecha "+
                                                                      "FROM compra JOIN factura ON compra.factura = factura.id "+
                                                                      "WHERE factura.fecha BETWEEN ? AND ?");
        
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
    
    static ResultSet ventasPorUsuario(){
    }
}
