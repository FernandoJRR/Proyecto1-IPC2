<%-- 
    Document   : registro-nuevos-modelos
    Created on : Sep 4, 2021, 1:33:03 PM
    Author     : fernanrod
--%>

<%@page import="exceptions.DuplicadoException"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="exceptions.NoExisteException"%>
<%@page import="exceptions.ConflictException"%>
<%@page import="controlador.ControlEnsamble"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controlador.ControlPiezas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
	String modelo = request.getParameter("modelo");
	float precioVenta = Float.valueOf(request.getParameter("precio"));
	HashMap<String, Integer> cantidadPiezas = new HashMap<>();
	try {
		int i = 0;
		while (request.getParameter("tipo" + i) != null) {
			String tipo = request.getParameter("tipo" + i);
			int cantidad = Integer.valueOf(request.getParameter("cantidad" + i));
			if (!cantidadPiezas.containsKey(tipo)) {
				cantidadPiezas.put(tipo, cantidad);
			} else {
				throw new ConflictException();
			}
			i++;
		}

		ControlEnsamble.crearModeloMueble(modelo, precioVenta);

		for (Map.Entry<String, Integer> set : cantidadPiezas.entrySet()) {
			ControlEnsamble.agregarInstruccionModelo(modelo, set.getKey(), set.getValue());
		}
%>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    El modelo se ha registrado exitosamente!
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%} catch (ConflictException | DuplicadoException e) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    No se ha podido registrar el modelo, revisa y vuelve a ingresar los id. Recuerda que el nombre del modelo no puede repetirse.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% } catch (SQLException e) {%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    Ha ocurrido un error, contacta con el administrador.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% }%>
