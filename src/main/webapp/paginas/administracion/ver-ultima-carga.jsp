<%-- 
    Document   : ver-ultima-carga
    Created on : Sep 5, 2021, 11:16:20 AM
    Author     : fernanrod
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="controlador.ControlFinanzas"%>
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
		<div class="container-fluid" style="margin-left: 3%; margin-top: 5%; max-width: 75%" id="searchDiv">
		    <div class="row">
			<div class="col-md-auto" style="margin-left: 32%">
			    <h2>Ultima Carga de Datos</h2>
			    <%
				    ResultSet lineasCargadas = null;
				    ResultSet lineasConError = null;
				    try {
					    lineasCargadas = ControlFinanzas.obtenerLineasCargadas();
					    lineasConError = ControlFinanzas.obtenerLineasConError();
				    } catch (SQLException e) {

				    }
			    %>
			</div>
		    </div>
		    <div class="row">
			<h4>Lineas Cargadas</h4>
			<div class="col">
			    <table class="table table-striped">
				<thead>
				    <tr>
					<th>Expresion</th>
				    </tr>
				</thead>
				<tbody>
				    <% while (lineasCargadas.next()) {
						    String expresion = lineasCargadas.getString("expresion");
				    %>
				    <tr>
					<td><%= expresion%></td>
				    </tr>
				    <%
					    }%>
				</tbody>
			    </table>
			</div>
		    </div>
		    <div class="row">
			<div class="col">
			    <h4>Lineas No Cargadas con Error</h4>
			    <table class="table table-striped">
				<thead>
				    <tr>
					<th>Expresion</th>
					<th>Error</th>
				    </tr>
				</thead>
				<tbody>
				    <% while (lineasConError.next()) {
						    String linea = lineasConError.getString("expresion");
						    String error = lineasConError.getString("error");
				    %>
				    <tr>
					<td><%= linea%></td>
					<td><%= error%></td>
				    </tr>
				    <%
					}%>
				</tbody>
			    </table>
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
