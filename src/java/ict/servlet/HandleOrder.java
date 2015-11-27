/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.OrderBean;
import ict.bean.ProductBean;
import ict.bean.ShoppingCartBean;
import ict.bean.UserInfo;
import ict.db.OrderDB;
import ict.db.ProductDB;
import ict.db.ShoppingCartDB;
import ict.db.UserDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "HandleOrder", urlPatterns = {"/handleOrder"})
public class HandleOrder extends HttpServlet {

    private OrderDB db;
    private ProductDB pdb;
    private UserDB udb;
    private ShoppingCartDB scdb;

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
        pdb = new ProductDB(url, username, password);
        udb = new UserDB(url, username, password);
        scdb = new ShoppingCartDB(url, username, password);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("list".equalsIgnoreCase(action)) {
            ArrayList<OrderBean> ob = db.listOrder();
            request.setAttribute("ob", ob);
            request.setAttribute("action", action);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/listOrder.jsp");
            rd.forward(request, response);
        } else if ("record".equalsIgnoreCase(action)) {
            String uid = (String) request.getServletContext().getAttribute("uid");
            ArrayList<OrderBean> ob = db.listOrderById(uid);
            request.setAttribute("ob", ob);
            request.setAttribute("action", action);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/listOrder.jsp");
            rd.forward(request, response);
        } else if ("add".equalsIgnoreCase(action)) {
            try {
                String uid = (String) request.getServletContext().getAttribute("uid");
                if (uid != null) {
                    HttpSession session = request.getSession(true);
                    ArrayList<ShoppingCartBean> arr = (ArrayList<ShoppingCartBean>) session.getAttribute("shoppingCart");
                    String oid = db.lastID();
                    double tprice = Double.parseDouble(request.getParameter("total"));
                    int bouns = calBonus(tprice);
                    java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("datetime"));
                    java.sql.Date sqlDate = new java.sql.Date(date.getTime());
                    if (request.getParameter("select").equalsIgnoreCase("delivery")) {
                        db.addDeliveryOrder(oid, uid, tprice, "process", bouns);
                    } else if (request.getParameter("select").equalsIgnoreCase("self")) {
                        db.addPickUpOrder(oid, uid, sqlDate, tprice, "process", bouns);
                    }
                    for (int i = 0; i < arr.size(); i++) {
                        arr.get(i).setOid(oid);
                        scdb.updateCart(arr.get(i));
                    }
                    session.removeAttribute("shoppingCart");
                    UserInfo u = (UserInfo) session.getAttribute("userName");
                    u.setBonus(u.getBonus() + bouns);
                    session.setAttribute("userName", u);
                    udb.setNewBonus(u);
                    response.sendRedirect("product?action=groupBy");
                } else {
                    response.sendRedirect("login.jsp");
                }
            } catch (SQLException ex) {
                Logger.getLogger(HandleOrder.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ParseException ex) {
                Logger.getLogger(HandleOrder.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("view".equalsIgnoreCase(action)) {
            String oid = request.getParameter("id");
            OrderBean o = db.listOrderByOid(oid);
            ArrayList<ShoppingCartBean> arr = scdb.getProductId(oid);
            ArrayList<ProductBean> pdbl = new ArrayList<ProductBean>();
            for (int i = 0; i < arr.size(); i++) {
                ProductBean pb = pdb.productdetail(arr.get(i).getPid());
                pdbl.add(pb);
            }
            request.setAttribute("o", o);
            request.setAttribute("scdbl", arr);
            request.setAttribute("pdbl", pdbl);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/orderDetails.jsp");
            rd.forward(request, response);
        } else if ("show".equalsIgnoreCase(action)) {
            String oid = request.getParameter("id");
            OrderBean o = db.listOrderByOid(oid);
            request.setAttribute("o", o);
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/updateOrder.jsp");
            rd.forward(request, response);
        } else if ("update".equalsIgnoreCase(action)) {
            try {
                String oid = request.getParameter("oid");
                String status = request.getParameter("status");
                if ("cancel".equalsIgnoreCase(status)) {
                    response.sendRedirect("handleOrder?action=cancel");
                }
                db.updateStatus(oid, status);
                response.sendRedirect("handleOrder?action=list");
            } catch (SQLException ex) {
                Logger.getLogger(HandleOrder.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("cancel".equalsIgnoreCase(action)) {
            try {
                String oid = request.getParameter("id");
                String status = "cancel";
                db.updateStatus(oid, status);
                OrderBean o = db.listOrderByOid(oid);
                if (o.getBonus() > 0) {
                    HttpSession session = request.getSession(true);
                    UserInfo u = (UserInfo) session.getAttribute("userName");
                    u.setBonus(u.getBonus() - o.getBonus());
                    udb.setNewBonus(u);
                }
                ArrayList<ShoppingCartBean> arr = scdb.getProductId(oid);
                for (int i = 0; i < arr.size(); i++) {;
                    pdb.unOrderProduct(arr.get(i).getPid(), arr.get(i).getQty());
                }
                response.sendRedirect("handleOrder?action=record");
            } catch (SQLException ex) {
                Logger.getLogger(HandleOrder.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            PrintWriter out = response.getWriter();
            out.println("No such action!!!");
        }
    }

    private int calBonus(double tprice) {
        return (int) (tprice / 1000) * 100;
    }
}
