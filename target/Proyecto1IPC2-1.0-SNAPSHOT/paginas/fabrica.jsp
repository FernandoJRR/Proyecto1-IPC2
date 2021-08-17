<%-- 
    Document   : fabrica
    Created on : Aug 15, 2021, 6:04:57 PM
    Author     : fernanrod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% HttpSession sesion = request.getSession();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="..//bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="..//bootstrap/js/bootstrap.min.js"></script>
	<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <title>Departamento de Fabrica</title>
    </head>
    <body>
	<nav class="navbar navbar-light bg-light">
	    <div class="container-fluid">
		<a class="navbar-brand">Fabrica</a>
		 <form class="form-inline" action="logout.jsp">
                    <a><i class="fa fa-user-circle" aria-hidden="true"></i><%=sesion.getAttribute("usuario")%></a>
                    <button class="btn btn-outline-danger my-2 my-sm-0 m-3" type="submit">Log out</button>
                </form>
	    </div>
	</nav>
    </body>
    	<script>window.addEventListener("pageshow", function (event) {
                    var historyTraversal = event.persisted ||
                            (typeof window.performance != "undefined" && window.performance.navigation.type === 2);
                    if (historyTraversal) {
                        // Se recarga la pagina
                        window.location.reload();
	    <%
		    if (sesion.getAttribute("loged") == null || (Boolean)sesion.getAttribute("loged")==false) {
			    response.sendRedirect("index.jsp");
		    }
	    %>
                    }
                });
	</script>
</html>
