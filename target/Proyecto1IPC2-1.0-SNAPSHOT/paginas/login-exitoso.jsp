<%-- 
    Document   : login-exitoso
    Created on : Aug 15, 2021, 5:22:13 AM
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
        <h1>Si funciono</h1>
	<h2><%=sesion.getAttribute("usuario")%></h2>
	<h2><%=sesion.getAttribute("tipoDeUsuario")%></h2>
    </body>
</html>
