<%-- 
    Document   : desensamble-mueble
    Created on : Sep 4, 2021, 3:38:54 AM
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
		int idMueble = Integer.valueOf(request.getParameter("id"));
		ControlEnsamble.desensamblarMueble(idMueble);
%>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    El mueble se ha desensamblado exitosamente!
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (NoExisteException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    El mueble a desensamblar no existe.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (ConflictException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    El mueble ya ha sido desensamblado previamente.
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