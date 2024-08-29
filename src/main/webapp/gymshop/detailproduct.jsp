<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board2.ReviewBean"%>
<%@page import="board2.ReviewDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="gym.admin.ProductBean"%>
<%@page import="gym.admin.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <script type="text/javascript" src="<%=request.getContextPath()%>/gymshop/gymscript.js"></script>
    
    <%@ include file="prod_top.jsp" %>
<%
String pno = request.getParameter("pno");
session.setAttribute("pno", pno);
String requestDir = request.getContextPath()+"/clothes";
DecimalFormat df = new DecimalFormat("###,###");

ProductDao pdao = ProductDao.getInstance();
ProductBean pb = pdao.getProductByPno(pno);
//System.out.println("디테일상품카테고리:"+pb.getPcategory());
clists = cdao.getAllCartListById(userid);


ReviewDao rdao = ReviewDao.getInstance();
ArrayList<ReviewBean> rlists = rdao.getArticlesByPno(pno);

%>

<style>
    .select-box {
        margin-bottom: 10px; /* 선택 박스 간격 조절 */
        max-width: 300px; /* 최대 너비 설정 */
        width: 100%; /* 초기 너비 설정 */
    }

    .select-box select {
        width: 100%; /* 선택 박스 전체 너비 */
        padding: 10px; /* 내부 여백 */
        border: 1px solid #ccc; /* 테두리 스타일 */
        border-radius: 5px; /* 테두리 굴곡 */
        background-color: #f9f9f9; /* 배경색 */
        font-family: Arial, sans-serif; /* 글꼴 */
        color: #333; /* 텍스트 색상 */
        appearance: none; /* 기본 스타일링 제거 (크로스 브라우징) */
        -webkit-appearance: none;
        -moz-appearance: none;
    }

    /* 선택 박스 활성화 시 스타일 */
    .select-box select:focus {
        outline: none; /* 포커스 효과 제거 */
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.3); /* 포커스 효과 추가 */
    }

    /* 반응형 디자인을 위한 미디어 쿼리 */
    @media screen and (max-width: 768px) {
        .select-box {
            max-width: 100%; /* 화면 크기에 맞게 조정 */
        }
    }
    
    
    
    .qt-area {
        width: 150px; /* 입력란의 너비 조정 */
        margin: 10px; /* 입력란 주변 여백 조정 */
        border: 1px solid #ccc; /* 입력란 테두리 스타일 지정 */
        border-radius: 5px; /* 입력란 테두리 모서리를 둥글게 처리 */
        padding: 5px; /* 입력란 내부 여백 조정 */
    }

    .qt-area input[type="number"] {
        width: 100%; /* 입력란의 너비를 100%로 설정하여 부모 요소에 맞춤 */
        padding: 5px; /* 입력란 내부 여백 조정 */
        border: none; /* 입력란 테두리 없애기 */
        border-radius: 3px; /* 입력란 테두리 모서리를 둥글게 처리 */
        outline: none; /* 포커스 효과 제거 */
        font-size: 16px; /* 입력란 텍스트 크기 설정 */
    }

    /* 입력란에 포커스가 되었을 때 테두리 스타일 변경 */
    .qt-area input[type="number"]:focus {
        border: 1px solid #007bff; /* 포커스 효과를 위한 테두리 스타일 지정 */
    }
</style>

<script>
function checkOption() {
    var poption = document.f.poption.value;
    var cqty = document.f.cqty.value;
    	if (poption == "Size") {
        alert("옵션을 선택하세요.");
        return false;
    }
        
    return true;
}

function goOrder(pno){
    var poption = document.f.poption.value;
    var cqty = document.f.cqty.value;

  	if (poption === "Size") {
        alert("옵션을 선택하세요.");
        return false;
  	}
    
    location.href = "orderForm.jsp?pno=<%=pno%>&cqty=" + cqty + "&poption=" + poption + "&userid=<%=userid%>&pname=<%=pb.getPname()%>&pimage=<%=pb.getPimage()%>&creserves=<%=pb.getReserves()%>&price=<%=pb.getPrice()%>";
}
</script>






            <!-- Collect the nav links, forms, and other content for toggling -->

            <div class="collapse navbar-collapse" id="navbar">

              <ul class="nav navbar-nav navbar-right">

                <li><a href="#">Home</a></li>

                <li><a href="#">Blog</a></li>

                <li><a href="#">Shortcode</a></li>

                <li><a href="#">Features</a></li>

                <li><a href="#">Media</a></li>

                <li><a href="#">About Us</a></li>

                <li><a href="#">Contact Us</a></li>

              </ul>

            </div><!-- /.navbar-collapse -->


    <div class="short-description">

        <div class="container">

            <div class="row">

                <div class="col-md-6">

                    <div class="product-thumbnail">

                        <div class="col-md-2 col-sm-2 col-xs-2">

                            <ul class="thumb-image">

                                <li class="active"><a href="#"><img src="<%=requestDir + "/" + pb.getPimage() %>"></a></li>


                            </ul>

                        </div>

                        <div class="col-md-10 col-sm-10 col-xs-10">

                            <div class="thumb-main-image"><a href=""><img src="<%=requestDir + "/" + pb.getPimage() %>"></a></div>

                        </div>

                    </div>

                    <div class="clearfix"></div>

                </div><br><br>

                <div class="panel-group" id="accordion">


                    <div class="product-info">

                        <span class="product-id" style="font-size: 20px;"><span class="strong-text"><%=pb.getPname()%></span></span>

                        <div>

                        <span></span>

                    </div>

                        <span class="strong-text" style="font-size: 20px;">₩<%=df.format(pb.getPrice())%></span>

                    </div>

                    <p class="short-info">
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
                    
