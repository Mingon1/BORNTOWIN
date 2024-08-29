<%@page import="java.io.File"%>
<%@page import="gym.admin.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 	<%
request.setCharacterEncoding("UTF-8");
String [] sc = request.getParameterValues("rowcheck");
String pimage = request.getParameter("pimage"); // 이미지 파일명을 받아옴
System.out.println("상품삭제"+sc+","+pimage);

ProductDao pdao = ProductDao.getInstance();
int cnt = pdao.selectDelete(sc);
String configFolder = config.getServletContext().getRealPath("/clothes");
File file = new File(configFolder+"/"+pimage);
if(file.exists()) {
    if(file.delete()){
    }
}

String msg, url;
if(cnt > 0) {
    msg = "삭제성공";
    url = "product.jsp";
} else {
    msg = "삭제실패";
    url = "product.jsp";
}
%>
<script>
    alert("<%=msg%>");
</script>
<meta http-equiv="refresh" content="0;url=<%=url%>">
