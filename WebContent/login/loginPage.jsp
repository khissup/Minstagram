<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Minstagram</title>
    <link href="${pageContext.request.contextPath}/assets/css/css_main.css" rel="stylesheet" type="text/css">
    <meta charset="utf-8">
</head>
<body>
<div class="content-area">
    <div class="login-box">
        <div class="login-greet">
            Welcome to PhotoBlog!
        </div>
        <div class="login-form">
        	<form action="${pageContext.request.contextPath}/login/loginPro.jsp" method="post">
                <input type="email" placeholder="E-mail" name="email" class="login-box-input login-placeholder"><br>
                <input type="password" placeholder="Password" name="password" class="login-box-input login-placeholder"><br><br>
                <input type="submit" value="로그인" class="login-button">
            </form>
        </div>
        <div class="regist-recommend">
            <p>
                아직 회원이 아니신가요?
            </p>
            <a href="${pageContext.request.contextPath}/registration/registerPage.jsp">회원가입</a>
        </div>
    </div>
</div>
</body>
</html>
