package dbControl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FollowDAO {
    DBConnect dbConnect = null;
    String sql = "";

    public FollowDAO(){ dbConnect = new DBConnect();}

    //팔로우 기능 구현
    public int follow(int user_id,int following_id) throws Exception{
        Connection con = dbConnect.getConnection();
        PreparedStatement pstmt = null;

        int check = -1;

        try{
            sql="INSERT INTO insta.follow(user_id, following_id) VALUES(?,?)";
            pstmt = con.prepareStatement(sql);

            pstmt.setInt(1, user_id);
            pstmt.setInt(2, following_id);
            pstmt.executeUpdate();

            check = 1;

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBClose.close(con, pstmt);
        }
        return check;
    }

    //언팔로우 기능 구현
    public int unfollow(int user_id, int following_id) throws Exception{
        Connection con = dbConnect.getConnection();
        PreparedStatement pstmt = null;

        int check = -1;

        try{
            sql = "DELETE FROM insta.follow WHERE user_id = ? AND following_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, user_id);
            pstmt.setInt(2, following_id);
            pstmt.executeUpdate();

            check = 1;
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBClose.close(con, pstmt);
        }
        return check;
    }

    //팔로잉 여부 확인 기능 구현
    public boolean isFollwing(int user_id, int following_id) throws Exception{
        Connection con = dbConnect.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        boolean isFollowing = false;

        try{
            sql = "SELECT * FROM insta.follow WHERE user_id = ? AND following_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, user_id);
            pstmt.setInt(2, following_id);

            rs = pstmt.executeQuery();

            if (rs.next()){
                isFollowing = true;
            }else{
                isFollowing = false;
            }

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBClose.close(con, pstmt);
        }
        return isFollowing;
    }
    
 // 팔로워 몇명인지 얻어오기
    public int getFollowerCount(int following_id) throws Exception{
        ResultSet rs = null;
        Connection con = dbConnect.getConnection();
        PreparedStatement pstmt = null;
        int count = 0;

        try{
            // 현재 세션에 접속된 유저의 포스트 개수를 select한다
            sql="SELECT count(?) from insta.follow WHERE following_id= ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, following_id);
            pstmt.setInt(2, following_id);
            rs = pstmt.executeQuery();

            while(rs.next()){
                // 불러온 포스팅의 내용부분을 새로 바꿔주는 부분
                count = rs.getInt(1);
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBClose.close(con, pstmt);
        }
        return count;
    }
    // 팔로우 몇명인지 얻어오기
    public int getFollowingCount(int user_id) throws Exception{
        ResultSet rs = null;
        Connection con = dbConnect.getConnection();
        PreparedStatement pstmt = null;
        int count = 0;

        try{
            // 현재 세션에 접속된 유저의 포스트 개수를 select한다
            sql="SELECT count(?) from insta.follow WHERE user_id= ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, user_id);
            pstmt.setInt(2, user_id);
            rs = pstmt.executeQuery();

            while(rs.next()){
                // 불러온 포스팅의 내용부분을 새로 바꿔주는 부분
                count = rs.getInt(1);
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBClose.close(con, pstmt);
        }
        return count;
    }
    
}
