<%-- 
    Document   : compras-ventas
    Created on : Aug 30, 2021, 4:43:27 PM
    Author     : fernanrod
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page = "/includes/recursos.jsp"></jsp:include>
		<title>Departamento de Ventas</title>
	</head>
	<body>
	<jsp:include page = "/includes/header.jsp"></jsp:include>
		<div class="container-fluid">
		    <div class="row flex-nowrap">
			<div class="container-fluid" style="margin-left: 27%; margin-top: 15%" id="searchDiv">
			    <div class="row">
				<div class="col-md-auto" style="margin-left: 14%">
				    <h2>Registrar Compras</h2>
				</div>
			    </div>
			    <div class="row">
				<div class="col">
				    <form action="registrar-compra.jsp" method="GET">
					<div class="input-group">
					    <div class="form-floating" style="min-width: 40%; margin-top: 2%">
						<input type="text" class="form-control" id="nit" name="nit" placeholder="nit" pattern="\d{5,9}[A-Za-z0-9]$" title="Un NIT puede tener entre 6 y 10 caracteres, debe terminar por una letra o numero, no puede contener guiones">
						<label for="nit">NIT:</label>
					    </div>
					    <button class="btn btn-outline-primary" type="submit" style="margin-top: 2%">Ingresa</button>
					</div>
					<div id="notaBusqueda" class="form-text">Ingresa el NIT del comprador.</div>
				    </form>
				<c:if test="${param.compraExitosa != null}">
					<div class="alert alert-success alert-dismissible fade show" role="alert">
					    El registro de la compra ha sido exitoso! Puedes consultar los detalles de esta en el apartado de Consultas!
					    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
				</c:if>
			    </div>
			</div>
		    </div>
		</div>
	</div>
	<div style="margin-top: 16.5%">
	    <jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/ventas.jsp"/></jsp:include>
	    <jsp:include page = "/includes/footer.jsp"></jsp:include>	
	</div>
    </body>
</html>
