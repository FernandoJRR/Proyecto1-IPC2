<%-- 
    Document   : ver-usuarios-registrados
    Created on : Aug 29, 2021, 5:47:10 AM
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
			    <div class="container-fluid align-self-center" style="margin-left: 15%" id="searchDiv">
				<div class="row">
				    <div class="col-md-auto" style="margin-left: 14%">
					<h2>Usuarios Registrados</h2>
				    </div>
				</div>
				<div class="row">
				    <div class="col">
					<form action="ver-usuarios-registrados.jsp" method="GET">
					    <div class="input-group">
						<div class="form-floating" style="min-width: 40%">
						    <input type="text" class="form-control" id="barra" name="busqueda" placeholder="Username">
						    <label for="barra">Username</label>
						</div>
						<button class="btn btn-outline-primary" type="submit">Buscar</button>
					    </div>
					    <div id="notaBusqueda" class="form-text">Si no ingresas nada a la barra se mostraran todos los usuarios.</div>
					</form>
				    </div>
				</div>
			    <c:if test="${param.busqueda != null}">
				    <div class="row py-3" style="max-width: 47%">

					<script>
                                                document.getElementById("searchDiv").className = "container-fluid py-5";
					</script>
					<jsp:include page="resultados-usuarios-registrados.jsp"></jsp:include>
					</div>
			    </c:if>
		    </div>
		</div>
	</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/finanzas.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>
