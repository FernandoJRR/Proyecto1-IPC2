<%-- 
    Document   : resultados-reporte-ventas
    Created on : Sep 5, 2021, 7:46:41 PM
    Author     : fernanrod
--%>

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