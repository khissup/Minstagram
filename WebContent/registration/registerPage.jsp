<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Minstagram</title>
    <link href="${pageContext.request.contextPath}/assets/css/css_main.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/assets/js/main_js.js" type=text/javascript></script>
    <meta charset="utf-8">
</head>
<body>
<div class="content-area">
    <div class="register-box">
        <h1>회원가입</h1>
        <p>Minstagram에 오신것을 환영합니다. 간단한 절차를 통해 회원가입 하셔서 서비스를 이용해보세요.</p>
        <hr>
        <form action="${pageContext.request.contextPath}/registration/registerPro.jsp" method="post" onsubmit="return registerFormCheck();">
            <br>
            <p>
                <label for="nick">Nick Name </label><br>
                <input type="text" name="nick" placeholder="Your Nickname" id="nick">
            </p>
            <p>
                <label for="email">Email </label><br>
                <input type="email" name="email" placeholder="example@gmail.com" id="email">
            </p>
            <p>
                <label for="password">Password </label><br>
                <input type="password" name="password" placeholder="********" id="password">
            </p>
            <br>
            <p>
                &nbsp;<input type="submit" id="register-button" value="제출">&nbsp;
                <input type="button" id="register-button" value="취소" onClick = "location.href='http://localhost:8080/webTest/logout.jsp'">
            </p>
        </form>

    </div>
</div>
</body>
</html>
