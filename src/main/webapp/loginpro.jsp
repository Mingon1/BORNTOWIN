<%@page import="gym.user.UserBean"%>
<%@page import="gym.user.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    request.setCharacterEncoding("UTF-8");
                            
                           	String id = request.getParameter("id");
                            String passwd = request.getParameter("passwd");
                            System.out.print(id);
                            UserDao udao = UserDao.getInstance();
                            UserBean ub = udao.login(id,passwd);
                            
                            String msg, url;
                            if(ub !=null){ //사용자 정보가 있을경우
                            	if(ub.getId().equals("admin")){
                            		msg="관리자 로그인";
                            		url="main.jsp";
                            		session.setAttribute("userid", id);
                            		session.setAttribute("userno", ub.getNo());
                            		session.setAttribute("username",ub.getName());
                            		System.out.println(ub.getName());
                            	}else{
                            		msg = "환영합니다";
                            		url="main.jsp";
                            		session.setAttribute("userid", id); // 입력한 id
                            		session.setAttribute("userno",ub.getNo()); // 
                            		session.setAttribute("username" , ub.getName()); // 
                            		System.out.println(ub.getName());
                           		 	}//if
                            	}else{
                            		msg = "아이디 또는 비밀번호가 일치하지 않습니다.";
                                    url = "main.jsp";
                            	}
    %>
    
<script>
    alert("<%=msg%>");
</script>
<meta http-equiv="refresh" content="0; url=<%=url%>">