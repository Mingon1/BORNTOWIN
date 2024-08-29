<%@page import="gym.admin.NoticeDao"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String uploadDir = config.getServletContext().getRealPath("/Notice");    
    MultipartRequest mr = null;
    mr = new MultipartRequest(request,
			uploadDir,
			1024*1024*10,
			"UTF-8"
			/* new DefaultFileRenamePolicy() */);
    
    String opimage = mr.getOriginalFileName("nimage");
   	String requestDir = request.getContextPath()+"/Notice";
   	requestDir = requestDir + "/" + opimage;
   	
   	%>
	<img src="<%=requestDir%>" width="100">
	<% 
	NoticeDao ndao = NoticeDao.getInstance();
	int cnt = ndao.insertNotice(mr);  
	
	String msg, url;
	if(cnt>0){
		msg = "공지사항이 등록 되었습니다";
		url = "NoticeForm.jsp";
	}else {
		msg = "공지사항 등록 실패";
		url = "NoticeForm.jsp";
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>
    