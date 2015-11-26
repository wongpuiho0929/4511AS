
package ict.servlet;


import ict.bean.UserInfo;
import ict.db.UserDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author user
 */
@WebServlet(name = "EditUserController", urlPatterns = {"/editUserController"})
public class EditUserController extends HttpServlet {
    
    private UserDB db;
    
    public void init(){
        String username = this.getServletContext().getInitParameter("username");
        String password = this.getServletContext().getInitParameter("password");
        String url = this.getServletContext().getInitParameter("url");
        db = new UserDB(url,username,password);
    }
    
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
        ArrayList<UserInfo> users = db.queryUser();
        int idL = Integer.parseInt(users.get(users.size() -1).getId());
        idL++;
        String id = "" + idL;
        String name = request.getParameter("name");
        String tel = request.getParameter("tel");
        String address = request.getParameter("address");
        String position = request.getParameter("position");
        String action = request.getParameter("action");
        if ("add".equalsIgnoreCase(action)) {
            db.addRecord(id, name, tel, address, position);
            response.sendRedirect("handleUser?action=list");
        } else if("edit".equalsIgnoreCase(action)) {
            UserInfo cb = new UserInfo();
            cb.setId(id);
            cb.setName(name);
            cb.setTel(tel);
            cb.setAddress(address);
            cb.setPosition(position);
            db.editRecord(cb);
            response.sendRedirect("handleUser?action=list");
        } else {
            PrintWriter out = response.getWriter();
            out.println("No such action!!!");
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
