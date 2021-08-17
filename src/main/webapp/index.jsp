<%-- 
    Document   : index.jsp
    Created on : Aug 13, 2021, 9:05:31 PM
    Author     : fernanrod
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="controlador.AutenticadorUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	Boolean validezUsername = null;
	Boolean validezPassword = null;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="Content-Type" content="text/html">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Prueba Login</title>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="jquery-3.6.0.js"></script>
	<script src="index.js"></script>
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="index.css" rel="stylesheet">
        <title>Login</title>
    </head>
    <body>
	<%
		HttpSession sesion = request.getSession();
	%>
	<script>window.addEventListener("pageshow", function (event) {
                    var historyTraversal = event.persisted ||
                            (typeof window.performance != "undefined" && window.performance.navigation.type === 2);
                    if (historyTraversal) {
                        // Se recarga la pagina
                        window.location.reload();
	    <%
		    if (sesion.getAttribute("loged") != null) {
			    out.println(sesion.getAttribute("loged"));
			    if ((Boolean) sesion.getAttribute("loged")) {
				    String pagina = sesion.getAttribute("tipoDeUsuario").toString().toLowerCase();
				    response.sendRedirect("paginas/" + pagina + ".jsp");
			    }
		    }
	    %>
                    }
                });
	</script>
	<div class="container cn">
	    <div class="row">
		<!--
		<div class="col bg"></div>
		-->
		<div class="col">
		    <h2 class="fw-bold text-center py-5">Bienvenido a Mi Muebleria</h2>

		    <!-- login -->
		    <form  class="row g-3 needs-validation" action="index.jsp" method="POST" novalidate>
			<div class="mb-4">
			    <label for="username" class="form-label">Usuario</label>
			    <input type="text" class="form-control" name="username" id="campo-username" required autocomplete="off">
			    <div class="invalid-feedback">El usuario ingresado no es valido</div>
			</div>
			<div class="mb-4">
			    <label for="password" class="form-label">Contraseña</label>
			    <input type="password" class="form-control" name="password" id="campo-password" required>
			    <div class="invalid-feedback">La contraseña ingresada no es valida</div>
			</div>
			<div class="d-grid">
			    <button type="submit" class="btn btn-primary" name="login" onclick="">Iniciar Sesion</button>
			</div>
		    </form>		
		</div>
	    </div>
	</div>
    </body>
    <%	    if (request.getParameter("login") != null) {
		    boolean statusUsername = AutenticadorUsuario.autenticarUsername(request.getParameter("username"));
		    boolean statusPassword = false;
		    if (statusUsername) {
			    statusPassword = AutenticadorUsuario.autenticarPassword(request.getParameter("username"), request.getParameter("password"));
		    }

		    if (statusUsername && statusPassword) {
			    sesion = request.getSession();
			    sesion.setAttribute("loged", true);
			    sesion.setAttribute("usuario", request.getParameter("username"));
			    sesion.setAttribute("tipoDeUsuario", AutenticadorUsuario.darTipoUsuario((String) sesion.getAttribute("usuario")));
			    String pagina = sesion.getAttribute("tipoDeUsuario").toString().toLowerCase();
			    response.sendRedirect("paginas/" + pagina + ".jsp");
		    } else if (statusUsername == false) {
			    validezUsername = false;
			    validezPassword = true;
    %><script>
            document.getElementById("campo-username").className = "form-control is-invalid";
            document.getElementById("campo-password").className = "form-control";
    </script><%
    } else if (statusPassword == false) {
	    validezUsername = true;
	    validezPassword = false;
    %><script>
            document.getElementById("campo-username").className = "form-control";
            document.getElementById("campo-password").className = "form-control is-invalid";
    </script><%
		    }
	    }
    %>
    <script>
            (function () {
                'use strict'

                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.querySelectorAll('.needs-validation')

                // Loop over them and prevent submission
                Array.prototype.slice.call(forms)
                        .forEach(function (form) {
                            form.addEventListener('submit', function (event) {
                                if (!form.checkValidity()) {
                                    event.preventDefault()
                                    event.stopPropagation()
                                }
                                form.classList.add('was-validated')
                            }, false)
                        })
            })()
    </script>
</html>
