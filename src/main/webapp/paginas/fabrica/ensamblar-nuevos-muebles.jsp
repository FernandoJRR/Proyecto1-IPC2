<%-- 
    Document   : ensamblar-nuevos-muebles
    Created on : Sep 3, 2021, 9:41:04 AM
    Author     : fernanrod
--%>


<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlEnsamble"%>
<%@page import="controlador.ControlPiezas"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page = "/includes/recursos.jsp"></jsp:include>
		<title>Departamento de Fabrica</title>
	</head>
	<body>
	<jsp:include page = "/includes/header.jsp"></jsp:include>
		<div class="container-fluid">
		    <div class="row flex-nowrap">
		    <jsp:include page = "/includes/sidebar-fabrica-ensamble.jsp"></jsp:include>
			    <div class="container-fluid align-self-center" style="margin-left: 15%" id="searchDiv">
				<div class="row">
				    <div class="col-md-auto" style="margin-left: 14%">
					<h2>Ensamblar Mueble</h2>
				    </div>
				</div>
				<div class="row">
				    <h5>Ingresa el modelo del mueble que deseas ensamblar:</h5>
				</div>
				<div class="row">
				    <div class="col">
					<form action="ensamblaje-muebles.jsp" method="GET">
					    <div class="input-group">
						<div class="form-floating" style="min-width: 40%">
						    <select class="form-select" id="modelo" name="modelo" required>
							<option disabled selected value="0">Elige un modelo...</option>
						    <%
							    ResultSet modelosMuebles = null;
							    try {
								    modelosMuebles = ControlEnsamble.obtenerModelosMuebles();
							    } catch (SQLException e) {

							    }
							    while (modelosMuebles.next()) {
						    %>
						    <option value="<%= modelosMuebles.getString("nombre")%>"><%= modelosMuebles.getString("nombre")%></option>
						    <%
							    }
						    %>
						</select>
						<label for="modelo">Modelo</label>
					    </div>
					    <button class="btn btn-outline-primary" type="submit">Ingresar</button>
					</div>
				    </form>
				</div>
			    </div>
		    </div>
		</div>
	</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/fabrica.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>