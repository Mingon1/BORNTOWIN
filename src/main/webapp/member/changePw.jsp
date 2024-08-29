<%@page import="gym.user.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String passwd =request.getParameter("passwd");
String id =request.getParameter("id");

UserDao udao = UserDao.getInstance();
int cnt = udao.changePw(passwd, id);
String msg, url;
if (cnt >-1) {
    msg = "변경되었습니다";
    url = request.getContextPath()+"/gymshop/myPageForm.jsp";
    
} else {
	msg = "변경실패";
	url = request.getContextPath()+"/gymshop/myPageForm.jsp";
}
%>
<script>
alert("<%=msg%>");
</script>
<meta http-equiv="refresh" content="0; url=<%=url%>">
    