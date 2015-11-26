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
                                <li class="first"><a href="handleUser?action=getEditAccount">Edit personal Information</a></li>
                                <li class=""><a href="changeClientPassword.jsp">Change Password</a></li>
                                <li class="last"><a href="bonusPoint.jsp">Check Bonus Point</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div id="content" class="float_r">
                    <form method="get" action="gift">
                        <input type="hidden" name="action" value="search">
                            <table>
                                <tr><td>Bonus Point</td><td><input type="text" name="bonus"/></td><td colspan="2"><input type="submit" name="search" value="Search" class="submit_btn"/></td><td colspan="2"><input type="submit" name="search" value="All" class="submit_btn"/></td></tr>
                                <tr><td>Option</td><td><input type="radio" name="option" value="less"/>less</td></tr>
                                <tr><td></td><td><input type="radio" name="option" value="equal"/>equal</td></tr>
                                <tr><td></td><td><input type="radio" name="option" value="greater"/>greater</td></tr>
                            </table>
                    </form>
                    <form action="gift" method="POST" >
                        <input type="hidden" name="action" value="add" />
                        <input type="hidden" name="bonus" value="<%=userName.getBonus()%>"/>
                        <center><h1>Gift List</h1>
                            <p align="right">bonus point:<%=userName.getBonus()%></p>                            
                            <%
                                ArrayList<GiftBean> gifts
                                        = (ArrayList<GiftBean>) request.getAttribute("gb");
                                out.println("<table border='0' width='90%'");
                                out.println("<tr>");
                                out.println("<th align='left'>Name</th> <th> Bonus Point</th><th>Qty</th><th>Description</th ><th></th >");
                                out.println("</tr>");
                                for (int i = 0; i < gifts.size(); i++) {
                                    GiftBean gb = gifts.get(i);
                                    out.println("<tr align='center'>");
                                    out.println("<td align='left'>" + gb.getGiftName() + "</td>");
                                    out.println("<td>" + gb.getBonusPoint() + "</td>");
                                    out.println("<td>" + gb.getQty() + "</td>");
                                    out.println("<td>" + gb.getDescriptions() + "</td>");
                                    out.println("<td><input type=\"radio\" name=\"gid\" value=\"" + gb.getGiftId() + "\"/></td>");
                                    out.println("</tr>");
                                }
                                out.println("<tr></tr>");
                                out.println("<tr><td colspan=\"5\" align=\"right\"><input type=\"submit\" value=\"select\"/></td></tr>");
                                out.println("</table>");
                            %>
                        </center>
                        
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


        </div> <!-- END of templatemo_wrapper Text -->

    </body>
</html>
