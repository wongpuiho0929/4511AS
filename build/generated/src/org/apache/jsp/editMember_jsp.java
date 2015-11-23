package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.ArrayList;
import ict.bean.UserInfo;

public final class editMember_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n");
      out.write("<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n");
      out.write("    <head>\r\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n");
      out.write("        <title>Station Shop Template</title>\r\n");
      out.write("        <meta name=\"keywords\" content=\"\" />\r\n");
      out.write("        <meta name=\"description\" content=\"\" />\r\n");
      out.write("\r\n");
      out.write("        <link href=\"css/templatemo_style.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/ddsmoothmenu.css\" />\r\n");
      out.write("        <script type=\"text/javascript\" src=\"js/jquery.min.js\"></script>\r\n");
      out.write("        <script type=\"text/javascript\" src=\"js/ddsmoothmenu.js\"></script>\r\n");
      out.write("        <script language=\"javascript\" type=\"text/javascript\">\r\n");
      out.write("            function clearText(field)\r\n");
      out.write("            {\r\n");
      out.write("                if (field.defaultValue == field.value)\r\n");
      out.write("                    field.value = '';\r\n");
      out.write("                else if (field.value == '')\r\n");
      out.write("                    field.value = field.defaultValue;\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("        </script>\r\n");
      out.write("\r\n");
      out.write("        <script type=\"text/javascript\">\r\n");
      out.write("\r\n");
      out.write("            ddsmoothmenu.init({\r\n");
      out.write("                mainmenuid: \"top_nav\", //menu DIV id\r\n");
      out.write("                orientation: 'h', //Horizontal or vertical menu: Set to \"h\" or \"v\"\r\n");
      out.write("                classname: 'ddsmoothmenu', //class added to menu's outer DIV\r\n");
      out.write("                //customtheme: [\"#1c5a80\", \"#18374a\"],\r\n");
      out.write("                contentsource: \"markup\" //\"markup\" or [\"container_id\", \"path_to_menu_file\"]\r\n");
      out.write("            })\r\n");
      out.write("\r\n");
      out.write("        </script>\r\n");
      out.write("\r\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" media=\"all\" href=\"css/jquery.dualSlider.0.2.css\" />\r\n");
      out.write("\r\n");
      out.write("        <script src=\"js/jquery-1.3.2.min.js\" type=\"text/javascript\"></script>\r\n");
      out.write("        <script src=\"js/jquery.easing.1.3.js\" type=\"text/javascript\"></script>\r\n");
      out.write("        <script src=\"js/jquery.timers-1.2.js\" type=\"text/javascript\"></script>\r\n");
      out.write("        <script src=\"js/jquery.dualSlider.0.3.min.js\" type=\"text/javascript\"></script>\r\n");
      out.write("\r\n");
      out.write("        <script type=\"text/javascript\">\r\n");
      out.write("\r\n");
      out.write("            $(document).ready(function () {\r\n");
      out.write("\r\n");
      out.write("                $(\".carousel\").dualSlider({\r\n");
      out.write("                    auto: true,\r\n");
      out.write("                    autoDelay: 6000,\r\n");
      out.write("                    easingCarousel: \"swing\",\r\n");
      out.write("                    easingDetails: \"easeOutBack\",\r\n");
      out.write("                    durationCarousel: 1000,\r\n");
      out.write("                    durationDetails: 600\r\n");
      out.write("\r\n");
      out.write("                });\r\n");
      out.write("\r\n");
      out.write("            });\r\n");
      out.write("        </script>\r\n");
      out.write("    </head>\r\n");
      out.write("    <body>\r\n");
      out.write("        ");
      ict.bean.UserInfo userName = null;
      synchronized (session) {
        userName = (ict.bean.UserInfo) _jspx_page_context.getAttribute("userName", PageContext.SESSION_SCOPE);
        if (userName == null){
          userName = new ict.bean.UserInfo();
          _jspx_page_context.setAttribute("userName", userName, PageContext.SESSION_SCOPE);
        }
      }
      out.write("\r\n");
      out.write("\r\n");
      out.write("        <div id=\"templatemo_wrapper\">\r\n");
      out.write("            <div id=\"templatemo_header\">\r\n");
      out.write("\r\n");
      out.write("                <div id=\"site_title\">\r\n");
      out.write("                    <h1><a href=\"#\">Station Shop</a></h1>\r\n");
      out.write("                </div>\r\n");
      out.write("\r\n");
      out.write("                <div id=\"header_right\">\r\n");
      out.write("                    <a href=\"#\">My Account</a> | <a href=\"#\">My Cart</a> | <a href=\"#\">My Recard</a> | <a href=\"#\">Checkout</a> |\r\n");
      out.write("\r\n");
      out.write("                    ");

                        if (userName.getUsername() == null) {
                            out.print("<a href='login.jsp'>Log In</a>");
                        } else {
                            out.print("<font size=5>" + userName.getUsername() + ",</font>" + " <a href='login?action=logout'> Logout</a>");
                        }
                    
      out.write("\r\n");
      out.write("                </div>\r\n");
      out.write("\r\n");
      out.write("                <div class=\"cleaner\"></div>\r\n");
      out.write("            </div> <!-- END of templatemo_header -->\r\n");
      out.write("\r\n");
      out.write("            <div id=\"templatemo_menu\">\r\n");
      out.write("                <div id=\"top_nav\" class=\"ddsmoothmenu\">\r\n");
      out.write("                    <ul>\r\n");
      out.write("                        <li><a href=\"index.jsp\" class=\"selected\">Home</a></li>\r\n");
      out.write("                        <li><a href=\"products.jsp\">Products</a>\r\n");
      out.write("                            <ul>\r\n");
      out.write("                                <li><a href=\"#submenu1\">Sub menu 1</a></li>\r\n");
      out.write("                                <li><a href=\"#submenu2\">Sub menu 2</a></li>\r\n");
      out.write("                                <li><a href=\"#submenu3\">Sub menu 3</a></li>\r\n");
      out.write("                            </ul>\r\n");
      out.write("                        </li>\r\n");
      out.write("                        <li><a href=\"about.jsp\">About</a>\r\n");
      out.write("                            <ul>\r\n");
      out.write("                                <li><a href=\"#submenu1\">Sub menu 1</a></li>\r\n");
      out.write("                                <li><a href=\"#submenu2\">Sub menu 2</a></li>\r\n");
      out.write("                                <li><a href=\"#submenu3\">Sub menu 3</a></li>\r\n");
      out.write("                                <li><a href=\"#submenu4\">Sub menu 4</a></li>\r\n");
      out.write("                                <li><a href=\"#submenu5\">Sub menu 5</a></li>\r\n");
      out.write("                            </ul>\r\n");
      out.write("                        </li>\r\n");
      out.write("                        <li><a href=\"checkout.jsp\">Checkout</a></li>\r\n");
      out.write("                        <li><a href=\"contact.jsp\">Contact</a></li>\r\n");
      out.write("                    </ul>\r\n");
      out.write("                    <br style=\"clear: left\" />\r\n");
      out.write("                </div> <!-- end of ddsmoothmenu -->\r\n");
      out.write("                <div id=\"menu_second_bar\">\r\n");
      out.write("                    <div id=\"top_shopping_cart\">\r\n");
      out.write("                        Shopping Cart: <strong>X Products</strong> ( <a href=\"#\">Show Cart</a> )\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <div id=\"templatemo_search\">\r\n");
      out.write("                        <form action=\"#\" method=\"get\">\r\n");
      out.write("                            <input type=\"text\" value=\"Search\" name=\"keyword\" id=\"keyword\" title=\"keyword\" onfocus=\"clearText(this)\" onblur=\"clearText(this)\" class=\"txt_field\" />\r\n");
      out.write("                            <input type=\"submit\" name=\"Search\" value=\" Search \" alt=\"Search\" id=\"searchbutton\" title=\"Search\" class=\"sub_btn\"  />\r\n");
      out.write("                        </form>\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <div class=\"cleaner\"></div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div> <!-- END of templatemo_menu -->\r\n");
      out.write("\r\n");
      out.write("            <div id=\"templatemo_main\">\r\n");
      out.write("                <div id=\"sidebar\" class=\"float_l\">\r\n");
      out.write("                    <div class=\"sidebar_box\"><span class=\"bottom\"></span>\r\n");
      out.write("                        <h3>Categories</h3>   \r\n");
      out.write("                        <div class=\"content\"> \r\n");
      out.write("                            <ul class=\"sidebar_list\">\r\n");
      out.write("                                <li class=\"first\"><a href=\"#\">Aenean varius nulla</a></li>\r\n");
      out.write("                                <li><a href=\"#\">Cras mattis arcu</a></li>\r\n");
      out.write("                                <li><a href=\"#\">Donec turpis ipsum</a></li>\r\n");
      out.write("                                <li><a href=\"#\">Fusce sodales mattis</a></li>\r\n");
      out.write("                                <li><a href=\"#\">Maecenas et mauris</a></li>\r\n");
      out.write("                                <li><a href=\"#\">Mauris nulla tortor</a></li>\r\n");
      out.write("                                <li><a href=\"#\">Nulla odio ipsum</a></li>\r\n");
      out.write("                                <li><a href=\"#\">Nunc ac viverra nibh</a></li>\r\n");
      out.write("                                <li><a href=\"#\">Praesent id venenatis</a></li>\r\n");
      out.write("                                <li><a href=\"#\">Quisque odio velit</a></li>\r\n");
      out.write("                                <li><a href=\"#\">Suspendisse posuere</a></li>\r\n");
      out.write("                                <li><a href=\"#\">Tempus lacus risus</a></li>\r\n");
      out.write("                                <li><a href=\"#\">Ut tincidunt imperdiet</a></li>\r\n");
      out.write("                                <li><a href=\"#\">Vestibulum eleifend</a></li>\r\n");
      out.write("                                <li class=\"last\"><a href=\"#\">Velit mi rutrum diam</a></li>\r\n");
      out.write("                            </ul>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div id=\"content\" class=\"float_r\">\r\n");
      out.write("                    ");
      ict.bean.UserInfo c = null;
      synchronized (request) {
        c = (ict.bean.UserInfo) _jspx_page_context.getAttribute("c", PageContext.REQUEST_SCOPE);
        if (c == null){
          c = new ict.bean.UserInfo();
          _jspx_page_context.setAttribute("c", c, PageContext.REQUEST_SCOPE);
        }
      }
      out.write("\r\n");
      out.write("                    ");

                        String type = c.getId()!= null ? "edit" : "add";
                        String id = c.getId() != null ? c.getId() : "";
                        String name = c.getId() != null ? c.getName(): "";
                        String tel = c.getId() != null ? c.getTel() : "";
                        String address = c.getId() != null ? c.getAddress(): "";
                        String position = c.getId() != null ? c.getPosition(): "";
                    
      out.write("\r\n");
      out.write("                    <h1>");
      out.print(type);
      out.write("</h1>\r\n");
      out.write("                    <form method=\"post\" action=\"handleEdit\">\r\n");
      out.write("                        <input type=\"hidden\" name=\"action\" value=\"");
      out.print(type);
      out.write("\"/>\r\n");
      out.write("                        <table border=\"0\">\r\n");
      out.write("                            <tr>\r\n");
      out.write("                                <td><p align=\"right\" /><b>id </b></td>\r\n");
      out.write("                                <td><p /><input type=\"text\" name=\"id\" maxlength=\"10\" size=\"15\" value=\"");
      out.print(id);
      out.write("\"></td>\r\n");
      out.write("                            </tr>\r\n");
      out.write("                            <tr>\r\n");
      out.write("                                <td><p align=\"right\" /><b>name </b></td>\r\n");
      out.write("                                <td><p /><input type=\"text\" name=\"name\" maxlength=\"10\" size=\"15\" value=\"");
      out.print(name);
      out.write("\"></td>\r\n");
      out.write("                            </tr>\r\n");
      out.write("                            <tr>\r\n");
      out.write("                                <td><p align=\"right\" /><b>tel </b></td>\r\n");
      out.write("                                <td><p /><input type=\"text\" name=\"tel\" maxlength=\"10\" size=\"15\" value=\"");
      out.print(tel);
      out.write("\"></td>\r\n");
      out.write("                            </tr>\r\n");
      out.write("                            <tr>\r\n");
      out.write("                                <td><p align=\"right\" /><b>address </b></td>\r\n");
      out.write("                                <td><p /><input type=\"text\" name=\"address\" maxlength=\"10\" size=\"15\" value=\"");
      out.print(address);
      out.write("\"></td>\r\n");
      out.write("                            </tr>\r\n");
      out.write("                            <tr>\r\n");
      out.write("                                <td><p align=\"right\" /><b>age </b></td>\r\n");
      out.write("                                <td><p /><input type=\"radio\" name=\"age\" maxlength=\"10\" size=\"15\" value=\"");
      out.print(address);
      out.write("\"></td>\r\n");
      out.write("                            </tr>\r\n");
      out.write("                            <tr>\r\n");
      out.write("                                <td colspan=\"2\"><p align=\"center\" /><input type=\"submit\" value=\"submit\"</td>\r\n");
      out.write("                            </tr>\r\n");
      out.write("                        </table>\r\n");
      out.write("                    </form>\r\n");
      out.write("                </div> \r\n");
      out.write("                <div class=\"cleaner\"></div>\r\n");
      out.write("            </div> <!-- END of templatemo_main -->\r\n");
      out.write("\r\n");
      out.write("            <div id=\"templatemo_footer\">\r\n");
      out.write("                <p>\r\n");
      out.write("                    <a href=\"index.jsp\">Home</a> | <a href=\"products.jsp\">Products</a> | <a href=\"about.jsp\">About</a> | <a href=\"faqs.jsp\">FAQs</a> | <a href=\"checkout.jsp\">Checkout</a> | <a href=\"contact.jsp\">Contact</a>\r\n");
      out.write("                </p>\r\n");
      out.write("\r\n");
      out.write("                Copyright © 2048 <a href=\"#\">Your Company Name</a>\r\n");
      out.write("            </div> <!-- END of templatemo_footer -->\r\n");
      out.write("\r\n");
      out.write("        </div> <!-- END of templatemo_wrapper Text -->\r\n");
      out.write("\r\n");
      out.write("    </body>\r\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
