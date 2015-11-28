<%@page import="java.util.Calendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="ict.bean.ShoppingCartBean"%>
<%@page import="ict.bean.ProductBean"%>
<%@page import="ict.db.ProductDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Stationery Station - Checkout Page</title>
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

            function show() {
                document.getElementById("datetime").style.visibility = "visible";
            }

            function hide() {
                document.getElementById("datetime").style.visibility = "hidden";
            }

        </script>

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
                        <li><a href="index.jsp" >Home</a></li>
                        <li><a href="products.jsp">Products</a></li>
                        <li><a href="Search.jsp" >Search</a></li>
                        <li><a href="checkout.jsp" class="selected">Checkout</a></li>
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
                    <form action="handleOrder" method="POST">
                        <input type="hidden" name="action" value="add"/>
                        <h2>Checkout</h2>
                        <h5><strong>BILLING DETAILS</strong></h5>
                        <div class="content_half float_l checkout">
                            User ID:
                            <input type="text"  style="width:300px;"  value="<%=userName.getId()%>" readonly/>
                            Name:                				
                            <input type="text"  style="width:300px;"  value="<%=userName.getName()%>" readonly/>
                            Address:
                            <input type="text"  style="width:300px;"  value="<%=userName.getAddress()%>" readonly/>
                            Position
                            <input type="text"  style="width:300px;"  value="<%=userName.getPosition()%>" readonly/>                      
                        </div>

                        <div class="content_half float_r checkout">
                            Email:
                            <input type="text"  style="width:300px;"  value="<%=userName.getAddress()%>" readonly/>
                            Phone:<br />
                            <span style="font-size:10px">Please, specify your reachable phone number. YOU MAY BE GIVEN A CALL TO VERIFY AND COMPLETE THE ORDER.</span>
                            <input type="text"  style="width:300px;"  value="<%=userName.getTel()%>" readonly/>
                            DateTime:<br />
                            <span style="font-size:10px">yyyy-MM-dd</span>
                            <input type="text" id="datetime" name="datetime" style="width:300px; visibility: hidden"  value="2015-11-30"/>
                        </div>

                        <div class="cleaner h50"></div>
                        <h3>Shopping Cart</h3>
                        <%
                            String url = "jdbc:mysql://localhost:3306/ITP4511_ASDB";
                            String username = "root";
                            String password = "tommy985";
                            double tprice = 0.0;
                            ProductDB p = new ProductDB(url, username, password);
                            for (int i = 0; i < shoppingCart.size(); i++) {
                                ProductBean bean = p.productdetail(((ShoppingCartBean) (shoppingCart.get(i))).getPid());
                                int qty = ((ShoppingCartBean) (shoppingCart.get(i))).getQty();
                                tprice += bean.getPrice() * qty;
                            }
                        %>
                        <h4>TOTAL: <strong><%=tprice%></strong></h4>
                        <p><input type="radio" name="select" value="delivery" onclick="hide()" checked/><font size='3'>delivery  </font> 
                            <input type="radio" name="select" value="self" onclick="show()"/><font size='3'>self pick-up </font>                          
                            <p align="right"><input type="submit" value="Create Order"/></p>
                            <input type="hidden" name="total" value="<%=tprice%>"/>
                    </form>
                    </p>
                    <table style="border:1px solid #CCCCCC;" width="100%">
                        <%--<tr>
                            <td height="80px"> <img src="images/paypal.gif" alt="paypal" /></td>
                            <td width="400px;" style="padding: 0px 20px;">Recommended if you have a PayPal account. Fastest delivery time.
                            </td>
                            <td><a href="#" class="more">PAYPAL</a></td>
                        </tr>
                        <tr>
                            <td  height="80px"><img src="images/2co.gif" alt="paypal" />
                            </td>
                            <td  width="400px;" style="padding: 0px 20px;">2Checkout, Inc. is an authorized retailer of goods and services provided by Template-Guide.com
                                2CheckOut accepts customer orders via online checks, Visa, MasterCard, Discover, American Express, Diners, JCB and debit cards with the Visa, Mastercard logo. Sed laoreet ornare ligula eu blandit. Validate <a href="http://validator.w3.org/check?uri=referer" rel="nofollow"><strong>XHTML</strong></a> &amp; <a href="http://jigsaw.w3.org/css-validator/check/referer" rel="nofollow"><strong>CSS</strong></a>.
                            </td>
                            <td><a href="#" class="more">2CHECKOUT</a></td>
                        </tr>--%>
                        <%
                            for (int i = 0; i < shoppingCart.size(); i++) {
                                ProductBean bean = p.productdetail(((ShoppingCartBean) (shoppingCart.get(i))).getPid());
                                int qty = ((ShoppingCartBean) (shoppingCart.get(i))).getQty();
                                out.print("<tr>");
                                out.print("<td height='80px'>" + "<img src='" + bean.getPhoto() + "' height='150' width='200'></td>");
                                out.print("<td width='400px;' style='padding: 0px 20px;'>" + bean.getName() + "</td>");
                                out.print("<td width='400px;' style='padding: 0px 20px;'>" + qty + "</td>");
                                out.print("<td width='400px;' style='padding: 0px 20px;'>" + bean.getPrice() + "</td>");
                                out.print("<td width='400px;' style='padding: 0px 20px;'>" + bean.getPrice() * qty + "</td>");
                            }
                        %>
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

        </div> <!-- END of templatemo_wrapper -->

    </body>
</html>