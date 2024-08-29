<%@page import="gym.user.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    request.setCharacterEncoding("UTF-8");
                String userid = request.getParameter("userid");

                UserDao udao = UserDao.getInstance();
                boolean flag = udao.searchId(userid);
                
                String str="";
                if(flag){ // true
                	str ="No";
                	out.print(str);
                }else{
                	str="Yes";
                	out.print(str);
                }
    %>
    
    