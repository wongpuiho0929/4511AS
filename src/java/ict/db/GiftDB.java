/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.GiftBean;
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
public class GiftDB {
    
    private String url = "";
    private String username = "";
    private String password = "";
     
    public GiftDB(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }
    
    public Connection getConnection() throws SQLException, IOException{
        try {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch(ClassNotFoundException ex) {
            Logger.getLogger(GiftDB.class.getName()).log(Level.SEVERE, null, ex);
        }        
        return DriverManager.getConnection(url, username, password);
    }
    
    public void createGiftTable(){
        Connection cnnct = null;
        Statement stmnt = null;
        try{
            cnnct = getConnection();
            stmnt = cnnct.createStatement();
            String sql 
                    = "create table if not exists gift ("
                    + "giftId varchar(5) not null,"
                    + "giftName varchar(20) not null,"
                    + "bonusPoint int(20) not null,"
                    + "qty int(20) not null,"
                    + "descriptions varchar(100) not null,"
                    + "primary key (giftId)"
                    + ")";
            stmnt.execute(sql);
            stmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
    
    public ArrayList <GiftBean> listGift(){
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        GiftBean gb = null;
        ArrayList <GiftBean> gbs = new ArrayList <GiftBean> ();
        try{
            cnnct = getConnection();
            String preQueryStatment = "select * from gift";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            while (rs.next()){
                gb = new GiftBean();
                String giftId = rs.getString("giftId");
                String giftName = rs.getString("giftName");
                int bonusPoint = rs.getInt("bonusPoint");
                int qty = rs.getInt("qty");
                String descriptions = rs.getString("descriptions");
                
                gb.setGiftId(giftId);
                gb.setGiftName(giftName);
                gb.setBonusPoint(bonusPoint);
                gb.setQty(qty);
                gb.setDescriptions(descriptions);
                gbs.add(gb);
            }
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return gbs;
    }
    
    public boolean addGift(String giftId, String giftName, int bonusPoint, int qty, String descriptions) throws SQLException, IOException {
        Connection cnnct = null;
        PreparedStatement pstmmt = null;
        boolean isValid = false;
        cnnct = getConnection();
        String preQueryStatement = "INSERT INTO GIFT VALUES (?,?,?,?,?)";
        pstmmt = cnnct.prepareStatement(preQueryStatement);
        pstmmt.setString(1, giftId);
        pstmmt.setString(2, giftName);
        pstmmt.setDouble(3, bonusPoint);
        pstmmt.setInt(4, qty);
        pstmmt.setString(5, descriptions);
        int rowCount = pstmmt.executeUpdate();
        if (rowCount > 1) {
            isValid = true;
        }
        pstmmt.close();
        cnnct.close();
        return isValid;
    }
    
    public ArrayList <GiftBean> listGiftByBonusPoint(int gBonusPoint, String option){
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        GiftBean gb = null;
        ArrayList <GiftBean> gbs = new ArrayList <GiftBean> ();
        String preQueryStatement;
        try {
            cnnct = getConnection();
            if("less".equalsIgnoreCase(option))               
                preQueryStatement = "SELECT * FROM GIFT WHERE BONUSPOINT < ?";
            else if("equal".equalsIgnoreCase(option)) 
                preQueryStatement = "SELECT * FROM GIFT WHERE BONUSPOINT = ?";
            else
                preQueryStatement = "SELECT * FROM GIFT WHERE BONUSPOINT > ?";
            pStmnt = cnnct.prepareStatement(preQueryStatement);
            pStmnt.setInt(1, gBonusPoint);
            ResultSet rs = null;
            rs = pStmnt.executeQuery();
            while (rs.next()){
                gb = new GiftBean();
                String giftId = rs.getString("giftId");
                String giftName = rs.getString("giftName");
                int bonusPoint = rs.getInt("bonusPoint");
                int qty = rs.getInt("qty");
                String descriptions = rs.getString("descriptions");
                
                gb.setGiftId(giftId);
                gb.setGiftName(giftName);
                gb.setBonusPoint(bonusPoint);
                gb.setQty(qty);
                gb.setDescriptions(descriptions);
                gbs.add(gb);
            }
            pStmnt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return gbs;
    }
    
    public boolean delGift(String giftId){
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        boolean isSuccess = false;
        try{
            cnnct = getConnection();
            String preQueryStatment = "delete from gift where giftId = ?";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            pStnmt.setString(1, giftId);
            int rowCount = pStnmt.executeUpdate();
            if (rowCount >=1 ){
                isSuccess = true;
            }
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    
    public boolean UpdateGiftQty(GiftBean gb){
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        boolean isSuccess = false;
        try{
            cnnct = getConnection();
            String preQueryStatment = "update gift set qty = ? where giftId = ?";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            int qty = gb.getQty();
            pStnmt.setInt(1, --qty);
            pStnmt.setString(2, gb.getGiftId());
            int rowCount = pStnmt.executeUpdate();
            if (rowCount >=1 ){
                isSuccess = true;
            }
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return isSuccess;
    }
    
    public GiftBean listGiftByID(String id){
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        GiftBean gb = null;
        try{
            cnnct = getConnection();
            String preQueryStatment = "select * from gift where giftId = ?";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            pStnmt.setString(1, id);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            if (rs.next()){
                gb = new GiftBean();
                int bonusPoint = rs.getInt("bonusPoint");
                int qty = rs.getInt("qty");
                
                gb.setGiftId(id);
                gb.setBonusPoint(bonusPoint);
                gb.setQty(qty);
            }
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return gb;
    }
}
