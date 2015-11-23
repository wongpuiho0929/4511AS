package ict.db;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import static java.util.logging.Level.SEVERE;
import java.util.logging.Logger;

public class UserDB {
   private String url="";
   private String username ="";
   private String password = "";

    public UserDB(String url,String username,String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }
   
    public Connection getConnection() throws SQLException,IOException{
        
        //System.setProperty("jdbc.drivers","com.mysql.jdbc.Driver");
        try{
            Class.forName("com.mysql.jdbc.Driver");
        }catch(ClassNotFoundException ex){
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE,null,ex);
        }
         
        return DriverManager.getConnection(url,username,password);
    }
  
    
    public void createUserInfoTable(){
        Connection cnnct =null; 
        Statement stmmt = null;
        try{
            cnnct = getConnection();
            stmmt = cnnct.createStatement();
            String sql = "Create table if not EXISTS userInfo("
                    +"Id varchar(5) not null,"+"username varchar(25) not null,"
                    +"password varchar(25) not null,"+"position varchar(25) not null,"
                    +"isfreeze(1) not null)";
            stmmt.execute(sql);
            stmmt.close();
            cnnct.close();
        }catch(Exception e){
                    
            
        }
        
    }
    
    public boolean isValidUser(String user,String pwd) throws SQLException, IOException{
        Connection cnnct =null; 
        PreparedStatement pstmmt = null;
        boolean isValid = false;
            cnnct = getConnection();
            String preQueryStatement = "SELECT * FROM USERINFO WHERE username=? and password=?";
            pstmmt = cnnct.prepareStatement(preQueryStatement);
            pstmmt.setString(1, user);
            pstmmt.setString(2, pwd);
            ResultSet rowCount = pstmmt.executeQuery();
            if(rowCount.next()){
                isValid =true;
            }
            
            pstmmt.close();
            cnnct.close();
            return isValid;
        
    }
    
    public boolean addUserInfo(String id,String user,String pwd,String position,String isfreeze) throws SQLException, IOException{
        Connection cnnct =null; 
        PreparedStatement pstmmt = null;
        boolean isValid = false;
            cnnct = getConnection();
            String preQueryStatement = "INSERT INTO USERINFO (ID, USERNAME, PASSWORD,POSITION)VALUES (?,?,?,?,?)";
            pstmmt = cnnct.prepareStatement(preQueryStatement);
            pstmmt.setString(1, id);
            pstmmt.setString(2, user);
            pstmmt.setString(3, pwd);
            pstmmt.setString(4, position);
            pstmmt.setString(5, isfreeze);
            int rowCount = pstmmt.executeUpdate();
            if(rowCount>1){
                isValid =true;
            }
            pstmmt.close();
            cnnct.close();
            return isValid;
        
    }
    
    
    
}
