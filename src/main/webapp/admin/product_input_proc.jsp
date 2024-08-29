<%@page import="gym.admin.ProductDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
	String uploadDir = config.getServletContext().getRealPath("/clothes");    
    MultipartRequest mr = null;
    mr = new MultipartRequest(request,
			uploadDir,
			1024*1024*10,
			"UTF-8"
			/* new DefaultFileRenamePolicy() */);
    
    String opimage = mr.getOriginalFileName("pimage");
	String requestDir = request.getContextPath()+"/clothes";
	requestDir = requestDir + "/" + opimage;
	System.out.println(requestDir);
	
	//System.out.println("적립금"+Integer.parseInt(mr.getParameter("reserves")));
	%>
	<img src="<%=requestDir%>" width="100">
	<% 
	String [] sarr = mr.getParameterValues("psize");
	String psize=" ";
    for(int i =0; i<sarr.length; i++){
    	psize += sarr[i]+ " ";
    }
    
	ProductDao pdao = ProductDao.getInstance();
	int cnt = pdao.insertProduct(mr, psize);  
	String str, url;
	if(cnt>0){
		str = "상품 등록 성공";
		url = "product.jsp";
	}else {
		str = "상품 등록 실패";
		url = "product.jsp";
	}
%>
<script>
	alert("<%=str%>");
	location.href = "<%=url%>";
</script>

