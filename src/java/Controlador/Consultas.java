/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import com.mysql.jdbc.CallableStatement;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.List;
import modelo.Clase;
import modelo.Tutoria;
import modelo.Persona;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import modelo.Taller;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.BodyPart;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
import static org.apache.commons.codec.binary.Base64.decodeBase64;
import static org.apache.commons.codec.binary.Base64.encodeBase64;

/**
 *
 * @author Alex
 */
public class Consultas extends Conexion {

    // Definición del tipo de algoritmo a utilizar (AES, DES, RSA)
    private final static String alg = "AES";
    // Definición del modo de cifrado a utilizar
    private final static String cI = "AES/CBC/PKCS5Padding";

    private final static String key = "92AE31A79FEEB2A3"; //llave
    private final static String iv = "0123456789ABCDEF"; // vector de inicialización

    /**
     * Función de tipo String que recibe una llave (key), un vector de
     * inicialización (iv) y el texto que se desea cifrar
     *
     * @param key la llave en tipo String a utilizar
     * @param iv el vector de inicialización a utilizar
     * @param cleartext el texto sin cifrar a encriptar
     * @return el texto cifrado en modo String
     * @throws Exception puede devolver excepciones de los siguientes tipos:
     * NoSuchAlgorithmException, InvalidKeyException,
     * InvalidAlgorithmParameterException, IllegalBlockSizeException,
     * BadPaddingException, NoSuchPaddingException
     */
    public static String encrypt(String key, String iv, String cleartext) throws Exception {
        Cipher cipher = Cipher.getInstance(cI);
        SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes(), alg);
        IvParameterSpec ivParameterSpec = new IvParameterSpec(iv.getBytes());
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec, ivParameterSpec);
        byte[] encrypted = cipher.doFinal(cleartext.getBytes());
        return new String(encodeBase64(encrypted));
    }

    /**
     * Función de tipo String que recibe una llave (key), un vector de
     * inicialización (iv) y el texto que se desea descifrar
     *
     * @param key la llave en tipo String a utilizar
     * @param iv el vector de inicialización a utilizar
     * @param encrypted el texto cifrado en modo String
     * @return el texto desencriptado en modo String
     * @throws Exception puede devolver excepciones de los siguientes tipos:
     * NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException,
     * InvalidAlgorithmParameterException, IllegalBlockSizeException
     */
    public static String decrypt(String key, String iv, String encrypted) throws Exception {
        Cipher cipher = Cipher.getInstance(cI);
        SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes(), alg);
        IvParameterSpec ivParameterSpec = new IvParameterSpec(iv.getBytes());
        byte[] enc = decodeBase64(encrypted);
        cipher.init(Cipher.DECRYPT_MODE, skeySpec, ivParameterSpec);
        byte[] decrypted = cipher.doFinal(enc);
        return new String(decrypted);
    }

    public boolean autenticacion(String email, String contrasena) {
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            this.conectar();
            st = this.getCn().prepareStatement("SELECT * FROM persona WHERE EmailPersona = ? AND PasswordPersona = ?");
            st.setString(1, email);
            st.setString(2, encrypt(key, iv, contrasena));
            rs = st.executeQuery();
            if (rs.absolute(1)) {
                return true;
            }
        } catch (Exception e) {
            System.err.printf("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (st != null) {
                    st.close();
                }

                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return false;
    }

    public boolean registrar(String nombre, String email, String password) {
        PreparedStatement st = null;

        try {
            this.conectar();
            st = this.getCn().prepareStatement("INSERT INTO persona(NombrePersona, EmailPersona, PasswordPersona, TipoPersona, TelefonoPersona, DireccionPersona, BarrioResidenciaPersona) values(?,?,?,'','','','')");
            st.setString(1, nombre);
            st.setString(2, email);
            st.setString(3, encrypt(key, iv, password));
            if (st.executeUpdate() == 1) {
                confirmarRegistro(nombre, email);
                return true;
            }
        } catch (Exception e) {
            System.err.printf("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (st != null) {
                    st.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return false;
    }

    public boolean editarCuenta(int codigo, String nombre, String direccion, String barrio, String telefono, String email, String password) {
        PreparedStatement st = null;

        try {
            this.conectar();
            st = this.getCn().prepareStatement("UPDATE persona SET NombrePersona = ?, DireccionPersona = ?, BarrioResidenciaPersona = ?, TelefonoPersona = ?, EmailPersona = ?, PasswordPersona = ? WHERE CodigoPersona = ?");
            st.setString(1, nombre);
            st.setString(2, direccion);
            st.setString(3, barrio);
            st.setString(4, telefono);
            st.setString(5, email);
            st.setString(6, encrypt(key, iv, password));
            st.setInt(7, codigo);
            if (st.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            System.err.printf("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (st != null) {
                    st.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return false;
    }

    public boolean verificarHorario(String fecha, String hora) {
        PreparedStatement st = null;
        ResultSet rs = null;
        String fec_hor = fecha + " " + hora + ":00";

        try {
            this.conectar();
            st = this.getCn().prepareStatement("SELECT * FROM clase INNER JOIN Tutoria ON (clase.CodigoTutoria = Tutoria.CodigoTutoria)"
                    + "WHERE clase.FechaClase = ? AND clase.HoraClase = ? OR clase.FechaClase = ? AND TIMESTAMPDIFF(MINUTE, CONCAT(clase.FechaClase,' ',clase.HoraClase),?) < clase.DuracionClase*60");
            st.setString(1, fecha);
            st.setString(2, hora);
            st.setString(3, fecha);
            st.setString(4, fec_hor);
            rs = st.executeQuery();
            if (rs.absolute(1)) {
                return true;
            }
        } catch (Exception e) {
            System.err.printf("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (st != null) {
                    st.close();
                }

                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return false;
    }

    public boolean verificarEmail(String email) {
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            this.conectar();
            st = this.getCn().prepareStatement("SELECT * FROM persona WHERE EmailPersona = ?");
            st.setString(1, email);
            rs = st.executeQuery();
            if (rs.absolute(1)) {
                return true;
            }
        } catch (Exception e) {
            System.err.printf("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (st != null) {
                    st.close();
                }

                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return false;
    }

    public boolean registrarClase(String fecha, String hora, String duracion, String materia,
            String tema, String mensaje, String nombre, String email, String password, String direccion, String barrio,
            String telefono) {

        CallableStatement cst = null;

        try {
            this.conectar();
            cst = (CallableStatement) getCn().prepareCall("CALL ClasePresenciaNueva(?,?,?,?,?,?,?,?,?,?,?,?)");
            cst.setString(1, fecha);
            cst.setString(2, hora);
            cst.setString(3, duracion);
            cst.setString(4, materia);
            cst.setString(5, tema);
            cst.setString(6, mensaje);
            cst.setString(7, nombre);
            cst.setString(8, direccion);
            cst.setString(9, barrio);
            cst.setString(10, telefono);
            cst.setString(11, email);
            cst.setString(12, encrypt(key, iv, password));

            if (cst.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            System.err.println("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (cst != null) {
                    cst.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return false;
    }

    public boolean registrarClaseAnonimo(String fecha, String hora, String duracion, String materia,
            String tema, String mensaje, String nombre, String email, String password, String direccion, String barrio,
            String telefono) {

        CallableStatement cst = null;

        try {
            this.conectar();
            cst = (CallableStatement) getCn().prepareCall("CALL ClasePresenciaNueva(?,?,?,?,?,?,?,?,?,?,?,?)");
            cst.setString(1, fecha);
            cst.setString(2, hora);
            cst.setString(3, duracion);
            cst.setString(4, materia);
            cst.setString(5, tema);
            cst.setString(6, mensaje);
            cst.setString(7, nombre);
            cst.setString(8, direccion);
            cst.setString(9, barrio);
            cst.setString(10, telefono);
            cst.setString(11, email);
            cst.setString(12, encrypt(key, iv, password));

            if (cst.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            System.err.println("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (cst != null) {
                    cst.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return false;
    }

    public boolean registrarTrabajoAnonimo(String fecha, String hora, String archivo, String materia,
            String tema, String mensaje, String nombre, String direccion, String barrio, String telefono, String email,
            String password) {

        CallableStatement cst = null;

        try {
            this.conectar();
            cst = (CallableStatement) getCn().prepareCall("CALL TrabajoNuevo(?,?,?,?,?,?,?,?,?,?,?,?)");
            cst.setString(1, fecha);
            cst.setString(2, hora);
            cst.setString(3, archivo);
            cst.setString(4, materia);
            cst.setString(5, tema);
            cst.setString(6, mensaje);
            cst.setString(7, nombre);
            cst.setString(8, direccion);
            cst.setString(9, barrio);
            cst.setString(10, telefono);
            cst.setString(11, email);
            cst.setString(12, encrypt(key, iv, password));

            if (cst.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            System.err.println("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (cst != null) {
                    cst.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return false;
    }

    public boolean editarClase(String fecha, String hora, String duracion, String materia,
            String tema, String mensaje, String nombre, String email, String direccion, String barrio,
            String telefono, String codigoTut) {

        CallableStatement cst = null;

        try {
            this.conectar();
            cst = (CallableStatement) getCn().prepareCall("CALL ClasePresenciaEditar(?,?,?,?,?,?,?,?,?,?,?,?)");
            cst.setString(1, fecha);
            cst.setString(2, hora);
            cst.setString(3, duracion);
            cst.setString(4, materia);
            cst.setString(5, tema);
            cst.setString(6, mensaje);
            cst.setString(7, nombre);
            cst.setString(8, direccion);
            cst.setString(9, barrio);
            cst.setString(10, telefono);
            cst.setString(11, email);
            cst.setString(12, codigoTut);
            if (cst.executeUpdate() == 1) {
                return true;
            }

        } catch (Exception e) {
            System.err.println("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (cst != null) {
                    cst.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return false;
    }

    public boolean eliminarClase(int codigo) {

        CallableStatement cst = null;

        try {
            this.conectar();
            cst = (CallableStatement) getCn().prepareCall("CALL ClasePresencialEliminar(?)");
            cst.setInt(1, codigo);

            if (cst.executeUpdate() == 1) {
                return true;
            }

        } catch (Exception e) {
            System.err.println("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (cst != null) {
                    cst.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return false;
    }

    public boolean eliminarTaller(int codigo) {
        CallableStatement cst = null;

        try {
            this.conectar();
            cst = (CallableStatement) getCn().prepareCall("CALL TrabajoEliminar(?)");
            cst.setInt(1, codigo);

            if (cst.executeUpdate() == 1) {
                return true;
            }

        } catch (Exception e) {
            System.err.println("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (cst != null) {
                    cst.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return false;
    }

    public boolean registrarTrabajo(String fecha, String hora, String archivo, String materia, String tema,
            String mensaje, String nombre, String email, String password, String direccion, String barrio,
            String telefono) {

        CallableStatement cst = null;

        try {
            this.conectar();
            cst = (CallableStatement) getCn().prepareCall("CALL TrabajoNuevo(?,?,?,?,?,?,?,?,?,?,?,?)");
            cst.setString(1, fecha);
            cst.setString(2, hora);
            cst.setString(3, archivo);
            cst.setString(4, materia);
            cst.setString(5, tema);
            cst.setString(6, mensaje);
            cst.setString(7, nombre);
            cst.setString(8, direccion);
            cst.setString(9, barrio);
            cst.setString(10, telefono);
            cst.setString(11, email);
            cst.setString(12, encrypt(key, iv, password));

            if (cst.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            System.err.println("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (cst != null) {
                    cst.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return false;
    }

    public boolean editarTrabajo(String fecha, String hora, String archivo, String materia, String tema,
            String mensaje, String nombre, String email, String password, String direccion, String barrio,
            String telefono, String codigoTall) {

        CallableStatement cst = null;

        try {
            this.conectar();
            cst = (CallableStatement) getCn().prepareCall("CALL TrabajoEditar(?,?,?,?,?,?,?,?,?,?,?,?,?)");
            cst.setString(1, fecha);
            cst.setString(2, hora);
            cst.setString(3, archivo);
            cst.setString(4, materia);
            cst.setString(5, tema);
            cst.setString(6, mensaje);
            cst.setString(7, nombre);
            cst.setString(8, direccion);
            cst.setString(9, barrio);
            cst.setString(10, telefono);
            cst.setString(11, email);
            cst.setString(12, encrypt(key, iv, password));
            cst.setString(13, codigoTall);

            if (cst.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            System.err.println("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (cst != null) {
                    cst.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return false;
    }

    public List<Clase> listarClases(String email) {
        List<Clase> listaClases = new ArrayList();
        PreparedStatement st = null;
        ResultSet rs = null;
        DateFormat dtfecha = new SimpleDateFormat("yyyy-MM-dd");
        try {
            this.conectar();
            st = this.getCn().prepareStatement("SELECT tutoria.CodigoTutoria, tutoria.AsignaturaTutoria, tutoria.TemaTutoria, tutoria.DudasInquietudesTutoria, "
                    + "clase.FechaClase, clase.HoraClase, clase.DuracionClase "
                    + "FROM persona JOIN estudiante ON persona.CodigoPersona = estudiante.CodigoPersona "
                    + "JOIN asistirtutoria ON estudiante.CodigoEstudiante = asistirtutoria.CodigoEstudiante "
                    + "JOIN tutoria ON asistirtutoria.CodigoTutoria = tutoria.CodigoTutoria "
                    + "JOIN clase ON tutoria.CodigoTutoria = clase.CodigoTutoria "
                    + "AND persona.EmailPersona = ?");
            st.setString(1, email);
            rs = st.executeQuery();
            while (rs.next()) {
                Tutoria tut = new Tutoria();
                Clase cls = new Clase();

                tut.setCodigoTutoria(rs.getInt("CodigoTutoria"));
                tut.setAsignaturaTutoria(rs.getString("AsignaturaTutoria"));
                tut.setTemaTutoria(rs.getString("TemaTutoria"));
                tut.setDudasInquietudesTutoria(rs.getString("DudasInquietudesTutoria"));
                cls.setFechaClase(dtfecha.format(rs.getDate("FechaClase")));
                cls.setHoraClase(rs.getString("HoraClase"));
                cls.setDuracionClase(rs.getInt("DuracionClase"));
                cls.setTutoria(tut);
                listaClases.add(cls);
            }

        } catch (Exception e) {
            System.err.printf("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (st != null) {
                    st.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return listaClases;
    }

    public List<Taller> listarTalleres(String email) {
        List<Taller> listaTalleres = new ArrayList();
        PreparedStatement st = null;
        ResultSet rs = null;
        DateFormat dtfecha = new SimpleDateFormat("yyyy-MM-dd");
        try {
            this.conectar();
            st = this.getCn().prepareStatement("SELECT tutoria.CodigoTutoria, tutoria.AsignaturaTutoria, tutoria.TemaTutoria, tutoria.DudasInquietudesTutoria, "
                    + "taller.FechaEntregaTaller, taller.HoraEntregaTaller "
                    + "FROM persona JOIN estudiante ON persona.CodigoPersona = estudiante.CodigoPersona "
                    + "JOIN asistirtutoria ON estudiante.CodigoEstudiante = asistirtutoria.CodigoEstudiante "
                    + "JOIN tutoria ON asistirtutoria.CodigoTutoria = tutoria.CodigoTutoria "
                    + "JOIN taller ON tutoria.CodigoTutoria = taller.CodigoTutoria "
                    + "AND persona.EmailPersona = ?");
            st.setString(1, email);
            rs = st.executeQuery();
            while (rs.next()) {
                Tutoria tut = new Tutoria();
                Taller tls = new Taller();

                tut.setCodigoTutoria(rs.getInt("CodigoTutoria"));
                tut.setAsignaturaTutoria(rs.getString("AsignaturaTutoria"));
                tut.setTemaTutoria(rs.getString("TemaTutoria"));
                tut.setDudasInquietudesTutoria(rs.getString("DudasInquietudesTutoria"));
                tls.setFechaEntregaTaller(dtfecha.format(rs.getDate("FechaEntregaTaller")));
                tls.setHoraEntregaTaller(rs.getString("HoraEntregaTaller"));
                tls.setTutoria(tut);
                listaTalleres.add(tls);
            }

        } catch (Exception e) {
            System.err.printf("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (st != null) {
                    st.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return listaTalleres;
    }

    public Persona obtenerDatosUsuario(String email) {
        Persona usuario = new Persona();
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            this.conectar();
            st = this.getCn().prepareStatement("SELECT * FROM persona WHERE EmailPersona = ?");
            st.setString(1, email);
            rs = st.executeQuery();
            if (rs.next()) {
                usuario.setCodigoPersona(rs.getInt("CodigoPersona"));
                usuario.setNombrePersona(rs.getString("NombrePersona"));
                usuario.setEmailPersona(rs.getString("EmailPersona"));
                usuario.setPasswordPersona(decrypt(key, iv, rs.getString("PasswordPersona")));
                usuario.setTipoPersona(rs.getString("TipoPersona"));
                usuario.setTelefonoPersona(rs.getString("TelefonoPersona"));
                usuario.setDireccionPersona(rs.getString("DireccionPersona"));
                usuario.setBarrioResidenciaPersona(rs.getString("BarrioResidenciaPersona"));
            }
        } catch (Exception e) {
            System.err.printf("Error" + e);
        } finally {
            try {
                if (this.getCn() != null) {
                    this.cerrar();
                }
                if (st != null) {
                    st.close();
                }

                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                System.err.printf("Error" + e);
            }
        }
        return usuario;
    }

    public boolean enviarMensaje(String email, String mensaje) {

        boolean enviado = false;
        String host = "smtp.gmail.com";

        Properties prop = System.getProperties();

        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", host);
        prop.put("mail.smtp.user", "asesoriasacademicasweb@gmail.com");
        prop.put("mail.smtp.password", "A99xo81I*");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");

        Session sesion = Session.getDefaultInstance(prop);

        try {
            MimeMessage message = new MimeMessage(sesion);

            message.setFrom(new InternetAddress(email));

            message.setRecipient(Message.RecipientType.TO, new InternetAddress("asesoriasacademicasweb@gmail.com"));

            message.setSubject("Contacto");
            message.setText(mensaje);
            message.setText("Usuario: " + email + "\n"
                    + "Mensaje: " + mensaje + "\n\n"
                    + "Asesorias Academicas, Justo lo que necesitabas!");

            Transport transport = sesion.getTransport("smtp");

            transport.connect(host, "asesoriasacademicasweb@gmail.com", "A99xo81I*");

            transport.sendMessage(message, message.getAllRecipients());

            transport.close();
            enviado = true;

        } catch (Exception e) {
            System.err.println("Error" + e);
        }

        return enviado;
    }

    public boolean recuperarDatos(String email) {
        Persona usuario = new Persona();
        usuario = obtenerDatosUsuario(email);

        boolean enviado = false;
        String host = "smtp.gmail.com";

        Properties prop = System.getProperties();

        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", host);
        prop.put("mail.smtp.user", "asesoriasacademicasweb@gmail.com");
        prop.put("mail.smtp.password", "A99xo81I*");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");

        Session sesion = Session.getDefaultInstance(prop);

        try {
            MimeMessage message = new MimeMessage(sesion);

            message.setFrom(new InternetAddress("asesoriasacademicasweb@gmail.com"));

            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));

            message.setSubject("Recuperación de cuenta Asesorías Académicas");
            message.setText("¡Hola! " + usuario.getNombrePersona() + " has solicitado recuperar tus credenciales de acceso.\n\n"
                    + "Email: " + usuario.getEmailPersona() + "\n"
                    + "Password: " + usuario.getPasswordPersona() + "\n\n"
                    + "Asesorias Academicas, Justo lo que necesitabas!");

            Transport transport = sesion.getTransport("smtp");

            transport.connect(host, "asesoriasacademicasweb@gmail.com", "A99xo81I*");

            transport.sendMessage(message, message.getAllRecipients());

            transport.close();
            enviado = true;

        } catch (Exception e) {
            System.err.println("Error" + e);
        }

        return enviado;
    }

    public boolean confirmarRegistro(String nombre, String email) {
        boolean enviado = false;
        String host = "smtp.gmail.com";

        Properties prop = System.getProperties();

        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", host);
        prop.put("mail.smtp.user", "asesoriasacademicasweb@gmail.com");
        prop.put("mail.smtp.password", "A99xo81I*");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");

        Session sesion = Session.getDefaultInstance(prop);

        try {
            MimeMessage message = new MimeMessage(sesion);

            message.setFrom(new InternetAddress("asesoriasacademicasweb@gmail.com"));

            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));

            message.setSubject("Su registro se ha completado satisfactoriamente!");
            message.setText("¡Hola! " + nombre + ", Bienvenido a Asesorias Académicas!.\n\n"
                    + "Gracias por unirse a nuestra comunidad, a travéa de nuestra plataforma virtual usted podrá solicitar una clase presencial, virtual o dejarnos su trabajo. Lo invitamos ingrese al siguiente Link http://env-0941534.ric.jelastic.vps-host.net/login.jsp\n\n"
                    + "Asesorias Academicas, Justo lo que necesitabas!");

            Transport transport = sesion.getTransport("smtp");

            transport.connect(host, "asesoriasacademicasweb@gmail.com", "A99xo81I*");

            transport.sendMessage(message, message.getAllRecipients());

            transport.close();
            enviado = true;

        } catch (Exception e) {
            System.err.println("Error" + e);
        }

        return enviado;
    }

    public boolean confirmarClaseEstudiante(String fecha, String hora, String materia, String tema, String nombre, String email, String direccion, String barrio) {
        boolean enviado = false;
        String host = "smtp.gmail.com";

        Properties prop = System.getProperties();

        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", host);
        prop.put("mail.smtp.user", "asesoriasacademicasweb@gmail.com");
        prop.put("mail.smtp.password", "A99xo81I*");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");

        Session sesion = Session.getDefaultInstance(prop);

        try {
            MimeMessage message = new MimeMessage(sesion);

            message.setFrom(new InternetAddress("asesoriasacademicasweb@gmail.com"));

            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));

            message.setSubject("[RECORDATORIO] Nueva tutoría!");
            message.setText("¡Hola! " + nombre + ", su tutoría se encuentra confirmada!.\n\n"
                    + "Nos da gusto informarle que su tutoria en " + materia + " sobre el tema " + tema + " en la dirección " + direccion + " barrio " + barrio + " para el día " + fecha + " a las " + hora + " le ha sido asignada a un tutor(a).\n\n"
                    + "Asesorias Academicas, Justo lo que necesitabas!");

            Transport transport = sesion.getTransport("smtp");

            transport.connect(host, "asesoriasacademicasweb@gmail.com", "A99xo81I*");

            transport.sendMessage(message, message.getAllRecipients());

            transport.close();
            enviado = true;

        } catch (Exception e) {
            System.err.println("Error" + e);
        }

        return enviado;
    }

    public boolean confirmarClaseDocente(String fecha, String hora, String materia, String tema, String nombre, String email, String direccion, String barrio) {
        boolean enviado = false;
        String host = "smtp.gmail.com";

        Properties prop = System.getProperties();

        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", host);
        prop.put("mail.smtp.user", "asesoriasacademicasweb@gmail.com");
        prop.put("mail.smtp.password", "A99xo81I*");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");

        Session sesion = Session.getDefaultInstance(prop);

        try {
            MimeMessage message = new MimeMessage(sesion);

            message.setFrom(new InternetAddress(email));

            message.setRecipient(Message.RecipientType.TO, new InternetAddress("asesoriasacademicasweb@gmail.com"));

            message.setSubject("Contacto");
            message.setSubject("[RECORDATORIO] Nueva tutoría!");
            message.setText("¡Hola! tutor(a), un nueva tutoría se ha adicionado a su agenda.\n\n"
                    + "Nos da gusto informarle que una nueva tutoria en " + materia + " sobre el tema " + tema + " en la dirección " + direccion + " barrio " + barrio + " para el día " + fecha + " a las " + hora + " le ha sido asignada.\n\n"
                    + "Asesorias Academicas, Justo lo que necesitabas!");

            Transport transport = sesion.getTransport("smtp");

            transport.connect(host, "asesoriasacademicasweb@gmail.com", "A99xo81I*");

            transport.sendMessage(message, message.getAllRecipients());

            transport.close();
            enviado = true;

        } catch (Exception e) {
            System.err.println("Error" + e);
        }

        return enviado;
    }

    public boolean confirmarTrabajo(String fecha, String hora, String materia, String tema, String nombre, String email, String direccion, String barrio, String archivo) {
        boolean enviado = false;
        
        String host = "smtp.gmail.com";

        Properties prop = System.getProperties();

        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", host);
        prop.put("mail.smtp.user", "asesoriasacademicasweb@gmail.com");
        prop.put("mail.smtp.password", "A99xo81I*");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");

        Session sesion = Session.getDefaultInstance(prop);

        try {          
           MimeMessage message = new MimeMessage(sesion);

            message.setFrom(new InternetAddress(email));

            message.setRecipient(Message.RecipientType.TO, new InternetAddress("asesoriasacademicasweb@gmail.com"));

            message.setSubject("Contacto");
            message.setSubject("[RECORDATORIO] Nuevo trabajo!");
            message.setText("¡Hola! tutor(a), un nuevo trabajo se ha adicionado a su agenda.\n\n"
                    + "Nos da gusto informarle que un nuevo trabajo en " + materia + " sobre el tema " + tema + " para el día " + fecha + " a las " + hora + " le ha sido asignado.\n\n"
                    + "A continuación descargue el archivo correspondiente: " + "http://env-0941534.ric.jelastic.vps-host.net/Archivos/" + archivo + "\n" 
                    + "Asesorias Academicas, Justo lo que necesitabas!");

            Transport transport = sesion.getTransport("smtp");

            transport.connect(host, "asesoriasacademicasweb@gmail.com", "A99xo81I*");

            transport.sendMessage(message, message.getAllRecipients());

            transport.close();
            enviado = true;;

        } catch (Exception e) {
            System.err.println("Error" + e);
        }

        return enviado;
    }
}
