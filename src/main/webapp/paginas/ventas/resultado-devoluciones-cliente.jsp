<%-- 
    Document   : resultado-devoluciones-cliente
    Created on : Sep 6, 2021, 12:46:47 AM
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
	ResultSet devoluciones = null;
	try {
		String nit = request.getParameter("nit");
		String primerFecha = request.getParameter("primerFecha");
		String segundaFecha = request.getParameter("segundaFecha");

		if (primerFecha.equals("") || segundaFecha.equals("")) {
			devoluciones = ControlVentas.obtenerDevolucionesCliente(nit);
		} else {
			DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			devoluciones = ControlVentas.obtenerDevolucionesCliente(nit, LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
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
	    <th>Costo del Mueble</th> 
	    <th>Fecha de Devolucion</th> 
	</tr>
    </thead>
    <tbody>
	<% while (devoluciones.next()) {
			int id = devoluciones.getInt("id");
			String nombrePieza = devoluciones.getString("nombre_mueble");
			float costo = devoluciones.getFloat("costo");
			LocalDate fechaVenta = devoluciones.getDate("fecha").toLocalDate();
	%>
	<tr>
	    <td><%= id%></td>
	    <td><%= nombrePieza%></td>
	    <td>Q.<%= costo%></td>
	    <td><%= fechaVenta%></td>
	</tr>
	<%
		}%>
    </tbody>
</table>