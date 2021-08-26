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