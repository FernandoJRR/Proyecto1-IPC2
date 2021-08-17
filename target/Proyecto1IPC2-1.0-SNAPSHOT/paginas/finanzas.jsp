<%-- 
    Document   : finanzas
    Created on : Aug 15, 2021, 6:05:25 PM
    Author     : fernanrod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%HttpSession sesion = request.getSession();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Finanzas</h1>
	<h2><%=sesion.getAttribute("usuario")%></h2>
	<h2><%=sesion.getAttribute("tipoDeUsuario")%></h2>
    </body>
</html>
