package controlador;

import java.sql.SQLException;
import java.util.Scanner;

import exceptions.ConflictException;
import exceptions.DuplicadoException;

public class pruebas {
    public static void main(String[] args){
        Scanner input = new Scanner(System.in);
        String nombreModelo;
        String nombrePieza;
        int cantidadPieza;
        System.out.println("Modelo:");
        nombreModelo = input.nextLine();
        System.out.println("Pieza:");
        nombrePieza = input.nextLine();
        System.out.println("Cantidad:");
        cantidadPieza = Integer.valueOf( input.nextLine());
        input.close();
        
        try {
            ControlEnsamble.eliminarModelo(nombreModelo);
            System.out.println("Query exitoso");
        } catch (SQLException e) {
            e.printStackTrace();
        } /*catch (DuplicadoException e) {
            System.out.println("Ya estaba registrado");
        } */catch (ConflictException e) {
            System.out.println("No se puede eliminar");
        }
    }
}
