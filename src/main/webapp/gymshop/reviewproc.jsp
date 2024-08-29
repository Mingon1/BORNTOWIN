<%@page import="board2.ReviewDao"%>
<%@page import="board2.ReviewBean"%>
<%@page import="board2.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board2.BoardDao"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String uploadDir = config.getServletContext().getRealPath("/clothes");    
    MultipartRequest mr = null;
    mr = new MultipartRequest(request,
			uploadDir,
			1024*1024*10,
			"UTF-8"
			/* new DefaultFileRenamePolicy() */);
    
    String opimage = mr.getOriginalFileName("rimage");
   	String requestDir = request.getContextPath()+"/clothes";
   	requestDir = requestDir + "/" + opimage;
   	
   	%>
	<img src="<%=requestDir%>" width="100">
	<% 
	System.out.println("리뷰프로시"+mr.getParameter("pno"));
	ReviewDao rdao = ReviewDao.getInstance();
	int cnt = rdao.insertReview(mr);  
	
	String msg, url;
	if(cnt>0){
		msg = "후기가 등록 되었습니다";
		url = "myPageForm.jsp?pno="+mr.getParameter("pno");
	}else {
		msg = "후기 등록 실패";
		url = "reviewForm.jsp?pno="+mr.getParameter("pno");
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>
