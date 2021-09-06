<%-- 
    Document   : catalogo-ventas
    Created on : Sep 5, 2021, 11:23:56 PM
    Author     : fernanrod
--%>

<%@page import="controlador.ControlVentas"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="controlador.ControlFinanzas"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page = "/includes/recursos.jsp"/>
	<title>Departamento de Ventas</title>
    </head>
    <body>
	<jsp:include page = "/includes/header.jsp"/>
	<div class="container-fluid">
	    <div class="row flex-nowrap">
		<jsp:include page = "/includes/sidebar-ventas-consultas.jsp"/>
		<div class="container-fluid" style="margin-left: 3%; margin-top: 5%; max-width: 75%" id="searchDiv">
		    <div class="row">
			<div class="col-md-auto" style="margin-left: 40%">
			    <h2>Catalogo</h2>
			    <%
				    ResultSet mueblesSalaVentas = null;
				    try {
					    mueblesSalaVentas = ControlVentas.obtenerMueblesSalaVentas();
				    } catch (SQLException e) {

				    }
			    %>
			</div>
		    </div>
		    <div class="row">
			<h4>Muebles en Sala de Ventas</h4>
			<div class="col">
			    <table class="table table-striped">
				<thead>
				    <tr>
					<th>Id del Mueble</th>
					<th>Nombre del Mueble</th>
					<th>Precio de Venta</th>
				    </tr>
				</thead>
				<tbody>
				    <% while (mueblesSalaVentas.next()) {
						    int id = mueblesSalaVentas.getInt("id");
						    String nombre = mueblesSalaVentas.getString("nombre_mueble");
						    float precio = mueblesSalaVentas.getFloat("precio_venta");
				    %>
				    <tr>
					<td><%= id%></td>
					<td><%= nombre%></td>
					<td>Q.<%= precio%></td>
				    </tr>
				    <%
					    }%>
				</tbody>
			    </table>
			</div>
		    </div>
		</div>
	    </div>
	</div>
	<div>
	    <jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/ventas.jsp"/></jsp:include>
	    <jsp:include page = "/includes/footer.jsp"></jsp:include>	
	</div>
    </body>
</html>
