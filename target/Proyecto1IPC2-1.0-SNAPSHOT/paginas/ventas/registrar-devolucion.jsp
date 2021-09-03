<%-- 
    Document   : registrar-devolucion
    Created on : Sep 2, 2021, 12:28:41 PM
    Author     : fernanrod
--%>

<%@page import="controlador.ControlVentas"%>
<%@page import="java.sql.ResultSet"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page = "/includes/recursos.jsp"/>
	<script src="utils-registro.js"></script>
	<title>Departamento de Ventas</title>
    </head>
    <body>
	<%
		ResultSet factura = ControlVentas.obtenerDatosFactura(Integer.valueOf(request.getParameter("factura")));
		factura.next();
		String encargado = factura.getString("encargado");
		String fechaFacturacion = factura.getString("fecha");
	%>
	<jsp:include page = "/includes/header.jsp"/>
	<div class="container-fluid" style="margin-left: 20%; max-width: 60%">
	    <h2>Datos Factura:</h2>
	    <div class="input-group mb-3">
		<span class="input-group-text" id="basic-addon1">Numero de Factura</span>
		<input type="text" class="form-control" placeholder="numero" name="factura" value="<%= request.getParameter("factura")%>" disabled>
	    </div>
	    <div class="input-group mb-3">
		<span class="input-group-text" id="basic-addon1">Usuario Encargado de Facturacion</span>
		<input type="text" class="form-control" placeholder="usuario" value="<%= encargado%>" disabled> 
	    </div>
	    <div class="input-group mb-3">
		<span class="input-group-text" id="basic-addon1">Fecha de Facturacion</span>
		<input type="text" class="form-control" placeholder="fecha" value="<%= fechaFacturacion%>" disabled> 
	    </div>
	    <table class="table table-striped">
		<thead>
		    <tr>
			<th>Id del Mueble</th>
			<th>Nombre del Mueble</th>
			<th>Precio</th> 
			<th>Estado</th> 
		    </tr>
		</thead>
		<tbody>
		    <%
			    factura.beforeFirst();
			    while (factura.next()) {
				    int idMueble = factura.getInt("mueble_comprado");
				    String nombreMueble = factura.getString("nombre_mueble");
				    float precio = factura.getFloat("precio");
				    String comprobante = factura.getString("comprobante");
		    %>
		    <tr>
			<td><%= idMueble%></td>
			<td><%= nombreMueble%></td>
			<td>Q.<%= precio%></td>
			<%if (comprobante == null) {%>
			<td>Comprado</td>
			<% } else {%>
			<td>Devuelto</td>
			<% }%>
		    </tr>
		    <%
			    }
		    %>
		</tbody>
	    </table>
	    <form action="proceso-devolucion.jsp" method="POST" class="mb-3">
		<input type="hidden" name="factura" value="<%= request.getParameter("factura")%>">
		<h2>Muebles a Devolver</h2>
		<h4 style="align-center">Ingresa los id de los muebles a devolver:</h4>
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
		    <button type="submit" class="btn btn-outline-primary mt-3">Devolver</button>
		</div>   
	    </form>
	    <c:if test="${param.fueraDeFecha != null}">
		    <div class="alert alert-danger alert-dismissible fade show" role="alert">
			El tiempo para realizar la devolucion ha caducado, el cliente solo tiene un plazo de una semana desde la compra para devolver.
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		    </div>
	    </c:if>
	    <c:if test="${param.devolucionFallida != null}">
		    <div class="alert alert-danger alert-dismissible fade show" role="alert">
			Ha ocurrido un error, revisa y vuelve a ingresar los id.
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		    </div>
	    </c:if>
	</div>
	<div style="margin-top: 16.5%">
	    <jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/ventas.jsp"/></jsp:include>
	    <jsp:include page = "/includes/footer.jsp"></jsp:include>	
	</div>
    </body>
</html>
