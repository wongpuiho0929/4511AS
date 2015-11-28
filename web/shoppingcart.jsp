<%@page import="ict.bean.ProductBean"%>
<%@page import="ict.db.ProductDB"%>
<%@page import="ict.bean.ShoppingCartBean"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Stationery Station - Shopping Cart</title>
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
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="products.jsp" class="selected">Products</a></li>
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
                <div id="content" class="float_r">
                    <h1>Shopping Cart</h1>
                    <table width="680px" cellspacing="0" cellpadding="5">
                        <tr bgcolor="#ddd">
                            <th width="220" align="left">Image </th> 
                            <th width="180" align="left">Name </th> 
                            <th width="100" align="center">Quantity </th> 
                            <th width="60" align="right">Price </th> 
                            <th width="60" align="right">Total </th> 
                            <th width="90"></th>

                        </tr>
                        <%
                            String url = "jdbc:mysql://localhost:3306/ITP4511_ASDB";
                            String username = "root";
                            String password = "tommy985";
                            double tprice = 0.0;
                            ProductDB p = new ProductDB(url, username, password);
                            for (int i = 0; i < shoppingCart.size(); i++) {
                                ProductBean bean = p.productdetail(((ShoppingCartBean)(shoppingCart.get(i))).getPid());
                                int qty = ((ShoppingCartBean)(shoppingCart.get(i))).getQty();
                                out.print("<tr>");
                                out.print("<td>" + "<img src='" + bean.getPhoto() + "' height='150' width='200'></td>");
                                out.print("<td>" + bean.getName() + "</td>");
                                out.print("<td align='center'>"+ qty +"</td>");
                                out.print("<td align='right'>" + bean.getPrice() + "</td>");
                                out.print("<td align='right'>" + bean.getPrice()*qty + "</td>");
                                out.print("<td align='center'> <a href='cart?action=remove&sid=" + ((ShoppingCartBean) (shoppingCart.get(i))).getSid() + "&qty=" + ((ShoppingCartBean) (shoppingCart.get(i))).getQty()+"&pid="+ ((ShoppingCartBean) (shoppingCart.get(i))).getPid()+ "'>Remove</a> </td>");
                                tprice += bean.getPrice()*qty;
                            }
                        %>
                        <tr>
                            <td colspan="3"></td>
                            <td align="right" style="background:#ddd; font-weight:bold"> Total </td>
                            <td align="right" style="background:#ddd; font-weight:bold"><%=tprice%> </td>
                            <td style="background:#ddd; font-weight:bold"> </td>
                        </tr>
                    </table>
                    <div style="float:right; width: 215px; margin-top: 20px;">
                        <p><a href="checkout.jsp">Proceed to checkout</a></p>
                        <p><a href="products.jsp">Continue shopping</a></p>

                    </div>

                </div> 
                <div class="cleaner"></div>
            </div> <!-- END of templatemo_main -->

            <div id="templatemo_footer">
                <p>
                   <a href="index.jsp">Home</a> | <a href="products.jsp">Products</a> |  <a href="checkout.jsp">Checkout</a>
                </p>

                Copyright © 2015 <a href="index.jsp">Stationery Station</a>
            </div> 

        </div> <!-- END of templatemo_wrapper -->

    </body>
</html>