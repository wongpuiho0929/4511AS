/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ict.test;


import ict.db.*;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.http.HttpServlet;
/**
 *
 * @author a1
 */
public class test extends HttpServlet{
    public static void main(String[]arg) throws SQLException, IOException{
        String url = "jdbc:mysql://localhost:3306/ITP4511_ASDB";
        String username= "root";
        String password = "tommy985";
        UserDB db = new UserDB(url, username, password);
        db.createUserInfoTable();
        db.addUserInfo("1", "xyz", "123","Manager","Y");
        System.out.print(db.isValidUser("xyz","123"));
    }
}
