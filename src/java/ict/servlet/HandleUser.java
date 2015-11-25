/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.UserInfo;
import ict.db.UserDB;
import java.io.IOException;
import java.io.PrintWriter;
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
                String password = db.getNewPassword(id);
                ArrayList<UserInfo> users = db.queryUser();
                UserInfo user = new UserInfo();
                user.setId(id);
                user.setPassword(password);
                request.setAttribute("users", users);
                request.setAttribute("password", password);
                request.setAttribute("id", id);
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/listMember.jsp");
                rd.forward(request, response);
            }
        } else if ("showClientDateil".equalsIgnoreCase(action)) {
            String id = (String) request.getServletContext().getAttribute("uid");
            if (id != null) {
                UserInfo user = db.queryCustByID(id);
                request.setAttribute("u", user);
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/showClientAccount.jsp");
                rd.forward(request, response);
            }
        } else if ("getEditAccount".equalsIgnoreCase(action)) {
            String id = (String) request.getServletContext().getAttribute("uid");
            if (id != null) {
                UserInfo users = db.queryCustByID(id);
                request.setAttribute("u", users);
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/editClientAccout.jsp");
                rd.forward(request, response);
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
