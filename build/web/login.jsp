<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stationery Station - Login</title>
        <link href="css/templatemo_style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/ddsmoothmenu.js"></script>
        <link rel="stylesheet" type="text/css" media="all" href="css/jquery.dualSlider.0.2.css" />

        <script src="js/jquery-1.3.2.min.js" type="text/javascript"></script>
    </head>
    <body>
        <div id="templatemo_wrapper">
            <div id="templatemo_header">

                <div id="site_title">
                    <h1><a href="index.jsp">Station Shop</a></h1>
                </div >
                <div class="cleaner"></div>
            </div>
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
                <div id="menu_second_bar" style="height: auto">
                    <h1><font color="white">Login</font></h1>

                    <div class="cleaner"></div>
                </div>
            </div> <!-- END of templatemo_menu -->

            <div id="templatemo_middle" class="carousel">
                <br><br>
                <center>
                    <form method="post" action="login">
                        <input type="hidden" name="action" value="authenticate"/>
                        <table border ="0">
                            <tr><td><p align="right"><b><font size='5'>User Name:</font></b></td>
                                <td><p><input type="text" name="username" maxlength="10" size="15"></td>
                            </tr>
                            <tr>
                                <td><p align="right"><b><font size='5'>Password:</font></b></td>
                                <td><p><input type="password" name="password" maxlength="10" size="15"></td>
                            </tr>
                            <tr>
                                <td colspan="2"><p align="center"><input type="submit" value="Login" id="searchbutton" class="submit_btn"></p></td>
                            </tr>
                        </table>
                    </form>
                </center>
            </div>

            <div id="templatemo_footer">
                <p>
                    <a href="index.jsp">Home</a> | <a href="products.jsp">Products</a> |  <a href="checkout.jsp">Checkout</a>
                </p>

                Copyright © 2015 <a href="index.jsp">Stationery Station</a>
            </div> 
        </div>
    </body>
</html>
