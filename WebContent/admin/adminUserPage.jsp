<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="dbControl.PostDAO" %>
<%@ page import="dbControl.PostDTO" %>
<%@ page import="dbControl.FollowDAO" %>
<%@ page import="dbControl.MemberDAO" %>
<%@ page import="dbControl.MemberDTO" %>
<%@ page import="dbControl.CommentDAO" %>
<%@ page import="dbControl.CommentDTO" %>
<%@ page import="java.util.*" %>

<%  //로그인 체크
    if(session.getAttribute("adminId") ==null){
%>
<jsp:forward page="../login/loginPage.jsp" />
<%
    }
%>
<html>
<head>
    <title>Photoblog</title>
    <link href="../assets/css/css_main.css" rel="stylesheet" type="text/css">
    <meta charset="utf-8">
    <script>
    
    </script>
</head>
<body>

<jsp:include page="adminMenu.jsp" flush="false"></jsp:include>
<br><br>
<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align:enter; border : 1px solid #dddddd;">
				<thead>
					<tr>
						
						<th style="background-color: #eeeeee; text-align:center;">이름</th>
						<th style="background-color: #eeeeee; text-align:center;">이메일</th>
						<th style="background-color: #eeeeee; text-align:center;">게시글수</th>
						<th style="background-color: #eeeeee; text-align:center;">팔로워수</th>
						<th style="background-color: #eeeeee; text-align:center;">팔로잉수</th>
						<th style="background-color: #eeeeee; text-align:center;">가입일</th>
						 
					</tr>
				</thead>
				<tbody>
				<%
					MemberDAO memberDAO = new MemberDAO();
					FollowDAO followDao = new FollowDAO();
					PostDAO postDao = new PostDAO();
					ArrayList<MemberDTO> list = memberDAO.getAllList();

					for(int  i = 0; i < list.size(); i++)
					{
						int id=list.get(i).getId();
						int postCount = postDao.getPostCount(id);
				        int followerCount = followDao.getFollowerCount(id);
				        int followingCount = followDao.getFollowingCount(id);
				%>
					<tr>
						
						
						<td style="text-align:center;"><%=list.get(i).getNick()%></td>
						<td style="text-align:center;"><%=list.get(i).getEmail()%></td>
						<td style="text-align:center;"><%=postCount%></td>
						<td style="text-align:center;"><%=followerCount%></td>
						<td style="text-align:center;"><%=followingCount%></td>
						<td style="text-align:center;"><%=list.get(i).getSign_up_date()%></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
		
		
		</div>
	</div>


</body>
</html>
