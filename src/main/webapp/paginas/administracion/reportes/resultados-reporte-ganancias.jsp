<%-- 
    Document   : resultados-reporte-ganancias
    Created on : Sep 5, 2021, 8:42:57 PM
    Author     : fernanrod
--%>

<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.File"%>
<%@page import="controlador.GeneradorReportesCSV"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="controlador.ControlFinanzas"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	ResultSet ganancias = null;
	Float gananciasTotales = null;
	try {
		String primerFecha = request.getParameter("primerFecha");
		String segundaFecha = request.getParameter("segundaFecha");

		if (primerFecha.equals("") || segundaFecha.equals("")) {
			ganancias = ControlFinanzas.reporteGanancias();
			gananciasTotales = ControlFinanzas.obtenerGanancia();
		} else {
			DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			ganancias = ControlFinanzas.reporteGanancias(LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
			gananciasTotales = ControlFinanzas.obtenerGanancia(LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
		}
		DecimalFormat df = new DecimalFormat("###.##");
		gananciasTotales = Float.valueOf(df.format(gananciasTotales));
	} catch (SQLException e) {
%><h2>Ha ocurrido un error.</h2><%
		e.printStackTrace();
	}
%>
<h2 class="mt-3">Ganancias</h2>
<table id="mueblesCreadosTabla" class="table table-striped">
    <thead>
	<tr>
	    <th>Id del Mueble</th>
	    <th>Nombre del Mueble</th>
	    <th>Ganancia</th> 
	    <th>Fecha de Venta</th> 
	</tr>
    </thead>
    <tbody>
	<% while (ganancias.next()) {
			int id = ganancias.getInt("id");
			String nombrePieza = ganancias.getString("nombre_mueble");
			Float precio = ganancias.getFloat("precio");
			Float ganancia = ganancias.getFloat("ganancia");
			LocalDate fechaVenta = ganancias.getDate("fecha").toLocalDate();

			DecimalFormat df = new DecimalFormat("###.##");
			precio = Float.valueOf(df.format(precio));
	%>
	<tr>
	    <td><%= id%></td>
	    <td><%= nombrePieza%></td>
	    <%if (ganancias.getString("ganancia") == null) {%>
	    <td>Q.<%= df.format(precio / 3)%></td>
	    <%} else {%>
	    <td>Q.<%= ganancia%></td>
	    <% }%>
	    <td><%= fechaVenta%></td>
	</tr>
	<%
		}%>
    </tbody>
    <tr>
	<th>Ganancias Totales</th>
	<th>Q.<%= gananciasTotales%></th>
    </tr>
</table>
<%
	String primerFecha = request.getParameter("primerFecha");
	String segundaFecha = request.getParameter("segundaFecha");

	ArrayList<String> reporteCSV = null;
	if (primerFecha.equals("") || segundaFecha.equals("")) {
		reporteCSV = GeneradorReportesCSV.generarReporteGanancias();
	} else {
		DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		reporteCSV = GeneradorReportesCSV.generarReporteGanancias(LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
	}

	String path = System.getProperty("user.home") + "/temp.csv";
	File strFile = new File(path);
	boolean fileCreated = strFile.createNewFile();
	//Escritura del archivo personal
	BufferedWriter objWriter = new BufferedWriter(new FileWriter(strFile));
	for (String linea : reporteCSV) {
		objWriter.write(linea);
		objWriter.newLine();
	}
	objWriter.flush();
	objWriter.close();
%>
<a href="servlet-descarga?path=<%= path%>&nombre-archivo=reporte-ganancias"><button type="button" class="btn btn-primary">Descargar</button> </a>