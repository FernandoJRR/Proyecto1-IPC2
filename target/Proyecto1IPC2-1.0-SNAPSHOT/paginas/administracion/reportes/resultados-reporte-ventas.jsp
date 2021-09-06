<%-- 
    Document   : resultados-reporte-ventas
    Created on : Sep 5, 2021, 7:46:41 PM
    Author     : fernanrod
--%>

<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.Writer"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controlador.GeneradorReportesCSV"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="controlador.ControlFinanzas"%>
<%@page import="java.time.LocalDate"%>
<%@page import="controlador.ControlEnsamble"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlPiezas"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	ResultSet ventas = null;
	try {
		String primerFecha = request.getParameter("primerFecha");
		String segundaFecha = request.getParameter("segundaFecha");

		if (primerFecha.equals("") || segundaFecha.equals("")) {
			ventas = ControlFinanzas.reporteVentas();
		} else {
			DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			ventas = ControlFinanzas.reporteVentas(LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
		}

	} catch (SQLException e) {
%><h2>Ha ocurrido un error.</h2><%
		e.printStackTrace();
	}
%>
<h2 class="mt-3">Ventas Realizadas</h2>
<table id="mueblesCreadosTabla" class="table table-striped">
    <thead>
	<tr>
	    <th>Id del Mueble</th>
	    <th>Nombre del Mueble</th>
	    <th>Precio de Venta</th> 
	    <th>Fecha de Venta</th> 
	</tr>
    </thead>
    <tbody>
	<% while (ventas.next()) {
			int id = ventas.getInt("id");
			String nombrePieza = ventas.getString("nombre_mueble");
			float precio = ventas.getFloat("precio");
			LocalDate fechaVenta = ventas.getDate("fecha_venta").toLocalDate();
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
<%
	String primerFecha = request.getParameter("primerFecha");
	String segundaFecha = request.getParameter("segundaFecha");

	ArrayList<String> reporteCSV = null;
	if (primerFecha.equals("") || segundaFecha.equals("")) {
		reporteCSV = GeneradorReportesCSV.generarReporteVentas();
	} else {
		DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		reporteCSV = GeneradorReportesCSV.generarReporteVentas(LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
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
<a href="servlet-descarga?path=<%= path%>&nombre-archivo=reporte-ventas"><button type="button" class="btn btn-primary">Descargar</button> </a>