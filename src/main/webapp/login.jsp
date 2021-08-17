<%-- 
    Document   : login
    Created on : Aug 14, 2021, 7:08:26 AM
    Author     : fernanrod
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="controlador.*"%>
<jsp:useBean id="usuario" class="bean.Usuario" scope="request"/>
<jsp:setProperty name="usuario" property="*"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Test</title>
    </head>
    
	<%
		boolean statusUsername = AutenticadorUsuario.autenticarUsername(usuario);
		boolean statusPassword = false;
		if(statusUsername){
			statusPassword = AutenticadorUsuario.autenticarPassword(usuario);
		}
		
		if(statusUsername && statusPassword){
			bean.Usuario.tipo tipoUsuario = AutenticadorUsuario.darTipoUsuario(usuario);
	%>
	<%
			String username = usuario.getUsername();
			String tipoPagina = "index";
			switch(tipoUsuario){
				case FABRICA:
					tipoPagina = "fabrica";
					%><jsp:forward page = "fabrica.jsp"/><%
					break;
				case VENTAS:
					tipoPagina = "ventas";
					%><jsp:forward page = "ventas.jsp"/><%
					break;
				case FINANZAS:
					tipoPagina = "finanzas";
					%><jsp:forward page = "finanzas.jsp"/><%
					break;
				default:
					response.sendRedirect("index.jsp");
					break;
			}
			response.sendRedirect("paginas/"+tipoPagina+".jsp?username="+username+"&tipoUsuario="+tipoUsuario.toString());
	%>
	<%
		}else if(statusUsername==false){
	%>
			<jsp:forward page="index.jsp">
				<jsp:param name="validezUsername" value="false"/>
				<jsp:param name="validezPassword" value="true"/>
			</jsp:forward>
	<%
		}else if(statusUsername && statusPassword==false){
	%>
			<jsp:forward page="index.jsp">
				<jsp:param name="validezUsername" value="true"/>
				<jsp:param name="validezPassword" value="false"/>
			</jsp:forward>
	<%
		}
	%>
    
</html>
