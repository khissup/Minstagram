<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dbControl.MemberDAO" %>
<%@ page import="dbControl.MemberDTO" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<style>
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #333;
  text-color: #ffffff;
}

li {
  float: left;
}

li a {
  display: block;
  text-color: #ffffff;
  color: #ffffff;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

/* Change the link color to #111 (black) on hover */
li a:hover {
  background-color: #111;
  text-color: #ffffff;
  text-decoration: none;
  color: #ffffff;
}


</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="css/custom.css">
<body>
<nav>
	<ul class="nav-container">
		<li class="nav-item"><a>Minstagram</a></li>
		<li class="nav-item"><a href="adminUserPage.jsp">회원정보</a></li>
		<li class="nav-item"><a href="#contact">좋아요</a></li>
		<li class="right"><a href="logout.jsp">로그아웃</a></li>
	</ul>
</nav>
</body>
</html>