/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.db;

import ict.bean.UserGiftBean;
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
public class UserGiftDB {
    
    private String url = "";
    private String username = "";
    private String password = "";
     
    public UserGiftDB(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }
    
    public Connection getConnection() throws SQLException, IOException{
        try {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch(ClassNotFoundException ex) {
            Logger.getLogger(UserGiftDB.class.getName()).log(Level.SEVERE, null, ex);
        }        
        return DriverManager.getConnection(url, username, password);
    }
    
    public void createUserGiftTable(){
        Connection cnnct = null;
        Statement stmnt = null;
        try{
            cnnct = getConnection();
            stmnt = cnnct.createStatement();
            String sql 
                    = "create table if not exists UserGift ("
                    + "userId varchar(5) not null,"
                    + "giftId varchar(5) not null,"
                    + "bonusPoint int(20) not null,"
                    + "FOREIGN KEY (giftId) REFERENCES gift(giftid),"
                    + "FOREIGN KEY (userId) REFERENCES userinfo(id)"
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
    
    public ArrayList <UserGiftBean> listGiftById(String id){
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        UserGiftBean ugb = null;
        ArrayList <UserGiftBean> ugbs = new ArrayList <UserGiftBean> ();
        try{
            cnnct = getConnection();
            String preQueryStatment = "select * from usergift where userid = ?";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            pStnmt.setString(1, id);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            while (rs.next()){
                ugb = new UserGiftBean();
                String giftId = rs.getString("giftId");
                String userId = rs.getString("userId");
                int bonusPoint = rs.getInt("bonusPoint");
                
                ugb.setGiftId(giftId);
                ugb.setUserId(userId);
                ugb.setBonusPoint(bonusPoint);
                ugbs.add(ugb);
            }
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return ugbs;
    }
    
    public boolean addUserGift(String giftId, String userId, int bonusPoint) throws SQLException, IOException {
        Connection cnnct = null;
        PreparedStatement pstmmt = null;
        boolean isValid = false;
        cnnct = getConnection();
        String preQueryStatement = "INSERT INTO USERGIFT VALUES (?,?,?)";
        pstmmt = cnnct.prepareStatement(preQueryStatement);
        pstmmt.setString(1, userId);
        pstmmt.setString(2, giftId);
        pstmmt.setInt(3, bonusPoint);
        int rowCount = pstmmt.executeUpdate();
        if (rowCount > 1) {
            isValid = true;
        }
        pstmmt.close();
        cnnct.close();
        return isValid;
    }
    
    public ArrayList <UserGiftBean> listGiftByBonusPoint(int gBonusPoint, String option){
        Connection cnnct = null;
        PreparedStatement pStmnt = null;
        UserGiftBean ugb = null;
        ArrayList <UserGiftBean> ugbs = new ArrayList <UserGiftBean> ();
        String preQueryStatement = "";
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
            if (rs.next()) {
                ugb = new UserGiftBean();
                String giftId = rs.getString("userId");
                String userId = rs.getString("giftId");
                int bonusPoint = rs.getInt("bonusPoint");
                
                ugb.setGiftId(giftId);
                ugb.setUserId(userId);
                ugb.setBonusPoint(bonusPoint);
                ugbs.add(ugb);
             
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
        return ugbs;
    }
}
