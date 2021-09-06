<%-- 
    Document   : carga-datos
    Created on : Sep 4, 2021, 5:23:26 PM
    Author     : fernanrod
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page = "/includes/recursos.jsp"/>
	<title>Departamento de Ventas</title>
    </head>
    <body>
	<jsp:include page = "/includes/header.jsp"/>
	<div class="container-fluid">
	    <div class="row flex-nowrap">
		<jsp:include page = "/includes/sidebar-administracion-carga.jsp"/>
		<div class="container-fluid" style="margin-left: 20%; margin-top: 15%" id="searchDiv">
		    <div class="row">
			<div class="col-md-auto" style="margin-left: 14%">
			    <h2>Carga de Datos</h2>
			</div>
		    </div>
		    <div class="row">
			<div class="col">
			    <form action="carga-datos-servlet" method="POST" enctype="multipart/form-data">
				<div class="input-group">
				    <div class="input-group mt-3" style="max-width: 40%">
					<label class="input-group-text" for="archivo">Subir</label>
					<input type="file" class="form-control" id="archivo" name="archivo" size="50" required>
					<button class="btn btn-outline-primary" type="submit">Cargar</button>
				    </div>
				</div>
				<div id="notaBusqueda" class="form-text">Ingresa el archivo con los datos.</div>
			    </form>
			    <c:if test="${param.carga != null}">
				    <div class="alert alert-success alert-dismissible fade show" role="alert">
					Los datos han sido cargados, puedes ver mas detalles en la seccion "Ver Ultima Carga".
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				    </div>
			    </c:if>
			</div>
		    </div>
		</div>
	    </div>
	</div>
	<div>
	    <jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/finanzas.jsp"/></jsp:include>
	    <jsp:include page = "/includes/footer.jsp"></jsp:include>	
	</div>
    </body>
</html>
