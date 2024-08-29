<%@page import="board2.CommentsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board2.CommentsDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board2.BoardBean"%>
<%@page import="board2.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="top.jsp"%>

<%
request.setCharacterEncoding("UTF-8");
String bno = request.getParameter("bno");
String pageNum = request.getParameter("pageNum");
System.out.print("bno:"+bno+","+pageNum);

BoardDao bdao = BoardDao.getInstance();
BoardBean bb = bdao.getArticle(bno);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date regDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(bb.getReg_date());
String sdfdate = sdf.format(regDate);


String requestDir = request.getContextPath()+"/clothes";

%>
    <script>
function recheck() {
    var conf = confirm("정말 삭제하시겠습니까?");
    if (conf) {
        location.href = "deleteproc.jsp?bno=<%=bb.getBno()%>&pageNum=<%=pageNum%>";
    } else {
        return false;
    }
}
</script>

<div class="main">
			<!-- MAIN CONTENT -->
			<div class="main-content">
				<div class="container-fluid">
					<h3 class="page-title">Q&A</h3>
					<div class="panel panel-headline">
						<div class="panel-body">
						
	<div style="width: 80%; height: 80%; margin: auto;">
    <div class="panel">
        <div class="panel-heading">
            <h3 class="panel-title">
                <b>게시물 내용</b>
            </h3>
            <%if(bb.getPimage()==null){%>
            <div></div>
            <%}else{%>
            <div>
                <p style="width: 100px;"><img src="<%=requestDir + "/" + bb.getPimage() %>" width="100%" height="100px"></p>
                <input type="text" name="pimage2" value="<%=bb.getPimage()%>"> <br>
            </div>
            <%}%>
            <div>
                <h4><b><%=bb.getTitle()%></b></h4>
            </div>
            <br>
            <br>
            <div>
                <%=bb.getWriter()%>
            </div>
            <div>작성일 <%=sdfdate%> 조회수 <%=bb.getReadcount()%></div>
            <br>
            <div><%=bb.getContent()%></div>
            <div>
                <input type="button" value="목록" onclick="location='Q&A.jsp'"> 
                <input type=button value="답변" onclick="location='<%=request.getContextPath()%>/board/replyForm.jsp?ref=<%=bb.getRef()%>&re_step=<%=bb.getRe_step()%>&re_level=<%=bb.getRe_level()%>&pageNum=<%=pageNum%>'">
            </div>
        </div>
    </div>
</div>

						</div>
					</div>
				</div>
			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN -->
	<!-- END WRAPPER -->
	<!-- Javascript -->
	<script src="assets/vendor/jquery/jquery.min.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script src="assets/scripts/klorofil-common.js"></script>
</body>

</html>

    
