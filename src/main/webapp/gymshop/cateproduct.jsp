<%@page import="java.text.DecimalFormat"%>
<%@page import="gym.admin.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gym.admin.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="prod_top.jsp" %>
    <% 
    request.setCharacterEncoding("UTF-8");
    
    String pcategory = request.getParameter("pcategory");
    //System.out.println("카테고리:"+pcategory);
    
    ProductDao pdao = ProductDao.getInstance();
    String requestDir = request.getContextPath()+"/clothes";
    DecimalFormat df = new DecimalFormat("###,###");
    int count = 0;
    int pageSize = 12; // 한 페이지에 보여줄 상품 수를 4개로 설정

    String pageNum= request.getParameter("pageNum");
    if(pageNum == null){
        pageNum="1";//~
    }

    int currentPage = Integer.parseInt(pageNum);//~
    int startRow = (currentPage - 1)* pageSize + 1; //~
    int endRow = currentPage * pageSize; //

    int prodcount = pdao.getproductByCategoryCount(pcategory); //카테고리별 상품 갯수
    //System.out.println("카테고리별 상품갯수:"+prodcount);
    int number = 0; // 게시글 번호를 저장할 변수

    number = prodcount - (currentPage-1) * pageSize; //


    ArrayList<ProductBean> alists = pdao.getArticlesByCategory(startRow, endRow, pcategory);

    %>
    <style>
    .product-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
    }
    .product-item {
        margin: 10px;
        text-align: center;
    }
    .product-item img {
        width: 300px;
        height: 400px;
    }
    </style>

    <div style="margin: auto; text-align: center;">
    <h4><b><%=pcategory%></b></h4>
    </div>
    <%
    if(alists.size() == 0) {//상품이 없는 경우
        out.println("<div style='text-align:center;'><b>상품이 없습니다.</b></div><br><br>");
    } else {
        out.println("<div class='product-container'>");
        for(ProductBean pb : alists){ // 수정된 부분: plists 대신 alists 사용
            %>
            <div class="product-item">
                <p><a href="detailproduct.jsp?pno=<%=pb.getPno()%>"><img src="<%=requestDir + "/" + pb.getPimage() %>" width= "300" height="400px"></a></p>
                <div><%=pb.getPname()%></div>
                <div>₩<%=df.format(pb.getPrice())%></div>
            </div>
            <% 
            count++;
            if (count % 4 == 0) {
                // 4개씩 출력 후 다음 줄로 넘어감
                out.println("</div><div class='product-container'>");
            }
        }
        out.println("</div>");
    }
    %>
     <div  style="margin: auto; text-align: center;">
    <%
    if(prodcount>0){
        int pageCount = prodcount / pageSize + (prodcount % pageSize == 0 ? 0 : 1);
        int pageBlock = 10;
        int startPage = ((currentPage -1) / pageBlock*pageBlock) + 1;
        int endPage = startPage + pageBlock -1;
        if(endPage > pageCount){
            endPage = pageCount;
        }
        if(startPage > 10){
    %>
        <a href="cateproduct.jsp?pageNum=<%=startPage-10%>&pcategory=<%=pcategory%>">&lt;</a>
    <%  
        }
        for(int i=startPage; i<=endPage ; i++){
    %>
            <a href="cateproduct.jsp?pageNum=<%=i%>&pcategory=<%=pcategory%>">[<%=i %>]</a>
    <%          
            }
            if(endPage < pageCount){
    %>
                <a href="cateproduct.jsp?pageNum=<%=startPage+10%>&pcategory=<%=pcategory%>">&gt;</a> 
    <%          
            }
        }
    %>
    </div>
    <%@ include file="prod_bottom.jsp" %>
    