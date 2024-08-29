<%@page import="gym.shop.mall.CartDao"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--detail=>-->
    <%
    request.setCharacterEncoding("UTF-8");
    %>
    <jsp:useBean id="cb" class="gym.shop.mall.CartBean">
    <jsp:setProperty name="cb" property="*"/>
    </jsp:useBean>
    <%
    CartDao cdao = CartDao.getInstance();
    int cnt = cdao.insertCart(cb);
    String msg, url, url2;
	if(cnt>0){
		msg = "장바구니에 담았습니다";
		url = "detailproduct.jsp?pno="+cb.getPno();
		url2 = "cartlist.jsp?pno="+cb.getPno();
	}else {
	    msg = "이미 장바구니에 있는 상품입니다";
	    url = "detailproduct.jsp?pno="+cb.getPno();
	    url2 = "cartlist.jsp?pno="+cb.getPno();
	}
	%>
<script>
    alert("<%=msg%>");
    if (confirm("장바구니로 가시겠습니까?")) {
        location.href = "<%=url2%>";
    } else {
        location.href = "<%=url%>";
    }
</script>

