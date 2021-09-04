<%-- 
    Document   : registrar-nuevos-modelos
    Created on : Sep 4, 2021, 11:10:08 AM
    Author     : fernanrod
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="controlador.ControlPiezas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page = "/includes/recursos.jsp"></jsp:include>
		<script src="utils.js"></script>
		<title>Departamento de Administracion</title>
	</head>
	<body>
	<%
		ResultSet tiposPiezas = null;
		try {
			tiposPiezas = ControlPiezas.tipoPiezas();
		} catch (SQLException e) {

		}
	%>
	<jsp:include page = "/includes/header.jsp"></jsp:include>
		<div class="container-fluid">
		    <div class="row flex-nowrap">
		    <jsp:include page = "/includes/sidebar-administracion-modelos.jsp"/>
		    <div class="container" style="margin-left: 14%; margin-top: 11%">
			<h2>Registrar Nuevo Modelo</h2>
			<h4>Ingresa los datos que se piden</h4>
			<form class="mb-3" style="max-width: 50%" action="registrar-nuevos-modelos.jsp" method="POST">
			    <div class="input-group mb-3">
				<span class="input-group-text" id="nombre-label">Nombre del Modelo</span>
				<input type="text" class="form-control" id="modelo" name="modelo" required>
			    </div>
			    <div class="input-group mb-3">
				<span class="input-group-text">Precio de Venta</span>
				<span class="input-group-text">Q.</span>
				<input type="number" min="0" step="0.01" value="0.00" class="form-control" name="precio" required>
				<span class="input-group-text">.00</span>
			    </div>
			    <h2>Instrucciones del Modelo</h2>
			    <h4 style="align-center">Ingresa el tipo de pieza y la cantidad de esta que usa el modelo</h4>
			    <ul class="list-group" id="lista-id">
				<li class="list-group-item mx-auto" id="li0" name="li0">
				    <div class="input-group mb-3">
					<span class="input-group-text" id="tipo-label0">Tipo Pieza</span>
					<select class="form-select" id="tipo0" name="tipo0" required>
					    <option selected disabled value="">Elije un tipo de pieza...</option>
					    <%
						    while (tiposPiezas.next()) {
							    String tipoPieza = tiposPiezas.getString("nombre");
					    %>
					    <option value="<%= tipoPieza%>"><%= tipoPieza%></option>
					    <%
						    }
						    tiposPiezas.beforeFirst();
					    %>
					</select>
					<span class="input-group-text" id="cantidad-label0">Cantidad Pieza</span>
					<input type="number" min="1" class="form-control" id="cantidad0" name="cantidad0" required>
				    </div>
				</li>
			    </ul>
			    <button class="btn btn-outline-secondary mt-3" type="button" onclick="agregarId(tiposDePiezas)" style="margin-left: 38.5%">
				<img src="${pageContext.request.contextPath}/resources/icon/plus.svg" width="15" height="15" alt="Agregar Id" />
			    </button>
			    <button class="btn btn-outline-secondary mt-3" type="button" onclick="removerId()">
				<img src="${pageContext.request.contextPath}/resources/icon/dash-lg.svg" width="15" height="15" alt="Remover Id" />
			    </button>
			    <div class="row">
				<button type="submit" class="btn btn-outline-primary mt-3">Registrar</button>
			    </div>
			</form>
			<div style="max-width: 50%">
			    <c:if test="${param.modelo != null}">
				    <jsp:include page="registro-nuevos-modelos.jsp"/>
			    </c:if>   
			</div>
		    </div>
		</div>
	</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/finanzas.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"/>
    </body>
    <script>
            const tiposDePiezas = [];
	<%while (tiposPiezas.next()) {%>
            tiposDePiezas.push("<%= tiposPiezas.getString("nombre").toString()%>");
	<% }%>
    </script>
</html>
