package ict.db;

import ict.bean.ProductBean;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProductDB {

    private String url = "";
    private String username = "";
    private String password = "";

    public ProductDB(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }

    public Connection getConnection() throws SQLException, IOException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return DriverManager.getConnection(url, username, password);
    }

    public void createProductTable() {
        Connection cnnct = null;
        Statement stmmt = null;
        try {
            cnnct = getConnection();
            stmmt = cnnct.createStatement();
            String sql = "Create table if not EXISTS Product("
                    + "PId varchar(5) not null," + "pName varchar(25) not null,"
                    + "price double not null," + "qty int(20) not null,"
                    + "photo varchar(25))";
            stmmt.execute(sql);
            stmmt.close();
            cnnct.close();
        } catch (Exception e) {

        }
    }

    public boolean addProduct(String pid, String pName, double price, int qty, String photo) throws SQLException, IOException {
        Connection cnnct = null;
        PreparedStatement pstmmt = null;
        boolean isValid = false;
        cnnct = getConnection();
        String preQueryStatement = "INSERT INTO Product VALUES (?,?,?,?,?)";
        pstmmt = cnnct.prepareStatement(preQueryStatement);
        pstmmt.setString(1, pid);
        pstmmt.setString(2, pName);
        pstmmt.setDouble(3, price);
        pstmmt.setInt(4, qty);
        pstmmt.setString(5, photo);
        int rowCount = pstmmt.executeUpdate();
        if (rowCount > 1) {
            isValid = true;
        }
        pstmmt.close();
        cnnct.close();
        return isValid;
    }

    public ArrayList<ProductBean> showProduct() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ProductBean pb = null;
        ArrayList<ProductBean> a = new ArrayList();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT * FROM PRODUCT";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = null;
            rs = pStmnt.executeQuery();
            while (rs.next()) {
                pb = new ProductBean();
                pb.setPid(rs.getString("pid"));
                pb.setName(rs.getString("pname"));
                pb.setPrice(rs.getDouble("price"));
                pb.setQty(rs.getInt("qty"));
                pb.setPhoto(rs.getString("photo"));
                a.add(pb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            while (ex != null) {
                ex.printStackTrace();
                ex = ex.getNextException();
            }
        } catch (IOException ex) {
            Logger.getLogger(ProductDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return a;
    }

}
