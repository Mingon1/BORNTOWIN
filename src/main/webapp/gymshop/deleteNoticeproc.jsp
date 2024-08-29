<%@page import="gym.admin.NoticeDao"%>
<%@page import="board2.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	NoticeDao ndao = NoticeDao.getInstance();
	String no = request.getParameter("no");
	
	
	int cnt = ndao.deleteNotice(no);
	

	String msg;
    String url;
    if(cnt > 0){
		msg = "삭제 성공";
		url = "notice.jsp";
	}else{
		msg = "삭제 오류";
		url = "noticeContent.jsp?no=" + no;
	}
	
%>
<script>
    alert("<%=msg%>");
</script>
<meta http-equiv="refresh" content="0 url=<%=url%>">