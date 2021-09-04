<%-- 
    Document   : eliminacion-modelo
    Created on : Sep 4, 2021, 4:18:56 PM
    Author     : fernanrod
--%>

<%@page import="exceptions.ConflictException"%>
<%@page import="controlador.ControlEnsamble"%>
<%@page import="exceptions.NoExisteException"%>
<%@page import="controlador.ControlUsuarios"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlPiezas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
	try {
		String nombreModelo = request.getParameter("modelo");
		ControlEnsamble.eliminarModelo(nombreModelo);
%>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    El modelo se ha eliminado exitosamente!
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (NoExisteException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    El modelo a eliminar no existe.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (ConflictException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    No se ha podido eliminar el modelo, verifica que no existan muebles ensamblados con el modelo.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (SQLException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    Ha ocurrido un error, contacta al administrador.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
	}
%>
