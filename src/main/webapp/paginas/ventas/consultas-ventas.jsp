<%-- 
    Document   : consultas-ventas
    Created on : Sep 1, 2021, 12:29:25 PM
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
		    <jsp:include page = "/includes/sidebar-ventas-consultas.jsp"/>
		    <div class="container-fluid align-self-center" style="margin-left: 15%" id="mensaje">
			<div class="row">
			    <div class="col-md-auto" style="margin-left: 16%">
				<h2>Consultas</h2>
			    </div>
			</div>
			<div class="row">
			    <div class="col-md-auto" style="margin-left: 12.5%">
				<h4>Para hacer alguna consulta selecciona una opcion del menu</h4>
			    </div>
			</div>
		    </div>
		</div>
	</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/ventas.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>