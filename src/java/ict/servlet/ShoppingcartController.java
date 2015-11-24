package ict.servlet;

import ict.bean.ShoppingCartBean;
import ict.db.ShoppingCartDB;
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

@WebServlet(name = "ShoppingcartController", urlPatterns = {"/cart"})
public class ShoppingcartController extends HttpServlet {

    ShoppingCartDB db;

    public void init() {
        String username = this.getServletContext().getInitParameter("username");
        String password = this.getServletContext().getInitParameter("password");
        String targetURL = this.getServletContext().getInitParameter("url");
        db = new ShoppingCartDB(targetURL, username, password);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String pid = request.getParameter("pid");
        String uid = (String) request.getServletContext().getAttribute("uid");
        String removesid = request.getParameter("sid");
        PrintWriter out = response.getWriter();
        if (action.equals("show")) {
            ArrayList<ShoppingCartBean> pb = db.showCart(uid);
            HttpSession session = request.getSession(true);
            session.setAttribute("shoppingCart", pb);
            out.print("<script type='text/javascript'>");
            out.print("location.href='shoppingcart.jsp'");
            out.print("</script>");
        } else if (action.equals("add")) {
            String sid = db.lastID();
            db.addShoppingCart(sid, uid, pid, 1);
            String targetURL = "cart?action=show&uid=" + uid;
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/" + targetURL);
            rd.forward(request, response);
        } else if (action.equals("remove")) {
            db.remove(removesid);
            String targetURL = "cart?action=show&uid=" + uid;
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/" + targetURL);
            rd.forward(request, response);
        }
    }

}
