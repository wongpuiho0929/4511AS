/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.UserInfo;
import ict.db.UserDB;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

/**
 *
 * @author user
 */
@WebServlet(name = "HandleUser", urlPatterns = {"/handleUser"})
public class HandleUser extends HttpServlet {

    private UserDB db;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("list".equalsIgnoreCase(action)) {
            ArrayList<UserInfo> users = db.queryUser();
            request.setAttribute("users", users);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/listMember.jsp");
            rd.forward(request, response);
        } else if ("getEditUser".equalsIgnoreCase(action)) {
            String id = request.getParameter("id");
            if (id != null) {
                UserInfo users = db.queryCustByID(id);
                request.setAttribute("u", users);
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/editMember.jsp");
                rd.forward(request, response);
            }
        } else if ("unfreeze".equalsIgnoreCase(action)) {
            String id = request.getParameter("id");
            if (id != null) {
                if (db.unfreeze(id)) {
                    ArrayList<UserInfo> users = db.queryUser();
                    request.setAttribute("users", users);
                    RequestDispatcher rd;
                    rd = getServletContext().getRequestDispatcher("/listMember.jsp");
                    rd.forward(request, response);
                }
            }
        } else if ("freeze".equalsIgnoreCase(action)) {
            String id = request.getParameter("id");
            if (id != null) {
                if (db.freeze(id)) {
                    ArrayList<UserInfo> users = db.queryUser();
                    request.setAttribute("users", users);
                    RequestDispatcher rd;
                    rd = getServletContext().getRequestDispatcher("/listMember.jsp");
                    rd.forward(request, response);
                }
            }
        } else if ("getNewPassword".equalsIgnoreCase(action)) {
            String id = request.getParameter("id");
            if (id != null) {
                if (db.freeze(id)) {
                    UserInfo user = db.queryCustByID(id);
                    Random r = new Random();
                    String password = "";
                    char[] temp = new char[8];
                    for (int i = 0; i < temp.length; i++) {
                        temp[i] = (char) (r.nextInt(74) + 48);
                        password += temp[i];
                    }
                    user.setPassword(password);
                    if (db.editRecord(user))
                        JOptionPane.showMessageDialog(null, "New Password: " + password);
                    request.setAttribute("users", user);
                    RequestDispatcher rd;
                    rd = getServletContext().getRequestDispatcher("/listMember.jsp");
                    rd.forward(request, response);
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
    public void init() {
        String username = this.getServletContext().getInitParameter("username");
        String password = this.getServletContext().getInitParameter("password");
        String url = this.getServletContext().getInitParameter("url");
        db = new UserDB(url, username, password);
        db.createUserInfoTable();
    }

}
