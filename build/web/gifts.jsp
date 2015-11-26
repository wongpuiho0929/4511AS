<%-- 
    Document   : listGift
    Created on : 2015年11月25日, 下午08:03:00
    Author     : pet10_000
--%>

<%@page import="ict.bean.GiftBean"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Redeem Gift</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />

        <link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/ddsmoothmenu.js"></script>
        <script language="javascript" type="text/javascript">
            function clearText(field)
            {
                if (field.defaultValue == field.value)
                    field.value = '';
                else if (field.value == '')
                    field.value = field.defaultValue;
            }

        </script>
        <link rel="stylesheet" type="text/css" media="all" href="css/jquery.dualSlider.0.2.css" />

        <script src="js/jquery-1.3.2.min.js" type="text/javascript"></script>       
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
                        <li><a href="index.jsp" class="selected">Home</a></li>
                        <li><a href="products.jsp">Products</a></li>
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
                        Shopping Cart: <strong>X Products</strong> ( <a href="#">Show Cart</a> )
                    </div>
                    <div id="templatemo_search">
                        <form action="#" method="get">
                            <input type="text" value="Search" name="keyword" id="keyword" title="keyword" onfocus="clearText(this)" onblur="clearText(this)" class="txt_field" />
                            <input type="submit" name="Search" value=" Search " alt="Search" id="searchbutton" title="Search" class="sub_btn"  />
                        </form>
                    </div>
                    <div class="cleaner"></div>
                </div>
            </div> <!-- END of templatemo_menu -->

            <div id="templatemo_middle" class="carousel">
                <div class="panel">

                    <div class="details_wrapper">

                        <div class="details">

                            <div class="detail">
                                <h2><a href="#">Station Shop</a></h2>
                                <p>Station Shop is free website template by templatemo for ecommerce websites or online stores. Sed aliquam arcu. Donec urna massa, cursus et mattis at, mattis quis lectus. </p>
                                <a href="#" title="Read more" class="more">Read more</a>
                            </div><!-- /detail -->

                            <div class="detail">
                                <h2><a href="#">Fusce hendrerit</a></h2>
                                <p>Duis dignissim tincidunt turpis eget pellentesque. Nulla consectetur accumsan facilisis. Suspendisse et est lectus, at consectetur sem.</p>
                                <a href="#" title="Read more" class="more">Read more</a>
                            </div><!-- /detail -->

                            <div class="detail">
                                <h2><a href="#">Aenean massa cum</a></h2>
                                <p>Sed vel interdum sapien. Aliquam consequat, diam sit amet iaculis ultrices, diam erat faucibus dolor, quis auctor metus libero vel mi.</p>
                                <a href="#" title="Read more" class="more">Read more</a>
                            </div><!-- /detail -->

                        </div><!-- /details -->

                    </div><!-- /details_wrapper --><!-- /paging --></div><!-- /panel -->

                <div class="backgrounds">

                    <div class="item item_1">
                        <img src="images/slider/02.jpg" alt="Slider 01" />
                    </div><!-- /item -->

                    <div class="item item_2">
                        <img src="images/slider/03.jpg" alt="Slider 02" />
                    </div><!-- /item -->

                    <div class="item item_3">
                        <img src="images/slider/01.jpg" alt="Slider 03" />
                    </div><!-- /item -->

                </div><!-- /backgrounds -->
            </div> <!-- END of templatemo_middle -->

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
                    <form action="gift" method="POST" >
                        <input type="hidden" name="action" value="add" />
                        <input type="hidden" name="userId" value="<%=userName.getId()%>"/>
                        <center><h1>Gift List</h1>
                            <p align="right">bonus point:</p>
                            <%
                                ArrayList<GiftBean> gifts
                                        = (ArrayList<GiftBean>) request.getAttribute("gb");
                                out.println("<table border='1' >");
                                out.println("<tr>");
                                out.println("<th>Name</th> <th> Bonus Point</th><th>Qty</th><th>Description</th ><th></th >");
                                out.println("</tr>");
                                for (int i = 0; i < gifts.size(); i++) {
                                    GiftBean gb = gifts.get(i);
                                    out.println("<tr>");
                                    out.println("<td>" + gb.getGiftName() + "</td>");
                                    out.println("<td>" + gb.getBonusPoint() + "</td>");
                                    out.println("<td>" + gb.getQty() + "</td>");
                                    out.println("<td>" + gb.getDescriptions() + "</td>");
                                    out.println("<td><input type=\"checkbox\" name=\"id\" value=\"" + gb.getGiftId() + "\"/></td>");
                                    out.println("</tr>");
                                }
                                out.println("<tr><td colspan=\"5\" align=\"right\"><input type=\"submit\" value=\"select\"/></td></tr>");
                                out.println("</table>");
                            %>
                        </center>
                        <tr style=" "
                </form>
            </div> 
            <div class="cleaner"></div>
        </div> <!-- END of templatemo_main -->

        <div id="templatemo_footer">
            <p>
                <a href="index.jsp">Home</a> | <a href="products.jsp">Products</a> | <a href="about.jsp">About</a> | <a href="faqs.jsp">FAQs</a> | <a href="checkout.jsp">Checkout</a> | <a href="contact.jsp">Contact</a>
            </p>

            Copyright © 2048 <a href="#">Your Company Name</a>
        </div> <!-- END of templatemo_footer -->

    </div> <!-- END of templatemo_wrapper Text -->

</body>
</html>
