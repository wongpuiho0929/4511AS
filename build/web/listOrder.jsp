<%-- 
    Document   : listOrder
    Created on : 2015年11月25日, 上午11:56:54
    Author     : pet10_000
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="ict.bean.OrderBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            ArrayList<OrderBean> orders
                    = (ArrayList<OrderBean>) request.getAttribute("orders");
            out.println("<h1>Customers</h1>");
            out.println("<table border='1' >");
            out.println("<tr>");
            out.println("<th>CustId</th> <th> name</th><th> tel</th><th> age</th >");
            out.println("</tr>");
            for (int i = 0; i < orders.size(); i++) {
                OrderBean c = orders.get(i);
                out.println("<tr>");
                out.println("<td>" + c.getoId()+ "</td>");
                out.println("<td>" + c.getuId()+ "</td>");
                out.println("<td>" + c.gettPrice() + "</td>");
                out.println("<td><a href=\"handleOrder?action=view&id="+ c.getoId()+"\"</a>view product</td>");
                out.println("<td><a href=\"handleOrder?action=update&id="+ c.getoId()+"\"</a>update state</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        %>
    </body>
</html>
