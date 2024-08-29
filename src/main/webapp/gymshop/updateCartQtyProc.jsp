<%@page import="gym.shop.mall.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String userid = request.getParameter("userid");
String pno = request.getParameter("pno");
String cno = request.getParameter("cno");
String cqty = request.getParameter("cqty");
System.out.println("넘어온cqty:"+cqty);

CartDao cdao = CartDao.getInstance();
int cnt = cdao.updateCartCqty(cqty, cno, userid);

String url;
if(cnt>0){
    url = "cartlist.jsp?pno="+pno+"&cqty="+cqty;
}else {
    url = "cartlist.jsp?pno="+pno;
}
response.sendRedirect(url);
%>