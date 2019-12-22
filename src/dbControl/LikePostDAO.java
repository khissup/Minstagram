package dbControl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LikePostDAO {
    DBConnect dbConnect = null;
    String sql = "";

    public LikePostDAO(){ dbConnect = new DBConnect();}

    // 게시글 좋아요 기능 구현
    public int like_post(int user_id,int post_id) throws Exception{
        Connection con = dbConnect.getConnection();
        PreparedStatement pstmt = null;

        int check = -1;

        try{
            sql="INSERT INTO insta.like_post(user_id, post_id) VALUES(?,?)";
            pstmt = con.prepareStatement(sql);

            pstmt.setInt(1, user_id);
            pstmt.setInt(2, post_id);
            pstmt.executeUpdate();

            check = 1;

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBClose.close(con, pstmt);
        }
        return check;
    }

    // 게시글 좋아요 취소기능 구현
    public int unlike_post(int user_id, int post_id) throws Exception{
        Connection con = dbConnect.getConnection();
        PreparedStatement pstmt = null;

        int check = -1;

        try{
            sql = "DELETE FROM insta.like_post WHERE user_id = ? AND post_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, user_id);
            pstmt.setInt(2, post_id);
            pstmt.executeUpdate();

            check = 1;
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBClose.close(con, pstmt);
        }
        return check;
    }

    // 게시글 좋아요 했는지 확인
    public boolean isLikingPost(int user_id, int post_id) throws Exception{
        Connection con = dbConnect.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        boolean isLikingPost = false;

        try{
            sql = "SELECT * FROM insta.like_post WHERE user_id = ? AND post_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, user_id);
            pstmt.setInt(2, post_id);

            rs = pstmt.executeQuery();

            if (rs.next()){
            	isLikingPost = true;
            }else{
            	isLikingPost = false;
            }

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            DBClose.close(con, pstmt);
        }
        return isLikingPost;
    }
    
 // 게시글에 눌린 좋아요가 몇명인지 얻어오기
    public int getlike_postCount(int post_id) throws Exception{
        ResultSet rs = null;
        Connection con = dbConnect.getConnection();
        PreparedStatement pstmt = null;
        int count = 0;

        try{
            // 현재 세션에 접속된 유저의 포스트 개수를 select한다
            sql="SELECT count(?) from insta.like_post WHERE post_id= ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, post_id);
            pstmt.setInt(2, post_id);
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
