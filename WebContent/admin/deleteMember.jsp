<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="dbControl.MemberDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    int adminId = Integer.parseInt(request.getParameter("admin_id"));
    int userId = Integer.parseInt(request.getParameter("user_id"));

    MemberDAO memberDao = new MemberDAO();
    int check = memberDao.deleteMember(userId);

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
    location.href='adminPage.jsp'
</script>
<%
    }
%>
%>
