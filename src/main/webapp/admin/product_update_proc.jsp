<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="gym.admin.ProductDao"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
		ProductDao pdao = ProductDao.getInstance();
	  	
	    String configDir = config.getServletContext().getRealPath("/clothes");
	    int maxSize = 1024*1024*5;
	    String encoding = "UTF-8";
	    MultipartRequest mr = new MultipartRequest(request,configDir,maxSize,encoding);
	   /* 	
	    기존이미지O, 새이미지O => 기존이미지 폴더에서 삭제, 새이미지 업로드
	    기존이미지X, 새이미지O => 새이미지 업로드
	    기존이미지O, 새이미지X => 기존이미지 그대로 사용
	    기존이미지X, 새이미지X => X
	     */
	    String ornimg = mr.getParameter("pimage2"); // 기존
	    String pimage = mr.getFilesystemName("pimage"); // 새
	    String img  = null;
	    String configFolder = config.getServletContext().getRealPath("/clothes");
	    if(ornimg == null){ 
	    	if(pimage != null){ 
	    		img = pimage;
	    	}
	    }else if(ornimg != null){ 
	    	
	    	if(pimage == null){ 
	    		img = ornimg;
	    	}else if(pimage != null){ 
	    		img = pimage;
	    		
	    		File delFile = new File(configFolder,ornimg); 
	    	}
	    }
	    String[] sarr = mr.getParameterValues("psize");
	    String psize = "";
	    if (sarr != null) {
	        for(int i = 0; i < sarr.length; i++){
	            psize += sarr[i] + " ";
	        }
	    }
	    
	    
	    int cnt = pdao.updateProduct(mr, img, psize);     
	    
	   	String msg,url;

	   	if(cnt > 0){
	   		msg = "수정 성공";
	   		url = "product.jsp";
	   	}else{
	   		msg = "수정 실패";
	   		url = "product_updateForm.jsp?pno="+mr.getParameter("pno");
	   	}
    %>
     <script>
        alert("<%=msg%>");
        location.href="<%=url%>";
    </script>
    
    
    
    