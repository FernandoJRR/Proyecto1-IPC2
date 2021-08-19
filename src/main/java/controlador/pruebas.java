package controlador;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

import exceptions.ConflictException;
import exceptions.DuplicadoException;
import exceptions.NoExisteException;

public class pruebas {
    public static void main(String[] args){
        Scanner input = new Scanner(System.in);

        /*
        String nombre;
        System.out.println("Modelo:");
        nombre = input.nextLine();

        String username;
        System.out.println("Usuario:");
        username = input.nextLine();
        */
        int idMueble;
        System.out.println("ID:");
        idMueble = Integer.valueOf(input.nextLine());

        /*
        LocalDate fecha;
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        System.out.println("Fecha:");
        fecha = LocalDate.parse(input.nextLine(),formato);
        */

        input.close();
        
        Integer id[] = {4,8,10,11,12};
        
        try {
            ControlEnsamble.desensamblarMueble(idMueble);
            System.out.println("Query exitoso");
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NoExisteException e) {
            System.out.println("Algo no existe");
        } catch (ConflictException e) {
            System.out.println("Hay un conflicto");
        } catch (DuplicadoException e) {
            System.out.println("Hay un duplicado");
        }
    }
}