<div class="accordion accordion-flush" id="accordionFlushExample">
  <div class="accordion-item" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
    <h2 class="accordion-header btn btn-transparent border-0">
      DETAILS
    </h2>
    <div id="flush-collapseOne" class="accordion-collapse collapse">
      <div class="accordion-body" style="font-size:12px"><%=pb.getPcontents()%></div>
    </div>
  </div>
  <div class="accordion-item" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
    <h2 class="accordion-header btn btn-transparent border-0">
      SIZE GUIDE
    </h2>
    <div id="flush-collapseTwo" class="accordion-collapse collapse">
      <div class="accordion-body" style="font-size:12px">(Unit : cm)<br>
		1 : Length 78 / Shoulder 66 / Chest 67 / Sleeve 31 / Armhole 35<br>
		2 : Length 80 / Shoulder 68 / Chest 71 / Sleeve 32 / Armhole 36<br>
		3 : Length 82 / Shoulder 70 / Chest 75 / Sleeve 33 / Armhole 37<br><br>
		
		BOTTOM
		1 : Length 102 / Waist 35 / Thigh 34.5 / Rise 30 / Hem 27<br>
		2 : Length 104 / Waist 39 / Thigh 36.5 / Rise 32 / Hem 29<br>
		
		</div>
		
    </div>
  </div>
  <div class="accordion-item" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
    <h2 class="accordion-header btn btn-transparent border-0">
      SHIPPING
    </h2>
    <div id="flush-collapseThree" class="accordion-collapse collapse">
      <div class="accordion-body" style="font-size:12px">배송 방법 : 택배<br>
			배송 지역 : 전국지역<br>
			배송 비용 : ₩3,000<br>
			배송 기간 : 3일 ~ 7일<br>
			배송 안내 : 산간벽지나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.<br>
			고객님께서 주문하신 상품은 입금 확인후 배송해 드립니다. <br>다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.<br>
		</div>
    </div>
  </div>
</div>
                    
					</p>
					
					<div class="container">
    <div class="container">
    <div class="row">
        <div class="col-md-6">
            <!-- 상품 정보 영역 -->
        </div>
        <div class="col-md-6 d-flex justify-content-between">
            <!-- 버튼 영역 -->
            <form name="f" action="cartaddProc.jsp" method="post" onsubmit="return checkOption()">
    <div class="select-box">
    <%if(pb.getPcategory().equals("BAG")){%>
    	<select name="poption">
            <option value="Size" disabled selected>옵션(필수)</option>
            <option value="Free">F</option>
        </select>
    <%}else{%>
        <select name="poption">
    <option value="Size" disabled selected>옵션(필수)</option>
    <% 
    String[] sizes = pb.getPsize().split(" "); // 공백을 기준으로 문자열을 분할하여 배열에 저장
    for (String size : sizes) { // 배열의 각 요소에 대해 반복
        if (!size.trim().isEmpty()) { // 빈 문자열이 아닌 경우에만 처리
    %>
        <option value="<%= size.trim() %>"><%= size.trim() %></option>
    <% 
        }
    } 
    %>
		</select>
    <%}%>
    </div>
    <input type="hidden" name="userid" value="<%=userid%>">
    <input type="hidden" name="pno" value="<%=pb.getPno()%>">
    <input type="hidden" name="pname" value="<%=pb.getPname()%>">
    <input type="hidden" name="pimage" value="<%=pb.getPimage()%>">
    <input type="hidden" name="creserves" value="<%=pb.getReserves()%>">
    <input type="hidden" name="price" value="<%=pb.getPrice()%>">
    <div class="qt-area">
        <input type="number" name="cqty" value="1" min="1" max="<%=pb.getPqty()%>">
    </div>
    <input type="submit" class="btn btn-theme" value="장바구니 담기">
    <input type="button" class="btn btn-theme" value="바로 구매하기" onclick="goOrder('<%=pb.getPno()%>')">
</form>
        </div>
    </div>
