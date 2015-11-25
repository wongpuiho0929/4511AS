package ict.db;

import ict.bean.ShoppingCartBean;
import ict.bean.UserInfo;
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

public class ShoppingCartDB {

    private String url = "";
    private String username = "";
    private String password = "";

    public ShoppingCartDB(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }
    
    public Connection getConnection() throws SQLException, IOException {

        //System.setProperty("jdbc.drivers","com.mysql.jdbc.Driver");
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return DriverManager.getConnection(url, username, password);
    }

    public void createShoppingCartTable() {
        Connection cnnct = null;
        Statement stmmt = null;
        try {
            cnnct = getConnection();
            stmmt = cnnct.createStatement();
            String sql = "Create table if not EXISTS shoppingcart("
                    + "sId varchar(5) not null," + "uId varchar(5) not null," + "oId varchar(5),"
                    + "pId varchar(5) not null," + "qty int(20) not null"
                    + ")";
            stmmt.execute(sql);
            stmmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDB.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ShoppingCartDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean addShoppingCart(String sId, String uId, String pId, int qty) {
        Connection cnnct = null;
        PreparedStatement stmmt = null;
        boolean chk = false;
        try {
            cnnct = getConnection();
            String sql = "INSERT INTO SHOPPINGCART (SID,UID,PID,QTY) VALUES(?,?,?,?)";
            stmmt = cnnct.prepareStatement(sql);
            stmmt.setString(1, sId);
            stmmt.setString(2, uId);
            stmmt.setString(3, pId);
            stmmt.setInt(4, qty);

            int rowCount = stmmt.executeUpdate();
            if (rowCount > 1) {
                chk = true;
            }
            stmmt.close();
            cnnct.close();

        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDB.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ShoppingCartDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return chk;
    }

    public ArrayList<ShoppingCartBean> showCart(String uId) {
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        ShoppingCartBean cart = null;
        ArrayList<ShoppingCartBean> a = new ArrayList<ShoppingCartBean>();
        try {
            cnnct = getConnection();
            String preQueryStatment = "select * from shoppingcart where uid=?";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            pStnmt.setString(1, uId);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            while (rs.next()) {
                cart = new ShoppingCartBean();
                String sid = rs.getString("sid");
                String uid = rs.getString("uid");
                String pid = rs.getString("pid");
                int qty = rs.getInt("qty");
                String oid = rs.getString("oid");

                cart.setSid(sid);
                cart.setUid(uid);
                cart.setQty(qty);
                cart.setPid(pid);
                cart.setOid(oid);
                a.add(cart);
            }
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return a;
    }

    public String lastID() {
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        String id = "";
        try {
            cnnct = getConnection();
            String preQueryStatment = "select sid from shoppingcart";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            while (rs.next()) {
                id = rs.getString("sid");
            }
            if (id == null || id == "") {
                id = "S0001";
                return id;
            }
            id = id.substring(id.indexOf("S") + 1);
            int i = Integer.parseInt(id);
            i++;
            id = "S";
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

    public void remove(String sid) {
       Connection cnnct = null;
       PreparedStatement pStnmt = null;
        try {
            cnnct = getConnection();
            String sql = "Delete from shoppingcart where sid=?";
            pStnmt = cnnct.prepareStatement(sql);
            pStnmt.setString(1, sid);
             int rowCount = pStnmt.executeUpdate();
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            Logger.getLogger(ShoppingCartDB.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ShoppingCartDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
