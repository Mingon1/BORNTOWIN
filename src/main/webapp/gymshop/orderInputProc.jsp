<%@page import="java.util.ArrayList"%>
<%@page import="gym.user.UserBean"%>
<%@page import="gym.user.UserDao"%>
<%@page import="gym.shop.mall.CartDao"%>
<%@page import="gym.shop.mall.OrderDao"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String pno =request.getParameter("pno");
String cno =request.getParameter("cno");
String ouserid =request.getParameter("ouserid");
String amount =request.getParameter("amount");
String totalreserves =request.getParameter("totalreserves");
%>
<jsp:useBean id="ob" class="gym.shop.mall.OrderBean">
<jsp:setProperty name="ob" property="*"/>
</jsp:useBean>
    <%
    System.out.println("인풋프로시"+ob.getOqty());
    ob.setOuserid(ouserid);
    OrderDao odao = OrderDao.getInstance();
    UserDao udao = UserDao.getInstance();
    
    
    int cnt = odao.insertOrder(ob);
    
    CartDao cdao = CartDao.getInstance();
    String msg, url;
	if(cnt>0){
		msg = "결제가 완료되었습니다.";
		cdao.deleteAllCartList(ouserid);
		udao.updateReserves(totalreserves, ouserid);
		url = "complete.jsp?ouserid="+ouserid+"&ono="+cnt+"&cno="+cno;
	}else {
	    msg = "결제 실패";
	    url = "cartlist.jsp?pno="+pno;
	}
	%>
<script>
    alert("<%=msg%>");
    location.href = "<%=url%>";
</script>
