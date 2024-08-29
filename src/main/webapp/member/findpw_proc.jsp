<%@page import="gym.user.UserBean"%>
<%@page import="gym.user.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    request.setCharacterEncoding("UTF-8");
                            
                            String name = request.getParameter("name");
                            String id = request.getParameter("id");
                            
                            UserDao udao = UserDao.getInstance();
                           	UserBean ub = udao.findPw(name, id);
                           	
                           	String msg, url;
                            if (ub == null) {
                                msg = "없는 회원";
                                url = "findpw.jsp";
                                
                            } else {
                            	msg = "비밀번호는"+ub.getPasswd()+"입니다.";
                            	url = "../login.jsp";
                            }
    %>
    <script>
        alert("<%=msg%>");
    </script>
    <meta http-equiv="refresh" content="0; url=<%=url%>">
   