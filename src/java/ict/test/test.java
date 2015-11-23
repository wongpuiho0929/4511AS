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
public class test extends HttpServlet {

    public static void main(String[] arg) throws SQLException, IOException {
        String url = "jdbc:mysql://localhost:3306/ITP4511_ASDB";
        String username = "root";
        String password = "tommy985";
        
        UserDB db = new UserDB(url, username, password);
        db.createUserInfoTable();
        db.addUserInfo("1","","","","xyz","123","Manager","N");
        System.out.print(db.isValidUser("xyz","123"));

      
        /*UserDB db = new UserDB(url, username, password);
        db.createUserInfoTable();
        db.addUserInfo("1", "xyz", "123","Manager","Y");
        System.out.print(db.isValidUser("xyz","123"));*/
        ProductDB pdb = new ProductDB(url, username, password);
        pdb.createProductTable();
        pdb.addProduct("P0001", "Integer eleifend sed", 100.0, 20, "images/product/01.jpg");
        pdb.addProduct("P0002", "Nam cursus facilisis", 200.0, 20, "images/product/02.jpg");
        pdb.addProduct("P0003", "Mauris consectetur", 120.5, 20, "images/product/03.jpg");
        pdb.addProduct("P0004", "Proin volutpat", 260.0, 20, "images/product/04.jpg");
        pdb.addProduct("P0005", "Aenean tempus", 80.0, 20, "images/product/05.jpg");
        pdb.addProduct("P0006", "Nulla luctus urna", 193.0, 20, "images/product/06.jpg");
        pdb.addProduct("P0007", "Pellentesque, Validate", 30.0, 20, "images/product/07.jpg");
        pdb.addProduct("P0008", "Suspendisse fermentum", 220.0, 20, "images/product/08.jpg");
        pdb.addProduct("P0009", "Donec laoreet velit", 65.0, 20, "images/product/09.jpg");


    }
}
