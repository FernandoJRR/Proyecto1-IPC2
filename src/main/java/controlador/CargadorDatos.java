package controlador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import bean.Usuario;
import exceptions.ConflictException;
import exceptions.DuplicadoException;
import exceptions.FormatoException;
import exceptions.NoExisteException;

public class CargadorDatos {
    static Connection connection = ConexionBD.getConnection();
    static ArrayList<String> lineas = new ArrayList<>();

    static ArrayList<String> lineasCargadas = new ArrayList<>();
    static ArrayList<String> lineasConError = new ArrayList<>();
    static ArrayList<String> erroresLineas = new ArrayList<>();

//Se crean los patrones usados para la revision del formato
    //Patron para que la expresion sea considerada una instruccion
    static final Pattern patronBase = Pattern.compile("^[A-Z_]+\\(.+\\)$");

    //Patrones de cada tipo de instruccion
    static final Pattern patronUsuario = Pattern.compile("^USUARIO\\(\"[\\w\\s]+\",\\s*\"[\\w\\s]{6,}\",\\s*[123]\\)$");
    static final Pattern patronCliente = Pattern.compile("^CLIENTE\\(\"[\\w\\s]+\",\\s*\"\\d{5,9}[A-Za-z0-9]\",\\s*\".+\"(,\\s*\"[\\w\\s]+\",\\s*\"[\\w\\s]+\")?\\)$");
    static final Pattern patronPieza = Pattern.compile("^PIEZA\\(\"[\\w\\s]+\",\\s*\\d+(\\.\\d{1,2})?\\)$");
    static final Pattern patronMueble = Pattern.compile("^MUEBLE\\(\"[\\w\\s]+\",\\s*\\d+(\\.\\d{1,2})?\\)$");
    static final Pattern patronEnsamblePiezas = Pattern.compile("^ENSAMBLE_PIEZAS\\(\"[\\w\\s]+\",\\s*\"[\\w\\s]+\",\\s*\\d+(\\.\\d{1,2})?\\)$");
    static final Pattern patronEnsamblarMueble = Pattern.compile("^ENSAMBLAR_MUEBLE\\(\"[\\w\\s]+\",\\s*[\\w\\s]+,\\s*\"\\d{2}/\\d{2}/\\d{4}\"\\)$");

    public static void cargarDatos(ArrayList<String> instrucciones) throws SQLException{
        lineas = instrucciones;
        lineasCargadas = new ArrayList<>();
        lineasConError = new ArrayList<>();
        erroresLineas = new ArrayList<>();

        //Orden en el que las ordenes deben de registrarse
        final String[] ordenRegistro = {"USUARIO", "CLIENTE", "PIEZA", "MUEBLE", "ENSAMBLE_PIEZAS", "ENSAMBLAR_MUEBLE"};

        for(Iterator<String> iterator = lineas.iterator(); iterator.hasNext();) {
            String lineaActual = iterator.next();
            try {
                validarFormato(lineaActual);
            } catch (FormatoException e) {
                lineasConError.add(lineaActual);
                erroresLineas.add("Error de Formato");
                iterator.remove();
            }
        }

        for (String instruccionActual : ordenRegistro) {
            for (String linea : lineas) {
                if (linea.split("\\(")[0].equals(instruccionActual)) {
                    registrarLinea(linea, instruccionActual);
                }
            }
        }
        try {
            connection.setAutoCommit(false);
            PreparedStatement limpiarUltimaCarga = connection.prepareStatement("DELETE FROM ultimas_lineas_cargadas");
            limpiarUltimaCarga.executeQuery();
            limpiarUltimaCarga = connection.prepareStatement("DELETE FROM ultimos_errores");
            limpiarUltimaCarga.executeQuery();
            
            //Se guardan las lineas cargadas
            for (String lineaCargada : lineasCargadas) {
                PreparedStatement agregarLinea = connection.prepareStatement("INSERT INTO ultimas_lineas_cargadas(expresion) VALUES (?)");
                agregarLinea.setString(1, lineaCargada);
                agregarLinea.executeUpdate();
            }
            //Se guardan las lineas con error
            for (int i = 0; i < lineasConError.size(); i++) {
                PreparedStatement agregarLinea = connection.prepareStatement("INSERT INTO ultimos_errores(expresion, error) VALUES (?,?)");
                agregarLinea.setString(1, lineasConError.get(i));
                agregarLinea.setString(2, erroresLineas.get(i));
                agregarLinea.executeUpdate();
            }
	    connection.commit();
        } catch (SQLException e) {
            try {
            connection.rollback();
            } catch (SQLException e2) {
            }
        } finally {
            try {
            connection.setAutoCommit(true);
            } catch (SQLException e3) {    
            }
        }
    }
    
