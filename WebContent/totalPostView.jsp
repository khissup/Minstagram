<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="dbControl.PostDAO" %>
<%@ page import="dbControl.PostDTO" %>
<%@ page import="dbControl.MemberDAO" %>
<%@ page import="dbControl.CommentDAO" %>
<%@ page import="dbControl.CommentDTO" %>
<%@ page import="dbControl.LikePostDAO" %>
<%@ page import="java.util.*" %>

<%  //로그인 체크
    if(session.getAttribute("memId") ==null){
%>
<jsp:forward page="${pageContext.request.contextPath}/login/loginPage.jsp" />
<%
    }
%>
<html>
<head>
    <title>Minstagram</title>
    <link href="assets/css/css_main.css" rel="stylesheet" type="text/css">
    <meta charset="utf-8">
    <script>

    </script>
</head>
<body>

<jsp:include page="mainMenu.jsp" flush="false"></jsp:include>
<%
    List<PostDTO> postList = null;
    PostDAO postDao = new PostDAO();
    postList = postDao.getTotalList();
    LikePostDAO likePostDao = new LikePostDAO();
    HashMap<Integer, Boolean>like_post=new HashMap(); // 해쉬맵으로 각 게시글별로 좋아요 클릭여부 판단
    MemberDAO memDao = new MemberDAO();
    int memId = (Integer)session.getAttribute("memId");
%>
<div class="content-area">

    <%
        for(int i=0; i<postList.size(); i++){
            PostDTO post = postList.get(i);

            List<CommentDTO> commentList = null;
            CommentDAO commentDAO = new CommentDAO();
            commentList = commentDAO.getList(post.getId());
            int like_postCount = likePostDao.getlike_postCount(post.getId());

            int userId = post.getUser_id();
            String postImg = post.getImage();
            int cntLike = post.getCnt_like();
            String content = post.getContent();
            int postId = post.getId();
            boolean isLiking = likePostDao.isLikingPost(memId, postId);
            like_post.put(memId, isLiking);
    %>
    <div class="post-box">
        <p class="post-top">
            <img src="${pageContext.request.contextPath}<%=memDao.getProfileImg(userId) %>" class="post-profile-img">
            <span class="post-top-name">
                  <a href="${pageContext.request.contextPath}/profile/profilePage.jsp?user_id=<%= userId%>">
                      <%=memDao.getUsername(userId) %>
                  </a>
              </span>
        </p>
        <p>
            <img src="${pageContext.request.contextPath}<%= postImg%>" class="post-img">
        </p>
        
        	
        <div class="post-content">
        <%
            	if(isLiking == true) {	//	이미 좋아요 누른 게시글일 경우
            %>
            <a href="${pageContext.request.contextPath}/likePost/unlikePost_2.jsp?user_id=<%=memId%>&post_id=<%=postId%>">
          		<img src="${pageContext.request.contextPath}/assets/icons/like5.png" class="unlikePost-button">
            </a>
            <%
            	}else if(isLiking == false){	//	좋아요 누르지 않은 게시글일 경우
            %>
            <a href="${pageContext.request.contextPath}/likePost/likePost_2.jsp?user_id=<%=memId%>&post_id=<%=postId%>">
          		<img src="${pageContext.request.contextPath}/assets/icons/like6.png" class="likePost-button">
            </a>
            <%
            	}
            %>
 
            <p class="post-like">
                좋아요 <%=like_postCount %>개
            </p>
            <p class="post-story">
                <b><a href="${pageContext.request.contextPath}/profile/profilePage.jsp?user_id=<%= userId%>">
                    <%=memDao.getUsername(userId) %></a></b> <%=content.replace("\r\n","<br>") %>
                </a>
            </p>
            <p class="post-comment">
                <%
                    for(int j=0; j<commentList.size(); j++){
                        CommentDTO comment = commentList.get(j);
                %>
                <b><a href="${pageContext.request.contextPath}/profile/profilePage.jsp?user_id=<%=comment.getUser_id()%>">
                    <%=memDao.getUsername(comment.getUser_id()) %></b></a> <%=comment.getContent() %>
                <br>
                <%
                    }
                %>
            </p>
            <hr>
            <div class="post-input">
                <img src="${pageContext.request.contextPath}/assets/icons/comment.png">
                <form action="commentPro.jsp" method="post">
                    <input type="text" placeholder="댓글 달기..." class="post-input-comment-box comment-placeholder" name="content">
                    <input type="hidden" name="post_id" value="<%=postId %>">
                    <input type="hidden" name="user_id" value="<%=session.getAttribute("memId")%>">
                </form>
            </div>
        </div>
    </div>
    <%
        }
    %>

</div>
</body>
</html>
