<%-- 
    Document   : registrar-nuevas-piezas
    Created on : Aug 25, 2021, 11:35:05 PM
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
		<title>Departamento de Fabrica</title>
	</head>
	<body>
	<jsp:include page = "/includes/header.jsp"></jsp:include>
		<div class="container-fluid">
		    <div class="row flex-nowrap">
		    <jsp:include page = "/includes/sidebar-fabrica-piezas.jsp"></jsp:include>
			    <div class="col-md-7 py-3 align-self-center" style="margin-left: 15%">
				<h2>Registrar Nueva Pieza</h2>
				<form action="registrar-nuevas-piezas.jsp" method="POST">
				    <div class="row mb-3">
					<label for="inputTipoPieza" class="col-sm-2 col-form-label">Elegir tipo de pieza:</label>
				    </div>
				    <div class="input-group mb-3">
					<label class="input-group-text" for="input1">Tipo Existente</label>
					<div class="input-group-text">
					    <input class="form-check-input mt-0" type="radio" name="tipo-pieza" value="" checked onclick="input2.disabled = true; input1.disabled = false">
					</div>					
					<select class="form-select" id="input1" name="input1" required>
					    <option disabled selected value="">Elige...</option>
					<%
						ResultSet tiposDePiezas = null;
						try {
							tiposDePiezas = ControlPiezas.tipoPiezas();
						} catch (SQLException e) {

						}
						while (tiposDePiezas.next()) {
					%>
					<option value="<%= tiposDePiezas.getString("nombre")%>"><%= tiposDePiezas.getString("nombre")%></option>
					<%
						}
					%>
				    </select>
				</div>
				<div class="input-group mb-3">
				    <label class="input-group-text" for="input2">Tipo Nuevo</label>
				    <div class="input-group-text">
					<input class="form-check-input mt-0" type="radio" name="tipo-pieza" value="" onclick="input2.disabled = false; input1.disabled = true">
				    </div>					
				    <input class="form-control" id="input2" name="input2" disabled required>
				</div>
				<div class="row mb-3">
				    <label for="inputTipoPieza" class="col col-form-label">Ingresa el precio de la pieza:</label>
				</div>
				<div class="input-group mb-3">
				    <span class="input-group-text">Q.</span>
				    <input type="number" min="0" step="0.01" value="0.00" class="form-control" name="costo" required>
				    <span class="input-group-text">.00</span>
				</div>
				<button type="submit" class="btn btn-primary">Registrar</button>
			    </form>
			    <c:if test="${param.costo != null}">
				    <%
					    String tipoExistente = request.getParameter("input1");
					    String tipoNoExistente = request.getParameter("input2");
					    float costo = Float.valueOf(request.getParameter("costo"));
				    %>
				    <jsp:include page="registrar-pieza.jsp">
					    <jsp:param name="tipo-existente" value="<%= tipoExistente%>" />
					    <jsp:param name="tipo-no-existente" value="<%= tipoNoExistente%>" />
					    <jsp:param name="costo" value="<%= costo%>" />
				    </jsp:include>			    
			    </c:if>
		    </div>
		</div>
	</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/fabrica.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>