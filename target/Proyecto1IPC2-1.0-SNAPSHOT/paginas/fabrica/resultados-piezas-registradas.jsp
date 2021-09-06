<%-- 
    Document   : resultados-piezas-registradas
    Created on : Aug 26, 2021, 4:16:33 PM
    Author     : fernanrod
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlPiezas"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	ResultSet cantidadesPiezas = null;
	ResultSet piezasDisponibles = null;
	ResultSet piezasEnUso = null;
	try {
		cantidadesPiezas = ControlPiezas.cantidadesPiezas(request.getParameter("busqueda"));
		piezasDisponibles = ControlPiezas.piezasDisponibles(request.getParameter("busqueda"));
		piezasEnUso = ControlPiezas.piezasEnUso(request.getParameter("busqueda"));
	} catch (SQLException e) {

	}
%>
<h2>Cantidades de Piezas Disponibles</h2>
<table id="cantidadesTabla" class="table table-striped">
    <thead>
	<tr>
	    <th onclick="ordenarTabla('cantidadesTabla',0)">Nombre de la Pieza</th>
	    <th onclick="ordenarTabla('cantidadesTabla',1)">Cantidad de la Pieza</th>
	    <th onclick="ordenarTabla('cantidadesTabla',2)">Estado del Stock</th>
	</tr>
    </thead>
    <tbody>
	<%
		while (cantidadesPiezas.next()) {
			String nombrePieza = cantidadesPiezas.getString("nombre");
			int cantidadPieza = cantidadesPiezas.getInt("cantidad");
			String estadoStock = null;
			if(cantidadPieza > 10){
				estadoStock = "En Stock";
			} else if(cantidadPieza <= 10 && cantidadPieza > 5){
				estadoStock = "Necesario reabastecer";
			} else if(cantidadPieza <= 5 && cantidadPieza > 0){
				estadoStock = "A punto de agotarse";
			} else if(cantidadPieza == 0){
				estadoStock = "Agotado";
			}
			
	%>
	<tr>
	    <td><%= nombrePieza%></td>
	    <td><%= cantidadPieza%></td>
	    <td><%= estadoStock%></td>
	</tr>
	<%
		}%>
    </tbody>
</table>
    
<h2>Piezas Disponibles</h2>
<table id="piezasDisponiblesTabla" class="table table-striped">
    <thead>
	<tr>
	    <th>Id</th>
	    <th onclick="ordenarTabla('piezasDisponiblesTabla',1)">Nombre</th>
	    <th>Costo</th> 
	</tr>
    </thead>
    <tbody>
	<% while (piezasDisponibles.next()) {
			int id = piezasDisponibles.getInt("id");
			String nombrePieza = piezasDisponibles.getString("nombre");
			float costo = piezasDisponibles.getFloat("costo");
	%>
	<tr>
	    <td><%= id%></td>
	    <td><%= nombrePieza%></td>
	    <td>Q.<%= costo%></td>
	</tr>
	<%
		}%>
    </tbody>
</table>
    
<h2>Piezas En Uso</h2>
<table id="piezasEnUsoTable" class="table table-striped">
    <thead>
	<tr>
	    <th>Id</th>
	    <th>Nombre</th>
	    <th>Costo</th>
	    <th colspan="2">Mueble</th>
	</tr>
	<tr>
	    <th></th>
	    <th></th>
	    <th></th>
	    <th>Id</th>
	    <th>Nombre Mueble</th>	    
	</tr>
    </thead>
    <tbody>
	<%
		while (piezasEnUso.next()) {
			int id = piezasEnUso.getInt("id");
			String nombrePieza = piezasEnUso.getString("nombre");
			float costo = piezasEnUso.getFloat("costo");
			int idMueble = piezasEnUso.getInt("id_mueble");
			String nombreMueble = piezasEnUso.getString("nombre_mueble");
	%>
	<tr>
	    <td><%= id%></td>
	    <td><%= nombrePieza%></td>
	    <td>Q.<%= costo%></td>
	    <td><%= idMueble%></td>
	    <td><%= nombreMueble%></td>
	</tr>
	<%
		}%>
    </tbody>
</table>

