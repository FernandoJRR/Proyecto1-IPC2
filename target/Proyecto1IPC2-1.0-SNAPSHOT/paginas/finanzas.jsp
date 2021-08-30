<%-- 
    Document   : finanzas
    Created on : Aug 15, 2021, 6:05:25 PM
    Author     : fernanrod
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%HttpSession sesion = request.getSession();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page = "/includes/recursos.jsp"></jsp:include>
		<title>Departamento de Finanzas y Administracion</title>
	</head>
	<body>
	<jsp:include page = "/includes/header.jsp"></jsp:include>
		<div class="container-fluid vertical-center">
		    <div class="card text-center mx-auto" style="width: 18rem;">
			<img class="card-img-top" src="${pageContext.request.contextPath}/img/logoUsuario.jpg" alt="Card image cap">
		    <div class="card-body">
			<h5 class="card-title">Usuarios</h5>
			<p class="card-text">Aqui puedes administrar los usuarios registrados en el sistema.</p>
			<a href="${pageContext.request.contextPath}/paginas/administracion/usuarios-administracion.jsp" class="btn btn-primary">Administrar</a>
		    </div>
		</div>
		<div class="card text-center mx-auto" style="width: 18rem;">
		    <img class="card-img-top" src="${pageContext.request.contextPath}/img/modeloMadera.jpg" alt="Card image cap">
		    <div class="card-body">
			<h5 class="card-title">Modelos de Muebles</h5>
			<p class="card-text">Aqui puedes administrar los registros de los modelos de muebles ensamblables de la muebleria.</p>
			<a href="${pageContext.request.contextPath}/paginas/fabrica/modelos-fabrica.jsp" class="btn btn-primary">Administrar</a>
		    </div>
		</div>
		<div class="card text-center mx-auto" style="width: 18rem;">
		    <img class="card-img-top" src="${pageContext.request.contextPath}/img/logoReporte.jpg" alt="Card image cap">
		    <div class="card-body">
			<h5 class="card-title">Reportes</h5>
			<p class="card-text">Aqui puedes ver los reportes de la Muebleria.</p>
			<a href="${pageContext.request.contextPath}/paginas/administracion/usuarios-administracion.jsp" class="btn btn-primary">Revisar</a>
		    </div>
		</div>
		<div class="card text-center mx-auto" style="width: 18rem;">
		    <img class="card-img-top" src="${pageContext.request.contextPath}/img/cargaDatos.png" alt="Card image cap">
		    <div class="card-body">
			<h5 class="card-title">Carga de Datos</h5>
			<p class="card-text">Aqui puedes cargar datos al sistema.</p>
			<a href="${pageContext.request.contextPath}/paginas/fabrica/modelos-fabrica.jsp" class="btn btn-primary">Cargar</a>
		    </div>
		</div>
	</div>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
	</body>
	<script>window.addEventListener("pageshow", function (event) {
                    var historyTraversal = event.persisted ||
                            (typeof window.performance != "undefined" && window.performance.navigation.type === 2);
                    if (historyTraversal) {
                        // Se recarga la pagina
                        window.location.reload();
	<%
		if (sesion.getAttribute("loged") == null || (Boolean) sesion.getAttribute("loged") == false || !sesion.getAttribute("tipoDeUsuario").toString().equals("FINANZAS")) {
			response.sendRedirect("../index.jsp");
		}
	%>
                    }
                });
    </script>
</html>