<%@page import="board2.CommentsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String bno = request.getParameter("bno");
String pageNum = request.getParameter("pageNum");
String cono = request.getParameter("cono");

CommentsDao cdao = CommentsDao.getInstance();
int cnt = cdao.deletecomments(cono);

if(cnt>0){
	response.sendRedirect("content.jsp?bno=" + bno + "&pageNum=" +pageNum);
} else {
	response.sendRedirect("content.jsp?bno="+bno + "&pageNum=" +pageNum);
}
%>