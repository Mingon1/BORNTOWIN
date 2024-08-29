<%@page import="board2.CommentsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String bno = request.getParameter("bno");
String pageNum = request.getParameter("pageNum");
String cowriter = request.getParameter("cowriter");
String cocontent = request.getParameter("cocontent");

CommentsDao cdao = CommentsDao.getInstance();
int cnt = cdao.insertComments(cowriter, cocontent, bno);

if(cnt>0){
	response.sendRedirect("content.jsp?bno=" + bno + "&pageNum=" +pageNum);
} else {
	response.sendRedirect("content.jsp?bno="+bno + "&pageNum=" +pageNum);
}
%>