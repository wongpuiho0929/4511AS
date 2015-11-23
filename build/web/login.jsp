<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" type="text/css" href="css/ddsmoothmenu.css" />
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/ddsmoothmenu.js"></script>
    </head>
    <body>
        <form method="post" action="login">
            <input type="hidden" name="action" value="authenticate"/>
            <table border ="0">
              <tr><td><p align="right"><b>Login:</b></td>
                  <td><p><input type="text" name="username" maxlength="10" size="15"></td>
              </tr>
              <tr>
                  <td><p align="right"><b>Password:</b></td>
                  <td><p><input type="password" name="password" maxlength="10" size="15"></td>
              </tr>
              <tr>
                   <td colspan="2"><p align="center"><input type="submit" value="Login"></p></td>
              </tr>
          </table>
        </form>
    </body>
</html>
