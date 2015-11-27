package ict.servlet;

import ict.bean.ProductBean;
import ict.db.ProductDB;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.RequestContext;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(name = "ProductController", urlPatterns = {"/product"})
public class ProductController extends HttpServlet {

    ProductDB db;
    private final String UPLOAD_DIRECTORY = "C:\\Users\\wongp\\Documents\\NetBeansProjects\\4511AS\\web\\images\\product";

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
        String category = request.getParameter("category");
        String price1 = request.getParameter("price1");
        String price2 = request.getParameter("price2");
        String sortBy = request.getParameter("sortBy");
        String sortType = request.getParameter("sortType");
        
        List<FileItem> multiparts = null;
        if (action == null) {
            try {
                multiparts = new ServletFileUpload(
                        new DiskFileItemFactory()).parseRequest(request);
                action = multiparts.get(0).getString();
            } catch (FileUploadException ex) {
                Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
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
        } else if (action.equals("groupBy")) {
            ArrayList<ProductBean> pb = db.groupBy();
            HttpSession session = request.getSession(true);
            session.setAttribute("groupBy", pb);
            String targetURL = "product?action=show";
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/" + targetURL);
            rd.forward(request, response);
        } else if (action.equals("search")) {
            ArrayList<ProductBean> pb = db.searchProduct(pName, bName, category, price1, price2, sortBy, sortType);
            response.setContentType("text/html");
            request.setAttribute("search", pb);
            ArrayList<String> a = new ArrayList<String>();
            a.add("true");
            request.setAttribute("chicked", a);
            String targetURL = "Search.jsp";
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/" + targetURL);
            rd.forward(request, response);
        } else if (action.equals("searchB")) {
            ArrayList<ProductBean> pb = db.searchProductByBrand(bName);
            response.setContentType("text/html");
            request.setAttribute("search", pb);
            ArrayList<String> a = new ArrayList<String>();
            a.add("true");
            request.setAttribute("chicked", a);
            String targetURL = "Search.jsp";
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/" + targetURL);
            rd.forward(request, response);
        } else if (action.equals("searchC")) {
            ArrayList<ProductBean> pb = db.searchProductByCategory(category);
            response.setContentType("text/html");
            request.setAttribute("search", pb);
            ArrayList<String> a = new ArrayList<String>();
            a.add("true");
            request.setAttribute("chicked", a);
            String targetURL = "Search.jsp";
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/" + targetURL);
            rd.forward(request, response);
        } else if (action.equals("add")) {
            if (ServletFileUpload.isMultipartContent(request)) {
                try {
                    String pId = db.lastID();
                    pName = multiparts.get(1).getString();
                    double price = Double.parseDouble(multiparts.get(2).getString());
                    int qty = Integer.parseInt(multiparts.get(3).getString());
                    bName = multiparts.get(4).getString();
                    String description = multiparts.get(5).getString();
                    category = multiparts.get(6).getString();
                    String photoName = "";
                    long a = multiparts.get(7).getSize();
                    FileItem item = multiparts.get(7);
                    if (!item.isFormField() && item.getSize() != 0) {
                        String name = new File(item.getName()).getName();
                        item.write(new File(UPLOAD_DIRECTORY + File.separator + name));
                        photoName = "images/product/" + name;

                    }
                    db.addProduct(pId, pName, price, qty, bName, description, category, photoName);
                    request.setAttribute("message", "File Uploaded Successfully");
                } catch (Exception ex) {
                    request.setAttribute("message", "File Upload Failed due to " + ex);
                }
            } else {
                request.setAttribute("message",
                        "Sorry this Servlet only handles file upload request");
            }
            request.getRequestDispatcher("/run.jsp").forward(request, response);
        } else if (action.equals("edit")) {

            double price = Double.parseDouble(request.getParameter("price"));
            int qty = Integer.parseInt(request.getParameter("qty"));
            String description = request.getParameter("description");
            category = request.getParameter("category");
            try {
                db.updateProduct(id, pName, price, qty, bName, description, category);
                String targetURL = "product?action=detail&pid=" + id;
                RequestDispatcher rd;
                rd = getServletContext().getRequestDispatcher("/" + targetURL);
                rd.forward(request, response);
            } catch (Exception e) {
            }

        }
    }

    private void ShowProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<ProductBean> pb = db.showProduct();
        HttpSession session = request.getSession(true);
        session.setAttribute("productList", pb);
        PrintWriter out = response.getWriter();
        out.print("<script type='text/javascript'>");
        out.print("location.href='index.jsp'");
        out.print("</script>");
    }
}
