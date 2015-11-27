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
        <jsp:useBean class="java.util.ArrayList" id="productList" scope="session"/>
        <jsp:useBean class="ict.bean.ProductBean" id="productDetail" scope="session"/>
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
                                <li class="first"><a href="product?action=searchC&category=File & Filing Accessories">File & Filing Accessories</a></li>
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


                                    <td height="30">Product ID:</td>
                                    <td><%=productDetail.getPid()%></td>
                                </tr>
                                <tr>
                                    <td height="30">Brand:</td>
                                    <td class="product_price"><%=productDetail.getBrand()%></td>
                                </tr>
                                <tr><td height="30">Quantity</td>
                                    <%
                                        if (productDetail.getQty() > 0) {
                                            out.print("<td class='product_availabilityT'>"+productDetail.getQty()+"</td></tr>");
                                        } else {
                                           out.print("<td class='product_availabilityF'>"+productDetail.getQty()+"</td></tr>");
                                        }
                                    %>
                                    
                            </table>
                            <div class="cleaner h20"></div>
                            <%out.print("<center><a href='cart?action=add&pid=" + productDetail.getPid() + "'class='add_to_card'>Add to Cart</a></center>");%>
                        </div>
                        <div class="cleaner h30"></div>

                        <h5>Product Description</h5>
                        <p><%=productDetail.getDescription()%></p>	

                        <div class="cleaner h50"></div>

                        <h4>Other</h4>
                        <%
                            long[] temp = new long[3];
                            boolean chk = true;
                            while (chk) {
                                for (int i = 0; i < 3; i++) {
                                    temp[i] = (long) Math.floor(Math.random() * productList.size());
                                    if (i == 2) {
                                        if ((temp[0] != temp[1]) && (temp[0] != temp[2]) && (temp[1] != temp[2])) {
                                            chk = false;
                                        }
                                    }
                                }
                            }

                            for (int i = 2; i >= 0; i--) {
                                if (i != 0) {
                                    out.print("<div class='product_box'>");
                                } else {
                                    out.print("<div class='product_box no_margin_right'>");
                                }
                                out.print("<a href='product?action=detail&pid=" + ((ProductBean) productList.get((int) temp[i])).getPid() + "'>" + "<img src='" + ((ProductBean) productList.get((int) temp[i])).getPhoto() + "' height='150' width='200'></a><br>");
                                out.print(((ProductBean) productList.get((int) temp[i])).getName());
                                out.print("<p class='product_price'>$" + ((ProductBean) productList.get((int) temp[i])).getPrice() + "</p>");
                                out.print("<a href='cart?action=add&pid=" + ((ProductBean) productList.get((int) temp[i])).getPid() + "' class='add_to_card'>Add to Cart</a>");
                                out.print("<a href='product?action=detail&pid=" + ((ProductBean) productList.get((int) temp[i])).getPid() + "' class='detail'>Detail</a>");
                                out.print("</div>");
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