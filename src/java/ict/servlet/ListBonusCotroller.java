/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.OrderBean;
import ict.bean.UserGiftBean;
import ict.db.GiftDB;
import ict.db.OrderDB;
import ict.db.UserGiftDB;
import java.io.IOException;
import java.util.ArrayList;
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
@WebServlet(name = "ListBonusCotroller", urlPatterns = {"/listBonusCotroller"})
public class ListBonusCotroller extends HttpServlet {
    
    private GiftDB gdb;
    private UserGiftDB ugdb;
    private OrderDB odb;
    
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
        String id = (String) request.getServletContext().getAttribute("uid");
        ArrayList<OrderBean> ob = odb.listOrderById(id);
        ArrayList<UserGiftBean> ugb = ugdb.listGiftById(id);
        request.setAttribute("ob", ob);
        request.setAttribute("ugb", ugb);
        RequestDispatcher rd;
        rd = getServletContext().getRequestDispatcher("/bonusPoint.jsp");
        rd.forward(request, response);
    }
    @Override
    public void init() {
        String username = this.getServletContext().getInitParameter("username");
        String password = this.getServletContext().getInitParameter("password");
        String url = this.getServletContext().getInitParameter("url");
        gdb = new GiftDB(url, username, password);
        ugdb = new UserGiftDB(url, username, password);
        odb = new OrderDB(url, username, password);
    }
}
