<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.apache.commons.collections.bag.SynchronizedSortedBag"%>
<%@page import="gym.admin.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gym.admin.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/adminscript.js"></script>
 <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            padding: 20px;
        }

        h3.page-title {
            margin-top: 0;
            padding-bottom: 10px;
            border-bottom: 1px solid #ccc;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 8px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        img {
            display: block;
            margin: auto;
        }

        input[type="checkbox"] {
            transform: scale(1.5);
        }

        input[type="button"] {
            padding: 10px 20px;
            background-color: #00BFFF; 
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="button"]:hover {
            background-color: #00BFFF; 
        }

        input[type="button"]:not(:last-child) {
            margin-right: 10px;
        }

        hr {
            margin: 20px 0;
            border: none;
            border-top: 1px solid #ddd;
        }
		 .button-group {
        text-align: left; 
    }

    .button-group input[type="button"] {
        margin-left: 10px; 
    }

    .button-group input[type="button"]:last-child {
        float: right; 
        background-color: #FA5858; 
        
    }
    </style>   

<%
ProductDao pdao = ProductDao.getInstance();
//ArrayList<ProductBean> plists = pdao.getAllProduct();
//ystem.out.println(plists.size());
DecimalFormat df = new DecimalFormat("###,###");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");


int pageSize = 10; // 한 페이지에 보여줄 상품 수

String pageNum= request.getParameter("pageNum");
if(pageNum == null){
	pageNum="1";//~
}

int currentPage = Integer.parseInt(pageNum);//~
int startRow = (currentPage - 1)* pageSize + 1; //~
int endRow = currentPage * pageSize; //

int count = 0; //전체 게시글 수를 저장할 변수
int number = 0; // 게시글 번호를 저장할 변수

count = pdao.getproductCount();	//

number = count - (currentPage-1) * pageSize; //


ArrayList<ProductBean> alists = pdao.getArticles(startRow, endRow);
%>
    
	<div class="button-group">
    	<input type="button" value="선택삭제" onclick="selectDelete()">
    	<input type="button" value="+상품등록" onclick="location.href='product_input.jsp'">
	</div>
	<hr>
    <form name="f" method="post" action="product_delete.jsp">
    <table border="1">
    	<tr>
    		<th rowspan="2"><input type="checkbox" name="allcheck" onclick="allDelete(this)"></th>
    		<th rowspan="2">번호</th>
    		<th rowspan="2">이미지</th>
    		<th>상품코드</th>
    		<th colspan="2">상품명</th>
    		<th rowspan="2">최초등록일</th>
    		<th colspan="2">진열</th>
    		<th colspan="2">가격정보</th>
    		<th rowspan="2" colspan="2 ">관리</th>
    	</tr>
    	<tr>
    		<th>업체코드</th>
    		<th>제조사명</th>
    		<th>카테고리</th>
    		<th>사이즈</th>
    		<th>재고</th>
    		<th>상품가격</th>
    		<th>적립금</th>
    	</tr>
    	
    	
    	<%if(alists.size()==0){%>
    		<tr><td colspan ="12">상품 없음</td></tr>
    	<%}%>
    	<%for(ProductBean pb : alists){
    	Date odate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(pb.getPinputdate());
		String sdfdate = sdf.format(odate);
    	String requestDir = request.getContextPath()+"/clothes";
    	//System.out.println(requestDir+"/"+pb.getPimage());
    	//System.out.println(request.getContextPath());
    	%>
    	<tr>
    		<td rowspan="2"><input type="checkbox" name="rowcheck" value="<%=pb.getPno()%>"></td>
    		<td rowspan="2"><%=pb.getPno()%></td>
    		<td rowspan="2">
    			<img src="<%=requestDir + "/" + pb.getPimage() %>" width="60" height="70">
    			<input type="hidden" name="pimage" value="<%= pb.getPimage() %>">
			</td>
    		<td><%=pb.getPcode()%></td>
    		<td colspan="2"><%=pb.getPname()%></td>
    		<td rowspan="2"><%=sdfdate%></td>
    		<td colspan="2">진열</td>
    		<td rowspan="2"><%=df.format(pb.getPrice())%>원</td>
    		<td rowspan="2"><%=df.format(pb.getReserves())%>원</td>
    		<td rowspan="2"><input type="button" value="수정" onclick="location='product_updateForm.jsp?pno=<%=pb.getPno()%>'"></td>
    		<%-- <%System.out.println("pno="+pb.getPno());%> --%>
    	</tr>
    	<tr>
    		<td>관리자</td>
    		<td><%=pb.getPcompany()%></td>
    		<td><%=pb.getPcategory()%></td>
    		<td><%=pb.getPsize()%></td>
    		<td><%=pb.getPqty()%></td>
    	</tr>
    	<% 
    	}
    	%>
    	
    	
    </table>
    <div  style="margin: auto; text-align: center;">
	<% if(count>0){
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
		<a href="product.jsp?pageNum=<%=startPage-10%>">&lt;</a>
	<%	
		}
		for(int i=startPage; i<=endPage ; i++){
	%>
				<a href="product.jsp?pageNum=<%=i%>">[<%=i %>]</a>
	<%			
			}
			if(endPage < pageCount){
	%>
				<a href="product.jsp?pageNum=<%=startPage+10%>">&gt;</a>	
	<%			
			}
		}

	%>
		</div>
    <hr>
    	<div class="button-group">
    		<input type="button" value="선택삭제" onclick="selectDelete()">
    		<input type="button" value="+상품등록" onclick="location.href='product_input.jsp'">
		</div>
    </form>
    
