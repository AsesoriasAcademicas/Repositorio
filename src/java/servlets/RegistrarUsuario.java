/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import Controlador.Consultas;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Alex
 */
public class RegistrarUsuario extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repeatPassword = request.getParameter("repeatPassword");

        Consultas co = new Consultas();
        if (co.verificarEmail(email)) {
            session.setAttribute("confirmacionExitosaRegistrarUsuario", "");
            session.setAttribute("confirmacionFallidaRegistrarUsuario", "<b>¡Ha ocurrido un error inesperado!</b> El email ya se encuentra asociado a una cuenta existente.");
            session.setAttribute("nombre", nombre);
            response.sendRedirect("registro.jsp");
        }else{
            if (!password.equals(repeatPassword)) {
                session.setAttribute("confirmacionExitosaRegistrarUsuario", "");
                session.setAttribute("confirmacionFallidaRegistrarUsuario", "<b>¡Ha ocurrido un error inesperado!</b> La contraseña de verificación no coincide.");
                session.setAttribute("nombre", nombre);
                session.setAttribute("email", email);
                response.sendRedirect("registro.jsp");
            }else{
                if (co.registrar(nombre, email, password)) {
                    session.setAttribute("confirmacionFallidaIniciarSesion", "");
                    session.setAttribute("confirmacionExitosaIniciarSesion", "<b>¡Bien Hecho!</b> Su registro se ha realizado satisfactoriamente.");
                    response.sendRedirect("login.jsp");
                }else{
                    session.setAttribute("confirmacionExitosaRegistrarUsuario", "");
                    session.setAttribute("confirmacionFallidaRegistrarUsuario", "<b>¡Ha ocurrido un error inesperado!</b> inténtalo nuevamente.");
                    response.sendRedirect("registro.jsp");
                }
            }
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
