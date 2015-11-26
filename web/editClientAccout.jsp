<%@page import="java.util.ArrayList"%>
<%@page import="ict.bean.UserInfo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Station Shop Template</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />

        <link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/ddsmoothmenu.js"></script>
        <script language="javascript" type="text/javascript">
            function clearText(field)
            {
                if (field.defaultValue == field.value)
                    field.value = '';
                else if (field.value == '')
                    field.value = field.defaultValue;
            }

        </script>

        <script type="text/javascript">

            ddsmoothmenu.init({
                mainmenuid: "top_nav", //menu DIV id
                orientation: 'h', //Horizontal or vertical menu: Set to "h" or "v"
                classname: 'ddsmoothmenu', //class added to menu's outer DIV
                //customtheme: ["#1c5a80", "#18374a"],
                contentsource: "markup" //"markup" or ["container_id", "path_to_menu_file"]
            })

        </script>

        <link rel="stylesheet" type="text/css" media="all" href="css/jquery.dualSlider.0.2.css" />

        <script src="js/jquery-1.3.2.min.js" type="text/javascript"></script>
        <script src="js/jquery.easing.1.3.js" type="text/javascript"></script>
        <script src="js/jquery.timers-1.2.js" type="text/javascript"></script>
        <script src="js/jquery.dualSlider.0.3.min.js" type="text/javascript"></script>

        <script type="text/javascript">

            $(document).ready(function () {

                $(".carousel").dualSlider({
                    auto: true,
                    autoDelay: 6000,
                    easingCarousel: "swing",
                    easingDetails: "easeOutBack",
                    durationCarousel: 1000,
                    durationDetails: 600

                });

            });
        </script>
    </head>
    <body>
        <jsp:useBean class="ict.bean.UserInfo" id="userName" scope="session"/>
        <% String s = userName.getId();
            pageContext.setAttribute("uid", s, PageContext.APPLICATION_SCOPE);
        %>

        <div id="templatemo_wrapper">
            <div id="templatemo_header">

                <div id="site_title">
                    <h1><a href="index.jsp">Station Shop</a></h1>
                </div>

                <div id="header_right">
                    <a href="#">My Account</a> | <a href="#">My Cart</a> | <a href="#">My Recard</a> | <a href="#">Checkout</a> |

                    <%
                        if (userName.getUsername() == null) {
                            out.print("<a href='login.jsp'>Log In</a>");
                        } else {
                            out.print("<font size=5>" + userName.getUsername() + ",</font>" + " <a href='login?action=logout'> Logout</a>");
                        }
                    %>
                </div>

                <div class="cleaner"></div>
            </div> <!-- END of templatemo_header -->

            <div id="templatemo_menu">
                <div id="top_nav" class="ddsmoothmenu">
                    <ul>
                        <li><a href="index.jsp" class="selected">Home</a></li>
                        <li><a href="products.jsp">Products</a></li>
                        <li><a href="Search.jsp" >Search</a></li>
                        <li><a href="checkout.jsp" >Checkout</a></li>
                    </ul>
                    <br style="clear: left" />
                </div> <!-- end of ddsmoothmenu -->
                <div id="menu_second_bar">
                    <div id="top_shopping_cart">
                        Shopping Cart: <strong>X Products</strong> ( <a href="#">Show Cart</a> )
                    </div>
                    <div class="cleaner"></div>
                </div>
            </div> <!-- END of templatemo_menu -->
            <jsp:useBean id="u" scope="request" class="ict.bean.UserInfo" />
            <%if (u.getId() != null) {
                    out.print("<div id=\"sidebar\" class=\"float_l\"><div class=\"sidebar_box\"><span class=\"bottom\"></span><h3>Manage</h3><div class=\"content\"><ul class=\"sidebar_list\"><li class=\"first\"><a href=\"handleUser?action=getEditAccount\">Edit personal Information</a></li><li class=\"last\"><a href=\"changeClientPassword.jsp\">Change Password</a></li></ul></div></div></div>");
                }
                String temID = u.getId() != null ? "templatemo_main" : "templatemo_middle";
                String temID2 = u.getId() != null ? "content" : "";
                String temClass = u.getId() != null ? "float_r" : "";
            %>

            <div id="<%=temID%>">

                <div id="<%=temID2%>" class="<%=temClass%>">
                    <%
                        String state = u.getId() != null ? "Edit Account" : "Register";
                        String type = u.getId() != null ? "edit" : "add";
                        String submitT = u.getId() != null ? "submit" : "register";
                        String name = u.getId() != null ? u.getName() : "";
                        String tel = u.getId() != null ? u.getTel() : "";
                        String address = u.getId() != null ? u.getAddress() : "";
                    %>
                    <center>
                        <h1><%if (u.getId() == null) out.print("<br /><br /><font color='cyan'>");%><%=state%><%if (u.getId() == null) out.print("</font>");%></h1>
                        <form method="POST" action="editAccountController">
                            <input type="hidden" name="action" value="<%=type%>"/>
                            <table border="0">
                                <tr>
                                    <td><p align="right" /><b><%if (u.getId() == null) out.print("<font size='3'>");%>Name <%if (u.getId() == null) out.print("</font>");%></b></td>
                                    <td><p /><input type="text" name="name" maxlength="10" size="15" value="<%=name%>"></td>
                                </tr>
                                <tr>
                                    <td><p align="right" /><b><%if (u.getId() == null) out.print("<font size='3'>");%>Tel no <%if (u.getId() == null) out.print("</font>");%></b></td>
                                    <td><p /><input type="text" name="tel" maxlength="10" size="15" value="<%=tel%>"></td>
                                </tr>
                                <tr>
                                    <td><p align="right" /><b><%if (u.getId() == null) out.print("<font size='3'>");%>Deliery Address <%if (u.getId() == null) out.print("</font>");%></b></td>
                                    <td><p /><input type="text" name="address" size="15" value="<%=address%>"></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><p align="center" /><input type="submit" value="<%=submitT%>" class="<%if (u.getId() == null) out.print("submit_btn");%>" /></td>
                                </tr>
                            </table>
                        </form>
                    </center>
                </div> 
                <div class="cleaner"></div>
            </div> <!-- END of templatemo_main -->

            <div id="templatemo_footer">
                <p>
                     <a href="index.jsp">Home</a> | <a href="products.jsp">Products</a> |  <a href="checkout.jsp">Checkout</a>
                </p>

                 Copyright © 2015 <a href="index.jsp">Stationery Station</a>
            </div> <!-- END of templatemo_footer -->

        </div> <!-- END of templatemo_wrapper Text -->

    </body>
</html>