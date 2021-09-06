<%-- 
    Document   : resultados-mueble-mas-vendido
    Created on : Sep 5, 2021, 10:32:21 PM
    Author     : fernanrod
--%>

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
	Boolean orden = null;
	try {
		primerFecha = request.getParameter("primerFecha");
		segundaFecha = request.getParameter("segundaFecha");
		orden = Boolean.valueOf(request.getParameter("orden"));

		if (primerFecha.equals("") || segundaFecha.equals("")) {
			rankingVentas = ControlFinanzas.rankingVentasMuebles(orden);
		} else {
			DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			rankingVentas = ControlFinanzas.rankingVentasMuebles(orden, LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
		}

	} catch (SQLException e) {
%><h2>Ha ocurrido un error.</h2><%
		e.printStackTrace();
	}
%>
<%if (orden) {%>
<h2 class="mt-3">Ranking Descendente de Ventas de Muebles</h2>
<h4 class="mt-3 mb-5">Los resultados se muestran del que mas se ha vendido al que menos</h4>
<% } else {%>
<h2 class="mt-3">Ranking Ascendente de Ventas de Muebles</h2>
<h4 class="mt-3 mb-5">Los resultados se muestran del que menos se ha vendido al que mas</h4>
<% }%>

<%while (rankingVentas.next()) {%>
<h5>Modelo Mueble: <%= rankingVentas.getString("nombre_mueble")%></h5>
<h5>Veces Vendido: <%= rankingVentas.getString("ventas")%></h5>
<%
	String modelo = rankingVentas.getString("nombre_mueble");
	ResultSet ventasMueble = null;
	if (primerFecha.equals("") || segundaFecha.equals("")) {
		ventasMueble = ControlFinanzas.obtenerVentasMuebles(modelo);
	} else {
		DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		ventasMueble = ControlFinanzas.obtenerVentasMuebles(modelo, LocalDate.parse(primerFecha, formato), LocalDate.parse(segundaFecha, formato));
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
	<% while (ventasMueble.next()) {
			int id = ventasMueble.getInt("id");
			String nombrePieza = ventasMueble.getString("nombre_mueble");
			float precio = ventasMueble.getFloat("precio");
			LocalDate fechaVenta = ventasMueble.getDate("fecha").toLocalDate();
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
<% }%>