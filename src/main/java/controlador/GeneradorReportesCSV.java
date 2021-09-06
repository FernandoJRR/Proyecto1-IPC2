package controlador;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.ResourceBundle.Control;

public class GeneradorReportesCSV {
    public static ArrayList<String> generarReporteVentas() throws SQLException {
        ArrayList<String> lineasCSV = new ArrayList<>();
        ResultSet reporteVentas = ControlFinanzas.reporteVentas();
        lineasCSV.add("Id Mueble,Nombre Mueble,Precio Venta,Fecha Venta");
        while (reporteVentas.next()) {
            String idMueble = reporteVentas.getString("id");
            String nombreMueble = reporteVentas.getString("nombre_mueble");
            String precio = reporteVentas.getString("precio");
            String fechaVenta = reporteVentas.getString("fecha_venta");
            lineasCSV.add(idMueble+","+nombreMueble+","+precio+","+fechaVenta);
        }
        return lineasCSV;
    }
    
    public static ArrayList<String> generarReporteVentas(LocalDate fechaPrimera, LocalDate fechaSegunda) throws SQLException{
        ArrayList<String> lineasCSV = new ArrayList<>();
        ResultSet reporteVentas = ControlFinanzas.reporteVentas(fechaPrimera, fechaSegunda);
        lineasCSV.add("Id Mueble,Nombre Mueble,Precio Venta,Fecha Venta");
        while (reporteVentas.next()) {
            String idMueble = reporteVentas.getString("id");
            String nombreMueble = reporteVentas.getString("nombre_mueble");
            String precio = reporteVentas.getString("precio");
            String fechaVenta = reporteVentas.getString("fecha_venta");
            lineasCSV.add(idMueble+","+nombreMueble+","+precio+","+fechaVenta);
        }
        return lineasCSV;
    }
    
    public static ArrayList<String> generarReporteDevoluciones() throws SQLException{
        ArrayList<String> lineasCSV = new ArrayList<>();
        ResultSet reporteDevoluciones = ControlFinanzas.reporteDevoluciones();
        lineasCSV.add("Id Mueble,Nombre Mueble,Precio Venta,Fecha Venta,Fecha Devolucion,Perdidas");
        while (reporteDevoluciones.next()) {
            String idMueble = reporteDevoluciones.getString("id");
            String nombreMueble = reporteDevoluciones.getString("nombre_mueble");
            String precio = reporteDevoluciones.getString("precio");
            String fechaVenta = reporteDevoluciones.getString("fecha_venta");
            String fechaDevolucion = reporteDevoluciones.getString("fecha_devolucion");
            String perdida = reporteDevoluciones.getString("perdida");
            lineasCSV.add(idMueble+","+nombreMueble+","+precio+","+fechaVenta+","+fechaDevolucion+","+perdida);
        }
        return lineasCSV;
    }

    public static ArrayList<String> generarReporteDevoluciones(LocalDate primerFecha, LocalDate segundaFecha) throws SQLException{
        ArrayList<String> lineasCSV = new ArrayList<>();
        ResultSet reporteDevoluciones = ControlFinanzas.reporteDevoluciones(primerFecha, segundaFecha);
        lineasCSV.add("Id Mueble,Nombre Mueble,Precio Venta,Fecha Venta,Fecha Devolucion,Perdidas");
        while (reporteDevoluciones.next()) {
            String idMueble = reporteDevoluciones.getString("id");
            String nombreMueble = reporteDevoluciones.getString("nombre_mueble");
            String precio = reporteDevoluciones.getString("precio");
            String fechaVenta = reporteDevoluciones.getString("fecha_venta");
            String fechaDevolucion = reporteDevoluciones.getString("fecha_devolucion");
            String perdida = reporteDevoluciones.getString("perdida");
            lineasCSV.add(idMueble+","+nombreMueble+","+precio+","+fechaVenta+","+fechaDevolucion+","+perdida);
        }
        return lineasCSV;
    }

    public static ArrayList<String> generarReporteGanancias() throws SQLException{
        ArrayList<String> lineasCSV = new ArrayList<>();
        ResultSet reporteGanancias = ControlFinanzas.reporteGanancias();
        lineasCSV.add("Id Mueble,Nombre Mueble,Ganancia,Fecha Venta");
        while (reporteGanancias.next()) {
            String idMueble = reporteGanancias.getString("id");
            String nombreMueble = reporteGanancias.getString("nombre_mueble");
            
            Float ganancia = null;
            if (reporteGanancias.getString("ganancia")!=null) {
                ganancia = reporteGanancias.getFloat("ganancia");
            } else {
                ganancia = reporteGanancias.getFloat("precio");
            }
            DecimalFormat df = new DecimalFormat("###.##");
			ganancia = Float.valueOf(df.format(ganancia));

            String fechaVenta = reporteGanancias.getString("fecha");
            lineasCSV.add(idMueble+","+nombreMueble+","+ganancia+","+fechaVenta);
        }
        Float gananciasTotales = ControlFinanzas.obtenerGanancia();
        DecimalFormat df = new DecimalFormat("###.##");
        gananciasTotales = Float.valueOf(df.format(gananciasTotales));
        lineasCSV.add("Ganancias Totales"+","+","+gananciasTotales+",");
        
        return lineasCSV;
    }
    