    public static void validarFormato(String linea) throws FormatoException{
        Matcher matcher = patronBase.matcher(linea);
        if (!matcher.matches()) {
            throw new FormatoException();
        }
        
        String tipoInstruccion = linea.split("\\(")[0];
        
        Matcher matcherInstruccion = null;
        switch (tipoInstruccion) {
            case "USUARIO":
                matcherInstruccion = patronUsuario.matcher(linea);
                break;
            case "CLIENTE":
                matcherInstruccion = patronCliente.matcher(linea);
                break;
            case "PIEZA":
                matcherInstruccion = patronPieza.matcher(linea);
                break;
            case "MUEBLE":
                matcherInstruccion = patronMueble.matcher(linea);
                break;
            case "ENSAMBLE_PIEZAS":
                matcherInstruccion = patronEnsamblePiezas.matcher(linea);
                break;
            case "ENSAMBLAR_MUEBLE":
                matcherInstruccion = patronEnsamblarMueble.matcher(linea);
                break;
            default:
                throw new FormatoException();
        }
        
        if (!matcherInstruccion.matches()) {
            throw new FormatoException();
        }
    }
    
    public static void registrarLinea(String linea, String instruccionActual){
        String[] parametros = null;
        switch (instruccionActual) {
            case "USUARIO":
                parametros = separarInstruccionUsuario(linea);
                String username = parametros[0];
                String password = parametros[1];
                int tipoUsuario = Integer.valueOf(parametros[2]);
                try {
                    if (tipoUsuario!=1&&tipoUsuario!=2&&tipoUsuario!=3) {
                        throw new ConflictException();
                    }
                    ControlUsuarios.crearUsuario(username, password, Usuario.tipo.values()[tipoUsuario-1]);
                    lineasCargadas.add(linea);
                } catch (SQLException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Error al registrar");
                } catch (DuplicadoException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("El username ya existia previamente");
                } catch (ConflictException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Existen parametros erroneos");
                } catch (Exception e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Error de registro");
                }
                break;
            case "CLIENTE":
                parametros = separarInstruccionesCliente(linea);
                String nombre = parametros[0];
                String nit = parametros[1];
                String direccion = parametros[2];
                String departamento = null;
                String municipio = null;
                if (parametros.length==5) {
                    departamento = parametros[3];
                    municipio = parametros[4];
                }
                try {
                    if (parametros.length==3) {
                        ControlVentas.registrarCliente(nit, nombre, direccion);
                    } else {
                        ControlVentas.registrarCliente(nit, nombre, direccion, municipio, departamento);
                    }
                    lineasCargadas.add(linea);
                } catch (SQLException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Error al registrar");
                } catch (DuplicadoException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("El cliente ya habia sido registrado previamente");
                } catch (ConflictException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Los parametros ingresados no son correctos");
                } catch (Exception e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Error de registro");
                }
                break;
            case "PIEZA":
                parametros = separarInstruccionesPieza(linea);
                String tipoPieza = parametros[0];
                float costo = Float.valueOf(parametros[1]);
                try {
                    ControlPiezas.crearPieza(tipoPieza, costo);
                    lineasCargadas.add(linea);
                } catch (SQLException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Error al registrar");
                } catch (ConflictException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Los parametros ingresados no son validos");
                } catch (Exception e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Error de registro");
                }
                break;
            case "MUEBLE":
                parametros = separarInstruccionesMueble(linea);
                String nombreModelo = parametros[0];
                float precio = Float.valueOf(parametros[1]);
                try {
                    ControlEnsamble.crearModeloMueble(nombreModelo, precio);
                    lineasCargadas.add(linea);
                } catch (SQLException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Error al registrar");
                } catch (DuplicadoException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("El modelo habia sido registrado previamente");
                } catch (ConflictException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Los parametros ingresados no son validos");
                } catch (Exception e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Error de registro");
                }
                break;
            case "ENSAMBLE_PIEZAS":
                parametros = separarInstruccionesEnsamblePiezas(linea);
                String nombreMueble = parametros[0];
                String pieza = parametros[1];
                int cantidadPieza = Integer.valueOf(parametros[2]);
                try {
                    ControlEnsamble.agregarInstruccionModelo(nombreMueble, pieza, cantidadPieza);
                    lineasCargadas.add(linea);
                } catch (SQLException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Error al registrar");
                } catch (DuplicadoException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("La instruccion ya habia sido ingresada previamente");
                    e.printStackTrace();
                } catch (ConflictException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Los parametros ingresados no son correctos");
                    e.printStackTrace();
                } catch (Exception e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Error de registro");
                }
                break;
            case "ENSAMBLAR_MUEBLE":
                parametros = separarInstruccionesEnsamblarMueble(linea);
                String muebleEnsamblado = parametros[0];
                String usuarioEnsamblador = parametros[1];
                try {
                    DateTimeFormatter formatoFecha = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    LocalDate fechaEnsamble = LocalDate.parse(parametros[2], formatoFecha);
                    ControlEnsamble.ensambleMueble(muebleEnsamblado, usuarioEnsamblador, fechaEnsamble);
                    lineasCargadas.add(linea);
                } catch (SQLException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Error al registrar");
                } catch (NoExisteException e) {
                    lineasConError.add(linea);
                    erroresLineas.add("No hay suficientes piezas para el ensamble");
                } catch (Exception e) {
                    lineasConError.add(linea);
                    erroresLineas.add("Error de registro");
                }
                break;
        }
    }
    
