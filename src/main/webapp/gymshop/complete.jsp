<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="gym.shop.mall.OrderBean"%>
<%@page import="gym.shop.mall.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="prod_top.jsp"%>
<%
request.setCharacterEncoding("UTF-8");
String ono = request.getParameter("ono"); 
String cno = request.getParameter("cno"); 
String ouserid = request.getParameter("ouserid"); 

OrderDao odao = OrderDao.getInstance();
OrderBean ob = odao.getOrderByOno(ouserid, cno);

DecimalFormat df = new DecimalFormat("###,###");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

Date odate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ob.getOdate());

String sdfdate = sdf.format(odate);

%>

<div class="payment-completion">
  <h3>결제가 정상적으로 완료되었습니다.</h3>
  
  <div class="payment-details">
    <label>결제금액:</label> <%=df.format(ob.getAmount())%>원<br>
    <label>결제수단:</label> <%=ob.getPayment()%><br>
    <label>결제일시:</label> <%=sdfdate%><br>
    <label>주문번호:</label> <%=ob.getOno()%><br>
  </div>

  <div class="confirmation-link">
    <a href="<%=request.getContextPath()%>/main.jsp" class="btn btn-dark">확인</a>
  </div>
</div>



<%@include file="prod_bottom.jsp"%>