package controlador;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

import exceptions.ConflictException;
import exceptions.DuplicadoException;
import exceptions.FueraDeFechaException;
import exceptions.NoExisteException;

public class pruebas {
    public static void main(String[] args){
        Scanner input = new Scanner(System.in);

        /*
        String nit;
        System.out.println("NIT:");
        nit = input.nextLine();
        
        String usuario;
        System.out.println("User:");
        usuario = input.nextLine();

        String nombre;
        System.out.println("Nombre:");
        nombre = input.nextLine();

        String direccion;
        System.out.println("Direccion:");
        direccion = input.nextLine();

        */
        LocalDate fecha;
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        System.out.println("Fecha:");
        fecha = LocalDate.parse(input.nextLine(),formato);

        LocalDate fechaHasta;
        System.out.println("Fecha:");
        fechaHasta = LocalDate.parse(input.nextLine(),formato);

        input.close();
        
        Integer id[] = {6};
        
        try {
            ResultSet ventas = ControlFinanzas.reporteDevoluciones(fecha, fechaHasta);
            System.out.println("Query exitoso");
            while (ventas.next()) {
                System.out.println(ventas.getString("nombre_mueble"));
                System.out.println(ventas.getString("fecha"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } /*catch (NoExisteException e) {
            System.out.println("Algo no existe");
        } catch (ConflictException e) {
            System.out.println("Hay un conflicto");
        } catch (FueraDeFechaException e) {
            System.out.println("Fecha vencida");
        }*/
    }
}
