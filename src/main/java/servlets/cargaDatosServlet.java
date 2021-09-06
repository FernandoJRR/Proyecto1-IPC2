/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controlador.CargadorDatos;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author fernanrod
 */
@WebServlet(name = "cargaDatosServlet", urlPatterns = {"/paginas/administracion/carga-datos-servlet"})
@MultipartConfig(location = "/tmp")
public class cargaDatosServlet extends HttpServlet {

	public static final String PATH = System.getProperty("user.home");

	/**
	 * Handles the HTTP <code>POST</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		Part filePart = request.getPart("archivo");
		String fileName = filePart.getName();
		InputStream fileStream = filePart.getInputStream();
		
		ArrayList<String> lineas = new ArrayList<>();

		try (BufferedReader in = new BufferedReader(new InputStreamReader(fileStream))) {
			String line = in.readLine();
			while (line != null) {
				lineas.add(line);
				line = in.readLine();
				System.out.println("linea");
			}
			CargadorDatos.cargarDatos(lineas);
			String filePath = PATH + "/" + "archivo";
			filePart.write(filePath);
			request.getRequestDispatcher("/paginas/administracion/carga-datos.jsp?carga=true").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}
