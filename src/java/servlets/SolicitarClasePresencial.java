/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import Controlador.Consultas;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.Clase;
import modelo.Persona;

/**
 *
 * @author Alex
 */
public class SolicitarClasePresencial extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    List<Clase> listaClases = new ArrayList();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        
        HttpSession session = request.getSession();
        try {
            Date fechaActual = new Date();
            String fechaActualParts[];
            String horaActualParts[];
            SimpleDateFormat formateadorFecha = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formateadorHora = new SimpleDateFormat("HH:mm");
            String fechaHoy = formateadorFecha.format(fechaActual);
            String horaHoy = formateadorHora.format(fechaActual);

            PrintWriter out = response.getWriter();

            String fecha = request.getParameter("fecha");
            String fechaParts[];

            String hora = request.getParameter("hora");
            String horaParts[];
            String duracion = request.getParameter("duracion");

            String materia = request.getParameter("materia");
            String tema = request.getParameter("tema");
            String mensaje = request.getParameter("mensaje");

            String nombre = request.getParameter("nombre");
            String direccion = request.getParameter("direccion");
            String barrio = request.getParameter("barrio");
            String telefono = request.getParameter("telefono");

            Consultas co = new Consultas();
            Persona anonimo = new Persona();
            
            if (request.getSession().getAttribute("usuario") == null) {
                if (co.registrarClaseAnonimo(fecha, hora, duracion, materia, tema, mensaje, nombre, "", "", direccion, barrio, telefono)) {
                    session.setAttribute("confirmacionFallidaNuevaClasePresencial", "");
                    session.setAttribute("confirmacionExitosaNuevaClasePresencial", "<b>¡Bien Hecho!</b> Su solicitud ha sido procesada satisfactoriamente.");
                    response.sendRedirect("NuevaClasePresencial.jsp");
                } else {
                    session.setAttribute("confirmacionExitosaNuevaClasePresencial", "");
                    session.setAttribute("confirmacionFallidaNuevaClasePresencial", "<b>¡Ha ocurrido un error inesperado!</b> intentalo nuevamente.");
                    response.sendRedirect("NuevaClasePresencial.jsp");
                }
            } else {
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
                Persona usu = (Persona) request.getSession().getAttribute("usuario");
                String email = usu.getEmailPersona();
                fechaParts = fecha.split("-");
                System.out.println("Fecha Clase: año " + fechaParts[0] + " - mes " + fechaParts[1] + " - día " + fechaParts[2]);
                fechaActualParts = fechaHoy.split("-");
                System.out.println("Fecha Hoy: año " + fechaActualParts[0] + " - mes " + fechaActualParts[1] + " - día " + fechaActualParts[2]);
                horaParts = hora.split(":");
                System.out.println("Hora Clase: hora " + horaParts[0] + " - minutos" + horaParts[0]);
                horaActualParts = horaHoy.split(":");
                System.out.println("Hora Clase: hora " + horaParts[1] + " - minutos" + horaParts[1]);

                if (Integer.parseInt(fechaParts[0]) >= Integer.parseInt(fechaActualParts[0])) {
                    if (Integer.parseInt(fechaParts[1]) >= Integer.parseInt(fechaActualParts[1])) {
                        if (Integer.parseInt(fechaParts[2]) > Integer.parseInt(fechaActualParts[2])) {
                            if (co.registrarClase(fecha, hora, duracion, materia, tema, mensaje, nombre, usu.getEmailPersona(), usu.getPasswordPersona(), direccion, barrio, telefono)) {
                                listaClases = co.listarClases(usu.getEmailPersona());
                                request.getSession().setAttribute("listaClases", listaClases);
                                co.confirmarClaseEstudiante(fecha, hora, materia, tema, nombre, usu.getEmailPersona(), direccion, barrio);
                                co.confirmarClaseDocente(fecha, hora, materia, tema, nombre, usu.getEmailPersona(), direccion, barrio);
                                request.getSession().setAttribute("listaClases", listaClases);
                                usu = co.obtenerDatosUsuario(email);
                                request.getSession().setAttribute("usuario", usu);
                                session.setAttribute("confirmacionFallidaSolicitaTuClasePresencial", "");
                                session.setAttribute("confirmacionExitosaSolicitaTuClasePresencial", "<b>¡Bien Hecho!</b> La clase ha sido creada satisfactoriamente.");
                                response.sendRedirect("solicitaTuClasePresencial.jsp");
                            } else {
                                System.out.println("No fué posible registrar la clase");
                                request.getSession().setAttribute("usuario", usu);
                                listaClases = co.listarClases(usu.getEmailPersona());
                                request.getSession().setAttribute("listaClases", listaClases);

                                session.setAttribute("confirmacionFallidaSolicitaTuClasePresencial", "<b>¡Ha ocurrido un error inesperado!</b> "
                                        + "No es posible definir una clase el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                                session.setAttribute("confirmacionExitosaSolicitaTuClasePresencial", "");
                                response.sendRedirect("solicitaTuClasePresencial.jsp");
                            }
                        } else {
                            if (Integer.parseInt(fechaParts[2]) == Integer.parseInt(fechaActualParts[2])) {
                                if (Integer.parseInt(horaParts[0]) >= Integer.parseInt(horaActualParts[0])) {
                                    if (co.registrarClase(fecha, hora, duracion, materia, tema, mensaje, nombre, usu.getEmailPersona(), usu.getPasswordPersona(), direccion, barrio, telefono)) {
                                        listaClases = co.listarClases(usu.getEmailPersona());
                                        request.getSession().setAttribute("listaClases", listaClases);
                                        co.confirmarClaseEstudiante(fecha, hora, materia, tema, nombre, usu.getEmailPersona(), direccion, barrio);
                                        co.confirmarClaseDocente(fecha, hora, materia, tema, nombre, usu.getEmailPersona(), direccion, barrio);
                                        request.getSession().setAttribute("listaClases", listaClases);
                                        usu = co.obtenerDatosUsuario(email);
                                        request.getSession().setAttribute("usuario", usu);
                                        session.setAttribute("confirmacionFallidaSolicitaTuClasePresencial", "");
                                        session.setAttribute("confirmacionExitosaSolicitaTuClasePresencial", "<b>¡Bien Hecho!</b> La clase ha sido creada satisfactoriamente.");
                                        response.sendRedirect("solicitaTuClasePresencial.jsp");
                                    } else {
                                        System.out.println("No fué posible registrar la clase");
                                        request.getSession().setAttribute("usuario", usu);
                                        listaClases = co.listarClases(usu.getEmailPersona());
                                        request.getSession().setAttribute("listaClases", listaClases);

                                        session.setAttribute("confirmacionFallidaSolicitaTuClasePresencial", "<b>¡Ha ocurrido un error inesperado!</b> "
                                                + "No es posible definir una clase el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                                        session.setAttribute("confirmacionExitosaSolicitaTuClasePresencial", "");
                                        response.sendRedirect("solicitaTuClasePresencial.jsp");
                                    }
                                } else {
                                    System.out.print("Horas:" + Integer.parseInt(horaParts[0]) + "<" + Integer.parseInt(horaActualParts[0]));
                                    request.getSession().setAttribute("usuario", usu);
                                    listaClases = co.listarClases(usu.getEmailPersona());
                                    request.getSession().setAttribute("listaClases", listaClases);

                                    session.setAttribute("confirmacionFallidaSolicitaTuClasePresencial", "<b>¡Ha ocurrido un error inesperado!</b> "
                                            + "No es posible definir una clase el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                                    session.setAttribute("confirmacionExitosaSolicitaTuClasePresencial", "");
                                    response.sendRedirect("solicitaTuClasePresencial.jsp");
                                }
                            } else {
                                System.out.print("Dia:" + Integer.parseInt(fechaParts[2]) + "<" + Integer.parseInt(fechaActualParts[2]));
                                request.getSession().setAttribute("usuario", usu);
                                listaClases = co.listarClases(usu.getEmailPersona());
                                request.getSession().setAttribute("listaClases", listaClases);

                                session.setAttribute("confirmacionFallidaSolicitaTuClasePresencial", "<b>¡Ha ocurrido un error inesperado!</b> "
                                        + "No es posible definir una clase el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                                session.setAttribute("confirmacionExitosaSolicitaTuClasePresencial", "");
                                response.sendRedirect("solicitaTuClasePresencial.jsp");
                            }
                        }
                    } else {
                        System.out.print("Mes:" + Integer.parseInt(fechaParts[1]) + "<" + Integer.parseInt(fechaActualParts[1]));
                        request.getSession().setAttribute("usuario", usu);
                        listaClases = co.listarClases(usu.getEmailPersona());
                        request.getSession().setAttribute("listaClases", listaClases);

                        session.setAttribute("confirmacionFallidaSolicitaTuClasePresencial", "<b>¡Ha ocurrido un error inesperado!</b> "
                                + "No es posible definir una clase el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                        session.setAttribute("confirmacionExitosaSolicitaTuClasePresencial", "");
                        response.sendRedirect("solicitaTuClasePresencial.jsp");
                    }
                } else {
                    System.out.print("Año:" + Integer.parseInt(fechaParts[0]) + "<" + Integer.parseInt(fechaActualParts[0]));
                    request.getSession().setAttribute("usuario", usu);
                    listaClases = co.listarClases(usu.getEmailPersona());
                    request.getSession().setAttribute("listaClases", listaClases);

                    session.setAttribute("confirmacionFallidaSolicitaTuClasePresencial", "<b>¡Ha ocurrido un error inesperado!</b> "
                            + "No es posible definir una clase el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                    session.setAttribute("confirmacionExitosaSolicitaTuClasePresencial", "");
                    response.sendRedirect("solicitaTuClasePresencial.jsp");
                }
            }
        } catch (Exception e) {
            System.err.printf("Error" + e);
            session.setAttribute("confirmacionExitosaNuevaClasePresencial", "");
            session.setAttribute("confirmacionFallidaNuevaClasePresencial", "<b>¡Ha ocurrido un error inesperado!</b> intentalo nuevamente.");
            response.sendRedirect("NuevaClasePresencial.jsp");
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
