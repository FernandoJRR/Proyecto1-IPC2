<%-- 
    Document   : resultados-reporte-usuario-mas-ganancias
    Created on : Sep 5, 2021, 10:27:45 PM
    Author     : fernanrod
--%>

<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.File"%>
<%@page import="controlador.GeneradorReportesCSV"%>
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
	ResultSet rankingGanancias = null;
	String primerFecha = null;
	String segundaFecha = null;
	float gananciasTotales = 0;
	try {
		primerFecha = request.getParameter("primerFecha");
		segundaFecha = request.getParameter("segundaFecha");

		if (primerFecha.equals("") || segundaFecha.equals("")) {
			rankingGanancias = ControlFinanzas.obtenerRankingGanancias();
		} else {
			DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			rankingGanancias = ControlFinanzas.obtenerRankingGanancias(LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
		}

	} catch (SQLException e) {
%><h2>Ha ocurrido un error.</h2><%
		e.printStackTrace();
	}
%>
<h2 class="mt-3">Usuario con Mas Ganancias</h2>
<h4 class="mt-3 mb-5">Los se muestra el usuario que mas ganancias ha hecho</h4>
<%while (rankingGanancias.next()) {%>
<h5>Usuario: <%= rankingGanancias.getString("username")%></h5>
<%
	String usuario = rankingGanancias.getString("username");
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
	    <th>Ganancia</th> 
	    <th>Fecha de Venta</th> 
	</tr>
    </thead>
    <tbody>
	<% while (ventasUsuario.next()) {
			int id = ventasUsuario.getInt("id");
			String nombrePieza = ventasUsuario.getString("nombre_mueble");
			float precio = ventasUsuario.getFloat("precio");
			float ganancia = ventasUsuario.getFloat("ganancia");
			LocalDate fechaVenta = ventasUsuario.getDate("fecha").toLocalDate();

			DecimalFormat df = new DecimalFormat("###.##");
	%>
	<tr>
	    <td><%= id%></td>
	    <td><%= nombrePieza%></td>
	    <%if (ventasUsuario.getString("ganancia") == null) {%>
	    <td>Q.<%= df.format(precio / 3)%></td>
	    <%
		    gananciasTotales += Float.valueOf(df.format(precio / 3));
	    } else {
		    gananciasTotales += ganancia;
	    %>
	    <td>Q.<%= ganancia%></td>
	    <% }%>
	    <td><%= fechaVenta%></td>
	</tr>
	<% }%>
	<tr>
	    <th>Ganancias Obtenidas</th>
		<%DecimalFormat df = new DecimalFormat("###.##");%>
	    <th><%= df.format(gananciasTotales)%></th>
		<%gananciasTotales = 0;%>
	</tr>
    </tbody>
</table>
<%
		rankingGanancias.afterLast();
	}

	ArrayList<String> reporteCSV = null;
	if (primerFecha.equals("") || segundaFecha.equals("")) {
		reporteCSV = GeneradorReportesCSV.generarReporteUsuarioMasGanancias();
	} else {
		DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		reporteCSV = GeneradorReportesCSV.generarReporteUsuarioMasGanancias(LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
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
<a href="servlet-descarga?path=<%= path%>&nombre-archivo=reporte-usuarios-mas-ganancias"><button type="button" class="btn btn-primary">Descargar</button> </a>