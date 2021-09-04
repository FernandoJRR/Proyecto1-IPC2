<%-- 
    Document   : resultados-muebles-ensamblados
    Created on : Sep 3, 2021, 11:57:04 AM
    Author     : fernanrod
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="controlador.ControlEnsamble"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlPiezas"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	ResultSet mueblesEnsamblados = null;
	try {
		String fechaDesde = request.getParameter("fechaDesde");
		String fechaHasta = request.getParameter("fechaHasta");

		if (fechaDesde.equals("") || fechaHasta.equals("")) {
			mueblesEnsamblados = ControlEnsamble.obtenerMueblesEnsamblados();
		} else {
			DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			mueblesEnsamblados = ControlEnsamble.obtenerMueblesEnsamblados(LocalDate.parse(fechaDesde, formato), LocalDate.parse(fechaHasta, formato));
		}

	} catch (SQLException e) {
%><h2>Ha ocurrido un error.</h2><%
	e.printStackTrace();
	}
%>
<h2 class="mt-3">Muebles Creados</h2>
<table class="table table-striped">
    <thead>
	<tr>
	    <th>Id</th>
	    <th>Nombre</th>
	    <th>Precio de Venta</th> 
	    <th>Fecha de Ensamble</th> 
	    <th>Usuario Ensamblador</th> 
	    <th>Estado</th> 
	</tr>
    </thead>
    <tbody>
	<% while (mueblesEnsamblados.next()) {
			int id = mueblesEnsamblados.getInt("id");
			String nombrePieza = mueblesEnsamblados.getString("nombre_mueble");
			float precio = mueblesEnsamblados.getFloat("precio_venta");
			LocalDate fechaEnsamble = mueblesEnsamblados.getDate("fecha_ensamble").toLocalDate();
			String usuarioEnsamblador = mueblesEnsamblados.getString("usuario_ensamblador");
			String estado = mueblesEnsamblados.getString("pieza");
	%>
	<tr>
	    <td><%= id%></td>
	    <td><%= nombrePieza%></td>
	    <td>Q.<%= precio%></td>
	    <td><%= fechaEnsamble%></td>
	    <td><%= usuarioEnsamblador%></td>
	    <%if (estado != null) {%>
	    <td>Ensamblado</td>
	    <% } else {%>
	    <td>Desensamblado</td>
	    <% } %>
	</tr>
	<%
		}%>
    </tbody>
</table>