/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.io.Serializable;

/**
 *
 * @author fernanrod
 */
public class Usuario implements Serializable{
	private String username;
	private String password;
	private tipo tipoUsuario;
	
	//Tipos de usuarios posibles
	public enum tipo{
		FABRICA, VENTAS, FINANZAS
	}
	
	public String getUsername() {
		return username;
	}

	public String getPassword() {
		return password;
	}

	public tipo getTipoUsuario() {
		return tipoUsuario;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setTipoUsuario(tipo tipoUsuario) {
		this.tipoUsuario = tipoUsuario;
	}
	
}
