package controlador;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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

        String linea = "ENSAMBLAR_MUEBLE(\"Mesa rustica\", jgranados,\"21/04/2018\")";
        
        Pattern patronEnsamblarMueble = Pattern.compile("^ENSAMBLAR_MUEBLE\\(\"[\\w\\s]+\",\\s*[\\w\\s]+,\\s*\"\\d{2}/\\d{2}/\\d{4}\"\\)$");
        Matcher matcher = patronEnsamblarMueble.matcher(linea);
        
        String parametros = linea.substring(9, linea.length()-1);
        String[] arregloParametros = parametros.split("\\,");
        arregloParametros[0] = arregloParametros[0].substring(0,arregloParametros[0].length()-1).trim();
        for (int i = 1; i < arregloParametros.length; i++) {
            arregloParametros[i] = arregloParametros[i].trim().substring(1, arregloParametros[i].trim().length()-1);
        }
        
        System.out.println(matcher.matches());
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
