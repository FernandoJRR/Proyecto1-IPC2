<%-- 
    Document   : header
    Created on : Aug 25, 2021, 1:24:38 PM
    Author     : fernanrod
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="servlets.logout"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-light bg-light">
    <div class="container-fluid">
	<% if (request.getSession().getAttribute("tipoDeUsuario").toString().equals("FABRICA")) {%>
	<a class="navbar-brand">Fabrica</a>
	<% } else if (request.getSession().getAttribute("tipoDeUsuario").toString().equals("VENTAS")) {%>
	<a class="navbar-brand">Ventas</a>
	<% } else if (request.getSession().getAttribute("tipoDeUsuario").toString().equals("FINANZAS")) {%>
	<a class="navbar-brand">Finanzas</a>
	<% }%>
	<form class="form-inline" action="${pageContext.request.contextPath}/paginas/logout-servlet" method="GET">
	    <a><i class="fa fa-user-circle m-2" aria-hidden="true"></i><%=request.getSession().getAttribute("usuario")%></a>
	    <button class="btn btn-outline-danger my-2 my-sm-0 m-3" type="submit">Log out</button>
	</form>
    </div>
</nav>
