/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author 90jal
 */
public class EditarArchivo extends HttpServlet {
    
    private final String UPLOAD_DIRECTORY = "C:\\Users\\90jal\\Desktop\\Archivos";

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
        
        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                List<FileItem> multiparts = new ServletFileUpload(
                        new DiskFileItemFactory()).parseRequest(request);
                
                for (FileItem item : multiparts) {
                    if (!item.isFormField()) {
                        String name = new File(item.getName()).getName();
                        request.getSession().setAttribute("archivo", name);
                        System.out.println("name " + name);
                        item.write(
                                new File(UPLOAD_DIRECTORY + File.separator + name));
                    }
                }
                
                session.setAttribute("confirmacionFallidaEditaTrabajo", "");
                session.setAttribute("confirmacionExitosaEditaTrabajo", "<b>¡Bien Hecho!</b> Su trabajo ha sido editado satisfactoriamente.");
                session.setAttribute("habilitar", "true");
                response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
            } catch (Exception ex) {
                System.err.println("File Upload Failed due to " + ex);
            }
            
        } else {
            session.setAttribute("confirmacionExitosaEditaTrabajo", "");
            session.setAttribute("confirmacionFallidaEditaTrabajo", "<b>¡Ha ocurrido un error inesperado!</b> intentalo nuevamente.");
            response.sendRedirect("EditarTrabajo.jsp?CodigoTutoria=" + request.getSession().getAttribute("codTall"));
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
