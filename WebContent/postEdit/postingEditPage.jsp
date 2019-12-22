<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%  //로그인 체크
    if(session.getAttribute("memId")==null){
%>
<jsp:forward page="${pageContext.request.contextPath}/login/loginPage.jsp" />
<%
    }
%>
<%
    request.setCharacterEncoding("UTF-8");

    String filepath = request.getParameter("filepath");
%>
<html>
<head>
    <title>Minstagram</title>
    <link href="${pageContext.request.contextPath}/assets/css/css_main.css" rel="stylesheet" type="text/css">
    <meta charset="utf-8">
</head>
<body>
<jsp:include page="../mainMenu.jsp" flush="false"></jsp:include>
<div class="content-area">
    <div class="upload-box">
        <p>
            포스팅 편집
        </p>
        <hr>
        <p>
            <img src="${pageContext.request.contextPath}<%=filepath %>" class="uploading-image">
        </p>
        <form action="${pageContext.request.contextPath}/postEdit/postingUploadPro.jsp" method="post">
            <p>
                <textarea placeholder="하고싶은 말을 입력해주세요" class="uploading-story" name="content"></textarea>
                <input type="hidden" value="<%= filepath%>" name="image">
                <input type="hidden" value="<%= session.getAttribute("memId")%>" name="userId">
            </p>
            <p>
                <input type="submit" value="작성" class="upload-button">
                <input type="button" value="취소" class="upload-button" onClick = "location.href = 'http://localhost:8080/webTest/index.jsp'">
            </p>
        </form>
    </div>
</div>
</body>
</html>