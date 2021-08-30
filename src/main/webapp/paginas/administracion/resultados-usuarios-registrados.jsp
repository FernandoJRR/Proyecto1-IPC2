<%-- 
    Document   : resultados-usuarios-registrados
    Created on : Aug 29, 2021, 12:56:55 PM
    Author     : fernanrod
--%>

<%@page import="controlador.ControlUsuarios"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlPiezas"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	ResultSet usuariosRegistrados = null;
	try {
		usuariosRegistrados = ControlUsuarios.obtenerUsuarios(request.getParameter("busqueda").toString());
	} catch (SQLException e) {

	}
%>
<h2>Usuarios Registrados</h2>
<table class="table table-striped">
    <thead>
	<tr>
	    <th>Username</th>
	    <th>Tipo</th>
	    <<th>Estado</th>
	</tr>
    </thead>
    <tbody>
	<% while (usuariosRegistrados.next()) {
			String username = usuariosRegistrados.getString("username");
			String tipo = usuariosRegistrados.getString("tipo_usuario");
			String estado = usuariosRegistrados.getString("estado");
	%>
	<tr>
	    <td><%= username%></td>
	    <td><%= tipo%></td>
	    <td><%= estado%></td>
	</tr>
	<%
		}%>
    </tbody>
</table>