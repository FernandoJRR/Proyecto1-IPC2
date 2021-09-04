<%-- 
    Document   : eliminar-piezas
    Created on : Sep 4, 2021, 10:33:09 AM
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
				<h2>Eliminar Pieza</h2>
				<h5>Ingresa el id de la pieza que quieras eliminar:</h5>
				<form class="mb-3" action="eliminar-piezas.jsp">
				    <div class="form-floating mb-3">
					<input type="number" class="form-control" id="id" name="id" placeholder="numero" required>
					<label for="username">Id Pieza</label>
				    </div>
				    <button type="submit" class="btn btn-primary">Eliminar</button>
				</form>
			    <c:if test="${param.id != null}">
				    <jsp:include page="eliminacion-piezas.jsp"/>
			    </c:if>
			    </div>
		    </div>
		</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/fabrica.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>
