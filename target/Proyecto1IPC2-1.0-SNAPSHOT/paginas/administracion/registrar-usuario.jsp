<%-- 
    Document   : registrar-usuario
    Created on : Aug 29, 2021, 6:45:40 PM
    Author     : fernanrod
--%>

<%@page import="exceptions.ConflictException"%>
<%@page import="exceptions.DuplicadoException"%>
<%@page import="controlador.ControlUsuarios"%>
<%@page import="bean.Usuario"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlPiezas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
	try {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		Usuario.tipo tipoUsuario = Usuario.tipo.valueOf(request.getParameter("tipo-usuario").toString());

		ControlUsuarios.crearUsuario(username, password, tipoUsuario);
%>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    El usuario se ha registrado con exito!
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (DuplicadoException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    El nombre de usuario ya existe, elige otro.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (ConflictException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    El password debe tener tener al menos 6 caracteres.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (SQLException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    No se ha podido registrar al usuario.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
	}
%>