<%@page import="gym.admin.NoticeBean"%>
<%@page import="gym.admin.NoticeDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="prod_top.jsp"%>

<%
request.setCharacterEncoding("UTF-8");
String no = request.getParameter("no");
String pageNum = request.getParameter("pageNum");

NoticeDao ndao = NoticeDao.getInstance();
NoticeBean nb = ndao.getArticle(no);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date regDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(nb.getRegdate());
String sdfdate = sdf.format(regDate);

String requestDir = request.getContextPath() + "/Notice";
%>

<script>
    function recheck() {
        var conf = confirm("정말 삭제하시겠습니까?");
        if (conf) {
            location.href = "deleteNoticeproc.jsp?no=<%=nb.getNo()%>&pageNum=<%=pageNum%>";
        } else {
            return false;
        }
    }
</script>

<div style=" display: flex; justify-content: center; align-items: center;">
    <div class="panel" style="width: 100%;">
        <div class="panel-heading" style="text-align: center;">
            <h3 class="panel-title"><b>공지사항</b></h3>
            <h4><b><%=nb.getNtitle()%></b></h4>
            <div>작성일 <%=sdfdate%> 조회수 <%=nb.getReadcount()%></div>
            <div style="text-align: center;">
               <img src="<%=requestDir + "/" + nb.getNimage() %>">
            </div>
            
            <div><%=nb.getNcontent()%></div>
            <div>
                <input type="button" value="목록" onclick="location='notice.jsp'"> 
                
                <% if(userid != null && userid.equals("admin")) { %>
    			<input type="button" value="삭제" onclick="return recheck()"> 
				<% } %>
            </div>
        </div>
    </div>
</div>

<%@include file="prod_bottom.jsp"%>
