<%-- 
    Document   : resultados-reporte-ganancias
    Created on : Sep 5, 2021, 8:42:57 PM
    Author     : fernanrod
--%>

<%@page import="controlador.ControlFinanzas"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	ResultSet ganancias = null;
	ResultSet gananciasTotales = null;
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
	    <th>Precio de Venta</th> 
	    <th>Fecha de Venta</th> 
	</tr>
    </thead>
    <tbody>
	<% while (ganancias.next()) {
			int id = ganancias.getInt("id");
			String nombrePieza = ganancias.getString("nombre_mueble");
			float precio = ganancias.getFloat("precio");
			LocalDate fechaVenta = ganancias.getDate("fecha").toLocalDate();
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
    <tr>
	<th>Ganancias Totales</th>
	    <%gananciasTotales.next();%>
	    <%
		    String gananciaTotal = gananciasTotales.getString("ganancia_total");
		    if (gananciaTotal == null) {
	    %>
	<th>Q.0.00</th>
	    <%
	    } else {
	    %>
	<th>Q.<%= gananciasTotales.getString("ganancia_total")%></th>
	    <%
		    }
	    %>

    </tr>
</table>