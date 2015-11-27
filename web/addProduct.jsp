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
            });

        </script>

        <script type="text/javascript">
            function validateForm() {
                var x = document.forms["addList"]["pName"].value;
                var price = document.forms["addList"]["price"].value;
                var bName = document.forms["addList"]["bName"].value;
                if (x == null || x == "") {
                    alert("Product Name must be filled out");
                    return false;
                }
                if (price == 0) {
                    document.forms["addList"]["price"].value = 0;
                    alert("Your do not set the price");
                    return false;
                }
                  if (bName == null || bName == "") {
                    alert("Brand Name must be filled out");
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
                    <h1>add Products:</h1>
                    <form method="POST" action="product" name='addList' onsubmit="return validateForm()" enctype="multipart/form-data" >
                        <input type="hidden" name="action" value="add">
                            <table cellpadding="15">
                                <tr></tr>
                                <tr><td><font size="5" color="black">Product Name</font></td><td><font size="5" color="black">:</font>       
                                        <input type="text" name="pName"/></td></tr>
                                <tr><td><font size="5" color="black">Price</font></td><td><font size="5" color="black">:</font>             
                                        <input type="number" name="price" value=0 min='0' max='1000' step='0.1' style="width: 50px;"/></td></tr>
                                <tr><td><font size="5" color="black">QTY</font></td><td><font size="5" color="black">:</font>               
                                        <input type="number" name="qty" value="0" min='0' max='50' step='1' style="width: 50px"/></td></tr>
                                <tr><td><font size="5" color="black">Brank Name </font></td><td><font size="5" color="black">:</font>        
                                        <input type="text" name="bName" /></td></tr>
                                <tr><td><font size="5" color="black">Product Description</font></td><td><font size="5" color="black">:</font> 
                                        <input type="textarea" name="description"/></td></tr>
                                <tr><td><font size="5" color="black">Category</font></td><td><font size="5" color="black">:</font>           
                                        <select name="category">
                                            <option value ="stationery">Stationery</option>
                                            <option value ="officeEquipment">Office Equipment</option>
                                            <option value="electrical">Electrical</option>
                                            <option value="newspaper">Newspaper</option>
                                            <option value="magazine">Magazine</option>
                                            <option value="filingAccessories">File and Filing Accessories</option>
                                        </select></td></tr>
                                <tr><td><font size="5" color="black">Product photo</font></td><td><font size="5" color="black">:</font>       
                                        <input type="file" name="photo"/></td></tr>
                                <tr><td colspan="2"><center><input type="submit" value="Add" class="submit_btn"/></center></td></tr>

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