<%-- 
    Document   : run
    Created on : 2015年11月26日, 下午11:12:01
    Author     : wongp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="js/jquery-1.4.4.js"></script>
        <script type="text/javascript">

            var millisecondsToWait = 2000;
            setTimeout(function () {
                $(document).ready(function () {
                    location.href = "product?action=groupBy";
                });
                window.onload = codeAddress;
            }, millisecondsToWait);

        </script>
    </head>
    <body>
        <div id="result">
            <h3>${requestScope["message"]}</h3>
        </div>
        <H2>Please Wait......</H2>
    </body>
</html>
