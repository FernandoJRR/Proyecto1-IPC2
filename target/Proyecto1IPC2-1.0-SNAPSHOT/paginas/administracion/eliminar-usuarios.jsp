<%-- 
    Document   : eliminar-usuarios
    Created on : Aug 29, 2021, 11:28:09 AM
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
			    <div class="col-md-7 py-3 align-self-center" style="margin-left: 15%">
				<h2>Eliminar Usuario</h2>
				<h5>Ingresa el username del usuario que quieras cancelar</h5>
				<form action="eliminar-usuarios.jsp">
				    <div class="form-floating mb-3">
					<input type="text" class="form-control" id="username" name="username" placeholder="name@example.com" required>
					<label for="username">Username</label>
				    </div>
				    <button type="submit" class="btn btn-primary">Cancelar Usuario</button>
				</form>
			    <c:if test="${param.username != null}">
				    <%
					    String username = request.getParameter("username");
				    %>
				    <jsp:include page="eliminacion-usuario.jsp">
					    <jsp:param name="username" value="<%= username%>"></jsp:param>
				    </jsp:include>
			    </c:if>
			    </div>
		    </div>
		</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/finanzas.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>
