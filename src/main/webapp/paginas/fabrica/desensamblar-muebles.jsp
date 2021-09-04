<%-- 
    Document   : desensamblar-mueble
    Created on : Sep 3, 2021, 9:47:05 AM
    Author     : fernanrod
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="controlador.ControlPiezas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page = "/includes/recursos.jsp"/>
	<title>Departamento de Fabrica</title>
    </head>
    <body>
	<jsp:include page = "/includes/header.jsp"/>
	<div class="container-fluid">
	    <div class="row flex-nowrap">
		<jsp:include page = "/includes/sidebar-fabrica-ensamble.jsp"/>
		<div class="col-md-7 py-3 align-self-center" style="margin-left: 15%">
		    <h2>Desensamblar Mueble</h2>
		    <h5>Ingresa el id del mueble que quieras desensamblar:</h5>
		    <form class="mb-3" action="desensamblar-muebles.jsp">
			<div class="form-floating mb-3">
			    <input type="number" class="form-control" id="id" name="id" placeholder="numero" required>
			    <label for="username">Id Mueble</label>
			</div>
			<button type="submit" class="btn btn-primary">Desensamblar</button>
		    </form>
		    <c:if test="${param.id != null}">
			    <jsp:include page="desensamble-mueble.jsp"/>
		    </c:if>
		</div>
	    </div>
	</div>
	<jsp:include page = "/includes/volver-footer.jsp">
		<jsp:param name="home" value="${pageContext.request.contextPath}/paginas/fabrica.jsp"/>
	</jsp:include>
	<jsp:include page = "/includes/footer.jsp"/>
    </body>
</html>
