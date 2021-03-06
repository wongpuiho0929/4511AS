package ict.servlet;

import ict.bean.ShoppingCartBean;
import ict.db.ProductDB;
import ict.db.ShoppingCartDB;
import ict.db.UserDB;
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
import javax.servlet.http.HttpSession;

@WebServlet(name = "ShoppingcartController", urlPatterns = {"/cart"})
public class ShoppingcartController extends HttpServlet {

    private ShoppingCartDB db;
    private ProductDB pdb;
    private UserDB udb;

    public void init() {
        String username = this.getServletContext().getInitParameter("username");
        String password = this.getServletContext().getInitParameter("password");
        String targetURL = this.getServletContext().getInitParameter("url");
        db = new ShoppingCartDB(targetURL, username, password);
        udb = new UserDB(targetURL, username, password);
        pdb = new ProductDB(targetURL, username, password);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String pid = request.getParameter("pid");
        String uid = (String) request.getServletContext().getAttribute("uid");
        if (uid == null || uid == "") {
            uid = request.getParameter("uid");
        }
        String removesid = request.getParameter("sid");
        PrintWriter out = response.getWriter();
        if (action.equals("login")) {
            ArrayList<ShoppingCartBean> pb = db.showCart(uid);
            HttpSession session = request.getSession(true);
            session.setAttribute("shoppingCart", pb);
            out.print("<script type='text/javascript'>");
            out.print("location.href='index.jsp'");
            out.print("</script>");
        } else if (action.equals("show")) {
            ArrayList<ShoppingCartBean> pb = db.showCart(uid);
            HttpSession session = request.getSession(true);
            session.setAttribute("shoppingCart", pb);
            out.print("<script type='text/javascript'>");
            out.print("location.href='shoppingcart.jsp'");
            out.print("</script>");
        } else if (action.equals("add")) {
            try {
                if (uid != null) {
                    if (pdb.productdetail(pid).getQty() > 0) {
                        String sid = db.lastID();
                        ShoppingCartBean bean = db.getCart(pid, uid);
                        if (bean == null) {
                            db.addShoppingCart(sid, uid, pid, 1);
                        } else {
                            db.updateQty(bean.getQty() + 1, bean.getSid());
                        }
                        pdb.orderProduct(pid, 1);
                        String targetURL = "cart?action=show&uid=" + uid;
                        RequestDispatcher rd;
                        rd = getServletContext().getRequestDispatcher("/" + targetURL);
                        rd.forward(request, response);
                    } else {
                        out.print("<script type='text/javascript'>alert('Sold!');location.href='index.jsp';</script>");
                    }
                } else {
                    out.print("<script type='text/javascript'>alert('Login First!');location.href='index.jsp';</script>");
                    
                }
            } catch (SQLException ex) {
                Logger.getLogger(ShoppingcartController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equals("remove")) {
            try {
                db.remove(removesid);
                int qty = Integer.parseInt(request.getParameter("qty"));
                pdb.unOrderProduct(pid, qty);
                String targetURL = "cart?action=show&uid=" + uid;
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/" + targetURL);
                rd.forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(ShoppingcartController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

}
