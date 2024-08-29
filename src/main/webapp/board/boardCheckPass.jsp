<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board2.BoardBean"%>
<%@page import="board2.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<%
request.setCharacterEncoding("UTF-8");
String bno = request.getParameter("bno");
String pageNum = request.getParameter("pageNum");
String passwd = request.getParameter("passwd");
String bid = request.getParameter("bid");
//System.out.print("checkpass,bno:" + bno + "," + "pageNum:" + pageNum + "," + "passwd:" + passwd+" ");
BoardDao bdao = BoardDao.getInstance();
BoardBean bb = bdao.getCheckpw(bno,passwd);
System.out.print(bb.getBid());

%>
<%@include file="board_top.jsp"%>
<script type="text/javascript">
function checkpw(){
    var passwd = document.f.passwd.value; // Get the entered password
    var inputPasswd = "<%=bb.getPasswd()%>"; 

    if("<%=userid%>" == "admin"){
        return true;
    } else if(passwd == inputPasswd){
        return true;
    } else {
        alert("비밀번호가 틀립니다.");
        location.href="boardCheckPass.jsp?bno=<%=bb.getBno()%>&passwd=<%=bb.getPasswd()%>&pageNum=<%=pageNum%>";
        return false;
    }
}
</script>


<form name="f" method="post" action="content.jsp" onsubmit="return checkpw()">
	<div style="width: 80%; height: 80%; margin: auto;">
		<div class="panel">
			<div class="panel-heading">
				<h3 class="panel-title">
					<b>Q&A</b>
				</h3>
				<div>
					<h4>
						<b> 비밀글보기 </b>
					</h4>
				</div>
				<br>
				<div style="font-size: 12px;">
					이 글은 비밀글입니다. <b>비밀번호를 입력하여 주세요.</b><br>
					관리자는 확인버튼만 누르시면 됩니다.
					
				</div>
				<br>
				<div>
					비밀번호 <input type="password" name="passwd">
				</div>

				<div>
					<input type="button" value="목록" onclick="location='board.jsp'"> 
					<input type="submit" value="확인">
					<input type="hidden" name="bno" value="<%=bb.getBno()%>">
                    <input type="hidden" name="bid" value="<%=bid%>">
                    <input type="hidden" name="pageNum" value="<%=pageNum%>">
				</div>
			</div>
		</div>
	</div>
</form>


<%@include file="board_bottom.jsp"%>