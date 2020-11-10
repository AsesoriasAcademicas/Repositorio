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
import java.util.List;
import java.util.ArrayList;
import modelo.Clase;
import modelo.Persona;
import modelo.Taller;

/**
 *
 * @author Alex
 */
public class IniciarSesion extends HttpServlet {

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
    List<Taller> listaTalleres = new ArrayList();
    Persona usuario = new Persona();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String constrasena = request.getParameter("password");
        
        Consultas co = new Consultas();
        usuario = co.obtenerDatosUsuario(email);
        listaClases = co.listarClases(usuario.getEmailPersona());
        listaTalleres = co.listarTalleres(usuario.getEmailPersona());
        if(co.autenticacion(email, constrasena)){
            request.getSession().setAttribute("usuario", usuario);
            request.getSession().setAttribute("listaClases", listaClases);
            request.getSession().setAttribute("listaTalleres", listaTalleres);
            
            session.setAttribute("confirmacionFallidaInicio", "");
            session.setAttribute("confirmacionExitosaInicio", "<b>¡Bienvenid@!</b> " + usuario.getNombrePersona());
            response.sendRedirect("index.jsp");
        }
        else{
            session.setAttribute("confirmacionExitosaIniciarSesion", "");
            session.setAttribute("confirmacionFallidaIniciarSesion", "<b>¡Ha ocurrido un error inesperado!</b> "
                    + "La contraseña ingresada es incorrecta. Por favor inténtalo de nuevo.");
            session.setAttribute("email", email);
            response.sendRedirect("login.jsp");
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
