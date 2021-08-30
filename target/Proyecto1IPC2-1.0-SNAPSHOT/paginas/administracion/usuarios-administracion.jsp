<%-- 
    Document   : usuarios-administracion
    Created on : Aug 28, 2021, 9:03:02 PM
    Author     : fernanrod
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			    <div class="container-fluid align-self-center" style="margin-left: 15%">
				<div class="row">
				    <div class="col-md-auto" style="margin-left: 5%">
					<h2>Bienvenido a la Administracion de Usuarios!</h2>
				    </div>
				</div>
				<div class="row">
				    <div class="col-md-auto">
					<h3>Usa el menu lateral para navegar por las opciones del sistema.</h3>
				    </div>
				</div>
			    </div>
		    </div>
		</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/finanzas.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>