</div>
                    
                    


                    <p><span class="strong-text">Categories:&nbsp;</span><%=pb.getPcategory()%></p>



                </div>

            </div>

        </div>

    </div> 

    <div class="container" >

        <div class="row">

            <div class="single-product-tabs"  style="width:100%;">

                <ul class="nav nav-tabs nav-single-product-tabs">

                    <li class="active"><a href="#description" data-toggle="tab">REVIEW</a></li>

                    <li><a href="#reviews" data-toggle="tab">REFUND AND EXCHANGE</a></li>

                    <li><a href="#care" data-toggle="tab">CARE</a></li>
                </ul>

                <div class="tab-content">

                    <div class="tab-pane active" id="description">

                        <div class="product-desc">


    						<table class="table table-striped">
    <tbody>
        <% 
        if(rlists.size() == 0){
        %>  
            <tr>
                <td colspan="3" align="center">상품 후기가 없습니다</td>
            </tr>
        <%
        } else {
            for (ReviewBean rb : rlists) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                Date regDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rb.getRegdate());
                String sdfdate = sdf.format(regDate);
        %>
            <tr>
                <td class="review-title"><%= rb.getRtitle() %></td>
                <td><%= rb.getRwriter() %></td>
                <td><%= sdfdate %></td>
            </tr>
            <tr class="review-content" style="display: none;">
                <td colspan="3"><%= rb.getRcontent() %></td>
            </tr>
        <% 
            } 
        }
        %>
    </tbody>
</table>
                            <div>
                            <input type="submit" class="btn btn-theme" value="Write" onclick="location='reviewForm.jsp?pno=<%=pno%>'">
                			<input type="button" class="btn btn-theme" value="List" onclick="location='reviewList.jsp'">
                            </div>

                        </div>

                    </div>

                    <div class="tab-pane" id="reviews" >
    				<p style="font-size: 12px;">
        			<strong>교환 및 반품 주소</strong><br>
        			[16261] 경기 수원시 팔달구 행궁로 11 매산집배소<br><br>
        			<strong>교환 및 반품이 가능한 경우</strong><br>
        			- 계약내용에 관한 서면을 받은 날부터 7일. 단, 그 서면을 받은 때보다 재화등의 공급이 늦게 이루어진 경우에는 재화등을 공급받거나 재화등의 공급이 시작된 날부터 7일 이내<br>
        			- 공급받으신 상품 및 용역의 내용이 표시.광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날 부터 3월이내, 그사실을 알게 된 날 또는 알 수 있었던 날부터 30일이내<br>
        			<br>
        			<strong>교환 및 반품이 불가능한 경우</strong><br>
        			- 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다)<br>
        			- 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우<br>
        			- 시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우<br>
        			- 복제가 가능한 재화등의 포장을 훼손한 경우<br>
        			- 개별 주문 생산되는 재화 등 청약철회시 판매자에게 회복할 수 없는 피해가 예상되어 소비자의 사전 동의를 얻은 경우<br>
        			- 디지털 콘텐츠의 제공이 개시된 경우, (다만, 가분적 용역 또는 가분적 디지털콘텐츠로 구성된 계약의 경우 제공이 개시되지 아니한 부분은 청약철회를 할 수 있습니다.)<br>
        			<br>
        			<strong>※ 고객님의 마음이 바뀌어 교환, 반품을 하실 경우 상품반송 비용은 고객님께서 부담하셔야 합니다. (색상 교환, 사이즈 교환 등 포함)</strong>
    				</p>
					</div>
                    

                    <div class="tab-pane" id="care">
    				<p style="font-size: 12px;">
        			<strong>제품 취급 주의사항</strong><br>
        				- 상품의 특성에 따라 취급 방식이 다르오니 상품별 상세페이지를 참고해주시고, 취급 부주의로 인한 제품의 형태가 변질됐을 경우 보상이 불가하니 이 점 유의해주세요.<br>
        				- 세탁 중 탈색의 우려가 있으므로, 단독 또는 같은 계열의 색상끼리 세탁해주시고, 짙은 색상의 제품은 세탁 후 색상이 연해질 수 있습니다.<br>
        				- 원단 특성상 마찰에 의하여 다른 의류 등에 이염이 될 수 있으므로, 옅은 색의 제품(의류, 소파, 구두, 운동화, 이너웨어, 가방 등)과 함께 사용하는 것을 삼가주세요.<br>
        				- 제품의 변형 및 손상 예방을 위해 손세탁 권장, 세탁기 이용 시 세탁망 사용을 권장합니다.<br>
        				- 합성세제는 세탁 시 원단 손상이 있을 수 있으니 사용하지 마시고, 중성세제를 이용하여 세탁해주세요.<br>
       				 	- 세탁 시에는 옷을 뒤집고 단추와 지퍼가 있는 의류는 모두 잠근 후 세탁해주세요.<br>
        				- 비벼서 세탁하거나 비틀어 물을 짤 경우 옷의 형태가 변형되고 보풀이 발생할 수 있으니 유의해주세요.<br>
        				- 세탁 후 건조 시에는 잘 펼쳐서 직사광선을 피해 자연 건조 해주시고 장시간 보관 시 통풍이 잘되고 습기가 없는 곳에 보관해주세요.<br>
        				- 고온의 다림질은 나염의 손상, 탈색, 수축의 원인이 될 수 있으니 주의해주세요.<br>
        				- 건조기는 제품의 변형 및 손상의 우려가 있으니 사용을 삼가주세요.<br>
        				- 이 외 궁금하신 점은 고객센터로 문의바랍니다.
    				</p>
					</div>


                </div>

            </div>

        </div>

    </div>


        <%@ include file="prod_bottom.jsp" %>