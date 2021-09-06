<%-- 
    Document   : resultados-reporte-usuario-mas-ganancias
    Created on : Sep 5, 2021, 10:27:45 PM
    Author     : fernanrod
--%>

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
<h2 class="mt-3">Ranking de Ganancias</h2>
<h4 class="mt-3 mb-5">Los resultados se muestran del usuario que mas ganancias ha hecho al que menos</h4>
<%while (rankingGanancias.next()) {%>
<h5>Usuario: <%= rankingGanancias.getString("username")%></h5>
<h5>Ganancias Obtenidas: Q.<%= rankingGanancias.getString("ganancia")%></h5>
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
<% }%>