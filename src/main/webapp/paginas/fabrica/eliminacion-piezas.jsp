<%-- 
    Document   : eliminacion-piezas
    Created on : Sep 4, 2021, 10:39:15 AM
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
		int idPieza = Integer.valueOf(request.getParameter("id"));
		ControlPiezas.eliminarPieza(idPieza);
%>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    La pieza se ha eliminado exitosamente!
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (NoExisteException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    La pieza a eliminar no existe.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (ConflictException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    La pieza esta ensamblada a un mueble, la pieza debe estar suelta para poder ser eliminada.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (SQLException e) {
e.printStackTrace();
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    Ha ocurrido un error contacta al administrador.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
	}
%>