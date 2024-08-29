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
    
    String opimage = mr.getOriginalFileName("pimage");
   	String requestDir = request.getContextPath()+"/clothes";
   	requestDir = requestDir + "/" + opimage;
   	//Timestamp ts = new Timestamp(System.currentTimeMillis());
   	//System.out.println(ts.toString());
   	BoardBean bb = new BoardBean();
   	bb.setPimage(opimage);
   	//bb.setReg_date(ts.toString());
   	
   	%>
	<img src="<%=requestDir%>" width="100">
	<% 
	BoardDao bdao = BoardDao.getInstance();
	int cnt = bdao.insertBoard(mr,bb);  
	
	String msg, url;
	if(cnt>0){
		msg = "게시글이 등록 되었습니다";
		url = "board.jsp";
	}else {
		msg = "게시글 등록 실패";
		url = "writeForm.jsp";
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>
