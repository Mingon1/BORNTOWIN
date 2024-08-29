<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board2.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		BoardDao pdao = BoardDao.getInstance();
	  	
	    String configDir = config.getServletContext().getRealPath("/clothes");
	    int maxSize = 1024*1024*5;
	    String encoding = "UTF-8";
	    MultipartRequest mr = new MultipartRequest(request,configDir,maxSize,encoding);

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
	    		
	    	}
	    }
	   
	    
	    
	    int cnt = pdao.updateBoard(mr, img);     
	    
	   	String msg,url;

	   	if(cnt > 0){
	   		msg = "수정 성공";
	   		url = "board.jsp?bno="+mr.getParameter("bno")+"&pageNum="+mr.getParameter("pageNum");
	   	}else{
	   		msg = "수정 실패";
	   		url = "board.jsp?bno="+mr.getParameter("bno")+"&pageNum="+mr.getParameter("pageNum");
	   	}
    %>
     <script>
        alert("<%=msg%>");
        location.href="<%=url%>";
    </script>
    