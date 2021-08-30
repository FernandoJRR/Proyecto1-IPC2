<%-- 
    Document   : registrar-nuevos-usuarios
    Created on : Aug 29, 2021, 5:47:50 AM
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
		    <jsp:include page = "/includes/sidebar-administracion-usuarios.jsp"></jsp:include>
			    <div class="container" style="margin-left: 14%; margin-top: 11%">
				<h2>Registrar Nuevo Usuario</h2>
				<h4>Ingresa los datos que se piden</h4>
				<form style="max-width: 50%" action="registrar-nuevos-usuarios.jsp" method="POST">
				    <div class="form-floating mb-3">
					<input type="text" class="form-control" id="username" name="username" placeholder="nombre" required>
					<label for="username">Username</label>
				    </div>
				    <div class="form-floating mb-3">
					<input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
					<label for="password">Contraseña</label>
				    </div>
				    <select class="form-select mb-3" id="tipo-usuario" name="tipo-usuario" required>
					<option selected disabled value>Elige un tipo de usuario...</option>
					<option value="FABRICA">Fabrica</option>
					<option value="VENTAS">Ventas</option>
					<option value="FINANZAS">Finanzas/Administracion</option>
				    </select>
				    <div class="col-auto">
					<button type="submit" class="btn btn-primary mb-3">Registrar</button>
				    </div>
				</form>
			    <c:if test="${param.username != null}">
				    <%
					    String username = request.getParameter("username");
					    String password = request.getParameter("password");
					    String tipoUsuario = request.getParameter("tipo-usuario");
				    %>
				    <jsp:include page="registrar-usuario.jsp">
					    <jsp:param name="username" value="<%= username%>"></jsp:param>
					    <jsp:param name="password" value="<%= password%>"></jsp:param>
					    <jsp:param name="tipo-usuario" value="<%= tipoUsuario%>"></jsp:param>
				    </jsp:include>
			    </c:if>
		    </div>
		</div>
	</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/finanzas.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>
