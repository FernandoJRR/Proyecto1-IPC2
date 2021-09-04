<%-- 
    Document   : proceso-ensamble
    Created on : Sep 4, 2021, 2:29:32 AM
    Author     : fernanrod
--%>

<%@page import="exceptions.NoExisteException"%>
<%@page import="exceptions.ConflictException"%>
<%@page import="controlador.ControlEnsamble"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlPiezas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
	String modelo = request.getParameter("modelo");
	String usuarioEnsamblador = request.getSession().getAttribute("usuario").toString();
	Integer[] id = null;
	try {
		id = new Integer[0];
		int i = 0;
		while (request.getParameter("id" + i) != null) {
			Integer[] temp = new Integer[id.length + 1];
			for (int j = 0; j < id.length; j++) {
				temp[j] = id[j];
			}
			temp[temp.length - 1] = Integer.valueOf(request.getParameter("id" + i));
			id = temp;
			i++;
		}
		LocalDate fechaEnsamble = LocalDate.now();
		ControlEnsamble.ensambleMueble(modelo, usuarioEnsamblador, fechaEnsamble, id);
%>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    El mueble se ha ensamblado exitosamente!
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%} catch (ConflictException|NoExisteException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    No se ha podido ensamblar el mueble, revisa y vuelve a ingresar los id.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% } catch (SQLException e) {%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    Ha ocurrido un error, contacta con el administrador.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% } %>
