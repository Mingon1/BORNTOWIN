<%@page import="gym.admin.ProductBean"%>
<%@page import="gym.admin.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <style>
   /* 테이블 헤더 스타일링 */
th {
    background-color: #f2f2f2;
    font-weight: bold;
    text-align: center;
    padding: 10px;
}

/* 테이블 셀 스타일링 */
td {
    text-align: left;
    padding: 10px;
}

/* 마우스 호버 효과 */
tr:hover {
    background-color: #f5f5f5;
}
/* 체크박스 스타일링 */
input[type="checkbox"] {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    width: 20px;
    height: 20px;
    border: 2px solid #ccc;
    border-radius: 4px;
    outline: none;
    cursor: pointer;
    vertical-align: middle;
}

/* 체크된 상태의 체크박스 스타일링 */
input[type="checkbox"]:checked {
    background-color: #2196F3;
}

/* 체크박스와 텍스트 사이의 간격 조정 */
input[type="checkbox"] + label {
    margin-left: 5px;
}
/* 저장 버튼 스타일링 */
input[type="submit"] {
    background-color: #000;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
   font-weight: bold;
}

input[type="submit"]:hover {
    background-color: #333;
}

/* 취소 버튼 스타일링 */
input[type="reset"] {
    background-color: #ccc;
    color: #333;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
}

input[type="reset"]:hover {
    background-color: #ddd;
}
  
   </style>    
 <%
String pno = request.getParameter("pno");
System.out.println("product_updateForm.jsp pno:" + pno);
ProductDao pdao = ProductDao.getInstance();

ProductBean pb = pdao.getProductByPno(pno); 
%>

 <%@ include file="top.jsp" %>
		<!-- END LEFT SIDEBAR -->
		<!-- MAIN -->
		<div class="main">
			<!-- MAIN CONTENT -->
			<div class="main-content">
				<div class="container-fluid">
					<h3 class="page-title">상품 정보수정</h3>
					<div id="toastr-demo" class="panel">
						<div class="panel-body">
							<!-- CONTEXTUAL -->
							<div>상품 정보</div>
    	<hr>
    <form action="product_update_proc.jsp" name="f" method="post" enctype="multipart/form-data">
    	<table border="1" width="90%">
    		<tr>
    			<th>상품코드</th>
    			<td><input type="text" name="pcode" value="<%=pb.getPcode()%>">
    			<input type="hidden" name="pno" value="<%=pb.getPno()%>">
    			</td>
    		</tr>
    		<tr>
    			<th>상품명</th>
    			<td><input type="text" name="pname" value="<%=pb.getPname()%>" size="50"></td>
    		</tr>
    		<tr>
    			<th>상품가격</th>
    			<td><input type="text" name="price" value="<%=pb.getPrice()%>"></td>
    		</tr>
    		<tr>
    			<th>상품카테고리</th>
    			<td><input type="text" name="pcategory" value="<%=pb.getPcategory()%>"></td>
    		</tr>
    		<tr>
    			<th>제조사</th>
    			<td><input type="text" name="pcompany" value="<%=pb.getPcompany()%>"></td>
    		</tr>
    		<tr>
    			<th>상품사이즈</th>
    			<td>
    				<%
		        String[] sarr = {"Free", "1", "2", "3"};
		        for(int i = 0; i < sarr.length; i++) {
		        	String ps = "";
		    %>
		        <input type="checkbox" name="psize" value="<%=sarr[i] %>" <% if(pb.getPsize().contains(sarr[i])) {%> checked <% }%>> <%=sarr[i] %>
		    <%
		        }
		    %>
    			</td>
    		</tr>
    		<tr>
    			<th>재고량</th>
    			<td><input type="text" name="pqty" value="<%=pb.getPqty()%>"></td>
    		</tr>
    		<tr>
    			<th>이미지</th>
    			<td>
    			<img src="<%=request.getContextPath()%>/clothes/<%=pb.getPimage()%>" alt="상품이미지" width="100">
    			<input type="file" name="pimage" value="파일 선택">
    			<input type="text" name="pimage2" value="<%=pb.getPimage()%>">
    			</td>
    		</tr>
    		
    		<tr>
    			<th>상세설명</th>
    			<td><textarea cols="100" rows="7" name="pcontents"><%=pb.getPcontents()%></textarea></td>
    		</tr>
    	</table>
    		<input type="submit" value="저장">
    		<input type="reset" value="취소">
    </form>
							<!-- END CALLBACK -->
						</div>
					</div>
				</div>
			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN -->
		<div class="clearfix"></div>
		<footer>
			<div class="container-fluid">
				<p class="copyright">Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a>
</p>
			</div>
		</footer>
	</div>
	<!-- END WRAPPER -->
	<!-- Javascript -->
	<script src="assets/vendor/jquery/jquery.min.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script src="assets/vendor/toastr/toastr.min.js"></script>
	<script src="assets/scripts/klorofil-common.js"></script>
</body>

</html>
