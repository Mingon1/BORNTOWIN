<%@page import="gym.shop.mall.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String [] rc = request.getParameterValues("rowcheck");
String userid = request.getParameter("userid");
String pno = request.getParameter("pno");
System.out.println("selectCartdel:"+userid+"pno:"+pno+","+rc);

CartDao cdao = CartDao.getInstance();
int cnt = cdao.selectDeleteCartList(rc, userid);

String url = "cartlist.jsp?pno=" + pno;
if (cnt <= 0) {
    response.sendRedirect(url);
}
%>
<script>
    location.href = "<%=url%>";
</script>