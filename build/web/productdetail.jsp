<%@page import="ict.bean.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ict.db.ProductDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Stationery Station - Product Detail</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />

        <link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />
        <script type="text/javascript" src="js/jquery.min.js"></script></script>
        <link rel="stylesheet" type="text/css" media="all" href="css/jquery.dualSlider.0.2.css" />

        <script src="js/jquery-1.3.2.min.js" type="text/javascript"></script>

    </head>

    <body>
        <jsp:useBean class="ict.bean.UserInfo" id="userName" scope="session"/>
        <jsp:useBean class="ict.bean.ProductBean" id="productDetail" scope="session"/>
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
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="products.jsp"  class="selected">Products</a></li>
                        <li><a href="Search.jsp" >Search</a></li>
                        <li><a href="checkout.jsp" >Checkout</a></li>
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
                                <li class="first"><a href="#">Aenean varius nulla</a></li>
                                <li><a href="#">Cras mattis arcu</a></li>
                                <li><a href="#">Donec turpis ipsum</a></li>
                                <li><a href="#">Fusce sodales mattis</a></li>
                                <li><a href="#">Maecenas et mauris</a></li>
                                <li><a href="#">Mauris nulla tortor</a></li>
                                <li><a href="#">Nulla odio ipsum</a></li>
                                <li><a href="#">Nunc ac viverra nibh</a></li>
                                <li><a href="#">Praesent id venenatis</a></li>
                                <li><a href="#">Quisque odio velit</a></li>
                                <li><a href="#">Suspendisse posuere</a></li>
                                <li><a href="#">Tempus lacus risus</a></li>
                                <li><a href="#">Ut tincidunt imperdiet</a></li>
                                <li><a href="#">Vestibulum eleifend</a></li>
                                <li class="last"><a href="#">Velit mi rutrum diam</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div id="content" class="float_r">                    
                    <h1><%=productDetail.getName()%></h1>
                    <div class="content_half float_l">
                        <a  rel="lightbox[portfolio]" href="<%=productDetail.getPhoto()%>"><img src="<%=productDetail.getPhoto()%>" alt="Image 01" height='300' width='350'/></a>
                    </div>
                    <div class="content_half float_r">
                        <form action="cart" method="POST">
                            <input type="hidden" name="action" value="addmore"/>
                            <input type="hidden" name="pid" value="<%=productDetail.getPid()%>"/>
                            <table>
                                <tr>
                                    <td height="30" width="160">Price:</td>
                                    <td><%=productDetail.getPrice()%></td>
                                </tr>
                                <tr>
                                    <td height="30">Availability:</td>
                                    <%
                                        if (productDetail.getQty() > 0) {
                                            out.print("<td>In Stock</td>");
                                        } else {
                                            out.print("<td>Sold</td>");
                                        }
                                    %>

                                </tr>
                                <tr>
                                    <td height="30">Model:</td>
                                    <td><%=productDetail.getPid()%></td>
                                </tr>
                                <tr>
                                    <td height="30">Manufacturer:</td>
                                    <td><%=productDetail.getBrand()%></td>
                                </tr>
                                <tr><td height="30">Quantity</td><td><input type="text" name="qty" value="1" style="width: 20px; text-align: right" /></td></tr>
                            </table>     

                            <div class="cleaner h20"></div>
                            <input type="submit" value="Add to Cart"/>
                        </form>
                    </div>
                    <div class="cleaner h30"></div>

                    <h5>Product Description</h5>
                    <p><%=productDetail.getDescription()%></p>	

                    <div class="cleaner h50"></div>

                    <h4>Etiam In Tellus</h4>
                    <%
                        String url = "jdbc:mysql://localhost:3306/ITP4511_ASDB";
                        String username = "root";
                        String password = "";
                        ProductDB pb = new ProductDB(url, username, password);
                        ArrayList<ProductBean> productList = pb.showProduct();
                        int count = 1;
                        for (int i = 0; i < 3; i++) {
                            if (count != 3) {
                                out.print("<div class='product_box'>");
                            } else {
                                out.print("<div class='product_box no_margin_right'>");
                                count = 0;
                            }
                            out.print("<a href='product?action=detail&pid=" + productList.get(i).getPid() + "'><img src='" + productList.get(i).getPhoto() + "' alt='Image " + i + "' height='150' width='200'/></a>");
                            out.print("<h3>" + productList.get(i).getName() + "</h3>");
                            out.print("<p class='product_price'>$ " + productList.get(i).getPrice() + "</p>");
                            out.print("<a href='cart?action=add&pid=" + productList.get(i).getPid() + "' class='add_to_card'>Add to Cart</a>");
                            out.print("<a href='product?action=detail&pid=" + productList.get(i).getPid() + "' class='detail'>Detail</a>");
                            out.print("</div>");
                            count++;
                        }
                    %>     

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
