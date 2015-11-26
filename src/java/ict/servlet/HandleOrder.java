/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.OrderBean;
import ict.db.OrderDB;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "HandleOrder", urlPatterns = {"/handleOrder"})
public class HandleOrder extends HttpServlet {
    
    private OrderDB db;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    public void init() {
        String username = this.getServletContext().getInitParameter("username");
        String password = this.getServletContext().getInitParameter("password");
        String url = this.getServletContext().getInitParameter("url");
        db = new OrderDB(url, username, password);
        db.createOrderTable();
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("list".equalsIgnoreCase(action)) {
            ArrayList<OrderBean> ob = db.listOrder();
            request.setAttribute("ob", ob);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/listOrder.jsp");
            rd.forward(request, response);
        }else if ("add".equalsIgnoreCase(action)) {
            
        } else {
            PrintWriter out = response.getWriter();
            out.println("No such action!!!");
        }
    }
}
