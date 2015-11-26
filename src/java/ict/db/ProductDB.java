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

    public ProductDB() {
        url = "jdbc:mysql://localhost:3306/ITP4511_ASDB";
        username = "root";
        password = "tommy985";
    }

    public ProductDB(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }

    public Connection getConnection() throws SQLException, IOException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductDB.class.getName()).log(Level.SEVERE, null, ex);
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
                    + "brand varchar(20) not null," + "description varchar(20) not null,"
                    + "category varchar(20) not null," + "photo varchar(25))";
            stmmt.execute(sql);
            stmmt.close();
            cnnct.close();
        } catch (Exception e) {

        }
    }

    public boolean addProduct(String pid, String pName, double price, int qty, String brand, String description, String category, String photo) throws SQLException, IOException {
        Connection cnnct = null;
        PreparedStatement pstmmt = null;
        boolean isValid = false;
        cnnct = getConnection();
        String preQueryStatement = "INSERT INTO Product VALUES (?,?,?,?,?,?,?,?)";
        pstmmt = cnnct.prepareStatement(preQueryStatement);
        pstmmt.setString(1, pid);
        pstmmt.setString(2, pName);
        pstmmt.setDouble(3, price);
        pstmmt.setInt(4, qty);
        pstmmt.setString(5, brand);
        pstmmt.setString(6, description);
        pstmmt.setString(7, category);
        pstmmt.setString(8, photo);
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
                pb.setBrand(rs.getString("brand"));
                pb.setDescription(rs.getString("description"));
                pb.setCategory(rs.getString("category"));
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
    
    public ArrayList<ProductBean> groupBy() {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ProductBean pb = null;
        ArrayList<ProductBean> a = new ArrayList();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT DISTINCT BRAND FROM PRODUCT";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            ResultSet rs = null;
            rs = pStmnt.executeQuery();
            while (rs.next()) {
                pb = new ProductBean();
                pb.setBrand(rs.getString("brand"));
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

    public ProductBean productdetail(String id) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ProductBean pb = null;
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT * FROM PRODUCT WHERE PID =?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, id);
            ResultSet rs = null;
            rs = pStmnt.executeQuery();
            if (rs.next()) {
                pb = new ProductBean();
                pb.setPid(rs.getString("pid"));
                pb.setName(rs.getString("pname"));
                pb.setPrice(rs.getDouble("price"));
                pb.setBrand(rs.getString("brand"));
                pb.setDescription(rs.getString("description"));
                pb.setCategory(rs.getString("category"));
                pb.setQty(rs.getInt("qty"));
                pb.setPhoto(rs.getString("photo"));

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
        return pb;
    }

    public ArrayList<ProductBean> searchProduct(String pName, String bName) {
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        ProductBean pb = null;
        ArrayList<ProductBean> a = new ArrayList();
        try {
            cnnct = getConnection();
            String preQueryStatement = "SELECT * FROM PRODUCT where pName Like ? and brand like ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setString(1, "%" + pName + "%");
            pStmnt.setString(2, "%" + bName + "%");
            ResultSet rs = null;
            rs = pStmnt.executeQuery();
            while (rs.next()) {
                pb = new ProductBean();
                pb.setPid(rs.getString("pid"));
                pb.setName(rs.getString("pname"));
                pb.setPrice(rs.getDouble("price"));
                pb.setBrand(rs.getString("brand"));
                pb.setDescription(rs.getString("description"));
                pb.setCategory(rs.getString("category"));
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
    
     public String lastID() {
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        String id = "";
        try {
            cnnct = getConnection();
            String preQueryStatment = "select pid from product";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            while (rs.next()) {
                id = rs.getString("pid");
            }
            if (id == null || id == "") {
                id = "P0001";
                return id;
            }
            id = id.substring(id.indexOf("P") + 1);
            int i = Integer.parseInt(id);
            i++;
            id = "P";
            id += String.format("%04d", i);
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return id;
    }
}
