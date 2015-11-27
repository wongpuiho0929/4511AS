<%-- 
    Document   : checkBonus
    Created on : 2015年11月25日, 下午07:17:41
    Author     : pet10_000
--%>

<%@page import="ict.bean.GiftBean"%>
<%@page import="ict.bean.OrderBean"%>
<%@page import="ict.bean.UserGiftBean"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check Bonus Point</title>
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
        <% String s = userName.getId();
            pageContext.setAttribute("uid", s, PageContext.APPLICATION_SCOPE);
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
                        <li><a href="checkout.jsp">Checkout</a></li>
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
                        <h3>Manage</h3>   
                        <div class="content"> 
                            <ul class="sidebar_list">
                                <li class="first"><a href="handleUser?action=getEditAccount">Edit personal Information</a></li>
                                <li class=""><a href="changeClientPassword.jsp">Change Password</a></li>
                                <li class="last"><a href="bonusPoint.jsp">Check Bonus Point</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div id="content" class="float_r">
                    <center><h1>Bonus Point</h1></center>
                    <p align="right">bonus point:<%=userName.getBonus()%></p>
                    <p align="right"><a href="gift?action=list">list gift</a></p>
                    <a href="listBonusCotroller?action=list">show bonus history</a>
                    <center>
                        <%    ArrayList<UserGiftBean> ugb = (ArrayList<UserGiftBean>) request.getAttribute("ugb");
                            ArrayList<OrderBean> ob = (ArrayList<OrderBean>) request.getAttribute("ob");
                            ArrayList<GiftBean> gb = (ArrayList<GiftBean>) request.getAttribute("gb");
                            if (ob != null) {
                                out.println("<table border='0' width='90%'");
                                out.println("<tr>");
                                out.println("<th align='left'>Order ID</th><th>Pick up date</th><th>Total Price</th><th>State</th><th>Bonus Point</th >");
                                out.println("</tr>");
                                for (int i = 0; i < ob.size(); i++) {
                                    OrderBean o = ob.get(i);
                                    out.println("<tr align='center'>");
                                    out.println("<td align='left'>" + o.getoId() + "</td>");
                                    out.println("<td>" + o.getPickUpDate() + "</td>");
                                    out.println("<td>" + o.gettPrice() + "</td>");
                                    out.println("<td>" + o.getStatus() + "</td>");
                                    out.println("<td>+" + o.getBonus() + "</td>");
                                    out.println("</tr>");
                                    if (o.getStatus().equalsIgnoreCase("cancel")) {
                                        out.println("<tr align='center'>><td></td><td></td><td></td><td></td><td>-" + o.getBonus() + "</td></tr>");
                                    }
                                }
                                out.println("</table>");
                            }
                            if (ugb != null) {
                                out.println("<table border='0' width='90%'");
                                out.println("<tr>");
                                out.println("<th align='left'>Gift ID</th> <th>Name</th><th>Descriptions</th ><th>Bonus Point</th >");
                                out.println("</tr>");
                                for (int i = 0; i < ugb.size(); i++) {
                                    UserGiftBean ug = ugb.get(i);
                                    for (int j = 0; j < gb.size(); j++) {
                                        GiftBean g = gb.get(j);
                                        if (ug.getGiftId().equalsIgnoreCase(g.getGiftId())) {
                                            out.println("<tr align='center'>");
                                            out.println("<td align='left'>" + ug.getGiftId() + "</td>");
                                            out.println("<td>" + g.getGiftName() + "</td>");
                                            out.println("<td>" + g.getDescriptions() + "</td>");
                                            out.println("<td>-" + ug.getBonusPoint() + "</td>");
                                            out.println("</tr>");
                                        }
                                    }
                                }
                                out.println("</table>");
                            }
                        %>
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
