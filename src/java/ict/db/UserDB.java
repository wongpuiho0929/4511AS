package ict.db;

import ict.bean.UserInfo;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDB {

    private String url = "";
    private String username = "";
    private String password = "";

    public UserDB(String url, String username, String password) {
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

    public void createUserInfoTable() {
        Connection cnnct = null;
        Statement stmmt = null;
        try {
            cnnct = getConnection();
            stmmt = cnnct.createStatement();
            String sql = "Create table if not EXISTS userInfo("
                    + "Id varchar(5) not null," + "name varchar(25) not null,"
                    + "tel varchar(10) not null," + "address varchar(50) not null,"
                    + "username varchar(25) not null," + "password varchar(25) not null,"
                    + "position varchar(25) not null," + "isfreeze varchar(1) not null)";
            stmmt.execute(sql);
            stmmt.close();
            cnnct.close();
        } catch (Exception e) {

        }

    }

    public UserInfo isValidUser(String user, String pwd) throws SQLException, IOException {
        Connection cnnct = null;
        PreparedStatement pstmmt = null;
        boolean isValid = false;
        UserInfo bean= null;
        cnnct = getConnection();
        String preQueryStatement = "SELECT * FROM USERINFO WHERE username=? and password=?";
        pstmmt = cnnct.prepareStatement(preQueryStatement);
        pstmmt.setString(1, user);
        pstmmt.setString(2, pwd);
        ResultSet rowCount = pstmmt.executeQuery();
        if (rowCount.next()) {
            isValid = true;
            bean = new UserInfo();
            bean.setId(rowCount.getString("id"));
            bean.setName(rowCount.getString("name"));
            bean.setTel(rowCount.getString("tel"));
            bean.setUsername(rowCount.getString("username"));
            bean.setPassword(rowCount.getString("password"));
            bean.setPosition(rowCount.getString("position"));
            bean.setIsfreeze(rowCount.getString("isfreeze"));
            
        }

        pstmmt.close();
        cnnct.close();
        return bean;

    }

    public boolean addUserInfo(String id, String name, String tel, String address, String user, String pwd, String position, String isfreeze) throws SQLException, IOException {
        Connection cnnct = null;
        PreparedStatement pstmmt = null;
        boolean isValid = false;
        cnnct = getConnection();
        String preQueryStatement = "INSERT INTO USERINFO (ID, NAME, TEL, ADDRESS, USERNAME, PASSWORD,POSITION,ISFREEZE)VALUES (?,?,?,?,?,?,?,?)";
        pstmmt = cnnct.prepareStatement(preQueryStatement);
        pstmmt.setString(1, id);
        pstmmt.setString(2, name);
        pstmmt.setString(3, tel);
        pstmmt.setString(4, address);
        pstmmt.setString(5, user);
        pstmmt.setString(6, pwd);
        pstmmt.setString(7, position);
        pstmmt.setString(8, isfreeze);
        int rowCount = pstmmt.executeUpdate();
        if (rowCount > 1) {
            isValid = true;
        }
        pstmmt.close();
        cnnct.close();
        return isValid;

    }

    public ArrayList queryUser() {
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        UserInfo user = null;
        ArrayList<UserInfo> users = new ArrayList<UserInfo>();
        try {
            cnnct = getConnection();
            String preQueryStatment = "select * from userinfo";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            while (rs.next()) {
                user = new UserInfo();
                String id = rs.getString("id");
                String name = rs.getString("name");
                String tel = rs.getString("tel");
                String address = rs.getString("address");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String position = rs.getString("position");
                String isfreezze = rs.getString("isfreeze");

                user.setId(id);
                user.setName(name);
                user.setTel(tel);
                user.setAddress(address);
                user.setUsername(username);
                user.setPassword(password);
                user.setPosition(position);
                user.setIsfreeze(isfreezze);
                users.add(user);
            }
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return users;
    }

    public boolean addRecord(String id, String name, String tel, String address, String position) {
        String username = "7";
        String password = "";
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatment = "INSERT INTO USERINFO (ID, NAME, TEL, ADDRESS, USERNAME, PASSWORD,POSITION,ISFREEZE)VALUES (?,?,?,?,?,?,?,?)";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            pStnmt.setString(1, id);
            pStnmt.setString(2, name);
            pStnmt.setString(3, tel);
            pStnmt.setString(4, address);
            pStnmt.setString(7, position);
            pStnmt.setString(8, "Y");
            Random r = new Random();
            char[] temp = new char[8];
            for (int i = 0; i < temp.length - 1; i++) {
                temp[i] = (char) (r.nextInt(9) + 48);
                username += temp[i];
            }
            pStnmt.setString(5, username);

            for (int i = 0; i < temp.length; i++) {
                temp[i] = (char) (r.nextInt(74) + 48);
                password += temp[i];
            }
            pStnmt.setString(6, password);

            int rowCount = pStnmt.executeUpdate();
            if (rowCount >= 1) {
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

    public boolean editRecord(UserInfo u) {
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatment = "update userinfo set name = ?,tel = ?, address = ?, position = ? where id = ?";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            pStnmt.setString(1, u.getName());
            pStnmt.setString(2, u.getTel());
            pStnmt.setString(3, u.getAddress());
            pStnmt.setString(4, u.getPosition());
            pStnmt.setString(5, u.getId());
            int rowCount = pStnmt.executeUpdate();
            if (rowCount >= 1) {
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

    public UserInfo queryCustByID(String id) {
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        UserInfo u = null;
        try {
            cnnct = getConnection();
            String preQueryStatment = "select * from userinfo where id = ?";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            pStnmt.setString(1, id);
            ResultSet rs = null;
            rs = pStnmt.executeQuery();
            if (rs.next()) {
                u = new UserInfo();
                String userId = rs.getString("id");
                String name = rs.getString("name");
                String tel = rs.getString("tel");
                String address = rs.getString("address");
                String position = rs.getString("position");

                u.setId(userId);
                u.setName(name);
                u.setTel(tel);
                u.setAddress(tel);
                u.setPosition(position);
            }
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return u;
    }

    public boolean unfreeze(String id) {
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatment = "update userinfo set isfreeze = 'N' where id = ?";;
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            pStnmt.setString(1, id);
            int rowCount = pStnmt.executeUpdate();
            if (rowCount >= 1) {
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

    public boolean freeze(String id) {
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        boolean isSuccess = false;
        try {
            cnnct = getConnection();
            String preQueryStatment = "update userinfo set isfreeze = 'Y' where id = ?";;
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            pStnmt.setString(1, id);
            int rowCount = pStnmt.executeUpdate();
            if (rowCount >= 1) {
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

    public String getNewPassword(String id) {
        Connection cnnct = null;
        PreparedStatement pStnmt = null;
        boolean isSuccess = false;
        Random r = new Random();
        String password = "";
        try {
            cnnct = getConnection();
            String preQueryStatment = "update userinfo set password = ? where id = ?";
            pStnmt = cnnct.prepareStatement(preQueryStatment);
            char[] temp = new char[8];
            for (int i = 0; i < temp.length; i++) {
                temp[i] = (char) (r.nextInt(74) + 48);
                password += temp[i];
            }
            pStnmt.setString(1, password);
            pStnmt.setString(2, id);
            int rowCount = pStnmt.executeUpdate();
            if (rowCount >= 1) {
                return password;
            }
            pStnmt.close();
            cnnct.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            ex = ex.getNextException();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return null;
    }
}
