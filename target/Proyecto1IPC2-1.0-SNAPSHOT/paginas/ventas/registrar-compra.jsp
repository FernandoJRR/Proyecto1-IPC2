<%-- 
    Document   : registrar-compra
    Created on : Aug 30, 2021, 7:29:34 PM
    Author     : fernanrod
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="exceptions.NoExisteException"%>
<%@page import="controlador.ControlUsuarios"%>
<%@page import="bean.Cliente"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page = "/includes/recursos.jsp"></jsp:include>
		<script src="utils-registro.js"></script>
		<title>Departamento de Ventas</title>
	</head>
	<body>
	<jsp:include page = "/includes/header.jsp"></jsp:include>
		<div class="container-fluid justify-content-center" style="max-width: 60%; margin-top: 5%">
		    <form action="proceso-compra.jsp" method="POST">
			<h2>Datos del cliente:</h2>
		    <%
			    String nit = null;
			    String nombre = null;
			    String direccion = null;
			    String departamento = null;
			    String municipio = null;
			    boolean noExiste = false;
			    try {
				    ResultSet cliente = ControlUsuarios.obtenerDatosUsuario(request.getParameter("nit"));
				    nit = request.getParameter("nit");
				    if (!cliente.next()) {
					    throw new NoExisteException();
				    }
				    nit = cliente.getString("nit");
				    nombre = cliente.getString("nombre");
				    direccion = cliente.getString("direccion");
				    departamento = cliente.getString("departamento");
				    municipio = cliente.getString("municipio");
		    %>
		    <div class="alert alert-success alert-dismissible fade show" role="alert">
			El cliente ya esta registrado en el sistema, por lo que no es necesario introducir nuevamente sus datos personales!
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		    </div>
		    <%
		    } catch (NoExisteException e) {
		    %>
		    <div class="alert alert-warning alert-dismissible fade show" role="alert">
			El cliente no esta registrado en el sistema, por favor ingresa sus datos personales!
			Aunque la compra falle el sistema guardara los datos del cliente.
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		    </div>
		    <% noExiste = true;%>
		    <%
		    } catch (SQLException e) {
		    %><h2>Ha ocurrido un error</h2><%
			    }
		    %>
		    <div class="input-group mb-3">
			<span class="input-group-text" id="nombre-label">NIT</span>
			<input type="text" class="form-control" id="nit" name="nit" value="<%= request.getParameter("nit")%>" disabled required>
			<input type="hidden" name="nit" value="<%= request.getParameter("nit")%>">
		    </div>
		    <div class="input-group mb-3">
			<span class="input-group-text" id="nombre-label">Nombre</span>
			<input type="text" class="form-control" id="nombre" name="nombre" disabled required>
		    </div>
		    <div class="input-group mb-3">
			<span class="input-group-text" id="direccion-label">Direccion</span>
			<input type="text" class="form-control" id="direccion" name="direccion" disabled required>
		    </div>
		    <%
			    if (noExiste) {
		    %>
		    <div class="form-check mb-3">
			<input class="form-check-input" type="checkbox" value="" id="direccionCompleja" onclick="ocultarDepartamentoMunicipio()" checked>
			<label class="form-check-label" for="direccionCompleja">Ingresar Departamento y Municipio</label>
		    </div>
		    <%
			    }
		    %>
		    <div class="input-group mb-3" id="barraDepartamento">
			<span class="input-group-text" id="departamento-label">Departamento</span>
			<input type="text" class="form-control" id="departamento" name="departamento" disabled>
		    </div>
		    <div class="input-group mb-3" id="barraMunicipio">
			<span class="input-group-text" id="municipio-label">Municipio</span>
			<input type="text" class="form-control" id="municipio" name="municipio" disabled>
		    </div>
		    <%
			    if (noExiste) {
		    %>
		    <script>
                            //El ingresar nombre, departamento, municipio y direccion se vuelve posible y requerido
                            document.getElementById("departamento").disabled = false;
                            document.getElementById("municipio").disabled = false;
                            document.getElementById("departamento").required = true;
                            document.getElementById("municipio").required = true;
                            document.getElementById("nombre").disabled = false;
                            document.getElementById("direccion").disabled = false;
		    </script>
		    <%
		    } else {
		    %>
		    <script>
                            document.getElementById("nombre").value = "<%= nombre%>";
                            document.getElementById("direccion").value = "<%= direccion%>";
			<%if (departamento != null) {%>
                            document.getElementById("departamento").value = "<%= departamento%>";
                            document.getElementById("municipio").value = "<%= municipio%>";
			<% } %>
		    </script>
		    <%

			    }
		    %>
		    <h2>Datos de la Compra:</h2>
		    <h4 style="align-center">Ingresa los id de los muebles a comprar:</h4>
		    <ul class="list-group" id="lista-id">
			<li class="list-group-item mx-auto" id="idLi0" name="idLi0"><input type="number" id="id0" name="id0" required></li>
		    </ul>
		    <button class="btn btn-outline-secondary mt-3" type="button" onclick="agregarId()" style="margin-left: 38.5%">
			<img src="${pageContext.request.contextPath}/resources/icon/plus.svg" width="15" height="15" alt="Agregar Id" />
		    </button>
		    <button class="btn btn-outline-secondary mt-3" type="button" onclick="removerId()">
			<img src="${pageContext.request.contextPath}/resources/icon/dash-lg.svg" width="15" height="15" alt="Remover Id" />
		    </button>
		    <div class="row">
			<button type="submit" class="btn btn-outline-primary mt-3">Facturar</button>
		    </div>
		</form>
		<c:if test="${param.compraFallida != null}">
			<div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
			    Registro Fallido, revisa y vuelve a ingresar los id de los muebles!
			    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</c:if>
	</div>
	<div style="margin-top: 16.5%">
	    <jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/ventas/compras-ventas.jsp"/></jsp:include>
	    <jsp:include page = "/includes/footer.jsp"></jsp:include>	
	</div>
    </body>
</html>
