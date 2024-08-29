<%@page import="gym.user.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="ub" class="gym.user.UserBean">
<jsp:setProperty name="ub" property="*"/>
</jsp:useBean>
<%
UserDao udao = UserDao.getInstance();
int cnt = udao.updateInfo(ub);
System.out.println("프로시아이디:"+ub.getId());

String msg, url;
if (cnt >-1) {
    msg = "수정되었습니다";
    url = request.getContextPath()+"/gymshop/myPageForm.jsp";
    
} else {
	msg = "수정실패";
	url = request.getContextPath()+"/gymshop/myPageForm.jsp";
}
%>
<script>
alert("<%=msg%>");
</script>
<meta http-equiv="refresh" content="0; url=<%=url%>">
