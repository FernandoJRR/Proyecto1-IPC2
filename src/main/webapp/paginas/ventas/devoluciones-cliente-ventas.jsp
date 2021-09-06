<%-- 
    Document   : devoluciones-cliente-ventas
    Created on : Sep 5, 2021, 11:24:30 PM
    Author     : fernanrod
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="controlador.ControlVentas"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page = "/includes/recursos.jsp"></jsp:include>
	<script src="${pageContext.request.contextPath}/resources/js/util-tablas.js"></script>
	<title>Departamento de Ventas</title>
    </head>
    <body>
	<jsp:include page = "/includes/header.jsp"></jsp:include>
		<div class="container-fluid">
		    <div class="row flex-nowrap">
		    <jsp:include page = "/includes/sidebar-ventas-consultas.jsp"></jsp:include>
			    <div class="col m-5 py-3">
				<h2 class="vertical-center" style="margin-left: 40%" id="formBusqueda">Devoluciones de un Cliente</h2>
				<form class="m-auto" style="max-width: 70%" action="devoluciones-cliente-ventas.jsp" method="GET">
				    <div class="input-group mb-3">
					<span class="input-group-text" id="basic-addon1">NIT del Cliente</span>
					<select class="form-select" id="nit" name="nit" required>
					    <option selected disabled value="">Elige el nit del cliente...</option>
					<%
						ResultSet nitClientes = null;
						try{
							nitClientes = ControlVentas.obtenerNitClientes();
						} catch (SQLException e) {
							
						}
						while (nitClientes.next()) {
							String nit = nitClientes.getString("nit");
					%>
					<option value="<%= nit%>"><%= nit%></option>
					<%
						}
					%>				    
					</select>				    
				</div>
				<div class="input-group">
				    <span class="input-group-text" id="basic-addon1">Primer Fecha</span>
				    <input class="form-control" type="date" id="primerFecha" name="primerFecha">
				    <span class="input-group-text" id="basic-addon1">Segunda Fecha</span>
				    <input class="form-control" type="date" id="segundaFecha" name="segundaFecha">
				    <button class="btn btn-outline-primary" type="submit" id="boton-busqueda">Buscar</button>
				</div>
			    </form>
			    <small id="notaBusqueda" class="form-text text-muted" style="margin-left: 15.3%">
				Se mostraran los datos entre ambas fechas sin importar cual sea mayor. Si no ingresas alguna de las fechas se mostraran todas las devoluciones del cliente.
			    </small>
			    <c:if test="${param.nit != null}">
				    <script>
                                            document.getElementById("formBusqueda").className = "mb-3";
				    </script>
				    <jsp:include page="resultado-devoluciones-cliente.jsp"/>
			    </c:if>
		    </div>
		</div>
	</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/ventas.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>
