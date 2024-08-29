<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    	session.invalidate();
    	String viewPage = request.getContextPath()+"/main.jsp";
    	response.sendRedirect(viewPage);
    %>