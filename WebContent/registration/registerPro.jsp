<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="dbControl.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    String userName = request.getParameter("nick");
    String email = (String)request.getParameter("email");
%>

<jsp:useBean id="dto" class="dbControl.MemberDTO" />
    <jsp:setProperty name="dto" property="*" />     <%--모든 값을 DTO에 집어넣음, 후에 Getter메소드로 호출가능--%>

<%
    MemberDAO memberDao = new MemberDAO();
	AdminDAO adminDao = new AdminDAO();//2019.11.29 강필수 수정

    if(memberDao.checkID(userName) == 1){
%>
<script>
    alert("<%=userName %> 은 이미 사용중인 Nick Name 입니다.");
    history.go(-1);
</script>

<%

    }else if((memberDao.checkEmail(email) == 1) || (adminDao.checkEmail(email) == 1)){//2019.11.29 강필수 수정
%>
<script>
    alert("<%=email%>은 사용불가능한 이메일입니다.");
    history.go(-1);
</script>
<%

    }else{
            memberDao.insertMember(dto);
%>

<script>
    alert("가입이 완료되었습니다.");
    location.href="${pageContext.request.contextPath}/index.jsp"
</script>
<%
    }
%>
}