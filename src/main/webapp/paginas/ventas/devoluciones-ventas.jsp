<%-- 
    Document   : devoluciones-ventas
    Created on : Aug 30, 2021, 4:43:46 PM
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
				    <h2>Registrar Devoluciones</h2>
				</div>
			    </div>
			    <div class="row">
				<div class="col">
				    <form action="validar-devolucion.jsp" method="GET">
					<div class="input-group">
					    <div class="form-floating" style="min-width: 40%; margin-top: 2%">
						<input type="number" class="form-control" id="factura" name="factura" placeholder="factura" pattern="[0-9]+" title="Solo puedes ingresar numeros enteros">
						<label for="factura">Numero de Factura:</label>
					    </div>
					    <button class="btn btn-outline-primary" type="submit" style="margin-top: 2%">Ingresa</button>
					</div>
					<div id="notaBusqueda" class="form-text">Ingresa el numero de factura para realizar la devolucion.</div>
				    </form>
				<c:if test="${param.devolucionExitosa != null}">
					<div class="alert alert-success alert-dismissible fade show" role="alert">
					    La devolucion ha sido exitosa!.
					    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
				</c:if>
				<c:if test="${param.facturaValida != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
					    La factura ingresada no existe, revisa el numero ingresado.
					    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
				</c:if>
				<c:if test="${param.fueraDeFecha != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
					    Ha pasado mas de una semana desde la compra, por lo que no se puede devolver ningun mueble.
					    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
				</c:if>
				<c:if test="${param.error != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
					    Ha ocurrido un error fatal, contacta al administrador.
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

