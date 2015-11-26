package ict.servlet;

import ict.bean.ProductBean;
import ict.db.ProductDB;
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

@WebServlet(name = "ProductController", urlPatterns = {"/product"})
public class ProductController extends HttpServlet {

    ProductDB db;

    public void init() {
        String username = this.getServletContext().getInitParameter("username");
        String password = this.getServletContext().getInitParameter("password");
        String targetURL = this.getServletContext().getInitParameter("url");
        db = new ProductDB(targetURL, username, password);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("pid");
        String pName = request.getParameter("pName");
        String bName = request.getParameter("bName");
        if (action.equals("show")) {
            ShowProduct(request, response);
        } else if (action.equals("detail")) {
            ProductBean pb = db.productdetail(id);
            HttpSession session = request.getSession(true);
            session.setAttribute("productDetail", pb);
            String targetURL = "productdetail.jsp";
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/" + targetURL);
            rd.forward(request, response);
        } else if (action.equals("search")) {
            ArrayList<ProductBean> pb = db.searchProduct(pName, bName);
            response.setContentType("text/html");
            request.setAttribute("search", pb);
            ArrayList<String> a = new ArrayList<String>();
            a.add("true");
            request.setAttribute("chicked", a);
            String targetURL = "Search.jsp";
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/" + targetURL);
            rd.forward(request, response);
        }
    }

    private void ShowProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<ProductBean> pb = db.showProduct();
        HttpSession session = request.getSession(true);
        session.setAttribute("productList", pb);
        PrintWriter out = response.getWriter();
        out.print("<script type='text/javascript'>");
        out.print("location.href='product.jsp'");
        out.print("</script>");
    }
}
