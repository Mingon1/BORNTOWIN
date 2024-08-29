<%@page import="gym.admin.NoticeBean"%>
<%@page import="gym.admin.NoticeDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="prod_top.jsp"%>

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
  .panel{
  align: center;
  }
</style>

<script>
var userid = '<%= userid %>';

function checkuserid() {
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

NoticeDao ndao = NoticeDao.getInstance();
count = ndao.getArticleCount();	//

number = count - (currentPage-1) * pageSize; //


ArrayList<NoticeBean> nlists = ndao.getArticles(startRow, endRow);
%>


<div  style="width: 80%; height:80%; margin: auto;">
	<div class="panel">
		<div class="panel-heading">
			<h3 class="panel-title"><b>NOTICE</b></h3>
		</div>
		<div class="panel-body" >
			<table class="table table-hover">
				<thead>
					<tr>
						<th>공지</th>
						<th>제목</th>
						<th>작성자</th>
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
					for(NoticeBean nb : nlists){
						Date regDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(nb.getRegdate());
						String sdfdate = sdf.format(regDate);
				    	String requestDir = request.getContextPath()+"/Notice";

				%>
					<tr>
						<td style="vertical-align: middle;">공지</td>
						<td style="vertical-align: middle;">
						<a href="noticeContent.jsp?no=<%=nb.getNo()%>&nuserid=<%=nb.getNuserid()%>&pageNum=<%=pageNum%>"><%=nb.getNtitle()%></a>
						</td>
						<td style="vertical-align: middle;">관리자</td>
						<td style="vertical-align: middle;"><%=sdfdate%></td>
						<td style="vertical-align: middle;"><%=nb.getReadcount()%></td>
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
		<a href="notice.jsp?pageNum=<%=startPage-10%>">&lt;</a>
	<%	
		}
		for(int i=startPage; i<=endPage ; i++){
	%>
				<a href="notice.jsp?pageNum=<%=i%>">[<%=i %>]</a>
	<%			
			}
			if(endPage < pageCount){
	%>
				<a href="notice.jsp?pageNum=<%=startPage+10%>">&gt;</a>	
	<%			
			}
		}

	%>
		</div>
</div>
<%@include file="prod_bottom.jsp"%>