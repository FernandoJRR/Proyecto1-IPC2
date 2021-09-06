<%-- 
    Document   : resultado-compras-cliente
    Created on : Sep 6, 2021, 12:14:53 AM
    Author     : fernanrod
--%>

<%@page import="controlador.ControlVentas"%>
<%@page import="controlador.ControlFinanzas"%>
<%@page import="java.time.LocalDate"%>
<%@page import="controlador.ControlEnsamble"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlPiezas"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	ResultSet compras = null;
	try {
		String nit = request.getParameter("nit");
		String primerFecha = request.getParameter("primerFecha");
		String segundaFecha = request.getParameter("segundaFecha");

		if (primerFecha.equals("") || segundaFecha.equals("")) {
			compras = ControlVentas.obtenerComprasCliente(nit);
		} else {
			DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			compras = ControlVentas.obtenerComprasCliente(nit, LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
		}

	} catch (SQLException e) {
%><h2>Ha ocurrido un error.</h2><%
	e.printStackTrace();
	}
%>
<h2 class="mt-3">Compras Realizadas</h2>
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
	<% while (compras.next()) {
			int id = compras.getInt("id");
			String nombrePieza = compras.getString("nombre_mueble");
			float precio = compras.getFloat("precio");
			LocalDate fechaVenta = compras.getDate("fecha").toLocalDate();
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