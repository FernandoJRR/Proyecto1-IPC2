package controlador;

import java.sql.SQLException;
import java.util.Scanner;

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
            ControlEnsamble.eliminarInstruccionesMueble(nombreModelo, nombrePieza);
            System.out.println("Query exitoso");
        } catch (SQLException e) {
            e.printStackTrace();
        } /*catch (DuplicadoException e) {
            System.out.println("Ya estaba registrado");
        }*/
    }
}
