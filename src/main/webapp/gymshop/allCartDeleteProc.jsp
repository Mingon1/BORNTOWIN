<%@page import="gym.shop.mall.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String userid = request.getParameter("userid");
String pno = request.getParameter("pno");
System.out.println(userid);

CartDao cdao = CartDao.getInstance();
int cnt = cdao.deleteAllCartList(userid);

String url = "cartlist.jsp?pno=" + pno;
if (cnt <= 0) {
    response.sendRedirect(url);
}
%>
<script>
    location.href = "<%=url%>";
</script>