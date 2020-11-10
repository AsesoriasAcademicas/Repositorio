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
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Clase;
import modelo.Persona;

/**
 *
 * @author Alex
 */
public class EliminarClasePresencial extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession();
        Consultas co = new Consultas();
        Persona usu = (Persona)request.getSession().getAttribute("usuario");
        int codigo = (int)request.getSession().getAttribute("codigo");
        if(co.eliminarClase(codigo)){
            listaClases = co.listarClases(usu.getEmailPersona());
            request.getSession().setAttribute("listaClases", listaClases);
            session.setAttribute("confirmacionFallidaSolicitaTuClasePresencial", "");
            session.setAttribute("confirmacionExitosaSolicitaTuClasePresencial", "<b>¡Bien Hecho!</b> La clase ha sido eliminada satisfactoriamente.");
            response.sendRedirect("solicitaTuClasePresencial.jsp");
        }
        else{
            session.setAttribute("confirmacionExitosaEliminarClasePresencial", "");
            session.setAttribute("confirmacionFallidaEliminarClasePresencial", "<b>¡Ha ocurrido un error inesperado!</b> intentalo nuevamente.");
            response.sendRedirect("EliminarClasePresencial.jsp");
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
