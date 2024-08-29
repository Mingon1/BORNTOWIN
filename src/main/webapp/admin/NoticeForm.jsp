<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/board/bscript.js"></script>
    
     <%@ include file="top.jsp" %>
 
		<!-- END LEFT SIDEBAR -->
		<!-- MAIN -->
		<div class="main">
			<!-- MAIN CONTENT -->
			<div class="main-content">
				<div class="container-fluid">
					<h3 class="page-title">공지사항 작성</h3>
					<div class="panel panel-headline">
						<div class="panel-body">
						<form action="noticeProc.jsp" name="f" method="post" enctype="multipart/form-data">
    <div>
        <b>Notice</b>
    </div><br><br>
        <div>
            <input type="file" name="nimage"> <br>
            <input type="hidden"name="nuserid" value="<%=userid%>">
        </div>
        <hr width="90%">
        <div>
            <input type="text" name="ntitle" placeholder="제목을 입력하세요">
        </div>
        <div class="textLengthWrap">
            <span class="textCount">0</span> / <span class="textTotal">200</span>자
        </div>
        <div>
            <textarea id="textBox" maxlength="200" cols="60" rows="5"placeholder="내용을 입력하세요" name="ncontent"></textarea>
        </div>
        
        <div>
            <input type="submit" value="등록"> 
            <input type="reset" value="취소" onclick="location.href='product.jsp'">
            <input type="button" value="공지사항" onclick="location.href='<%=request.getContextPath()%>/gymshop/notice.jsp'">
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