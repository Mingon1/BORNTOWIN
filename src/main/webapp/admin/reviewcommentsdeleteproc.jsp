<%@page import="gym.admin.ReviewCommentsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String rno = request.getParameter("rno");
String pageNum = request.getParameter("pageNum");
String rvno = request.getParameter("rvno");

ReviewCommentsDao rvdao = ReviewCommentsDao.getInstance();
int cnt = rvdao.deletecomments(rvno);

if(cnt>0){
	response.sendRedirect("ReviewContent.jsp?rno=" + rno + "&pageNum=" +pageNum);
} else {
	response.sendRedirect("ReviewContent.jsp?rno="+rno + "&pageNum=" +pageNum);
}
%>