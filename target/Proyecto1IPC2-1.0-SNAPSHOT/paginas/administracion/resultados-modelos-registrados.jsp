<%-- 
    Document   : resultados-modelos-registrados
    Created on : Sep 4, 2021, 3:40:10 PM
    Author     : fernanrod
--%>

<%@page import="controlador.ControlEnsamble"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlPiezas"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	ResultSet modelosMuebles = null;

	try {
		modelosMuebles = ControlEnsamble.obtenerModelosMuebles(request.getParameter("busqueda"));

	} catch (SQLException e) {

	}
%>
<h2>Modelos Registrados</h2>

<%while (modelosMuebles.next()) {%>
<h3 class="mt-5">Nombre del Modelo: <%= modelosMuebles.getString("nombre")%></h3>
<h3>Precio de Venta: Q.<%= modelosMuebles.getString("precio_default")%></h3>

<h4>Instrucciones Modelo</h4>

<table class="table table-striped">
    <thead>
	<tr>
	    <th>Tipo de Pieza</th>
	    <th>Cantidad</th>	
	</tr>
    </thead>
    <tbody>
	<%
		ResultSet instruccionesMueble = null;
		try {
			instruccionesMueble = ControlEnsamble.obtenerInstruccionesModelo(modelosMuebles.getString("nombre"));
		} catch (SQLException e) {

		}
		while (instruccionesMueble.next()) {
			String tipoPieza = instruccionesMueble.getString("tipo_pieza");
			int cantidadPieza = instruccionesMueble.getInt("cantidad_pieza");
	%>
	<tr>
	    <td><%= tipoPieza%></td>
	    <td><%= cantidadPieza%></td>
	</tr>
	<%
		}%>
    </tbody>
</table>
<% } %>