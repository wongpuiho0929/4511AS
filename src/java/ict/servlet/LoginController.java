package ict.servlet;

import ict.bean.UserInfo;
import ict.db.UserDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private UserDB db;

    public void init() {
        String username = this.getServletContext().getInitParameter("username");
        String password = this.getServletContext().getInitParameter("password");
        String targetURL = this.getServletContext().getInitParameter("url");
        db = new UserDB(targetURL, username, password);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (!isAuthenticated(request)
                && !("authenticate".equals(action))
                && !("logout".equals(action))) {
            doLogin(request, response);
            return;
        }
        if ("authenticate".equals(action)) {
            try {
                doAuthenticate(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if ("logout".equals(action)) {
            doLogout(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_IMPLEMENTED);
        }
    }

    private boolean isAuthenticated(HttpServletRequest request) {
        boolean result = false;
        HttpSession session = request.getSession();
        if (session.getAttribute("userInfo") != null) {
            result = true;
        }
        return result;
    }

    private void doAuthenticate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String targetURL;
        UserInfo isValid = db.isValidUser(username, password);
        if (isValid != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("userName", isValid);
            targetURL = "cart?action=login&uid="+isValid.getId();
            RequestDispatcher rd;
            rd = getServletContext().getRequestDispatcher("/" + targetURL);
            rd.forward(request, response);
            doLogin(request, response);
            return;
        } else {
            targetURL = "/loginError.jsp";
        }
        RequestDispatcher rd;
        rd = getServletContext().getRequestDispatcher("/" + targetURL);
        rd.forward(request, response);

    }

    private void doLogout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.removeAttribute("userInfo");
            session.removeAttribute("shoppingcart");
            session.invalidate();
        }
        doLogin(request, response);
    }

    private void doLogin(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        /*String targetURL = "login.jsp";
        RequestDispatcher rd;
        rd = getServletContext().getRequestDispatcher("/" + targetURL);
        rd.forward(request, response);*/
        PrintWriter out = response.getWriter();
        out.print("<script type='text/javascript'>");
        out.print("location.href='index.jsp'");
        out.print("</script>");
    }

}
