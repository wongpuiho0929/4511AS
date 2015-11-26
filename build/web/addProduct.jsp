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

        <script type="text/javascript">
            function validateForm() {
                var x = document.forms["addList"]["pName"].value;
                if (x == null || x == "") {
                    alert("Name must be filled out");
                    return false;
                }
            }
        </script>

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
                        <li><a href="products.jsp">Products</a></li>
                        <li><a href="Search.jsp" class="selected">Search</a></li>
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
                    <h1>add Products:</h1>
                    <form method="get" action="product" name='addList' onsubmit="return validateForm()">
                        <input type="hidden" name="action" value="add">
                            <table cellpadding="15">
                                <tr><td><font size="5" color="black">Product ID</font><td><font size="5" color="black">:</font>             <input type="text" name="pId"/></td>
                                        <tr><td><font size="5" color="black">Product Name</font></td><td><font size="5" color="black">:</font>       <input type="text" name="pName"/></td></tr>
                                        <tr><td><font size="5" color="black">Price</font></td><td><font size="5" color="black">:</font>             <input type="number" name="price" value=0 min='0' max='1000' step='0.1' style="width: 50px;"/></td></tr>
                                        <tr><td><font size="5" color="black">QTY</font></td><td><font size="5" color="black">:</font>               <input type="number" name="qty" value="0" min='0' max='50' step='1' style="width: 50px"/></td></tr>
                                        <tr><td><font size="5" color="black">Brank Name </font></td><td><font size="5" color="black">:</font>        <input type="text" name="bName" /></td></tr>
                                        <tr><td><font size="5" color="black">Product Description</font></td><td><font size="5" color="black">:</font> <input type="textarea" name="description"/></td></tr>
                                        <tr><td><font size="5" color="black">Category</font></td><td><font size="5" color="black">:</font>           
                                                <select name="category">
                                                    <option value ="stationery">Stationery</option>
                                                    <option value ="officeEquipment">Office Equipment</option>
                                                    <option value="electrical">Electrical</option>
                                                    <option value="newspaper">Newspaper</option>
                                                    <option value="magazine">Magazine</option>
                                                    <option value="filingAccessories">File & Filing Accessories</option>
                                                </select></td></tr>
                                        <tr><td><font size="5" color="black">Product photo</font></td><td><font size="5" color="black">:</font>       <input type="file" name="photo"/></td></tr>
                                        <tr><td colspan="2"><center><input type="submit" value="Search" class="submit_btn"/></center></td></tr>
                                        </table>
                                        </form>
                                        </div> 
                                        <div class="cleaner"></div>
                                        </div> <!-- END of templatemo_main -->

                                        <div id="templatemo_footer">
                                            <p>
                                                <a href="index.jsp">Home</a> | <a href="products.jsp">Products</a> | <a href="about.jsp">About</a> | <a href="faqs.jsp">FAQs</a> | <a href="checkout.jsp">Checkout</a> | <a href="contact.jsp">Contact</a>
                                            </p>

                                            Copyright © 2015 <a href="index.jsp">Stationery Station</a>
                                        </div> <!-- END of templatemo_footer -->

                                        </div> <!-- END of templatemo_wrapper -->

                                        </body>
                                        </html>