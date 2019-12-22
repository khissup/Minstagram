<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="dbControl.LikePostDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    int userId = Integer.parseInt(request.getParameter("user_id"));
    int postId = Integer.parseInt(request.getParameter("post_id"));

    LikePostDAO likePostDAO = new LikePostDAO();
    int check = likePostDAO.unlike_post(userId, postId);

    if (check == -1){
%>
<script>
    alert("오류가 발생하였습니다.");
    history.go(-1)
</script>
<%
    }else{
%>
<script>
	location.href='${pageContext.request.contextPath}/singlePostView.jsp?post_id=<%=postId %>'
</script>
<%
    }
%>
