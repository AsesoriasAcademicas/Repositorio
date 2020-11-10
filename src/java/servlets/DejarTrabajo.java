/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import Controlador.Consultas;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Taller;
import modelo.Persona;

/**
 *
 * @author Alex
 */
public class DejarTrabajo extends HttpServlet {

    private final String UPLOAD_DIRECTORY = "/opt/tomcat/webapps/ROOT/Archivos";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    List<Taller> listaTalleres = new ArrayList();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        try {
            Date fechaActual = new Date();
            String fechaActualParts[];
            String horaActualParts[];
            SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formateadorHora = new SimpleDateFormat("HH:mm");
            String fechaHoy = formateador.format(fechaActual);
            String horaHoy = formateadorHora.format(fechaActual);

            PrintWriter out = response.getWriter();

            String fecha = request.getParameter("fecha");
            String fechaParts[];

            String hora = request.getParameter("hora");
            String horaParts[];
            String archivo = (String) request.getSession().getAttribute("archivo");

            String materia = request.getParameter("materia");
            String tema = request.getParameter("tema");
            String mensaje = request.getParameter("mensaje");

            String nombre = request.getParameter("nombre");
            String direccion = request.getParameter("direccion");
            String barrio = request.getParameter("barrio");
            String telefono = request.getParameter("telefono");

            Consultas co = new Consultas();
            Persona usu = (Persona) request.getSession().getAttribute("usuario");
            String email = usu.getEmailPersona();
            if (usu != null) {
                /*if (co.verificarHorario(fecha, hora)) {
                System.out.println("Horario invalido");
                request.getSession().setAttribute("usuario", usu);
                listaClases = co.listarClases(usu.getEmailPersona());
                request.getSession().setAttribute("listaClases", listaClases);

                session.setAttribute("confirmacionFallidaNuevaClasePresencial", "<b>¡Ha ocurrido un error inesperado!</b> "
                        + "No es posible definir una clase el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                session.setAttribute("confirmacionExitosaNuevaClasePresencial", "");
                response.sendRedirect("NuevaClasePresencial.jsp");
            } else {*/
                fechaParts = fecha.split("-");
                fechaActualParts = fechaHoy.split("-");
                horaParts = hora.split(":");
                horaActualParts = horaHoy.split(":");

                if (Integer.parseInt(fechaParts[0]) >= Integer.parseInt(fechaActualParts[0])) {
                    if (Integer.parseInt(fechaParts[1]) >= Integer.parseInt(fechaActualParts[1])) {
                        if (Integer.parseInt(fechaParts[2]) > Integer.parseInt(fechaActualParts[2])) {
                            if (co.registrarTrabajo(fecha, hora, archivo, materia, tema, mensaje, nombre, usu.getEmailPersona(), usu.getPasswordPersona(), direccion, barrio, telefono)) {
                                listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                request.getSession().setAttribute("listaTalleres", listaTalleres);
                                co.confirmarTrabajo(fecha, hora, materia, tema, nombre, usu.getEmailPersona(), direccion, barrio, archivo);
                                request.getSession().setAttribute("listaTalleres", listaTalleres);
                                usu = co.obtenerDatosUsuario(email);
                                request.getSession().setAttribute("usuario", usu);
                                session.setAttribute("confirmacionFallidaDejanosTuTrabajo", "");
                                session.setAttribute("confirmacionExitosaDejanosTuTrabajo", "<b>¡Bien Hecho!</b> Su solicitud ha sido procesada satisfactoriamente.");
                                response.sendRedirect("dejanosTuTrabajo.jsp");
                            } else {
                                System.out.println("No fué posible registrar la clase");
                                request.getSession().setAttribute("usuario", usu);
                                listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                request.getSession().setAttribute("listaTalleres", listaTalleres);

                                session.setAttribute("confirmacionFallidaDejanosTuTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                        + "No es posible definir el taller en el horario especificado, intentalo nuevamente.");
                                session.setAttribute("confirmacionExitosaDejanosTuTrabajo", "");
                                response.sendRedirect("dejanosTuTrabajo.jsp");
                            }
                        } else {
                            if (Integer.parseInt(fechaParts[2]) == Integer.parseInt(fechaActualParts[2])) {
                                if (Integer.parseInt(horaParts[0]) >= Integer.parseInt(horaActualParts[0])) {
                                    if (co.registrarTrabajo(fecha, hora, archivo, materia, tema, mensaje, nombre, usu.getEmailPersona(), usu.getPasswordPersona(), direccion, barrio, telefono)) {
                                        listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                        request.getSession().setAttribute("listaTalleres", listaTalleres);
                                        co.confirmarTrabajo(fecha, hora, materia, tema, nombre, usu.getEmailPersona(), direccion, barrio, archivo);
                                        request.getSession().setAttribute("listaTalleres", listaTalleres);
                                        usu = co.obtenerDatosUsuario(email);
                                        request.getSession().setAttribute("usuario", usu);
                                        session.setAttribute("confirmacionFallidaDejanosTuTrabajo", "");
                                        session.setAttribute("confirmacionExitosaDejanosTuTrabajo", "<b>¡Bien Hecho!</b> Su solicitud ha sido procesada satisfactoriamente.");
                                        response.sendRedirect("dejanosTuTrabajo.jsp");;
                                    } else {
                                        System.out.println("No fué posible registrar la clase");
                                        request.getSession().setAttribute("usuario", usu);
                                        listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                        request.getSession().setAttribute("listaTalleres", listaTalleres);

                                        session.setAttribute("confirmacionFallidaDejanosTuTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                                + "No es posible definir el taller en el horario especificado, intentalo nuevamente.");
                                        session.setAttribute("confirmacionExitosaDejanosTuTrabajo", "");
                                        response.sendRedirect("dejanosTuTrabajo.jsp");
                                    }
                                } else {
                                    System.out.print("Horas:" + Integer.parseInt(horaParts[0]) + ">" + Integer.parseInt(horaActualParts[0]));
                                    request.getSession().setAttribute("usuario", usu);
                                    listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                    request.getSession().setAttribute("listaTalleres", listaTalleres);

                                    session.setAttribute("confirmacionFallidaDejanosTuTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                            + "No es posible definir el taller en el horario especificado, intentalo nuevamente.");
                                    session.setAttribute("confirmacionExitosaDejanosTuTrabajo", "");
                                    response.sendRedirect("dejanosTuTrabajo.jsp");
                                }
                            } else {
                                System.out.print("Horas:" + Integer.parseInt(horaParts[0]) + ">" + Integer.parseInt(horaActualParts[0]));
                                request.getSession().setAttribute("usuario", usu);
                                listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                request.getSession().setAttribute("listaTalleres", listaTalleres);

                                session.setAttribute("confirmacionFallidaDejanosTuTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                        + "No es posible definir el taller en el horario especificado, intentalo nuevamente.");
                                session.setAttribute("confirmacionExitosaDejanosTuTrabajo", "");
                                response.sendRedirect("dejanosTuTrabajo.jsp");
                            }
                        }
                    } else {
                        System.out.print("Dia:" + Integer.parseInt(fechaParts[1]) + "<" + Integer.parseInt(fechaActualParts[1]));
                        request.getSession().setAttribute("usuario", usu);
                        listaTalleres = co.listarTalleres(usu.getEmailPersona());
                        request.getSession().setAttribute("listaTalleres", listaTalleres);

                        session.setAttribute("confirmacionFallidaDejanosTuTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                + "No es posible definir el taller en el horario especificado, intentalo nuevamente.");
                        session.setAttribute("confirmacionExitosaDejanosTuTrabajo", "");
                        response.sendRedirect("dejanosTuTrabajo.jsp");
                    }
                } else {
                    System.out.print("Año:" + Integer.parseInt(fechaParts[0]) + ">" + Integer.parseInt(fechaActualParts[0]));
                    request.getSession().setAttribute("usuario", usu);
                    listaTalleres = co.listarTalleres(usu.getEmailPersona());
                    request.getSession().setAttribute("listaTalleres", listaTalleres);

                    session.setAttribute("confirmacionFallidaDejanosTuTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                            + "No es posible definir el taller en el horario especificado, intentalo nuevamente.");
                    session.setAttribute("confirmacionExitosaDejanosTuTrabajo", "");
                    response.sendRedirect("dejanosTuTrabajo.jsp");
                }

            } else {
                if (co.registrarTrabajoAnonimo(fecha, hora, archivo, materia, tema, mensaje, nombre, "", "", direccion, barrio, telefono)) {
                    session.setAttribute("confirmacionFallidaDejanosTuTrabajo", "");
                    session.setAttribute("confirmacionExitosaDejanosTuTrabajo", "<b>¡Bien Hecho!</b> Su solicitud ha sido procesada satisfactoriamente.");
                    response.sendRedirect("NuevoTrabajo.jsp");
                } else {
                    session.setAttribute("confirmacionExitosaDejanosTuTrabajo", "");
                    session.setAttribute("confirmacionFallidaDejanosTuTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> intentalo nuevamente.");
                    response.sendRedirect("NuevoTrabajo.jsp");
                }
            }
        } catch (Exception e) {
            System.err.printf("Error" + e);
            session.setAttribute("confirmacionExitosaDejanosTuTrabajo", "");
            session.setAttribute("confirmacionFallidaDejanosTuTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> intentalo nuevamente.");
            response.sendRedirect("NuevoTrabajo.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

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
        processRequest(request, response);
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
