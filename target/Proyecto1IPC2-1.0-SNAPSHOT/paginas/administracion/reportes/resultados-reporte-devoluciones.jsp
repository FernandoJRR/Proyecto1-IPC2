<%-- 
    Document   : resultados-reporte-devoluciones
    Created on : Sep 5, 2021, 8:04:09 PM
    Author     : fernanrod
--%>

<%@page import="controlador.ControlFinanzas"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	ResultSet devoluciones = null;
	try {
		String primerFecha = request.getParameter("primerFecha");
		String segundaFecha = request.getParameter("segundaFecha");

		if (primerFecha.equals("") || segundaFecha.equals("")) {
			devoluciones = ControlFinanzas.reporteDevoluciones();
		} else {
			DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			devoluciones = ControlFinanzas.reporteDevoluciones(LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
		}

	} catch (SQLException e) {
%><h2>Ha ocurrido un error.</h2><%
	e.printStackTrace();
	}
%>
<h2 class="mt-3">Devoluciones Realizadas</h2>
<table id="mueblesCreadosTabla" class="table table-striped">
    <thead>
	<tr>
	    <th>Id del Mueble</th>
	    <th>Nombre del Mueble</th>
	    <th>Precio de Venta</th> 
	    <th>Fecha de Venta</th> 
	    <th>Fecha de Devolucion</th> 
	    <th>Perdidas</th> 
	</tr>
    </thead>
    <tbody>
	<% while (devoluciones.next()) {
			int id = devoluciones.getInt("id");
			String nombrePieza = devoluciones.getString("nombre_mueble");
			float precio = devoluciones.getFloat("precio");
			LocalDate fechaVenta = devoluciones.getDate("fecha_venta").toLocalDate();
			LocalDate fechaDevolucion = devoluciones.getDate("fecha_devolucion").toLocalDate();
			float perdida = devoluciones.getFloat("perdida");
	%>
	<tr>
	    <td><%= id%></td>
	    <td><%= nombrePieza%></td>
	    <td>Q.<%= precio%></td>
	    <td><%= fechaVenta%></td>
	    <td><%= fechaDevolucion%></td>
	    <td>Q.<%= perdida%></td>
	</tr>
	<%
		}%>
    </tbody>
</table>