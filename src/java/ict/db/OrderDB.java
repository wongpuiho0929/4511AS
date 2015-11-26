/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.OrderBean;
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
    
    public ArrayList <OrderBean> listOrder(){
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        OrderBean db = null;
        ArrayList <OrderBean> dbs = new ArrayList <OrderBean> ();
        try{
            cnnct = getConnection();
            String preQueryStatment = "select * from order";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            while (rs.next()){
                db = new OrderBean();
                String oId = rs.getString("oId");
                String uId = rs.getString("uId");
                double tPrice = rs.getDouble("tPrice");
                String status = rs.getString("status");
                
                db.setoId(oId);
                db.setuId(uId);
                db.settPrice(tPrice);
                db.setStatus(status);
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
    
    public ArrayList <OrderBean> listOrderById(String id){
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        OrderBean db = null;
        ArrayList <OrderBean> dbs = new ArrayList <OrderBean> ();
        try{
            cnnct = getConnection();
            String preQueryStatment = "select * from order where id=?";            
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            pStnmt.setString(1, id);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            while (rs.next()){
                db = new OrderBean();
                String oId = rs.getString("oId");
                String uId = rs.getString("uId");
                double tPrice = rs.getDouble("tPrice");
                String status = rs.getString("status");
                int bonus = rs.getInt("bonus");
                
                db.setoId(oId);
                db.setuId(uId);
                db.settPrice(tPrice);
                db.setStatus(status);
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
    
    public boolean addOrder(String oid, String uid, double tprice, String status, int bonus) throws SQLException, IOException {
        Connection cnnct = null;
        PreparedStatement pstmmt = null;
        boolean isValid = false;
        cnnct = getConnection();
        String preQueryStatement = "INSERT INTO ORDERS VALUES (?,?,?,?,?)";
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
}
