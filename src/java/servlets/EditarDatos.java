/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import Controlador.Consultas;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Persona;

/**
 *
 * @author Alex
 */
public class EditarDatos extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Persona usuario = new Persona();

        HttpSession session = request.getSession();
        String nombre = request.getParameter("nombre");
        String direccion = request.getParameter("direccion");
        String barrio = request.getParameter("barrio");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Consultas co = new Consultas();
        Persona usu = co.obtenerDatosUsuario(email);
        if (co.editarCuenta(usu.getCodigoPersona(), nombre, direccion, barrio, telefono, email, password)) {
            usuario = co.obtenerDatosUsuario(email);
            request.getSession().setAttribute("usuario", usuario);
            session.setAttribute("confirmacionFallidaMiCuenta", "");
            session.setAttribute("confirmacionExitosaMiCuenta", "<b>¡Bien Hecho!</b> Sus datos han sido guardados satisfactoriamente.");
            response.sendRedirect("miCuenta.jsp");
        } else {
            session.setAttribute("confirmacionExitosaMiCuenta", "");
            session.setAttribute("confirmacionFallidaMiCuenta", "<b>¡Ha ocurrido un error inesperado!</b> inténtalo nuevamente.");
            response.sendRedirect("miCuenta.jsp");
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
            throws IOException {
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
            throws IOException {
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
