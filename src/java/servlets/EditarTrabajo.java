/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import Controlador.Consultas;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Clase;
import modelo.Persona;
import modelo.Taller;

/**
 *
 * @author 90jal
 */
public class EditarTrabajo extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        Date fechaActual = new Date();
        String fechaActualParts[];
        String horaActualParts[];
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formateadorHora = new SimpleDateFormat("HH:mm");
        String fechaHoy = formateador.format(fechaActual);
        String horaHoy = formateadorHora.format(fechaActual);

        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
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
                System.out.println("Fecha Clase: año " + fechaParts[0] + " - mes " + fechaParts[1] + " - día " + fechaParts[2]);
                fechaActualParts = fechaHoy.split("-");
                System.out.println("Fecha Hoy: año " + fechaActualParts[0] + " - mes " + fechaActualParts[1] + " - día " + fechaActualParts[2]);
                horaParts = hora.split(":");
                System.out.println("Hora Clase: hora " + horaParts[0] + " - minutos " + horaParts[0]);
                horaActualParts = horaHoy.split(":");
                System.out.println("Hora Clase: hora " + horaParts[1] + " - minutos " + horaParts[1]);

                //Persona usu = (Persona) request.getSession().getAttribute("usuario");
                if (Integer.parseInt(fechaParts[0]) >= Integer.parseInt(fechaActualParts[0])) {
                    if (Integer.parseInt(fechaParts[1]) >= Integer.parseInt(fechaActualParts[1])) {
                        if (Integer.parseInt(fechaParts[2]) > Integer.parseInt(fechaActualParts[2])) {
                            if (co.editarTrabajo(fecha, hora, archivo, materia, tema, mensaje, nombre, usu.getEmailPersona(), usu.getPasswordPersona(), direccion, barrio, telefono, request.getSession().getAttribute("codTall").toString())) {
                                listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                request.getSession().setAttribute("listaTalleres", listaTalleres);
                                co.confirmarClaseEstudiante(fecha, hora, materia, tema, nombre, usu.getEmailPersona(), direccion, barrio);
                                co.confirmarClaseDocente(fecha, hora, materia, tema, nombre, usu.getEmailPersona(), direccion, barrio);
                                request.getSession().setAttribute("listaTalleres", listaTalleres);
                                usu = co.obtenerDatosUsuario(usu.getEmailPersona());
                                request.getSession().setAttribute("usuario", usu);
                                session.setAttribute("confirmacionFallidaEditaTrabajo", "");
                                session.setAttribute("confirmacionExitosaEditaTrabajo", "<b>¡Bien Hecho!</b> El trabajo ha sido editada satisfactoriamente.");
                                response.sendRedirect("dejanosTuTrabajo.jsp");
                            } else {
                                System.out.println("No fué posible registrar la clase");
                                request.getSession().setAttribute("usuario", usu);
                                listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                request.getSession().setAttribute("listaTalleres", listaTalleres);

                                session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                        + "No es posible definir el trabajo para el día" + fecha + " a las " + hora + ", intentalo nuevamente.");
                                session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                                response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
                            }
                        } else {
                            if (Integer.parseInt(fechaParts[2]) == Integer.parseInt(fechaActualParts[2])) {
                                if (Integer.parseInt(horaParts[0]) >= Integer.parseInt(horaActualParts[0])) {
                                    if (co.editarTrabajo(fecha, hora, archivo, materia, tema, mensaje, nombre, usu.getEmailPersona(), usu.getPasswordPersona(), direccion, barrio, telefono, request.getSession().getAttribute("codTall").toString())) {
                                        listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                        request.getSession().setAttribute("listaTalleres", listaTalleres);
                                        co.confirmarClaseEstudiante(fecha, hora, materia, tema, nombre, usu.getEmailPersona(), direccion, barrio);
                                        co.confirmarClaseDocente(fecha, hora, materia, tema, nombre, usu.getEmailPersona(), direccion, barrio);
                                        request.getSession().setAttribute("listaTalleres", listaTalleres);
                                        usu = co.obtenerDatosUsuario(usu.getEmailPersona());
                                        request.getSession().setAttribute("usuario", usu);
                                        session.setAttribute("confirmacionFallidaEditaTrabajo", "");
                                        session.setAttribute("confirmacionExitosaEditaTrabajo", "<b>¡Bien Hecho!</b> El trabajo ha sido editada satisfactoriamente.");
                                        response.sendRedirect("dejanosTuTrabajo.jsp");
                                    } else {
                                        System.out.println("No fué posible registrar la clase");
                                        request.getSession().setAttribute("usuario", usu);
                                        listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                        request.getSession().setAttribute("listaTalleres", listaTalleres);

                                        session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                                + "No es posible definir el trabajo el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                                        session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                                        response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
                                    }
                                } else {
                                    System.out.print("Horas:" + Integer.parseInt(horaParts[0]) + "<" + Integer.parseInt(horaActualParts[0]));
                                    request.getSession().setAttribute("usuario", usu);
                                    listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                    request.getSession().setAttribute("listaTalleres", listaTalleres);

                                    session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                            + "No es posible definir el trabajo el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                                    session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                                    response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
                                }
                            } else {
                                System.out.print("Dia:" + Integer.parseInt(fechaParts[2]) + "<" + Integer.parseInt(fechaActualParts[2]));
                                request.getSession().setAttribute("usuario", usu);
                                listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                request.getSession().setAttribute("listaTalleres", listaTalleres);

                                session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                        + "No es posible definir el trabajo el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                                session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                                response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
                            }
                        }
                    } else {
                        System.out.print("Mes:" + Integer.parseInt(fechaParts[1]) + "<" + Integer.parseInt(fechaActualParts[1]));
                        request.getSession().setAttribute("usuario", usu);
                        listaTalleres = co.listarTalleres(usu.getEmailPersona());
                        request.getSession().setAttribute("listaTalleres", listaTalleres);

                        session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                + "No es posible definir el trabajo el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                        session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                        response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
                    }
                } else {
                    System.out.print("Año:" + Integer.parseInt(fechaParts[0]) + "<" + Integer.parseInt(fechaActualParts[0]));
                    request.getSession().setAttribute("usuario", usu);
                    listaTalleres = co.listarTalleres(usu.getEmailPersona());
                    request.getSession().setAttribute("listaTalleres", listaTalleres);

                    session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                            + "No es posible definir el trabjo el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                    session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                    response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
                }

            }
        /*
        if (usu != null) {
            if (co.verificarHorario(fecha, hora)) {
                request.getSession().setAttribute("usuario", usu);
                listaTalleres = co.listarTalleres(usu.getEmailPersona());
                request.getSession().setAttribute("listaTalleres", listaTalleres);

                session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                        + "No es posible definir el taller en el horario especificado, intentalo nuevamente.");
                session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
            } else {
                fechaParts = fecha.split("-");
                fechaActualParts = fechaHoy.split("-");
                horaParts = hora.split(":");
                horaActualParts = horaHoy.split(":");

                if (Integer.parseInt(fechaParts[0]) >= Integer.parseInt(fechaActualParts[0])) {
                    if (Integer.parseInt(fechaParts[1]) >= Integer.parseInt(fechaActualParts[1])) {
                        if (Integer.parseInt(fechaParts[2]) >= Integer.parseInt(fechaActualParts[2])) {
                            if (Integer.parseInt(horaParts[0]) >= Integer.parseInt(horaActualParts[0])) {
                                if (Integer.parseInt(horaParts[1]) >= Integer.parseInt(horaActualParts[1])) {
                                    if (co.editarTrabajo(fecha, hora, archivo, materia, tema, mensaje, nombre, usu.getEmailPersona(), usu.getPasswordPersona(), direccion, barrio, telefono, request.getSession().getAttribute("codTall").toString())) {
                                        listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                        request.getSession().setAttribute("listaTalleres", listaTalleres);
                                        co.confirmarTrabajo(fecha, hora, materia, tema, nombre, usu.getEmailPersona(), direccion, barrio);
                                        session.setAttribute("confirmacionFallidaEditaTrabajo", "");
                                        session.setAttribute("confirmacionExitosaEditaTrabajo", "<b>¡Bien Hecho!</b> Su solicitud ha sido procesada satisfactoriamente.");
                                        response.sendRedirect("dejanosTuTrabajo.jsp");
                                    } else {
                                        session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                                        session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> intentalo nuevamente.");
                                        response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
                                    }
                                } else {
                                    request.getSession().setAttribute("usuario", usu);
                                    listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                    request.getSession().setAttribute("listaClases", listaTalleres);

                                    session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                            + "No es posible definir una clase el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                                    session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                                    response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
                                }
                            } else {
                                request.getSession().setAttribute("usuario", usu);
                                listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                request.getSession().setAttribute("listaClases", listaTalleres);

                                session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                        + "No es posible definir una clase el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                                session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                                response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
                            }
                        } else {
                            if (Integer.parseInt(fechaParts[1]) > Integer.parseInt(fechaActualParts[1])) {
                                if (co.editarTrabajo(fecha, hora, archivo, materia, tema, mensaje, nombre, usu.getEmailPersona(), usu.getPasswordPersona(), direccion, barrio, telefono, request.getSession().getAttribute("codTall").toString())) {
                                    listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                    request.getSession().setAttribute("listaTalleres", listaTalleres);
                                    co.confirmarTrabajo(fecha, hora, materia, tema, nombre, usu.getEmailPersona(), direccion, barrio);
                                    session.setAttribute("confirmacionFallidaEditaTrabajo", "");
                                    session.setAttribute("confirmacionExitosaEditaTrabajo", "<b>¡Bien Hecho!</b> Su solicitud ha sido procesada satisfactoriamente.");
                                    response.sendRedirect("dejanosTuTrabajo.jsp");
                                } else {
                                    session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                                    session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> intentalo nuevamente.");
                                    response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
                                }
                            } else {
                                request.getSession().setAttribute("usuario", usu);
                                listaTalleres = co.listarTalleres(usu.getEmailPersona());
                                request.getSession().setAttribute("listaClases", listaTalleres);

                                session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                        + "No es posible definir una clase el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                                session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                                response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
                            }
                        }
                    } else {
                        request.getSession().setAttribute("usuario", usu);
                        listaTalleres = co.listarTalleres(usu.getEmailPersona());
                        request.getSession().setAttribute("listaClases", listaTalleres);

                        session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                                + "No es posible definir una clase el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                        session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                        response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
                    }
                } else {
                    request.getSession().setAttribute("usuario", usu);
                    listaTalleres = co.listarTalleres(usu.getEmailPersona());
                    request.getSession().setAttribute("listaClases", listaTalleres);

                    session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> "
                            + "No es posible definir una clase el día " + fecha + " a las " + hora + ", intentalo nuevamente.");
                    session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                    response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
                }
            }

        } else {
            if (co.editarTrabajo(fecha, hora, archivo, materia, tema, mensaje, nombre, usu.getEmailPersona(), usu.getPasswordPersona(), direccion, barrio, telefono, request.getSession().getAttribute("codTall").toString())) {
                session.setAttribute("confirmacionFallidaEditaTrabajo", "");
                session.setAttribute("confirmacionExitosaEditaTrabajo", "<b>¡Bien Hecho!</b> Su solicitud ha sido procesada satisfactoriamente.");
                response.sendRedirect("dejanosTuTrabajo.jsp");
            } else {
                session.setAttribute("confirmacionExitosaEditaTrabajo", "");
                session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> intentalo nuevamente.");
                response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
            }
        }*/
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
