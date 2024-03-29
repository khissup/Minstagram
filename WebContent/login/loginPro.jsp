<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="dbControl.MemberDAO" %>
<%@ page import="dbControl.AdminDAO" %>

<%
    // 한글 처리를 위해 받아온 값의 인코딩을 UTF로 해준다(모든 페이지에서 동일)
    request.setCharacterEncoding("UTF-8");

    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // 회원 테이블에 접근하여 값을 가져오는 MemberDAO의 인스턴스를 memberDao라는 이름으로 생성함
    MemberDAO memberDao = new MemberDAO();
    AdminDAO adminDao = new AdminDAO();//2019.11.29 강필수 수정
    // memberDao는 인증 여부를 int로 알려준다.(1 - 성공 / 0 - 실패 / -1 -에러)
    int check = memberDao.userCheck(email, password);
 	// adminDao는 인증 여부를 int로 알려준다.(1 - 성공 / 0 - 실패 / -1 -에러)
    int adm_check = adminDao.adminCheck(email, password);//2019.11.29 강필수 수정

    if(check==1){
        //인증성공하면 유저의 이메일을 memId라는 이름의 세션으로 지정한다. 앞으로 이 세션으로 로그인 인증을 하게 됨
        session.setAttribute("memId", memberDao.getUser_id(email));
%>
        <script>
            // 인증에 성공하면 인덱스 페이지로 이동
        	location.href="${pageContext.request.contextPath}/index.jsp";
        </script>
<%
    }else if(check==0){
        //비밀번호 불일치
%>
        <script>
            alert("비밀번호가 맞지 않습니다.");
            history.go(-1);
        </script>
<%
    }else if(adm_check==1){//2019.11.29 강필수 수정
    	//인증성공하면 관리자를 adminId라는 이름의 세션으로 지정한다. 앞으로 이 세션으로 로그인 인증을 하게 됨
    	session.setAttribute("adminId", adminDao.getAdmin_id(email));
%>
        <script>
    		// 인증에 성공하면 관리자 페이지로 이동
    	    location.href="${pageContext.request.contextPath}/admin/adminUserPage.jsp";
    	</script>
<%
    }else if(adm_check==0){//2019.11.29 강필수 수정
    	//비밀번호 불일치여도 존재하지 않는다고 표시
%>
        <script>
            alert("관리자_존재하지 않는 계정입니다.");
            history.go(-1);
        </script>
<%
    }else {
%>
        <script>
            alert("존재하지 않는 계정입니다.");
            history.go(-1);
        </script>
<%
    }
%>