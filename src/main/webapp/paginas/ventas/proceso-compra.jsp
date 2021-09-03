<%-- 
    Document   : proceso-compra
    Created on : Sep 1, 2021, 1:05:54 PM
    Author     : fernanrod
--%>

<%@page import="exceptions.ConflictException"%>
<%@page import="exceptions.NoExisteException"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlVentas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="bean.Cliente"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Departamento de Ventas</title>
    </head>
    <body>
	<%
		String nit = null;
		String nombre = null;
		String direccion = null;
		String departamento = null;
		String municipio = null;
		Integer[] id = null;
		boolean usuarioRegistrado = true;
		try {
			nit = request.getParameter("nit");
			if (request.getParameter("nombre") != null) {
				usuarioRegistrado = false;
			}
			if (usuarioRegistrado == false) {
				nombre = request.getParameter("nombre");
				direccion = request.getParameter("direccion");
				departamento = request.getParameter("departamento");
				municipio = request.getParameter("municipio");

				if (departamento != null) {
					ControlVentas.registrarCliente(nit, nombre, direccion, departamento, municipio);
				} else {
					ControlVentas.registrarCliente(nit, nombre, direccion);
				}
			}
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
			LocalDate localDate = LocalDate.now();
			ControlVentas.registrarCompra(nit, request.getSession().getAttribute("usuario").toString(), localDate, id);

	%>
	<jsp:forward page="compras-ventas.jsp">
		<jsp:param name="compraExitosa" value="true"></jsp:param>
	</jsp:forward>
	<%	} catch (SQLException e) {
	%>
	<jsp:forward page="registrar-compra.jsp?nit=<%= nit%>">
		<jsp:param name="compraFallida" value="true"></jsp:param>
	</jsp:forward>
	<%
	} catch (NoExisteException e) {
	%>
	<jsp:forward page="registrar-compra.jsp?nit=<%= nit%>">
		<jsp:param name="compraFallida" value="true"></jsp:param>
	</jsp:forward>
	<%
	} catch (ConflictException e) {
	%>
	<jsp:forward page="registrar-compra.jsp?nit=<%= nit%>">
		<jsp:param name="compraFallida" value="true"></jsp:param>
	</jsp:forward>
	<%
		}
	%>
    </body>
</html>
