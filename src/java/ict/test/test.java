package ict.test;

import ict.db.*;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.http.HttpServlet;

public class test extends HttpServlet {

    public static void main(String[] arg) throws SQLException, IOException {
        String url = "jdbc:mysql://localhost:3306/ITP4511_ASDB";
        String username = "root";
        String password = "tommy985";
        
        UserDB db = new UserDB(url, username, password);
        db.createUserInfoTable();
        db.addUserInfo("1","","","","xyz","123","Manager","N");


        ProductDB pdb = new ProductDB(url, username, password);

        pdb.createProductTable();
        pdb.addProduct("P0001", "Integer eleifend sed", 100.0, 20,"IS a Pen","pen","images/product/01.jpg");
        pdb.addProduct("P0002", "Nam cursus facilisis", 200.0, 20,"IS a Pen","pen", "images/product/02.jpg");
        pdb.addProduct("P0003", "Mauris consectetur", 120.5, 20,"IS a Pen","pen", "images/product/03.jpg");
        pdb.addProduct("P0004", "Proin volutpat", 260.0, 20,"IS a Pen","pen", "images/product/04.jpg");
        pdb.addProduct("P0005", "Aenean tempus", 80.0, 20,"IS a Pen","pen", "images/product/05.jpg");
        pdb.addProduct("P0006", "Nulla luctus urna", 193.0, 20,"IS a Pen","pen", "images/product/06.jpg");
        pdb.addProduct("P0007", "Pellentesque, Validate", 30.0, 20,"IS a Pen","pen", "images/product/07.jpg");
        pdb.addProduct("P0008", "Suspendisse fermentum", 220.0, 20,"IS a Pen","pen", "images/product/08.jpg");
        pdb.addProduct("P0009", "Donec laoreet velit", 65.0, 20,"IS a Pen","pen", "images/product/09.jpg");
        
        ShoppingCartDB scdb = new ShoppingCartDB(url,username,password);
        scdb.createShoppingCartTable();


    }
}
