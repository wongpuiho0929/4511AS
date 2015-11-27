/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.OrderBean;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author pet10_000
 */
public class OrderDB {

    private String url = "";
    private String username = "";
    private String password = "";

    public OrderDB(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }

    public Connection getConnection() throws SQLException, IOException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(OrderDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return DriverManager.getConnection(url, username, password);
    }

    public void createOrderTable() {
        Connection cnnct = null;
        Statement stmmt = null;
        try {
            cnnct = getConnection();
            stmmt = cnnct.createStatement();
            String sql
                    = "create table if not exists orders ("
                    + "oId varchar(5) not null,"
                    + "uId varchar(5) not null,"
                    + "pickUpDate datetime null,"
                    + "tPrice double not null,"
                    + "state varchar(20) not null,"
                    + "bonus int(20) not null,"
                    + "primary key (oId)"
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

    public ArrayList<OrderBean> listOrder() {
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        OrderBean db = null;
        ArrayList<OrderBean> dbs = new ArrayList<OrderBean>();
        try {
            cnnct = getConnection();
            String preQueryStatment = "select * from orders";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            while (rs.next()) {
                db = new OrderBean();
                String oId = rs.getString("oId");
                String uId = rs.getString("uId");
                Date date = rs.getDate("pickupdate");
                double tPrice = rs.getDouble("tPrice");
                String state = rs.getString("state");
                int bonus = rs.getInt("bonus");

                db.setoId(oId);
                db.setuId(uId);
                db.setPickUpDate(date);
                db.settPrice(tPrice);
                db.setStatus(state);
                db.setBonus(bonus);
                dbs.add(db);
            }
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return dbs;
    }

    public ArrayList<OrderBean> listOrderById(String id) {
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        OrderBean db = null;
        ArrayList<OrderBean> dbs = new ArrayList<OrderBean>();
        try {
            cnnct = getConnection();
            String preQueryStatment = "select * from orders where uid=?";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            pStnmt.setString(1, id);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            while (rs.next()) {
                db = new OrderBean();
                String oId = rs.getString("oId");
                String uId = rs.getString("uId");
                Date date = rs.getDate("pickupdate");
                double tPrice = rs.getDouble("tPrice");
                String state = rs.getString("state");
                int bonus = rs.getInt("bonus");

                db.setoId(oId);
                db.setuId(uId);
                db.setPickUpDate(date);
                db.settPrice(tPrice);
                db.setStatus(state);
                db.setBonus(bonus);
                dbs.add(db);
            }
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return dbs;
    }

    public OrderBean listOrderByOid(String oid) {
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        OrderBean o = null;
        try {
            cnnct = getConnection();
            String preQueryStatment = "select * from orders where oid=?";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            pStnmt.setString(1, oid);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            if (rs.next()) {
                o = new OrderBean();
                String oId = rs.getString("oId");
                String uId = rs.getString("uId");
                Date date = rs.getDate("pickupdate");
                double tPrice = rs.getDouble("tPrice");
                String state = rs.getString("state");
                int bonus = rs.getInt("bonus");

                o.setoId(oId);
                o.setuId(uId);
                o.setPickUpDate(date);
                o.settPrice(tPrice);
                o.setStatus(state);
                o.setBonus(bonus);
            }
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return o;
    }

    public boolean addPickUpOrder(String oid, String uid, Date date, double tprice, String status, int bonus) throws SQLException, IOException {
        Connection cnnct = null;
        PreparedStatement pstmmt = null;
        boolean isValid = false;
        cnnct = getConnection();
        String preQueryStatement = "INSERT INTO ORDERS VALUES (?,?,?,?,?,?)";
        pstmmt = cnnct.prepareStatement(preQueryStatement);
        pstmmt.setString(1, oid);
        pstmmt.setString(2, uid);
        pstmmt.setDate(3, date);
        pstmmt.setDouble(4, tprice);
        pstmmt.setString(5, status);
        pstmmt.setInt(6, bonus);
        int rowCount = pstmmt.executeUpdate();
        if (rowCount > 1) {
            isValid = true;
        }
        pstmmt.close();
        cnnct.close();
        return isValid;
    }

    public boolean addDeliveryOrder(String oid, String uid, double tprice, String status, int bonus) throws SQLException, IOException {
        Connection cnnct = null;
        PreparedStatement pstmmt = null;
        boolean isValid = false;
        cnnct = getConnection();
        String preQueryStatement = "INSERT INTO ORDERS(OID, UID, TPRICE, STATE, BONUS) VALUES (?,?,?,?,?)";
        pstmmt = cnnct.prepareStatement(preQueryStatement);
        pstmmt.setString(1, oid);
        pstmmt.setString(2, uid);
        pstmmt.setDouble(3, tprice);
        pstmmt.setString(4, status);
        pstmmt.setInt(5, bonus);
        int rowCount = pstmmt.executeUpdate();
        if (rowCount > 1) {
            isValid = true;
        }
        pstmmt.close();
        cnnct.close();
        return isValid;
    }

    public String lastID() {
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        String id = "";
        try {
            cnnct = getConnection();
            String preQueryStatment = "select oid from orders";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            while (rs.next()) {
                id = rs.getString("oid");
            }
            if (id == null || id == "") {
                id = "O0001";
                return id;
            }
            id = id.substring(id.indexOf("O") + 1);
            int i = Integer.parseInt(id);
            i++;
            id = "O";
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
    
    public boolean updateStatus(String oid, String status) throws SQLException, IOException {
        Connection cnnct = null;
        PreparedStatement pstmmt = null;
        boolean isValid = false;
        cnnct = getConnection();
        String preQueryStatement = "UPDATE ORDERS SET STATE = ? WHERE OID = ?";
        pstmmt = cnnct.prepareStatement(preQueryStatement);
        pstmmt.setString(1, status);
        pstmmt.setString(2, oid);       
        int rowCount = pstmmt.executeUpdate();
        if (rowCount > 1) {
            isValid = true;
        }
        pstmmt.close();
        cnnct.close();
        return isValid;
    }
}
