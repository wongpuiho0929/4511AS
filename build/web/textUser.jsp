<%-- 
    Document   : text
    Created on : 2015年11月23日, 下午10:26:15
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="handleUser" method="POST">
            <input type="hidden" name="action" value="list" />
            <input type="submit" value="see user account" />
        </form>
        <form action="handleUser" method="POST">
            <input type="hidden" name="action" value="showClientDateil" />
            <input type="submit" value="Client Datail" />
        </form>
    </body>
</html>
