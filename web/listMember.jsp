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
                        <h3>Manage</h3>   
                        <div class="content"> 
                            <ul class="sidebar_list">
                                <li class="last"><a href="editMember.jsp">Add Account</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div id="content" class="float_r">
                    <center>
                        <h2>Member account list</h2>
                        <div style="text-align: right">
                            <form action="#" method="get">
                                Search member : 
                                <input type="text" name="keyword" />
                                <input type="submit" name="Search" value=" Search " />
                            </form>
                        </div>
                        <br />
                        <table border="1">
                            <tr>
                                <th>ID</th><th>Name</th><th>Tel no.</th><th>Address</th><th>User Name</th><th>Balance</th><th>Bonus Point</th><th>position</th><th>Is freezed</th><th>Action</th>
                                    <%
                                        UserInfo upw = new UserInfo();
                                        String password = (String) request.getAttribute("password");
                                        String id = (String) request.getAttribute("id");
                                        ArrayList<UserInfo> users
                                                = (ArrayList<UserInfo>) request.getAttribute("users");
                                        for (int i = 0; i < users.size(); i++) {
                                            UserInfo u = users.get(i);
                                            out.println("<tr>");
                                            out.println("<td>" + u.getId() + "</td>");
                                            out.println("<td>" + u.getName() + "</td>");
                                            out.println("<td>" + u.getTel() + "</td>");
                                            out.println("<td>" + u.getAddress() + "</td>");
                                            out.println("<td>" + u.getUsername() + "</td>");
                                            out.println("<td>" + u.getBalance()+ "</td>");
                                            out.println("<td>" + u.getBonus()+ "</td>");
                                            out.println("<td>" + u.getPosition() + "</td>");
                                            out.println("<td>" + u.getIsfreeze() + "</td>");
                                            if ("Y".equals(u.getIsfreeze())) {
                                                out.println("<td><a href=\"handleUser?action=unfreeze&id=" + u.getId() + "\">unfreeze </a>");
                                            } else {
                                                out.println("<td><a href=\"handleUser?action=freeze&id=" + u.getId() + "\">freeze </a>");
                                            }
                                            out.println("<a href=\"handleUser?action=getEditUser&id=" + u.getId() + "\">edit </a>");
                                            out.println("<a href=\"handleUser?action=getNewPassword&id=" + u.getId() + "\">getNewPassword </a>");
                                            if (password != null && id.equals(u.getId())) {
                                                out.println("NewPassword = " + password);
                                            }
                                            out.println("</td></tr>");

                                        }
                                    %>
                            </tr>
                        </table>
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