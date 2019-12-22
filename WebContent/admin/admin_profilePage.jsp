<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="dbControl.PostDAO" %>
<%@ page import="dbControl.PostDTO" %>
<%@ page import="dbControl.MemberDAO" %>
<%@ page import="dbControl.FollowDAO" %>
<%@ page import="dbControl.AdminDAO" %>
<%@ page import="java.util.List" %>
<%
    request.setCharacterEncoding("UTF-8");
    //로그인 체크
    if(session.getAttribute("adminId")==null){
%>
<jsp:forward page="/login/loginPage.jsp" />
<%
    }else{
    	int Id = (Integer)session.getAttribute("adminId");
        int adminId = -1;
        if(session.getAttribute("adminId") != null)
        	adminId = (Integer)session.getAttribute("adminId");
        int requestedUserId = Integer.parseInt(request.getParameter("user_id"));

        MemberDAO memDao = new MemberDAO();
        FollowDAO followDao = new FollowDAO();
        AdminDAO adminDao = new AdminDAO();
        PostDAO postDao = new PostDAO();
        
        int postCount = postDao.getPostCount(requestedUserId);
        int followerCount = followDao.getFollowerCount(requestedUserId);
        int followingCount = followDao.getFollowingCount(requestedUserId);

        //팔로우중인지 확인

        boolean isAdmin = false;
        if(adminId != -1)
        	isAdmin = adminDao.isAdmin(adminId);
%>

<html>
<head>
    <title>Profile</title>
    <link href="${pageContext.request.contextPath}/assets/css/css_main.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/assets/js/main_js.js" type=text/javascript></script>
    <meta charset="utf-8">
</head>
<body>
<jsp:include page="../mainMenu.jsp" flush="false"></jsp:include>
<div class="content-area">


    <div class="profile-contents">
        <div class="profile-header">
            <div class="profile-header-image">
                <img class="profile-image" src="${pageContext.request.contextPath}<%=memDao.getProfileImg(requestedUserId) %>">
            </div>
            <div class="profile-header-contents">
                <div class="profile-header-nick">
                    <h1><%= memDao.getUsername(requestedUserId)%></h1>
                    <h4><%= memDao.getUsercreate(requestedUserId)%></h4>
                    <span class="follow-button-span">
					<button class="mdelete-button" onclick="location.href='deleteMember.jsp?admin_id=<%=Id%>&user_id=<%=requestedUserId%>'">
                                삭제
                    </button>
                    </span>
                </div>
                
                <div class="profile-stat">
                    <span>게시물 <%=postCount %>개</span>
                    <span>팔로워 <%=followerCount %>명</span>
                    <span>팔로잉 <%=followingCount %>명</span>
                </div>
                <div class="profile-comment">
                    <%= memDao.getProfileComment(requestedUserId) %>
                </div>
            </div>
        </div>

<%
        List<PostDTO> postList = null;
        postList = postDao.getList(requestedUserId);

%>

        <div class="profile-posts">
<%
        for(int i=0; i<postList.size(); i+=3){
%>
            <div class="profile-posts-row">
<%
            for(int j = i; j < i+3; j++){
                if(j<postList.size()){
                    PostDTO post = postList.get(j);

                    int userId = post.getUser_id();
                    String postImg = post.getImage();
                    int postId = post.getId();
%>
                <div class="profile-post">
                    <a href="${pageContext.request.contextPath}/singlePostView.jsp?post_id=<%=postId %>">
                        <img src="${pageContext.request.contextPath}<%=postImg%>">
                    </a>
                </div>
<%
                }
            }
%>
            </div>
<%
        }
%>
        </div>
    </div>


</div>
</body>
</html>
<%
    }
%>
