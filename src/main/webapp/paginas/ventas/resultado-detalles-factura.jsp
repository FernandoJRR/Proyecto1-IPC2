<%-- 
    Document   : resultado-detalles-factura
    Created on : Sep 6, 2021, 12:58:32 AM
    Author     : fernanrod
--%>

<%@page import="exceptions.NoExisteException"%>
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
	ResultSet detallesFactura = null;
	ResultSet comprasFactura = null;
	try {
		int factura = Integer.valueOf(request.getParameter("factura"));
		detallesFactura = ControlVentas.obtenerDetallesFactura(factura);
		comprasFactura = ControlVentas.obtenerComprasFactura(factura);
		detallesFactura.next();
%>
<h2 class="mt-3">Detalles Factura</h2>
<h4 class="mt-3">Numero de Factura: <%= detallesFactura.getInt("id")%></h4>
<h4 class="mt-3">Nit del Cliente: <%= detallesFactura.getString("cliente")%></h4>
<h4 class="mt-3">Encargado de Facturacion: <%= detallesFactura.getString("encargado")%></h4>
<h4 class="mt-3">Fecha de Facturacion: <%= detallesFactura.getDate("fecha")%></h4>
<h4 class="mt-5">Muebles Comprados</h4>
<table id="mueblesCreadosTabla" class="table table-striped">
    <thead>
	<tr>
	    <th>Id del Mueble</th>
	    <th>Nombre del Mueble</th>
	    <th>Precio de Venta</th> 
	</tr>
    </thead>
    <tbody>
	<% while (comprasFactura.next()) {
			int id = comprasFactura.getInt("mueble_comprado");
			String nombrePieza = comprasFactura.getString("nombre_mueble");
			float precio = comprasFactura.getFloat("precio");
	%>
	<tr>
	    <td><%= id%></td>
	    <td><%= nombrePieza%></td>
	    <td>Q.<%= precio%></td>
	</tr>
	<%
		}%>
    </tbody>
</table>
<%
} catch (NoExisteException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    La factura ingresada no existe.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (SQLException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    Ha ocurrido un error.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (Exception e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    Ha ocurrido un error.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
	}
%>