<%@page import="gym.admin.ReviewCommentsBean"%>
<%@page import="gym.admin.ReviewCommentsDao"%>
<%@page import="board2.ReviewBean"%>
<%@page import="board2.ReviewDao"%>
<%@page import="board2.CommentsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board2.CommentsDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board2.BoardBean"%>
<%@page import="board2.BoardDao"%>
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

<%@include file="prod_top.jsp"%>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title"><%=rb.getRtitle()%></h3>
                    <p class="card-text">작성자: <%=rb.getRwriter()%></p>
                    <p class="card-text">작성일: <%=sdfdate%></p>
                    <p class="card-text">조회수: <%=rb.getReadcount()%></p>
                </div>
                <div class="card-body">
                    <%if(rb.getRimage()!=null){%>
                        <p style="width: 300px;"><img src="<%=requestDir + "/" + rb.getRimage() %>" class="card-img-top mb-3" alt="Review Image"></p>
                    <%}%>
                    <p class="card-text"><%=rb.getRcontent()%></p>
                </div>
                <div class="card-footer">
                    <input type="button" class="btn btn-sm" value="목록" onclick="location='reviewList.jsp'"> 
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-5">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">댓글 목록</h3>
                </div>
                <div class="card-body">
                    <% 
                        ReviewCommentsDao rvdao = ReviewCommentsDao.getInstance();
                        ArrayList<ReviewCommentsBean> rvlists= rvdao.getcoList(rno);
                        for(ReviewCommentsBean rcb : rvlists){
                            Date coreg_Date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rcb.getCoreg_date());
                            String sdfco = sdf.format(coreg_Date);
                    %>
                    <div class="media mb-3">
                        <div class="media-body">
                            <h5 class="mt-0">관리자 <small class="text-muted"><%=sdfco%></small></h5>
                            <p><%=rcb.getCocontent()%></p>
                            <button class="btn btn-sm btn-danger" onclick="deleteComment('<%=rcb.getRvno()%>', '<%=rno%>', '<%=pageNum%>')">삭제</button>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="prod_bottom.jsp"%>