    public static ArrayList<String> generarReporteGanancias(LocalDate primerFecha, LocalDate segundaFecha) throws SQLException{
        ArrayList<String> lineasCSV = new ArrayList<>();
        ResultSet reporteGanancias = ControlFinanzas.reporteGanancias(primerFecha, segundaFecha);
        lineasCSV.add("Id Mueble,Nombre Mueble,Ganancia,Fecha Venta");
        while (reporteGanancias.next()) {
            String idMueble = reporteGanancias.getString("id");
            String nombreMueble = reporteGanancias.getString("nombre_mueble");
            
            Float ganancia = null;
            if (reporteGanancias.getString("ganancia")!=null) {
                ganancia = reporteGanancias.getFloat("ganancia");
            } else {
                ganancia = reporteGanancias.getFloat("precio");
            }
            DecimalFormat df = new DecimalFormat("###.##");
			ganancia = Float.valueOf(df.format(ganancia));

            String fechaVenta = reporteGanancias.getString("fecha");
            lineasCSV.add(idMueble+","+nombreMueble+","+ganancia+","+fechaVenta);
        }
        Float gananciasTotales = ControlFinanzas.obtenerGanancia(primerFecha, segundaFecha);
        DecimalFormat df = new DecimalFormat("###.##");
        gananciasTotales = Float.valueOf(df.format(gananciasTotales));
        lineasCSV.add("Ganancias Totales"+","+","+gananciasTotales+",");
        
        return lineasCSV;
    }
    
    public static ArrayList<String> generarReporteUsuarioMasVentas() throws SQLException{
        ArrayList<String> lineasCSV = new ArrayList<>();
        ResultSet rankingVentas = ControlFinanzas.obtenerRankingVentas();
        while (rankingVentas.next()) {
            String usuario = rankingVentas.getString("username");
            String ventas = rankingVentas.getString("ventas");
            lineasCSV.add("Usuario"+","+usuario+",,");
            lineasCSV.add("Ventas Realizadas"+","+ventas+",,");
            
            ResultSet ventasUsuario = ControlFinanzas.obtenerVentasPorUsuario(usuario);
            lineasCSV.add("Id Mueble,Nombre Mueble,Precio Venta,Fecha Venta");
            while (ventasUsuario.next()) {
                String id = ventasUsuario.getString("id");
                String nombreMueble = ventasUsuario.getString("nombre_mueble");
                String precio = ventasUsuario.getString("precio");
                String fecha = ventasUsuario.getString("fecha");
                lineasCSV.add(id+","+nombreMueble+","+precio+","+fecha);
            }
            lineasCSV.add("");
        }
        return lineasCSV;
    }
    
    public static ArrayList<String> generarReporteUsuarioMasVentas(LocalDate primerFecha, LocalDate segundaFecha) throws SQLException{
        ArrayList<String> lineasCSV = new ArrayList<>();
        ResultSet rankingVentas = ControlFinanzas.obtenerRankingVentas(primerFecha,segundaFecha);
        while (rankingVentas.next()) {
            String usuario = rankingVentas.getString("username");
            String ventas = rankingVentas.getString("ventas");
            lineasCSV.add("Usuario"+","+usuario+",,");
            lineasCSV.add("Ventas Realizadas"+","+ventas+",,");
            
            ResultSet ventasUsuario = ControlFinanzas.obtenerVentasPorUsuario(usuario,primerFecha,segundaFecha);
            lineasCSV.add("Id Mueble,Nombre Mueble,Precio Venta,Fecha Venta");
            while (ventasUsuario.next()) {
                String id = ventasUsuario.getString("id");
                String nombreMueble = ventasUsuario.getString("nombre_mueble");
                String precio = ventasUsuario.getString("precio");
                String fecha = ventasUsuario.getString("fecha");
                lineasCSV.add(id+","+nombreMueble+","+precio+","+fecha);
            }
            lineasCSV.add("");
        }
        return lineasCSV;
    }
    
    public static ArrayList<String> generarReporteUsuarioMasGanancias() throws SQLException{
        ArrayList<String> lineasCSV = new ArrayList<>();
        ResultSet rankingGanancias = ControlFinanzas.obtenerRankingGanancias();
        rankingGanancias.next();
        String usuario = rankingGanancias.getString("username");
        lineasCSV.add("Usuario"+","+usuario+",,");
        ResultSet ventasUsuario = ControlFinanzas.obtenerVentasPorUsuario(usuario);
        lineasCSV.add("Id Mueble,Nombre Mueble,Ganancia,Fecha Venta");
        float gananciasTotales = 0;
        while (ventasUsuario.next()) {
            String id = ventasUsuario.getString("id");
            String nombreMueble = ventasUsuario.getString("nombre_mueble");
            Float ganancia = null;
            if (ventasUsuario.getString("ganancia")!=null) {
                ganancia = ventasUsuario.getFloat("ganancia"); 
            } else {
                ganancia = ventasUsuario.getFloat("precio")/3; 
            }
            gananciasTotales += ganancia;
            DecimalFormat df = new DecimalFormat("###.##");
            ganancia = Float.valueOf(df.format(ganancia));
            String fecha = ventasUsuario.getString("fecha");
            lineasCSV.add(id+","+nombreMueble+","+ganancia+","+fecha);
        }
        DecimalFormat df = new DecimalFormat("###.##");
        gananciasTotales = Float.valueOf(df.format(gananciasTotales));
        lineasCSV.add("Ganancias Totales,"+gananciasTotales+",,");
        return lineasCSV;
    }

