<%@page import="board2.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	ReviewDao rdao = ReviewDao.getInstance();
	String rno = request.getParameter("rno");
	String rpasswd = request.getParameter("rpasswd");
	
	
	int cnt = rdao.deleteMyReview(rno,rpasswd);
	

	String msg;
    String url;
    if(cnt > 0){
		msg = "삭제 성공";
		url = "myPageForm.jsp";
	}else{
		msg = "삭제 오류";
		url = "mycontent.jsp?rno=" + rno;
	}
	
%>
<script>
    alert("<%=msg%>");
</script>
<meta http-equiv="refresh" content="0 url=<%=url%>">