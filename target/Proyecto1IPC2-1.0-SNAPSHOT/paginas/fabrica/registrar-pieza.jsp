<%-- 
    Document   : registrar-pieza
    Created on : Aug 28, 2021, 8:33:54 AM
    Author     : fernanrod
--%>

<%@page import="exceptions.ConflictException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlPiezas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
	String tipoPieza = null;
	float costoPieza = Float.valueOf(request.getParameter("costo"));
	if (!request.getParameter("tipo-existente").toString().equals("null")) {
		tipoPieza = request.getParameter("tipo-existente");
	} else if (!request.getParameter("tipo-no-existente").equals("null")) {
		tipoPieza = request.getParameter("tipo-no-existente");
	}

	if (!tipoPieza.equals("null")) {
		try {
			ControlPiezas.crearPieza(tipoPieza, costoPieza);
%>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    La pieza se ha registrado con exito!
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%} catch (SQLException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    No se ha podido registrar la pieza.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
} catch (ConflictException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    No se ha podido registrar la pieza, el precio no es valido.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
	}
} else {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    No se ha podido registrar la pieza.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
	}
%>
