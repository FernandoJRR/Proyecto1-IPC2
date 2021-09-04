<%-- 
    Document   : sidebar-fabrica-ensamble
    Created on : Sep 3, 2021, 9:36:54 AM
    Author     : fernanrod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-auto col-md-3 col-xl-2 px-sm-2 px-0 bg-dark">
    <div class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 text-white" style='margin-bottom: 168%'>
	<a href="${pageContext.request.contextPath}/paginas/fabrica/ensamble-fabrica.jsp" class="d-flex align-items-center pb-3 mb-md-0 me-md-auto text-white text-decoration-none">
	    <span class="fs-5 d-none d-sm-inline">Ensamblaje de Muebles</span>
	</a>
	<ul class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start" id="menu">
	    <li class="nav-item">
		<a href="${pageContext.request.contextPath}/paginas/fabrica/ver-muebles-ensamblados.jsp" class="nav-link align-middle px-0">
		    <i class="fs-4 bi-house"></i> <span class="ms-1 d-none d-sm-inline" style="color: #de9a57">Ver Muebles Ensamblados</span>
		</a>
	    </li>
	    <li>
		<a href="${pageContext.request.contextPath}/paginas/fabrica/ensamblar-nuevos-muebles.jsp" class="nav-link px-0 align-middle">
		    <i class="fs-4 bi-table"></i> <span class="ms-1 d-none d-sm-inline" style="color: #de9a57">Ensamblar Nuevo Mueble</span></a>
	    </li>
	    <li>
		<a href="${pageContext.request.contextPath}/paginas/fabrica/desensamblar-muebles.jsp" class="nav-link px-0 align-middle">
		    <i class="fs-4 bi-people"></i> <span class="ms-1 d-none d-sm-inline" style="color: #de9a57">Desensamblar Mueble</span> </a>
	    </li>
	</ul>
	<hr>
    </div>
</div>
