<%@page import="java.util.Date"%>
<%@page import="board2.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board2.BoardDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="top.jsp"%>
<style>
  table {
    width: 80%;
  }
  td {
    padding: 8px;
    text-align: center;
    width: 5px;
    height: 100px;
  }
  th {
    background-color: #f2f2f2;
    padding: 8px;
    text-align: center;
  }
</style>


<% 

//String gon = session.getAttribute("gon"); top에서 받았기때문에 여기선 안해도됨

int pageSize=10; // ~
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");


String pageNum= request.getParameter("pageNum");
if(pageNum == null){
	pageNum="1";//~
}

int currentPage = Integer.parseInt(pageNum);//~
int startRow = (currentPage - 1)* pageSize + 1; //~
int endRow = currentPage * pageSize; //

int count = 0; //전체 게시글 수를 저장할 변수
int number = 0; // 게시글 번호를 저장할 변수

BoardDao bdao = BoardDao.getInstance();
count = bdao.getArticleCount();	//

number = count - (currentPage-1) * pageSize; //


ArrayList<BoardBean> alists = bdao.getArticles(startRow, endRow);
%>

<div class="main">
			<!-- MAIN CONTENT -->
			<div class="main-content">
				<div class="container-fluid">
					<h3 class="page-title">Q&A</h3>
					<div class="panel panel-headline">
						<div class="panel-body">
						
<form name="f" method="post" action="writeForm.jsp"  onsubmit="return checkuserid()">
<div  style="width: 90%; height:100%; margin: auto;">
	<div class="panel">
		<div class="panel-heading">
			<h3 class="panel-title"><b>Q&A</b></h3>
		</div>
		<div class="panel-body" >
			<table class="table table-hover">
				<thead>
					<tr>
						<th>No</th>
						<th>상품이미지</th>
						<th>제목</th>
						<th>고객이름</th>
						<th>작성날짜</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
				<%
				if(count == 0){
				%>	
					<tr>
						<td colspan="6" align="center">작성된 글이 없습니다</td>
					</tr>
					</table>
				<%
				}else{
					for(BoardBean bb : alists){
						Date regDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(bb.getReg_date());
						String sdfdate = sdf.format(regDate);
				    	String requestDir = request.getContextPath()+"/clothes";

				%>
					<tr>
						<td style="vertical-align: middle;"><%=number--%></td>
						<%if(bb.getPimage()==null){
						%>
						<td></td>
						<%}else{%>
						<td>
            			<p style="width: 100px;"><img src="<%=requestDir + "/" + bb.getPimage() %>" width= "100%" height="100px"></p>
						</td>
						<%}%>
						<td style="vertical-align: middle;">
						<% 
						int wid = 0;
						if(bb.getRe_level()>0){
							wid = 10 * bb.getRe_level();
						%>
							<p style="width: 20px;"><img src="bimg/re.gif" width="<%=wid%>" height="15px"></p>
						<% 
						}
						%>
						<%if(bb.getSecret().equals("private")){ %>
						<a href="Q&Acontent.jsp?bno=<%=bb.getBno()%>&bid=<%=bb.getBid()%>&pageNum=<%=pageNum%>&passwd=<%=bb.getPasswd()%>"><%=bb.getTitle()%></a>
							<p style="width: 15px;" ><img src="bimg/lock.gif" width="15" height="15px"></p>					
						<%}else{
						%>
						<a href="Q&Acontent.jsp?bno=<%=bb.getBno()%>&bid=<%=bb.getBid()%>&pageNum=<%=pageNum%>"><%=bb.getTitle()%></a>
							
						<%
						}%>
						</td>
						<td style="vertical-align: middle;"><%=bb.getWriter()%></td>
						<td style="vertical-align: middle;"><%=sdfdate%></td>
						<td style="vertical-align: middle;"><%=bb.getReadcount()%></td>
					</tr>
					<%System.out.println(bb.getSecret());%>
				</tbody>
					<% 
					}//for
					%>
			</table>
				<%	
				}//else
				%>
		</div>
	</div>
		<div  style="margin: auto; text-align: center;">
	<% 
	if(count>0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		//
		
		int pageBlock = 10;
		
		int startPage = ((currentPage -1) / pageBlock*pageBlock) + 1;
		//
		int endPage = startPage + pageBlock -1;
		//
		if(endPage > pageCount){
			endPage = pageCount;
		}
		if(startPage > 10){
	%>
		<a href="Q&A.jsp?pageNum=<%=startPage-10%>">&lt;</a>
	<%	
		}
		for(int i=startPage; i<=endPage ; i++){
	%>
				<a href="Q&A.jsp?pageNum=<%=i%>">[<%=i %>]</a>
	<%			
			}
			if(endPage < pageCount){
	%>
				<a href="Q&A.jsp?pageNum=<%=startPage+10%>">&gt;</a>	
	<%			
			}
		}

	%>
		</div>
</div>

</form>
							
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

 <%@include file="bottom.jsp"%>