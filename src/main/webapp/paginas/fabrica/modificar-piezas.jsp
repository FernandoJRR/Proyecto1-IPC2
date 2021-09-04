<%-- 
    Document   : modificar-o-eliminar-piezas
    Created on : Aug 25, 2021, 11:35:17 PM
    Author     : fernanrod
--%>

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
		    <jsp:include page = "/includes/sidebar-fabrica-piezas.jsp"></jsp:include>
			    <div class="col-md-5 py-3 my-auto" style="margin-left: 15%">
				<h2>Modificar Pieza</h2>
				<div class="row">
				    <label class="form-label">Ingresa el id de la pieza:</label>
				</div>
				<form class="row g-3">
				    <div class="col-md-6">
					<select class="form-select">
					    <option disabled selected value="0">Elige un id...</option>
					    <option value="1">One</option>
					    <option value="2">Two</option>
					    <option value="3">Three</option>
					</select>				    
				    </div>
				    <div class="col-md-6">
					<input type="text" class="form-control" id="inputPassword4" disabled readonly>
				    </div>
				    <div class="col-12">
					<label for="inputAddress" class="form-label">Address</label>
					<input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St">
				    </div>
				    <div class="col-12">
					<label for="inputAddress2" class="form-label">Address 2</label>
					<input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
				    </div>
				    <div class="col-md-6">
					<label for="inputCity" class="form-label">City</label>
					<input type="text" class="form-control" id="inputCity">
				    </div>
				    <div class="col-md-4">
					<label for="inputState" class="form-label">State</label>
					<select id="inputState" class="form-select">
					    <option selected>Choose...</option>
					    <option>...</option>
					</select>
				    </div>
				    <div class="col-md-2">
					<label for="inputZip" class="form-label">Zip</label>
					<input type="text" class="form-control" id="inputZip">
				    </div>
				    <div class="col-12">
					<div class="form-check">
					    <input class="form-check-input" type="checkbox" id="gridCheck">
					    <label class="form-check-label" for="gridCheck">
						Check me out
					    </label>
					</div>
				    </div>
				    <div class="col-12">
					<button type="submit" class="btn btn-primary">Sign in</button>
				    </div>
				</form>
			    </div>
		    </div>
		</div>
	<jsp:include page = "/includes/volver-footer.jsp"><jsp:param name="home" value="${pageContext.request.contextPath}/paginas/fabrica.jsp"/></jsp:include>
	<jsp:include page = "/includes/footer.jsp"></jsp:include>
    </body>
</html>