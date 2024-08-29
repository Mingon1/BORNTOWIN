<%@page import="java.util.Date"%>
<%@page import="board2.ReviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board2.ReviewDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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

<script>
var userid = '<%= userid %>';

function checkuserid() {
	//console.log("checkuserid 함수 호출됨")
    if (userid==null) {
        alert("로그인이 필요합니다.");
        window.location.href = "<%=request.getContextPath()%>/login.jsp";
        
        return false;
    }
    return true;
}
</script>
<% 


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

ReviewDao rdao = ReviewDao.getInstance();
count = rdao.getArticleCount();	//

number = count - (currentPage-1) * pageSize; //


ArrayList<ReviewBean> alists = rdao.getArticles(startRow, endRow);
%>


<div  style="width: 80%; height:80%; margin: auto;">
	<div class="panel">
		<div class="panel-heading">
			<h3 class="panel-title"><b>Review</b></h3>
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
					for(ReviewBean rb : alists){
						Date regDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rb.getRegdate());
						String sdfdate = sdf.format(regDate);
				    	String requestDir = request.getContextPath()+"/clothes";

				%>
					<tr>
						<td style="vertical-align: middle;"><%=number--%></td>
						<%if(rb.getRimage()==null){
						%>
						<td></td>
						<%}else{%>
						<td>
            			<p style="width: 100px;"><img src="<%=requestDir + "/" + rb.getRimage() %>" width= "100%" height="100px"></p>
						</td>
						<%}%>
						<td style="vertical-align: middle;">
						<% 
						int wid = 0;
						if(rb.getRe_level()>0){
							wid = 10 * rb.getRe_level();
						%>
							<p style="width: 20px;"><img src="bimg/re.gif" width="<%=wid%>" height="15px"></p>
						<% 
						}
						%>
						<a href="ReviewContent.jsp?rno=<%=rb.getRno()%>&ruserid=<%=rb.getRuserid()%>&pageNum=<%=pageNum%>"><%=rb.getRtitle()%></a>
							
						</td>
						<td style="vertical-align: middle;"><%=rb.getRwriter()%></td>
						<td style="vertical-align: middle;"><%=sdfdate%></td>
						<td style="vertical-align: middle;"><%=rb.getReadcount()%></td>
					</tr>
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
		<a href="Review.jsp?pageNum=<%=startPage-10%>">&lt;</a>
	<%	
		}
		for(int i=startPage; i<=endPage ; i++){
	%>
				<a href="Review.jsp?pageNum=<%=i%>">[<%=i %>]</a>
	<%			
			}
			if(endPage < pageCount){
	%>
				<a href="Review.jsp?pageNum=<%=startPage+10%>">&gt;</a>	
	<%			
			}
		}

	%>
		</div>
</div>
						
							
						</div>
					</div>
				</div>
			</div>
			<!-- END MAIN CONTENT -->
		</div>
		
	<script src="assets/vendor/jquery/jquery.min.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script src="assets/scripts/klorofil-common.js"></script>
</body>

</html>


