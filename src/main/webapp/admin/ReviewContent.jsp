<%@page import="gym.admin.ReviewCommentsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gym.admin.ReviewCommentsDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board2.ReviewBean"%>
<%@page import="board2.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String rno = request.getParameter("rno");
String pageNum = request.getParameter("pageNum");

ReviewDao rdao = ReviewDao.getInstance();
ReviewBean rb = rdao.getArticle(rno);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date regDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rb.getRegdate());
String sdfdate = sdf.format(regDate);

String requestDir = request.getContextPath()+"/clothes";
%>
<%@ include file="top.jsp" %>
<!-- END LEFT SIDEBAR -->
<!-- MAIN -->
<div class="main">
    <!-- MAIN CONTENT -->
    <div class="main-content">
        <div class="container-fluid">
            <h3 class="page-title">리뷰 관리</h3>
            <div class="panel panel-headline">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="panel">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><b>게시물 내용</b></h3>
                                </div>
                                <div class="panel-body">
                                    <%if(rb.getRimage()!=null){%>
                                    <div class="text-left">
                                        <img src="<%=requestDir + "/" + rb.getRimage() %>" class="img-thumbnail" style="max-width: 30%; height: auto;">
                                    </div>
                                    <br>
                                    <%}%>
                                    <h4><b><%=rb.getRtitle()%></b></h4>
                                    <div><%=rb.getRwriter()%></div>
                                    <div>작성일 <%=sdfdate%> 조회수 <%=rb.getReadcount()%></div>
                                    <br>
                                    <div><%=rb.getRcontent()%></div>
                                </div>
                                <div class="panel-footer">
                                    <input type="button" value="목록" onclick="location='Review.jsp'"> 
                                </div>
                            </div>
                            <div class="panel">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><b>댓글 목록</b></h3>
                                </div>
                                <div class="panel-body">
                                    <div class="comments">
                                        <% 
                                        ReviewCommentsDao rvdao = ReviewCommentsDao.getInstance();
                                        ArrayList<ReviewCommentsBean> rvlists= rvdao.getcoList(rno);
                                        for(ReviewCommentsBean rcb : rvlists){
                                            Date coreg_Date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rcb.getCoreg_date());
                                            String sdfco = sdf.format(coreg_Date);
                                        %>
                                        <div class="comment">
                                            <div class="author"><strong>관리자</strong> <%=sdfco%></div>
                                            <div class="content"><%=rcb.getCocontent()%></div>
                                            <div class="actions">
                                                <input type="button" value="삭제" onclick="deleteComment('<%=rcb.getRvno()%>', '<%=rno%>', '<%=pageNum%>')">
                                            </div>
                                        </div>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                            <div class="panel">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><b>댓글 작성하기</b></h3>
                                </div>
                                <div class="panel-body">
                                    <form name="f" method="post" action="reviewcommentsproc.jsp?rno=<%=rno%>&pageNum=<%=pageNum%>">
                                        <div class="form-group">
                                            <textarea class="form-control" rows="3" name="cocontent"></textarea>
                                        </div>
                                        <div class="form-group">
                                            <input type="submit" class="btn btn-primary" value="등록">
                                        </div>
                                    </form>
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
<%@include file="bottom.jsp"%>
<script src="assets/vendor/jquery/jquery.min.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="assets/scripts/klorofil-common.js"></script>
</body>
</html>