    //Separa la linea de instrucciones del Usuario en sus parametros
    public static String[] separarInstruccionUsuario(String linea){
        String parametros = linea.substring(8, linea.length()-1);
        String[] arregloParametros = parametros.split("\\,");
        arregloParametros[0] = arregloParametros[0].trim().substring(1,arregloParametros[0].trim().length()-1).trim();
        arregloParametros[1] = arregloParametros[1].trim().substring(1,arregloParametros[1].trim().length()-1).trim();
        arregloParametros[2] = arregloParametros[2].trim();
        return arregloParametros;
    }
    
    //Separa la linea de instrucciones del Cliente en sus parametros
    public static String[] separarInstruccionesCliente(String linea){
        String parametros = linea.substring(9, linea.length()-1);
        String[] arregloParametros = parametros.split("\\,");
        arregloParametros[0] = arregloParametros[0].substring(0,arregloParametros[0].length()-1).trim();
        for (int i = 1; i < arregloParametros.length; i++) {
            arregloParametros[i] = arregloParametros[i].trim().substring(1, arregloParametros[i].trim().length()-1);
        }
        return arregloParametros;
    }
    
    //Separa la linea de instrucciones de la Pieza en sus parametros
    public static String[] separarInstruccionesPieza(String linea) {
        String parametros = linea.substring(7, linea.length()-1);
        String[] arregloParametros = parametros.split("\\,");
        arregloParametros[0] = arregloParametros[0].substring(0,arregloParametros[0].length()-1).trim();
        arregloParametros[1] = arregloParametros[1].trim();
        return arregloParametros;
    }
    
    //Separa las lineas de instrucciones del Mueble en sus parametros
    public static String[] separarInstruccionesMueble(String linea) {
        String parametros = linea.substring(8, linea.length()-1);
        String[] arregloParametros = parametros.split("\\,");
        arregloParametros[0] = arregloParametros[0].substring(0,arregloParametros[0].length()-1).trim();
        arregloParametros[1] = arregloParametros[1].trim();
        return arregloParametros;
    }
    
    //Separa las lineas de instrucciones del Ensamble de Piezas en sus parametros
    public static String[] separarInstruccionesEnsamblePiezas(String linea) {
        String parametros = linea.substring(17, linea.length()-1);
        String[] arregloParametros = parametros.split("\\,");
        arregloParametros[0] = arregloParametros[0].substring(0,arregloParametros[0].length()-1).trim();
        arregloParametros[1] = arregloParametros[1].trim().substring(1,arregloParametros[1].trim().length()-1).trim();
        arregloParametros[2] = arregloParametros[2].trim();
        return arregloParametros;
    }
    
    //Separa las lineas de instrucciones de Ensamblar Mueble en sus parametros
    public static String[] separarInstruccionesEnsamblarMueble(String linea) {
        String parametros = linea.substring(18, linea.length()-1);
        String[] arregloParametros = parametros.split("\\,");
        arregloParametros[0] = arregloParametros[0].substring(0,arregloParametros[0].length()-1).trim();
        arregloParametros[1] = arregloParametros[1].substring(0,arregloParametros[1].length()).trim();
        arregloParametros[2] = arregloParametros[2].trim().substring(1,arregloParametros[2].trim().length()-1).trim();
        return arregloParametros;
    }
}
