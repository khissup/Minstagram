<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="dbControl.PostDAO" %>
<%@ page import="dbControl.PostDTO" %>
<%@ page import="dbControl.MemberDAO" %>
<%@ page import="dbControl.CommentDAO" %>
<%@ page import="dbControl.CommentDTO" %>
<%@ page import="dbControl.LikePostDAO" %>
<%@ page import="java.util.List" %>

<%  //로그인 체크
    if(session.getAttribute("memId")==null){
%>
<jsp:forward page="${pageContext.request.contextPath}/login/loginPage.jsp" />
<%
    }else if(request.getParameter("post_id")==null || request.getParameter("post_id") == ""){
%>
<script>
    alert("잘못된 방식의 접근입니다.");
    history.go(-1);
</script>
%>

<%
    }else{
        request.setCharacterEncoding("UTF-8");
        int postId = Integer.parseInt(request.getParameter("post_id"));
        int memId = (Integer)session.getAttribute("memId");
%>

<html>
<head>
    <title>Post View</title>
    <link href="${pageContext.request.contextPath}/assets/css/css_main.css" rel="stylesheet" type="text/css">
    <meta charset="utf-8">
</head>
<body>
<jsp:include page="mainMenu.jsp" flush="false"></jsp:include>
<%
        PostDAO postDao = new PostDAO();
        PostDTO post = new PostDTO();
        MemberDAO memDao = new MemberDAO();
        
        LikePostDAO likePostDao = new LikePostDAO();
        boolean isLiking = likePostDao.isLikingPost(memId, postId);

        post = postDao.getSinglePost(postId);

        int userId = post.getUser_id();
        String postImg = post.getImage();
        int like_postCount = likePostDao.getlike_postCount(post.getId());
        int cntLike = post.getCnt_like();
        String content = post.getContent();
        boolean myPost = userId == memId;

        List<CommentDTO> commentList = null;
        CommentDAO commentDAO = new CommentDAO();
        commentList = commentDAO.getList(post.getId());
%>
<div class="content-area">
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
        
        
        
        <div class="single-post-contents">
        <div class="post-content">
        <%
            	if(isLiking == true) {	//	이미 좋아요 누른 게시글일 경우
            %>
            <a href="${pageContext.request.contextPath}/likePost/unlikePost_3.jsp?user_id=<%=memId%>&post_id=<%=postId%>">
          		<img src="${pageContext.request.contextPath}/assets/icons/like5.png" class="unlikePost-button">
            </a>
            <%
            	}else if(isLiking == false){	//	좋아요 누르지 않은 게시글일 경우
            %>
            <a href="${pageContext.request.contextPath}/likePost/likePost_3.jsp?user_id=<%=memId%>&post_id=<%=postId%>">
          		<img src="${pageContext.request.contextPath}/assets/icons/like6.png" class="likePost-button">
            </a>
            <%
            	}
            %>
        
            <div class="like_hate_report">
            
            
    
        </div>
            
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
    </div>
<%
        if(myPost == true){
%>
    <div class="delete-button-div">
        <button class="post-delete-button" onclick="location.href='${pageContext.request.contextPath}/postEdit/deletePost.jsp?post_id=<%=postId%>'">
            삭제
        </button>
    </div>
<%
        }
%>

</div>
</body>
</html>
<%
    }
%>