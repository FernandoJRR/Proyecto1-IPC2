<%-- 
    Document   : ver-modelos-registrados
    Created on : Sep 4, 2021, 11:09:54 AM
    Author     : fernanrod
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page = "/includes/recursos.jsp"/>
	<title>Departamento de Administracion</title>
    </head>
    <body>
	<jsp:include page = "/includes/header.jsp"/>
	<div class="container-fluid">
	    <div class="row flex-nowrap">
		<jsp:include page = "/includes/sidebar-administracion-modelos.jsp"/>
		<div class="col m-5 py-3">
		    <h2 class="vertical-center" style="margin-left: 40%" id="formBusqueda">Modelos Registrados</h2>
		    <form class="input-group m-auto vertical-center" style="max-width: 70%" action="ver-modelos-registrados.jsp" method="GET">
			<input type="text" class="form-control" placeholder="Nombre Modelo" name="busqueda" id="barraBusqueda">
			<button class="btn btn-outline-primary" type="submit" id="boton-busqueda">Buscar</button>
		    </form>
		    <small id="notaBusqueda" class="form-text text-muted" style="margin-left: 15.3%">
			Si no ingresas nada en la barra de busqueda se mostraran todos los modelos registrados.
		    </small>
		    <c:if test="${param.busqueda != null}">
			    <script>
                                    document.getElementById("formBusqueda").className = "mb-4";
                                    document.getElementById("barraBusqueda").className = "form-control mb-5";
                                    document.getElementById("boton-busqueda").className = "btn btn-outline-primary mb-5";
                                    document.getElementById("notaBusqueda").style.display = "none";
			    </script>
			    <jsp:include page="resultados-modelos-registrados.jsp"/>
		    </c:if>
		</div>
	    </div>
	</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/finanzas.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>
