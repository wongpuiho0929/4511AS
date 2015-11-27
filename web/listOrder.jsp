<%-- 
    Document   : listOrder
    Created on : 2015年11月25日, 上午11:56:54
    Author     : pet10_000
--%>

<%@page import="ict.bean.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ict.bean.OrderBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Handle Orders</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />

        <link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/ddsmoothmenu.js"></script>
        <link rel="stylesheet" type="text/css" media="all" href="css/jquery.dualSlider.0.2.css" />
        <script src="js/jquery-1.3.2.min.js" type="text/javascript"></script>
    </head>
    <body>
        <jsp:useBean class="ict.bean.UserInfo" id="userName" scope="session"/>
        <jsp:useBean class="java.util.ArrayList" id='shoppingCart' scope='session'/>
        <jsp:useBean class="java.util.ArrayList" id="groupBy" scope='session'/>
        <% String s = userName.getId();
            pageContext.setAttribute("uid", s, PageContext.APPLICATION_SCOPE);
        %>

        <div id="templatemo_wrapper">
            <div id="templatemo_header">

                <div id="site_title">
                    <h1><a href="index.jsp">Stationery Station</a></h1>
                </div>

                <div id="header_right">
                                      <a href="handleUser?action=showClientDateil">My Account</a> | <a href="shoppingcart.jsp">My Cart</a> | <a href="handleOrder?action=list">My Recard</a> | <a href="checkout.jsp">Checkout</a> |

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
                        <li><a href="Search.jsp">Search</a></li>
                        <li><a href="about.jsp">About</a>
                            <!--<ul>
                                <li><a href="#submenu1">Sub menu 1</a></li>
                                <li><a href="#submenu2">Sub menu 2</a></li>
                                <li><a href="#submenu3">Sub menu 3</a></li>
                                <li><a href="#submenu4">Sub menu 4</a></li>
                                <li><a href="#submenu5">Sub menu 5</a></li>
                            </ul>!-->
                        </li>
                        <li><a href="checkout.jsp">Checkout</a></li>
                        <li><a href="contact.jsp">Contact</a></li>
                    </ul>
                    <br style="clear: left" />
                </div> <!-- end of ddsmoothmenu -->
                <div id="menu_second_bar">
                    <div id="top_shopping_cart">
                        Shopping Cart: <strong><%=shoppingCart.size()%></strong> ( <a href="cart?action=show">Show Cart</a> )
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
                                <li class="first"><a href="product?action=searchC&category=File and Filing Accessories">File and Filing Accessories</a></li>
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
                                    for(int i=0;i<groupBy.size();i++){
                                        if(i==0){
                                            out.print("<li class='first'><a href=product?action=searchB&bName="+((ProductBean)(groupBy.get(i))).getBrand()+">"+((ProductBean)(groupBy.get(i))).getBrand()+"</a></li>");
                                        }else if(i==groupBy.size()-1){
                                            out.print("<li class='last'><a href=product?action=searchB&bName="+((ProductBean)(groupBy.get(i))).getBrand()+">"+((ProductBean)(groupBy.get(i))).getBrand()+"</a></li>");
                                        }else{
                                            out.print("<li><a href=product?action=searchB&bName="+((ProductBean)(groupBy.get(i))).getBrand()+">"+((ProductBean)(groupBy.get(i))).getBrand()+"</a></li>");
                                        }
                                    }
                                   
                                %>
                            </ul>
                        </div>
                    </div>
                </div>
<<<<<<< HEAD
                <div id="content" class="float_r">                   
                    <%
                        ArrayList<OrderBean> orders
                                = (ArrayList<OrderBean>) request.getAttribute("ob");
                        out.println("<h1>Order List</h1>");
                        out.println("<center><table border='0' width='90%'>");
                        out.println("<tr>");
                        out.println("<th>OrderId</th> <th>UserId</th><th>Total Price</th><th>State</th ><th>View/th ><th>Update</th >");
                        out.println("</tr>");

                        for (int i = 0; i < orders.size(); i++) {
                            OrderBean c = orders.get(i);
                            out.println("<tr>");
                            out.println("<td>" + c.getoId() + "</td>");
                            out.println("<td>" + c.getuId() + "</td>");
                            out.println("<td>" + c.gettPrice() + "</td>");
                            out.println("<td>" + c.getStatus() + "</td>");
                            out.println("<td><a href=\"handleOrder?action=view&id=" + c.getoId() + "\"</a>view product</td>");
                            out.println("<td><a href=\"handleOrder?action=update&id=" + c.getoId() + "\"</a>update state</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                        %>
                    </center>
                </div> 
                <div class="cleaner"></div>
            </div> <!-- END of templatemo_main -->

            <div id="templatemo_footer">
                <p>
                    <a href="index.jsp">Home</a> | <a href="products.jsp">Products</a> | <a href="about.jsp">About</a> | <a href="faqs.jsp">FAQs</a> | <a href="checkout.jsp">Checkout</a> | <a href="contact.jsp">Contact</a>
                </p>

                Copyright © 2015 <a href="index.jsp">Stationery Station</a>
            </div> <!-- END of templatemo_footer -->

        </div> <!-- END of templatemo_wrapper Text -->

    </body>
</html>
