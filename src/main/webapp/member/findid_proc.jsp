<%@page import="gym.user.UserBean"%>
<%@page import="gym.user.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <%
        request.setCharacterEncoding("UTF-8");
                                                    
                                                    String name = request.getParameter("name");
                                                    String phone1 = request.getParameter("phone1");
                                                    String phone2 = request.getParameter("phone2");
                                                    String phone3 =request.getParameter("phone3");
                                                    System.out.println("이름:"+name+"폰1:"+phone1);
                                                    UserDao udao = UserDao.getInstance();
                                                    UserBean ub = udao.fifndId(name , phone1 ,phone2 ,phone3);
                                                    
                                                    String msg, url;
                                                    if (ub == null) {
                                                        msg = "없는 회원";
                                                        url = "findid.jsp";
                                                        
                                                    } else {
                                                    	msg = "아이디는"+ub.getId()+"입니다.";
                                                    	url = "../login.jsp";
                                                    }
        %>
    <script>
        alert("<%=msg%>");
    </script>
    <meta http-equiv="refresh" content="0; url=<%=url%>">

    