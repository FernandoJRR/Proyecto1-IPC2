package controlador;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import bean.Usuario;
import exceptions.ConflictException;
import exceptions.DuplicadoException;
import exceptions.FueraDeFechaException;
import exceptions.NoExisteException;

public class pruebas {
    public static void main(String[] args){
        Scanner input = new Scanner(System.in);

        /*
        String patron;
        System.out.println("Patron:");
        patron = input.nextLine();
        
        String usuario;
        System.out.println("User:");
        usuario = input.nextLine();

        String nombre;
        System.out.println("Nombre:");
        nombre = input.nextLine();

        String direccion;
        System.out.println("Direccion:");
        direccion = input.nextLine();

        LocalDate fechaEnsamble;
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        System.out.println("Fecha:");
        fechaEnsamble = LocalDate.parse(input.nextLine(),formato);
        
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        LocalDate fecha;
        System.out.println("Fecha:");
        fecha = LocalDate.parse(input.nextLine(),formato);
        */

        input.close();

        try {
            ArrayList<String> reporteCSV = GeneradorReportesCSV.generarReporteVentas();
            for (String linea : reporteCSV) {
                System.out.println(linea);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        /*
        for (String string : arregloParametros) {
            System.out.println(string);
        }
        */
        /*
        try {
            ControlEnsamble.ensambleMueble("Mesa de Madera", "fabrica01", fecha);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NoExisteException e) {
            System.out.println("Algo no existe");
        } catch (ConflictException e) {
            System.out.println("Hay un conflicto");
        } catch (FueraDeFechaException e) {
            System.out.println("Fecha vencida");
        }*/
    }
}
