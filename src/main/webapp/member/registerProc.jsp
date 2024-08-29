<%@page import="gym.user.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    request.setCharacterEncoding("UTF-8");
    %>
    <jsp:useBean id="ub" class="gym.user.UserBean">
    <jsp:setProperty name="ub" property="*"/>
    </jsp:useBean>
    <%
    UserDao udao = UserDao.getInstance();
                int cnt = udao.InsertUser(ub);
                
            	String msg, url;
                if (cnt >0) {
                    msg = "회원가입되었습니다";
                    url = "../main.jsp";
                    
                } else {
                	msg = "회원가입실패";
                	url = "register.jsp";
                }
    %>
    <script>
        alert("<%=msg%>");
    </script>
    <meta http-equiv="refresh" content="0; url=<%=url%>">
   