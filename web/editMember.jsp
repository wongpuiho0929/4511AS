<%@page import="ict.bean.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ict.bean.UserInfo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Stationery Station</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />

        <link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/ddsmoothmenu.js"></script>
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
        <jsp:useBean class="java.util.ArrayList" id="groupBy" scope='session'/>
        <% String s = userName.getId();
            pageContext.setAttribute("uid", s, PageContext.APPLICATION_SCOPE);
            String position = userName.getPosition();
            try {
                if (!position.equals("Manager")) {
                    out.print("<script type='text/javascript'>");
                    out.print("location.href='index.jsp'");
                    out.print("</script>");
                }
            } catch (Exception e) {
                out.print("<script type='text/javascript'>");
                out.print("location.href='index.jsp'");
                out.print("</script>");
            }
        %>

        <div id="templatemo_wrapper">
            <div id="templatemo_header">

                <div id="site_title">
                    <h1><a href="index.jsp">Station Shop</a></h1>
                </div>

                <div id="header_right">
                    <a href="handleUser?action=showClientDateil">My Account</a> | <a href="shoppingcart.jsp">My Cart</a> | <a href="handleOrder?action=record">My Recard</a> | <a href="checkout.jsp">Checkout</a> |

                    <%
                        if (userName.getUsername() == null) {
                            out.print("<a href='login.jsp'>Log In</a> | ");
                            out.print("<a href='editClientAccout.jsp'>Register</a>");
                        } else {
                            if (userName.getPosition().equals("Manager")) {

                                out.print("<a href='addProduct.jsp'>Add Product</a> | ");
                                out.print("<a href='handleOrder?action=list'>Handle Orders</a> | ");
                                out.print("<a href='handleUser?action=list'>Handle Accounts</a> | ");
                            }
                            out.print("<font size=5>" + userName.getName() + ",</font>" + " <a href='login?action=logout'> Logout</a>");
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

            <div id="templatemo_main">
                <div id="sidebar" class="float_l">
                    <div class="sidebar_box"><span class="bottom"></span>
                        <h3>Categories</h3>   
                        <div class="content"> 
                            <ul class="sidebar_list">
                                <li class="first"><a href="product?action=searchC&category=filingAccessories">File and Filing Accessories</a></li>
                                <li><a href="product?action=searchC&category=Office Equipment">Office Equipment</a></li>
                                <li><a href="product?action=searchC&category=Electrical">Electrical</a></li>
                                <li><a href="product?action=searchC&category=Newspaper">Newspaper</a></li>
                                <li><a href="product?action=searchC&category=Magazine">Magazine</a></li>
                                <li class="last"><a href="product?action=searchC&category=Stationery">Stationery</a></li>
                            </ul>
                        </div>
                        <br>
                            <h3>Brand</h3>
                            <div class="content"> 
                                <ul class="sidebar_list">
                                    <%
                                        for (int i = 0; i < groupBy.size(); i++) {
                                            if (i == 0) {
                                                out.print("<li class='first'><a href=product?action=searchB&bName=" + ((ProductBean) (groupBy.get(i))).getBrand() + ">" + ((ProductBean) (groupBy.get(i))).getBrand() + "</a></li>");
                                            } else if (i == groupBy.size() - 1) {
                                                out.print("<li class='last'><a href=product?action=searchB&bName=" + ((ProductBean) (groupBy.get(i))).getBrand() + ">" + ((ProductBean) (groupBy.get(i))).getBrand() + "</a></li>");
                                            } else {
                                                out.print("<li><a href=product?action=searchB&bName=" + ((ProductBean) (groupBy.get(i))).getBrand() + ">" + ((ProductBean) (groupBy.get(i))).getBrand() + "</a></li>");
                                            }
                                        }

                                    %>
                                </ul>
                            </div>
                    </div>
                </div>
                <div id="content" class="float_r">
                    <jsp:useBean id="u" scope="request" class="ict.bean.UserInfo" />
                    <%                        String state = u.getId() != null ? "Edit User" : "Add User";
                        String type = u.getId() != null ? "edit" : "add";
                        String name = u.getId() != null ? u.getName() : "";
                        String tel = u.getId() != null ? u.getTel() : "";
                        String address = u.getId() != null ? u.getAddress() : "";
                        String position = u.getId() != null ? u.getPosition() : "";
                    %>
                    <h1><%=state%></h1>
                    <form method="POST" action="editUserController">
                        <input type="hidden" name="action" value="<%=type%>"/>
                        <table border="0">
                            <tr>
                                <td><p align="right" /><b>name </b></td>
                                <td><p /><input type="text" name="name" maxlength="10" size="15" value="<%=name%>"></td>
                            </tr>
                            <tr>
                                <td><p align="right" /><b>tel </b></td>
                                <td><p /><input type="text" name="tel" maxlength="10" size="15" value="<%=tel%>"></td>
                            </tr>
                            <tr>
                                <td><p align="right" /><b>address </b></td>
                                <td><p /><input type="text" name="address" maxlength="10" size="15" value="<%=address%>"></td>
                            </tr>
                            <tr>
                                <td><p align="right" /><b>position <%="client".equals(position)%></b></td>
                                <td><p /><input type="radio" name="position" maxlength="10" size="15" value="Manager" <%if ("Manager".equals(position)) {
                                        out.print("checked");
                                    }%> /> manager
                                           <input type="radio" name="position" maxlength="10" size="15" value="Client" <%if ("Client".equals(position)) {
                                                   out.print("checked");
                                               }%> /> client</td>
                            </tr>
                            <tr>
                                <td colspan="2"><p align="center" /><input type="submit" value="submit"</td>
                            </tr>
                        </table>
                    </form>
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