<%@page import="gym.user.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String id =request.getParameter("id");

UserDao udao = UserDao.getInstance();
int cnt = udao.deleteAccount(id);
String msg, url;
if (cnt >-1) {
    msg = "삭제되었습니다";
    session.invalidate();
    url = request.getContextPath()+"/main.jsp";
    
} else {
	msg = "삭제실패";
	url = request.getContextPath()+"/gymshop/myPageForm.jsp";
}
%>
<script>
alert("<%=msg%>");
</script>
<meta http-equiv="refresh" content="0; url=<%=url%>">
