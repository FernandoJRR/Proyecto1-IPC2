<%-- 
    Document   : ver-muebles-ensamblados
    Created on : Sep 3, 2021, 9:40:36 AM
    Author     : fernanrod
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page = "/includes/recursos.jsp"></jsp:include>
	<script src="${pageContext.request.contextPath}/resources/js/util-tablas.js"></script>
		<title>Departamento de Fabrica</title>
	</head>
	<body>
	<jsp:include page = "/includes/header.jsp"></jsp:include>
		<div class="container-fluid">
		    <div class="row flex-nowrap">
		    <jsp:include page = "/includes/sidebar-fabrica-ensamble.jsp"></jsp:include>
			    <div class="col m-5 py-3">
				<h2 class="vertical-center" style="margin-left: 40%" id="formBusqueda">Muebles Ensamblados</h2>
				<form class="input-group m-auto vertical-center" style="max-width: 70%" action="ver-muebles-ensamblados.jsp" method="GET">
				    <span class="input-group-text" id="basic-addon1">Primer Fecha</span>
				    <input class="form-control" type="date" id="fechaDesde" name="fechaDesde">
				    <span class="input-group-text" id="basic-addon1">Segunda Fecha</span>
				    <input class="form-control" type="date" id="fechaHasta" name="fechaHasta">
				    <button class="btn btn-outline-primary" type="submit" id="boton-busqueda">Buscar</button>
				</form>
				<small id="notaBusqueda" class="form-text text-muted" style="margin-left: 15.3%">
				    Se mostraran los datos entre ambas fechas sin importar cual sea mayor. Si no ingresas alguna de las fechas se mostraran todos los muebles.
				</small>
			    <c:if test="${param.fechaDesde != null}">
				    <script>
					    document.getElementById("formBusqueda").className = "mb-3";
				    </script>
				    <jsp:include page="resultados-muebles-ensamblados.jsp"/>
			    </c:if>
		    </div>
		</div>
	</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/fabrica.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>
