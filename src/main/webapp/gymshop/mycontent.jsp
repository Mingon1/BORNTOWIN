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

ReviewDao rdao = ReviewDao.getInstance();
ReviewBean rb = rdao.getArticle(rno);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date regDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rb.getRegdate());
String sdfdate = sdf.format(regDate);

String requestDir = request.getContextPath() + "/clothes";

%>
<script>
    function recheck(action) {
        var rpasswd = document.getElementsByName("rpasswd")[0].value.trim();
        if (rpasswd === '') {
            alert('비밀번호를 입력해주세요.');
            return false;
        } else {
            var conf = confirm(action + "하시겠습니까?");
            if (conf) {
                if (action === '삭제') {
                    location.href = "deleteMyReviewProc.jsp?rno=<%=rb.getRno()%>&rpasswd=" + rpasswd;
                } else if (action === '수정') {
                    location.href = "updateMyReviewForm.jsp?rno=<%=rb.getRno()%>&rpasswd=" + rpasswd;
                }
            } else {
                return false;
            }
        }
    }
</script>
<%@include file="prod_top.jsp"%>
<div class="container mt-4">
    <div class="card">
        <div class="card-header">
            <h5 class="card-title"><b>리뷰내용</b></h5>
            <%if(rb.getRimage()==null){%>
            <div></div>
            <%}else{%>
            <div>
                <img src="<%=requestDir + "/" + rb.getRimage() %>" class="img-fluid" style="max-width: 100px;">
                <input type="text" name="pimage2" value="<%=rb.getRimage()%>"> <br>
            </div>
            <%}%>
            <div>
                <h4><b><%=rb.getRtitle()%></b></h4>
            </div>
            <div>
                <p class="card-text"><%=rb.getRwriter()%></p>
            </div>
            <div class="text-muted">작성일 <%=sdfdate%> | 조회수 <%=rb.getReadcount()%></div>
            <hr>
            <div>
                <p class="card-text"><%=rb.getRcontent()%></p>
            </div>
            <div>비밀번호&nbsp;&nbsp;<input type="password" name="rpasswd">&nbsp;<span>삭제,수정하려면 비밀번호를 입력하세요</span></div>
            <div>
                <input type="button" class="btn btn-dark mr-2" value="확인" onclick="location='myPageForm.jsp'"> 
                <input type="button" class="btn btn-secondary mr-2" value="삭제" onclick="recheck('삭제')">
                <input type="button" class="btn btn-dark" value="수정" onclick="recheck('수정')">
            </div>
        </div>
    </div>
</div>
<br>
<br>
<br>
<div class="container mt-4">
    <div class="card">
        <div class="card-header">
            <h5 class="card-title"><b>관리자 댓글</b></h5>
        </div>
        <div class="card-body">
            <%
            ReviewCommentsDao rvdao = ReviewCommentsDao.getInstance();
            ArrayList<ReviewCommentsBean> rvlists= rvdao.getcoList(rno);
            for(ReviewCommentsBean rcb : rvlists){
                Date coreg_Date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rcb.getCoreg_date());
                String sdfco = sdf.format(coreg_Date);
            %>
            <div>
                <p class="card-text"><b>관리자</b> <%=sdfco%></p>
            </div>
            <div>
                <p class="card-text"><%=rcb.getCocontent()%></p>
            </div>
            <%
            }
            %>
        </div>
    </div>
</div>
<%@include file="prod_bottom.jsp"%>
