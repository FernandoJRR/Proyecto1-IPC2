<%-- 
    Document   : sidebar-administracion-usuarios
    Created on : Aug 28, 2021, 9:06:09 PM
    Author     : fernanrod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-auto col-md-3 col-xl-2 px-sm-2 px-0 bg-dark">
    <div class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 text-white" style='margin-bottom: 168%'>
	<a href="${pageContext.request.contextPath}/paginas/administracion/usuarios-administracion.jsp" class="d-flex align-items-center pb-3 mb-md-0 me-md-auto text-white text-decoration-none">
	    <span class="fs-5 d-none d-sm-inline">Usuarios</span>
	</a>
	<ul class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start" id="menu">
	    <li class="nav-item">
		<a href="${pageContext.request.contextPath}/paginas/administracion/ver-usuarios-registrados.jsp" class="nav-link align-middle px-0">
		    <i class="fs-4 bi-house"></i> <span class="ms-1 d-none d-sm-inline" style="color: #de9a57">Ver Usuarios Registrados</span>
		</a>
	    </li>
	    <li>
		<a href="${pageContext.request.contextPath}/paginas/administracion/registrar-nuevos-usuarios.jsp" class="nav-link px-0 align-middle">
		    <i class="fs-4 bi-table"></i> <span class="ms-1 d-none d-sm-inline" style="color: #de9a57">Registrar Nuevos Usuarios</span></a>
	    </li>
	    <li>
		<a href="${pageContext.request.contextPath}/paginas/administracion/eliminar-usuarios.jsp" class="nav-link px-0 align-middle">
		    <i class="fs-4 bi-people"></i> <span class="ms-1 d-none d-sm-inline" style="color: #de9a57">Eliminar Usuarios</span> </a>
	    </li>
	</ul>
	<hr>
    </div>
</div>