<%-- 
    Document   : proceso-devolucion
    Created on : Sep 2, 2021, 10:46:08 PM
    Author     : fernanrod
--%>

<%@page import="exceptions.FueraDeFechaException"%>
<%@page import="java.sql.ResultSet"%>
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
		int numeroFactura = Integer.valueOf(request.getParameter("factura"));
		try {
			ResultSet datosFactura = ControlVentas.obtenerDatosFactura(numeroFactura);
			if (!datosFactura.next()) {
				throw new ConflictException();
			}
			String nit = datosFactura.getString("cliente");
			String usuarioEncargado = datosFactura.getString("encargado");
			Integer[] id = null;

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
			LocalDate fechaDevolucion = LocalDate.now();
			ControlVentas.registrarDevolucion(nit, usuarioEncargado, numeroFactura, fechaDevolucion, id);
	%>
	<jsp:forward page="devoluciones-ventas.jsp">
		<jsp:param name="devolucionExitosa" value="true"></jsp:param>
	</jsp:forward>
	<%	} catch (ConflictException e) {
	%>
	<jsp:forward page="registrar-devolucion.jsp?factura=<%= numeroFactura%>">
		<jsp:param name="devolucionFallida" value="true"></jsp:param>
	</jsp:forward>
	<%
	} catch (NoExisteException e) {
	%>
	<jsp:forward page="registrar-devolucion.jsp?factura=<%= numeroFactura%>">
		<jsp:param name="devolucionFallida" value="true"></jsp:param>
	</jsp:forward>
	<%
	} catch (FueraDeFechaException e) {
	%>
	<jsp:forward page="registrar-devolucion.jsp?factura=<%= numeroFactura%>">
		<jsp:param name="fueraDeFecha" value="true"></jsp:param>
	</jsp:forward>
	<%
	} catch (SQLException e) {
	%>
	<jsp:forward page="registrar-devolucion.jsp?factura=<%= numeroFactura%>">
		<jsp:param name="devolucionFallida" value="true"></jsp:param>
	</jsp:forward>
	<%
		}
	%>
    </body>
</html>
