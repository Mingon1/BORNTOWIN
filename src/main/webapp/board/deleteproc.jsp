<%@page import="board2.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	BoardDao bdao = BoardDao.getInstance();
	String bno = request.getParameter("bno");
	String pageNum = request.getParameter("pageNum");
	int pn = Integer.parseInt(pageNum);
	
	
	int cnt = bdao.deleteBoard(bno);
	System.out.println(bno+","+pageNum);
	
	int pageSize=5;
	int count = bdao.getArticleCount();
	int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);

	String msg;
    String url;
    if(cnt > 0){
		msg = "삭제 성공";
		if(pageCount < pn){//8<9
			pn = pageCount;
		}
		url = "board.jsp?pageNum="+pn;
	}else{
		msg = "삭제 오류";
		url = "content.jsp?bno=" + bno +"&pageNum="+pageNum;
	}
	
%>
<script>
    alert("<%=msg%>");
</script>
<meta http-equiv="refresh" content="0 url=<%=url%>">