    public static ArrayList<String> generarReporteUsuarioMasGanancias(LocalDate primerFecha, LocalDate segundaFecha) throws SQLException{
        ArrayList<String> lineasCSV = new ArrayList<>();
        ResultSet rankingGanancias = ControlFinanzas.obtenerRankingGanancias(primerFecha,segundaFecha);
        rankingGanancias.next();
        String usuario = rankingGanancias.getString("username");
        lineasCSV.add("Usuario"+","+usuario+",,");
        ResultSet ventasUsuario = ControlFinanzas.obtenerVentasPorUsuario(usuario,primerFecha,segundaFecha);
        lineasCSV.add("Id Mueble,Nombre Mueble,Ganancia,Fecha Venta");
        float gananciasTotales = 0;
        while (ventasUsuario.next()) {
            String id = ventasUsuario.getString("id");
            String nombreMueble = ventasUsuario.getString("nombre_mueble");
            Float ganancia = null;
            if (ventasUsuario.getString("ganancia")!=null) {
                ganancia = ventasUsuario.getFloat("ganancia"); 
            } else {
                ganancia = ventasUsuario.getFloat("precio")/3; 
            }
            gananciasTotales += ganancia;
            DecimalFormat df = new DecimalFormat("###.##");
            ganancia = Float.valueOf(df.format(ganancia));
            String fecha = ventasUsuario.getString("fecha");
            lineasCSV.add(id+","+nombreMueble+","+ganancia+","+fecha);
        }
        DecimalFormat df = new DecimalFormat("###.##");
        gananciasTotales = Float.valueOf(df.format(gananciasTotales));
        lineasCSV.add("Ganancias Totales,"+gananciasTotales+",,");
        return lineasCSV;
    }
    
    public static ArrayList<String> generarReporteMueblesVendidos(boolean orden) throws SQLException{
        ArrayList<String> lineasCSV = new ArrayList<>();
        ResultSet rankingVentas = ControlFinanzas.rankingVentasMuebles(orden);
        while (rankingVentas.next()) {
            String modelo = rankingVentas.getString("nombre_mueble");
            String vecesVendido = rankingVentas.getString("ventas");
            lineasCSV.add("Modelo,"+modelo);
            lineasCSV.add("Ventas,"+vecesVendido);
            ResultSet ventasMuebles = ControlFinanzas.obtenerVentasMuebles(modelo);
            lineasCSV.add("Id Mueble,Nombre Mueble,Precio Venta,Fecha Venta");
            while (ventasMuebles.next()) {
                String id = ventasMuebles.getString("id");
                String nombreMueble = ventasMuebles.getString("nombre_mueble");
                String precio = ventasMuebles.getString("precio");
                String fechaVenta = ventasMuebles.getString("fecha");
                lineasCSV.add(id+","+nombreMueble+","+precio+","+fechaVenta);
            }
            lineasCSV.add("");
        }
        return lineasCSV;
    }

    public static ArrayList<String> generarReporteMueblesVendidos(boolean orden, LocalDate primerFecha, LocalDate segundaFecha) throws SQLException{
        ArrayList<String> lineasCSV = new ArrayList<>();
        ResultSet rankingVentas = ControlFinanzas.rankingVentasMuebles(orden,primerFecha,segundaFecha);
        while (rankingVentas.next()) {
            String modelo = rankingVentas.getString("nombre_mueble");
            String vecesVendido = rankingVentas.getString("ventas");
            lineasCSV.add("Modelo,"+modelo);
            lineasCSV.add("Ventas,"+vecesVendido);
            ResultSet ventasMuebles = ControlFinanzas.obtenerVentasMuebles(modelo,primerFecha,segundaFecha);
            lineasCSV.add("Id Mueble,Nombre Mueble,Precio Venta,Fecha Venta");
            while (ventasMuebles.next()) {
                String id = ventasMuebles.getString("id");
                String nombreMueble = ventasMuebles.getString("nombre_mueble");
                String precio = ventasMuebles.getString("precio");
                String fechaVenta = ventasMuebles.getString("fecha");
                lineasCSV.add(id+","+nombreMueble+","+precio+","+fechaVenta);
            }
            lineasCSV.add("");
        }
        return lineasCSV;
    }
}
