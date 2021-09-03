<%-- 
    Document   : validar-devolucion
    Created on : Sep 2, 2021, 1:11:10 PM
    Author     : fernanrod
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="exceptions.NoExisteException"%>
<%@page import="controlador.ControlVentas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
	try {
		int numeroFactura = Integer.valueOf(request.getParameter("factura"));
		ControlVentas.obtenerDatosFactura(numeroFactura);
		
		response.sendRedirect(request.getContextPath()+"/paginas/ventas/registrar-devolucion.jsp?factura="+numeroFactura);
%>

<%
} catch (NoExisteException e) {
%>
<jsp:forward page="devoluciones-ventas.jsp">
	<jsp:param name="facturaValida" value="false"/>
</jsp:forward>
<%
} catch (SQLException e) {
%>
<jsp:forward page="devoluciones-ventas.jsp">
	<jsp:param name="error" value="true"/>
</jsp:forward>
<%
	}
%>