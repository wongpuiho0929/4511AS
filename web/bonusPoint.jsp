<%-- 
    Document   : checkBonus
    Created on : 2015年11月25日, 下午07:17:41
    Author     : pet10_000
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check Bonus Point</title>
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
                    <center><h1>Bonus Point</h1></center>
                    <p align="right">bonus point:<%=userName.getBonus()%></p>
                    <p align="right"><a href="gift?action=list">list gift</a></p>
                    <a href="listBonusCotroller?action=list">show bonus history</a>
                    <%
                        
                        
                    %>                 
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
