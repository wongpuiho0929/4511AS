<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Station Shop - Shopping Cart</title>
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

    </head>

    <body>
        <jsp:useBean class="ict.bean.UserInfo" id="userName" scope="session"/>
        <div id="templatemo_wrapper">
            <div id="templatemo_header">

                <div id="site_title">
                    <h1><a href="#">Station Shop</a></h1>
                </div>

              <div id="header_right">
                    <a href="#">My Account</a> | <a href="#">My Cart</a> | <a href="#">My Recard</a> | <a href="#">Checkout</a> |

                    <%
                        if( userName.getUsername() ==null) {
                           out.print("<a href='login.jsp'>Log In</a>");
                        }else{
                            out.print("<font size=5>"+userName.getUsername() +",</font>" +" <a href='login?action=logout'> Logout</a>");
                        }
                    %>
                </div>

                <div class="cleaner"></div>
            </div> <!-- END of templatemo_header -->

            <div id="templatemo_menu">
                <div id="top_nav" class="ddsmoothmenu">
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="products.jsp">Products</a>
                            <ul>
                                <li><a href="#submenu1">Sub menu 1</a></li>
                                <li><a href="#submenu2">Sub menu 2</a></li>
                                <li><a href="#submenu3">Sub menu 3</a></li>
                            </ul>
                        </li>
                        <li><a href="about.jsp">About</a>
                            <ul>
                                <li><a href="#submenu1">Sub menu 1</a></li>
                                <li><a href="#submenu2">Sub menu 2</a></li>
                                <li><a href="#submenu3">Sub menu 3</a></li>
                                <li><a href="#submenu4">Sub menu 4</a></li>
                                <li><a href="#submenu5">Sub menu 5</a></li>
                            </ul>
                        </li>
                        <li><a href="checkout.jsp">Checkout</a></li>
                        <li><a href="contact.jsp">Contact</a></li>
                    </ul>
                    <br style="clear: left" />
                </div> <!-- end of ddsmoothmenu -->
                <div id="menu_second_bar">
                    <div id="top_shopping_cart">
                        Shopping Cart: <strong>3 Products</strong> ( <a href="#">Show Cart</a> )
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
                    <h1>Shopping Cart</h1>
                    <table width="680px" cellspacing="0" cellpadding="5">
                        <tr bgcolor="#ddd">
                            <th width="220" align="left">Image </th> 
                            <th width="180" align="left">Description </th> 
                            <th width="100" align="center">Quantity </th> 
                            <th width="60" align="right">Price </th> 
                            <th width="60" align="right">Total </th> 
                            <th width="90"> </th>
                        </tr>
                        <tr>
                            <td><img src="images/product/01.jpg" alt="Image 01" /></td> 
                            <td>Etiam in tellus</td> 
                            <td align="center"><input type="text" value="1" style="width: 20px; text-align: right" /> </td>
                            <td align="right">$100 </td> 
                            <td align="right">$100 </td>
                            <td align="center"> <a href="#">Remove</a> </td>
                        </tr>
                        <tr>
                            <td><img src="images/product/02.jpg" alt="Image 02" /> </td>
                            <td>Hendrerit justo</td> 
                            <td align="center"><input type="text" value="1" style="width: 20px; text-align: right" />  </td>
                            <td align="right">$40  </td>
                            <td align="right">$40 </td>
                            <td align="center"> <a href="#">Remove</a>  </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="right"  height="30px">Have you modified your basket? Please click here to <a href="shoppingcart.jsp"><strong>Update</strong></a>&nbsp;&nbsp; <br /> Validate <a href="http://validator.w3.org/check?uri=referer" rel="nofollow"><strong>XHTML</strong></a> &amp; <a href="http://jigsaw.w3.org/css-validator/check/referer" rel="nofollow"><strong>CSS</strong></a>&nbsp;&nbsp; </td>
                            <td align="right" style="background:#ddd; font-weight:bold"> Total </td>
                            <td align="right" style="background:#ddd; font-weight:bold">$140 </td>
                            <td style="background:#ddd; font-weight:bold"> </td>
                        </tr>
                    </table>
                    <div style="float:right; width: 215px; margin-top: 20px;">

                        <p><a href="checkout.jsp">Proceed to checkout</a></p>
                        <p><a href="javascript:history.back()">Continue shopping</a></p>

                    </div>

                </div> 
                <div class="cleaner"></div>
            </div> <!-- END of templatemo_main -->

            <div id="templatemo_footer">
                <p>
                    <a href="index.jsp">Home</a> | <a href="products.jsp">Products</a> | <a href="about.jsp">About</a> | <a href="faqs.jsp">FAQs</a> | <a href="checkout.jsp">Checkout</a> | <a href="contact.jsp">Contact</a>
                </p>

                Copyright © 2048 <a href="#">Your Company Name</a>
            </div> <!-- END of templatemo_footer -->

        </div> <!-- END of templatemo_wrapper -->

    </body>
</html>