<%-- 
    Document   : ensamblaje-muebles
    Created on : Sep 3, 2021, 5:30:46 PM
    Author     : fernanrod
--%>

<%@page import="controlador.ControlEnsamble"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="controlador.ControlPiezas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page = "/includes/recursos.jsp"/>
	<script src="utils.js"></script>

	<title>Departamento de Fabrica</title>
    </head>
    <body>
	<jsp:include page = "/includes/header.jsp"></jsp:include>
		<div class="container-fluid">
		    <div class="row flex-nowrap">
		    <jsp:include page = "/includes/sidebar-fabrica-ensamble.jsp"/>
		    <div class="col-md-7 py-3 align-self-center" style="margin-left: 15%">
			<h2>Ensamblar Nuevo Mueble</h2>
			<div class="input-group mb-3">
			    <span class="input-group-text" id="modelo-label">
				Modelo
			    </span>
			    <input type="text" class="form-control" id="modelo" name="modelo" value="<%= request.getParameter("modelo")%>" disabled>
			</div>
			<h4>Instrucciones del Modelo</h4>
			<table class="table table-striped">
			    <thead>
				<tr>
				    <th>Tipo de Pieza</th>
				    <th>Cantidad de la Pieza</th>
				</tr>
			    </thead>
			    <tbody>
				<%
					ResultSet instruccionesModelo = ControlEnsamble.obtenerInstruccionesModelo(request.getParameter("modelo"));
					while (instruccionesModelo.next()) {
						String tipoPieza = instruccionesModelo.getString("tipo_pieza");
						int cantidadPieza = instruccionesModelo.getInt("cantidad_pieza");
				%>
				<tr>
				    <td><%= tipoPieza%></td>
				    <td><%= cantidadPieza%></td>
				</tr>
				<%
					}
				%>
			    </tbody>
			</table>
			<form class="mb-3" action="ensamblaje-muebles.jsp" method="POST">
			    <input type="hidden" name="modelo" value="<%= request.getParameter("modelo")%>">							    
			    <div class="row mb-3">
				<label for="inputTipoPieza" class="col col-form-label">Ingresa los id de las piezas para ensamblar:</label>
			    </div>
			    <ul class="list-group" id="lista-id">
				<li class="list-group-item mx-auto" id="idLi0" name="idLi0"><input type="number" id="id0" name="id0" required></li>
			    </ul>
			    <button class="btn btn-outline-secondary mt-3" type="button" onclick="agregarId()" style="margin-left: 38.5%">
				<img src="${pageContext.request.contextPath}/resources/icon/plus.svg" width="15" height="15" alt="Agregar Id" />
			    </button>
			    <button class="btn btn-outline-secondary mt-3" type="button" onclick="removerId()">
				<img src="${pageContext.request.contextPath}/resources/icon/dash-lg.svg" width="15" height="15" alt="Remover Id" />
			    </button>
			    <div class="row">
				<button type="submit" class="btn btn-outline-primary mt-3">Ensamblar</button>
			    </div>
			</form>
			<c:if test="${param.id0 != null}">	
				<jsp:include page="proceso-ensamble.jsp"/>
			</c:if>
		    </div>
		</div>
	</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/fabrica.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>