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
String bno = request.getParameter("bno");
String pageNum = request.getParameter("pageNum");
System.out.print("bno:"+bno+","+pageNum);

BoardDao bdao = BoardDao.getInstance();
BoardBean bb = bdao.getArticle(bno);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date regDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(bb.getReg_date());
String sdfdate = sdf.format(regDate);


String requestDir = request.getContextPath()+"/clothes";

//System.out.println(bb.getRef() +"," +bb.getRe_step() + ","+bb.getRe_level());

%>
<%@include file="board_top.jsp"%>
<div class="container">
    <div class="panel">
        <div class="panel-heading">
            <h3 class="panel-title"><b>Q&A</b></h3>
            <br>
            <%if(bb.getPimage()!=null){%>
            <div>
   			 <p style="width:30%; height:auto;"><img src="<%=requestDir + "/" + bb.getPimage() %>" alt="이미지" class="img-responsive"></p>
    			<input type="text" name="pimage2" value="<%=bb.getPimage()%>"> <br>
			</div>
            <%}%>
            <div>
                <h4><b><%=bb.getTitle()%></b></h4>
            </div>
            <div><%=bb.getWriter()%></div>
            <div><font size="2px">작성일 <%=sdfdate%> 조회수 <%=bb.getReadcount()%></font></div>
            <br>
            <div><%=bb.getContent()%></div>
            <br><br>
            <div>
                <input type="button" value="목록" onclick="location='board.jsp'" class="btn btn-default"> 
                <% if (userid != null) { %>
                <input type=button value="삭제" onclick="location='deleteproc.jsp?bno=<%=bb.getBno()%>&pageNum=<%=pageNum%>'" class="btn btn-default">
                <input type=button value="수정" onclick="location='updateForm.jsp?bno=<%=bb.getBno()%>&pageNum=<%=pageNum%>'" class="btn btn-default">
                <input type=button value="답변" onclick="location='replyForm.jsp?ref=<%=bb.getRef()%>&re_step=<%=bb.getRe_step()%>&re_level=<%=bb.getRe_level()%>&pageNum=<%=pageNum%>'" class="btn btn-default">
                <% } %>
            </div>
        </div>
    </div>
</div>

<div class="container" style="margin-top: 20px;">
    <div class="panel panel-default">
        <div class="panel-body">
            <p><font size="3px">댓글</font></p>
            <hr>
            <% 
            CommentsDao cmdao = CommentsDao.getInstance();
            ArrayList<CommentsBean> cmlists= cmdao.getcoList(bno);
            for(CommentsBean cb : cmlists){
                Date coreg_Date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(cb.getCoreg_date());
                String sdfco = sdf.format(coreg_Date);
            %>
            <div style="margin-bottom: 10px;">
                <div><%=cb.getCowriter()%>&nbsp; &nbsp;<%=sdfco%></div>
                <div><%=cb.getCocontent()%></div>
                <div>
                    <input type="button" value="삭제" onclick="deleteComment('<%=cb.getCono()%>', '<%=bno%>', '<%=pageNum%>')" class="btn btn-danger btn-xs">
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>
<% if (userid != null) { %>
<div class="container" style="margin-top: 20px;">
    <form name="f" method="post" action="commentsproc.jsp?bno=<%=bno%>&pageNum=<%=pageNum%>">
        <b>댓글작성</b>
        <div class="form-group">
            <label for="cowriter">이름:</label>
            <input type="text" value="<%=username%>" name="cowriter" class="form-control">
        </div>
        <div class="form-group">
            <textarea cols="30" rows="3" name="cocontent" class="form-control"></textarea>
        </div>
        <div class="form-group">
            <input type="submit" value="등록" class="btn btn-primary">
        </div>
    </form>
    <%}%>
</div>

<%@include file="board_bottom.jsp"%>
