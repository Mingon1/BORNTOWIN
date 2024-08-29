<%@page import="board2.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%


	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
%>

	<jsp:useBean id="bb" class="board2.BoardBean">
	<jsp:setProperty name="bb" property="*"/>
	</jsp:useBean>
	
<%
	
	BoardDao bdao = BoardDao.getInstance();
	int cnt = bdao.replyArticle(bb);
	
	String msg;
    String url;
    if(cnt>0){
    	msg = "답글이 등록되었습니다.";
    	url="board.jsp?pageNum="+pageNum;
    }else{
    	msg = "답글 등록에 실패했습니다.";
    	url="replyForm.jsp?ref="+bb.getRef()+"&re_step="+bb.getRe_step()+"&re_level="+bb.getRe_level();
    }
    %>
    <script>
    	alert("<%=msg%>");
    </script>
    <meta http-equiv="refresh" content="0 url=<%=url%>">

