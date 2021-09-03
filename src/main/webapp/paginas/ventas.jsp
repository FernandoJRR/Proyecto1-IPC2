<%-- 
    Document   : ventas
    Created on : Aug 15, 2021, 6:05:19 PM
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
			<img class="card-img-top" src="${pageContext.request.contextPath}/img/logoCompras.png" alt="Card image cap">
		    <div class="card-body">
			<h5 class="card-title">Registrar Compra</h5>
			<p class="card-text">Aqui puedes facturar a los clientes que deseen realizar una compra.</p>
			<a href="${pageContext.request.contextPath}/paginas/ventas/compras-ventas.jsp" class="btn btn-primary">Facturar</a>
		    </div>
		</div>
		<div class="card text-center mx-auto" style="width: 18rem;">
		    <img class="card-img-top" src="${pageContext.request.contextPath}/img/logoDevolucion.jpg" alt="Card image cap">
		    <div class="card-body">
			<h5 class="card-title">Realizar Devolucion</h5>
			<p class="card-text">Aqui puedes registrar una devolucion en caso que un cliente devuelva un mueble.</p>
			<a href="${pageContext.request.contextPath}/paginas/ventas/devoluciones-ventas.jsp" class="btn btn-primary">Registrar</a>
		    </div>
		</div>
		<div class="card text-center mx-auto" style="width: 18rem;">
		    <img class="card-img-top" src="${pageContext.request.contextPath}/img/logoConsultas.png" alt="Card image cap">
		    <div class="card-body">
			<h5 class="card-title">Consultas</h5>
			<p class="card-text">Aqui puedes realizar consultas como ver el catalogo, ver las ventas, entre otras.</p>
			<a href="${pageContext.request.contextPath}/paginas/ventas/consultas-ventas.jsp" class="btn btn-primary">Registrar</a>
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
		if (sesion.getAttribute("loged") == null || (Boolean) sesion.getAttribute("loged") == false || !sesion.getAttribute("tipoDeUsuario").toString().equals("VENTAS")) {
			response.sendRedirect("../index.jsp");
		}
	%>
                    }
                });
    </script>
</html>
