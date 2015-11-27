/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.UserInfo;
import ict.bean.GiftBean;
import ict.db.GiftDB;
import ict.db.UserGiftDB;
import ict.db.UserDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author pet10_000
 */
@WebServlet(name = "gift", urlPatterns = {"/gift"})
public class GiftController extends HttpServlet {

    private GiftDB gdb;
    private UserGiftDB ugdb;
    private UserDB udb;

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
            String giftId = request.getParameter("gid");
            String id = (String) request.getServletContext().getAttribute("uid");
            int bonus = Integer.parseInt(request.getParameter("bonus"));
            if (id != null) {
                try {
                    GiftBean gb = gdb.listGiftByID(giftId);
                    UserInfo u = udb.queryCustByID(id);
                    if (gb.getBonusPoint() < bonus || gb.getBonusPoint() == bonus || gb.getQty() <= 0) {
                        int newBonus = bonus - gb.getBonusPoint();
                        ugdb.addUserGift(giftId, id, gb.getBonusPoint());
                        gdb.UpdateGiftQty(gb);
                        u.setBonus(newBonus);
                        HttpSession session = request.getSession(true);
                        u = (UserInfo)session.getAttribute("userName");
                        u.setBonus(newBonus);
                        session.setAttribute("userName", u);
                        udb.setNewBonus(u);
                    }
                } catch (Exception ex) {
                    PrintWriter out = response.getWriter();
                    out.println(ex);
                }
                response.sendRedirect("gift?action=list");
            } else {
                response.sendRedirect("login.jsp");
            }
        } else if (action.equalsIgnoreCase("search")) {
            String type = request.getParameter("search");
            if (type.equalsIgnoreCase("search")) {
                String option = request.getParameter("option");
                int bonus = Integer.parseInt(request.getParameter("bonus"));
                ArrayList<GiftBean> gb = gdb.listGiftByBonusPoint(bonus, option);
                request.setAttribute("gb", gb);
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/gifts.jsp");
                rd.forward(request, response);
            } else
                response.sendRedirect("gift?action=list");
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
        udb = new UserDB(url, username, password);
    }
}
