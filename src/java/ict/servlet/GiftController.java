/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.GiftBean;
import ict.db.GiftDB;
import ict.db.UserGiftDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *
 * @author pet10_000
 */
@WebServlet(name = "gift", urlPatterns = {"/gift"})
public class GiftController extends HttpServlet {

    private GiftDB gdb;
    private UserGiftDB ugdb;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("list".equalsIgnoreCase(action)) {
            ArrayList<GiftBean> gb = gdb.listGift();
            request.setAttribute("gb", gb);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/gifts.jsp");
            rd.forward(request, response);
        } else if ("add".equalsIgnoreCase(action)) {
            String[] giftId = request.getParameterValues("id");
            String userId = request.getParameter("userId");
            int bonus = Integer.parseInt(request.getParameter("bonus"));
            if(userId != null) {
                for (int i = 0; i < giftId.length; i++) {
                    try {
                        GiftBean gb = gdb.listGiftByID(giftId[i]);
                        ugdb.addUserGift(giftId[i], userId, gb.getBonusPoint());
                        gdb.UpdateGiftQty(gb);
                    } catch (SQLException ex) {
                        PrintWriter out = response.getWriter();
                        out.println(ex);
                    }
                }
                response.sendRedirect("gift?action=list");
            } else
                response.sendRedirect("login.jsp");
        } else {
            PrintWriter out = response.getWriter();
            out.println("No such action!!!");
        }
    }

    @Override
    public void init() {
        String username = this.getServletContext().getInitParameter("username");
        String password = this.getServletContext().getInitParameter("password");
        String url = this.getServletContext().getInitParameter("url");
        gdb = new GiftDB(url, username, password);
        ugdb = new UserGiftDB(url, username, password);
        gdb.createGiftTable();
        ugdb.createUserGiftTable();
    }
}
