<%@page import="java.util.ArrayList"%>
<%@page import="ict.bean.ProductBean"%>
<%@page import="ict.db.ProductDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Stationery Station - Search Page</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />

        <link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />

        <link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />
        <script type="text/javascript" src="js/jquery-latest.js"></script> 
        <script type="text/javascript" src="js/jquery.tablesorter.js"></script> 
        <script type="text/javascript">
            $(document).ready(function ()
            {
                $("#myTable").tablesorter({sortList: [[0, 0], [1, 0]]});
            }
            );
        </script>


        <link rel="stylesheet" type="text/css" media="all" href="css/jquery.dualSlider.0.2.css" />

       


    </head>

    <body>
        <jsp:useBean class="ict.bean.UserInfo" id="userName" scope="session"/>
        <jsp:useBean class="java.util.ArrayList" id='shoppingCart' scope='session'/>
        <jsp:useBean class="java.util.ArrayList" id="search" scope="request"/>
        <jsp:useBean class="java.util.ArrayList" id="chicked" scope="request"/>
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
                        <li><a href="products.jsp">Products</a></li>
                        <li><a href="Search.jsp" class="selected">Search</a></li>
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
                    <h1>Search Products:</h1>
                    <form method="get" action="product">
                        <input type="hidden" name="action" value="search">
                            <table>
                                <tr><td><font size="3" color="black">Product Name</font></td><td><font size="3" color="black">: </font><input type="text" name="pName"/></td><td><font size="3" color="black">Brank Name </font></td><td><font size="3" color="black">: </font><input type="text" name="bName" /></td></tr>
                                <tr><td><font size="3" color="black">Category</font></td><td><font size="3" color="black">: </font><select name="category">
                                            <option value ="">All</option>
                                            <option value ="stationery">Stationery</option>
                                            <option value ="Office Equipment">Office Equipment</option>
                                            <option value="electrical">Electrical</option>
                                            <option value="newspaper">Newspaper</option>
                                            <option value="magazine">Magazine</option>
                                            <option value="File and Filing Accessories">File and Filing Accessories</option>
                                        </select></td>
                                </tr>
                                <tr><td><font size="3" color="black">Price</font></td><td colspan="3"><font size="3" color="black">: from </font><input type="text" name="price1" value="0"/><font size="3" color="black"> to </font><font size="5" color="black"></font><input type="text" name="price2" value="999999" /></td></tr>
                                <tr><td><font size="3" color="black">Sort by</font></td><td><font size="3" color="black">: </font><select name="sortBy">
                                            <option value ="pName">Name</option>
                                            <option value ="brand">Brand</option>
                                            <option value="price">Price</option>
                                        </select><select name="sortType">
                                            <option value ="asc">Ascending</option>
                                            <option value ="desc">Descending</option>
                                        </select></td></tr>
                                <tr><td></td><td></td><td></td><td align="right"><input type="submit" value="Search" class="submit_btn"/></td></tr>
                            </table>
                    </form>
                    <table id="myTable" class="tablesorter">
                        <thead>
                            <%                        out.print("<hr/>");

                                try {
                                    if (chicked.get(0).toString().equals("true") && search.size() == 0) {
                                        out.print("<h1>Sorry, No record was found.</h1>");
                                    }
                                } catch (Exception ex) {

                                }

                                for (int i = 0; i < search.size(); i++) {
                                    if (i == 0) {
                                        out.print("<tr><th></th><th width=200><b><a href='#'>Name</a></b></th><th width=200><b><a href='#'>Brand</a></b></th><th width=200><b><a href='#'>Type</a></b></th><th width=200><b><a href='#'>Price</a></b></th></tr></thead><tbody>");
                                    }
                                    out.print("<tr><td width=200>");
                                    out.print("<img src='" + ((ProductBean) search.get(i)).getPhoto() + "' height= 150 width=180></td>");
                                    out.print("<td width=200>" + ((ProductBean) search.get(i)).getName() + "</td>");
                                    out.print("<td width=200>" + ((ProductBean) search.get(i)).getBrand() + "</td>");
                                    out.print("<td width=200>" + ((ProductBean) search.get(i)).getCategory() + "</td>");
                                    out.print("<td width=200>" + ((ProductBean) search.get(i)).getPrice() + "</td>");
                                    out.print("</tr>");
                                }
                                out.print("</tbody></table>");
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