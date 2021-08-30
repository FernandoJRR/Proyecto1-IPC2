<%-- 
    Document   : eliminacion-usuario
    Created on : Aug 29, 2021, 10:33:35 PM
    Author     : fernanrod
--%>

<%@page import="exceptions.NoExisteException"%>
<%@page import="controlador.ControlUsuarios"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlPiezas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
	try {
		String username = request.getParameter("username");
		ControlUsuarios.eliminarUsuario(username);
%>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    El usuario se ha cancelado exitosamente!
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (NoExisteException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    El usuario a cancelar no existe.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (SQLException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    No se ha podido cancelar al usuario.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
	}
%>

