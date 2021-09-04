<%-- 
    Document   : eliminar-modelo
    Created on : Sep 4, 2021, 11:10:32 AM
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
		<title>Departamento de Administracion</title>
	</head>
	<body>
	<jsp:include page = "/includes/header.jsp"></jsp:include>
		<div class="container-fluid">
		    <div class="row flex-nowrap">
		    <jsp:include page = "/includes/sidebar-administracion-modelos.jsp"></jsp:include>
			    <div class="col-md-7 py-3 align-self-center" style="margin-left: 15%">
				<h2>Eliminar Modelo</h2>
				<h5>Ingresa el nombre del modelo que quieres eliminar</h5>
				<form class="mb-3" action="eliminar-modelo.jsp">
				    <div class="form-floating mb-3">
					<input type="text" class="form-control" id="modelo" name="modelo" placeholder="modelo" required>
					<label for="modelo">Nombre Modelo</label>
				    </div>
				    <button type="submit" class="btn btn-primary">Eliminar Modelo</button>
				</form>
			    <c:if test="${param.modelo != null}">
				    <jsp:include page="eliminacion-modelo.jsp"/>
			    </c:if>
			    </div>
		    </div>
		</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/finanzas.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>
