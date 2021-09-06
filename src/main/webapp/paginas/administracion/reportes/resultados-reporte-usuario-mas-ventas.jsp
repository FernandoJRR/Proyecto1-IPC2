<%-- 
    Document   : resultados-reporte-usuario-mas-ventas
    Created on : Sep 5, 2021, 9:55:12 PM
    Author     : fernanrod
--%>

<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.File"%>
<%@page import="controlador.GeneradorReportesCSV"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controlador.ControlFinanzas"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	ResultSet rankingVentas = null;
	String primerFecha = null;
	String segundaFecha = null;
	try {
		primerFecha = request.getParameter("primerFecha");
		segundaFecha = request.getParameter("segundaFecha");

		if (primerFecha.equals("") || segundaFecha.equals("")) {
			rankingVentas = ControlFinanzas.obtenerRankingVentas();
		} else {
			DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			rankingVentas = ControlFinanzas.obtenerRankingVentas(LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
		}

	} catch (SQLException e) {
%><h2>Ha ocurrido un error.</h2><%
		e.printStackTrace();
	}
%>
<h2 class="mt-3">Ranking de Ventas</h2>
<h4 class="mt-3 mb-5">Los resultados se muestran del usuario que mas ganancias ha hecho al que menos</h4>
<%while (rankingVentas.next()) {%>
<h5>Usuario: <%= rankingVentas.getString("username")%></h5>
<h5>Ventas Realizadas: <%= rankingVentas.getString("ventas")%></h5>
    <%
	    String usuario = rankingVentas.getString("username");
	    ResultSet ventasUsuario = null;
	    if (primerFecha.equals("") || segundaFecha.equals("")) {
		    ventasUsuario = ControlFinanzas.obtenerVentasPorUsuario(usuario);
	    } else {
		    DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		    ventasUsuario = ControlFinanzas.obtenerVentasPorUsuario(usuario, LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
	    }
    %>
<table id="mueblesCreadosTabla" class="table table-striped mb-5">
    <thead>
	<tr>
	    <th>Id del Mueble</th>
	    <th>Nombre del Mueble</th>
	    <th>Precio de Venta</th> 
	    <th>Fecha de Venta</th> 
	</tr>
    </thead>
    <tbody>
	<% while (ventasUsuario.next()) {
			int id = ventasUsuario.getInt("id");
			String nombrePieza = ventasUsuario.getString("nombre_mueble");
			float precio = ventasUsuario.getFloat("precio");
			LocalDate fechaVenta = ventasUsuario.getDate("fecha").toLocalDate();
	%>
	<tr>
	    <td><%= id%></td>
	    <td><%= nombrePieza%></td>
	    <td>Q.<%= precio%></td>
	    <td><%= fechaVenta%></td>
	</tr>
	<%
		}%>
    </tbody>
</table>
<% }
	ArrayList<String> reporteCSV = null;
	if (primerFecha.equals("") || segundaFecha.equals("")) {
		reporteCSV = GeneradorReportesCSV.generarReporteUsuarioMasVentas();
	} else {
		DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		reporteCSV = GeneradorReportesCSV.generarReporteUsuarioMasVentas(LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
	}

	String path = System.getProperty("user.home") + "/temp.csv";
	File strFile = new File(path);
	boolean fileCreated = strFile.createNewFile();
	//Escritura del archivo
	BufferedWriter objWriter = new BufferedWriter(new FileWriter(strFile));
	for (String linea : reporteCSV) {
		objWriter.write(linea);
		objWriter.newLine();
	}
	objWriter.flush();
	objWriter.close();
%>
<a href="servlet-descarga?path=<%= path%>&nombre-archivo=reporte-usuario-mas-ventas"><button type="button" class="btn btn-primary">Descargar</button> </a>