package dbControl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDAO {
    DBConnect dbconnect = null;
    String sql = "";

    public AdminDAO() {
        dbconnect = new DBConnect();
    }

    // 로그인기능 구현
    public int adminCheck(String admin_id, String password) throws Exception{
        Connection con = dbconnect.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String dbpassword = "";
        int x = -1;

        try {
            sql = "SELECT password from insta.admin WHERE admin_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, admin_id);
            rs = pstmt.executeQuery();

            if(rs.next()){
                dbpassword = rs.getString("password");
                if(dbpassword.equals(password))
                    x = 1; //인증성공
                else
                    x = 0; //인증실패
            }
            else
                x = -1; //일치하는 이메일 없음
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBClose.close(con, pstmt);
        }
        return x;
    }
    
    //email로 user_id가져오
    public int getAdmin_id(String admin_id)throws Exception{
        Connection con = dbconnect.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int user_id = 0;

        try{
            sql = "SELECT id from insta.admin WHERE admin_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, admin_id);
            rs = pstmt.executeQuery();

            if(rs.next()){
                user_id = rs.getInt("id");
            }else{
                user_id = 0;
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBClose.close(con, pstmt);
        }
        return user_id;
    }
    
    //e-mail 중복체크
    public int checkEmail(String email) {
        Connection con = dbconnect.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String recievedEmail = email;
        int checkNum = -1;

        try {
            sql = "SELECT * FROM insta.admin where admin_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, recievedEmail);
            rs = pstmt.executeQuery();

            if(rs.next()){
                checkNum = 1;   //중복이메일 존재
            }else{
                checkNum = 0;   //중복이메일 없음
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBClose.close(con, pstmt);
        }
        return checkNum;
    }
    
    public boolean isAdmin(int user_id) throws Exception{
        Connection con = dbconnect.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        boolean isAdmin = false;

        try{
            sql = "SELECT * FROM insta.admin WHERE id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, user_id);

            rs = pstmt.executeQuery();

            if (rs.next()){
                isAdmin = true;
            }else{
                isAdmin = false;
            }

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBClose.close(con, pstmt);
        }
        return isAdmin;
    }
}
