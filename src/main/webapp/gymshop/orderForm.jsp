<%@page import="java.text.DecimalFormat"%>
<%@page import="gym.user.UserBean"%>
<%@page import="gym.user.UserDao"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="prod_top.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>


<style>
  .accordion-button {
    border: none; /* 테두리 없애기 */
    background-color: white; /* 배경 흰색 */
    color: black; /* 글자색 검은색 */
    font-size: 15px; 
  }
  
  th, td {
    text-align: left;
    padding: 8px;
  }
  #div{
  padding: 40px
  }
</style>

<script>
  function showInput() {
    var selectBox = document.getElementById("deliveryOption");
    var userInput = document.getElementById("userInput");

    if (selectBox.value === "직접입력") {
      userInput.style.display = "block";
    } else {
      userInput.style.display = "none";
    }
  }
  
  function selectPayment(payment) {
	    // 이전에 선택했던 결제수단의 체크를 해제
	    var previousPayment = document.querySelector('input[name="payment"]:checked');
	    if (previousPayment !== null) {
	        previousPayment.checked = false;
	    }
	    // 새로 선택한 결제수단의 체크를 설정
	    var newPayment = document.querySelector('input[value="' + payment + '"]');
	    if (newPayment !== null) {
	        newPayment.checked = true;
	    }
	}
  
  function payCheck() {
      var payment = document.querySelector('input[name="payment"]:checked');
      if (!payment) {
          alert("결제 방법을 선택하세요.");
          return false;
      }
  }

</script>

<%

request.setCharacterEncoding("UTF-8");

String pno =request.getParameter("pno");
String cno = request.getParameter("cno");
clists = cdao.getAllCartListByPno(userid, pno);
%>
<jsp:useBean id="cb1" class="gym.shop.mall.CartBean">
    <jsp:setProperty name="cb1" property="*"/>
    </jsp:useBean>
<%
//System.out.println("오더폼"+pno+cqty+poption);
if(pno !=null || cb1.getCqty()!=0 || cb1.getPoption()!=null){
	cdao.insertCart(cb1);
}

UserDao udao = UserDao.getInstance();
UserBean ub = udao.getAllUser(userid);


//System.out.println("카트리스트:"+clists.size());


DecimalFormat df = new DecimalFormat("###,###");
int totalAmount = 0;
int totalDeliveryFee = 0; 

int reserves =0;

int totalreserves =0;
int totaloqty = 0;
String allPname ="";
%>
<div id="div">
<div><h3>주문/결제</h3></div>
  <form name="f" method="post" action="orderInputProc.jsp" >
                 
<div class="accordion" id="accordionPanelsStayOpenExample">
  <div class="accordion-item">
    <h2 class="accordion-header" id="panelsStayOpen-headingOne"> 
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
        <b>배송정보</b>
      </button>
    </h2>
    <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">
      <div class="accordion-body" style="font-size:12px">
      <b>받는사람<font color="blue">*</font></b><input type="text" name="oname" value="<%=ub.getName()%>">
      <br><br>
      
      <b>휴대전화<font color="blue">*</font></b>
    		<select name="ophone1">
            	<option>010</option>
            	<option>011</option>
            	<option>016</option>
            	<option>017</option>
            </select>-
            <input type="text" name="ophone2" size="4" maxlength="4" value="<%=ub.getPhone2()%>">-
            <input type="text" name="ophone3" size="4" maxlength="4" value="<%=ub.getPhone3()%>">
      <br><br>
      
      <b>이메일<font color="blue">*</font></b><input type="text" name="oemail" value="<%=ub.getEmail()%>">
      <br><br>
      
      <b>주소<font color="blue">*</font></b>
    <input type="text" id="sample4_postcode" name="opostaddr" value="<%=ub.getPostaddr()%>" placeholder="우편번호">
	<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
	<input type="text" id="sample4_roadAddress" name="oroadaddr" value="<%=ub.getRoadaddr()%>" placeholder="도로명주소">
	<input type="text" id="sample4_jibunAddress" name="ojibunaddr" value="<%=ub.getJibunaddr()%>" placeholder="지번주소">
	<span id="guide" style="color:#999;display:none"></span>
	<input type="text" id="sample4_detailAddress" name="odetailaddr" value="<%=ub.getDetailaddr()%>" placeholder="상세주소">
	<input type="text" id="sample4_extraAddress" name="oexaddr" value="<%=ub.getExaddr()%>" placeholder="참고항목">
       <br><br>
       
        배송메모<br><select id="deliveryOption" name="orequests" onchange="showInput()">
          <option>메시지선택(선택사항)</option>
          <option>배송 전에 미리연락 바랍니다.</option>
          <option>부재 시 경비실에 맡겨주세요.</option>
          <option>부재 시 문 앞에 놔주세요.</option>
          <option>빠른 배송 부탁드립니다.</option>
          <option>택배함에 보관해 주세요.</option>
          <option>직접입력</option>
        </select>
        <input type="text" name="orequests" id="userInput" style="display: none;">
      </div>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header" id="panelsStayOpen-headingTwo">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="true" aria-controls="panelsStayOpen-collapseTwo">
        <b>주문상품</b>
      </button>
    </h2>
    <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingTwo">
      <div class="accordion-body" style="font-size:12px">
		<table style="border-collapse: collapse;">
        <tr>
            <th>이미지</th>
            <th>상품정보</th>
            <th>수량</th>
            <th>상품구매금액</th>
            <th>적립금</th>
            <th>배송비</th>
        </tr>
        
        <%for(CartBean cb : clists){
        String requestDir = request.getContextPath()+"/clothes";
        //System.out.println(requestDir+"/"+cb.getPimage());
        allPname += cb.getPname()+",";
        totaloqty += cb.getCqty();
        int amount = cb.getCqty() * cb.getPrice();
        reserves = cb.getCreserves() *  cb.getCqty();
        totalreserves += reserves;
        totalAmount += amount;
        totalDeliveryFee = totalAmount > 60000 ? 0 : 3000; 

        //System.out.println(request.getContextPath());
        %>
        <tr>
            <td>
                <p style="width: 150px;"><img src="<%=requestDir + "/" + cb.getPimage() %>" width= "20%" height="150px"></p>
            </td>
            <td style="width: 200px;">
                <%=cb.getPname()%><br>
                [옵션:<%=cb.getPoption()%>]
            </td>
            <td>
                <%=cb.getCqty()%>개
            </td>

       

            <td>₩<%=df.format(amount)%></td>
            <td>₩<%=df.format(reserves)%></td>
            <td>
                 <% if (totalAmount > 60000) { 
                 %>
                   무료
                <% } else { %>
                    ₩<%= totalDeliveryFee %>
                <% } %>
            </td>
        </tr>
            <input type="hidden" name="pno" value="<%=pno%>">
            <input type="hidden" name="pimage" value="<%=cb.getPimage()%>">
            <input type="hidden" name="ouserid" value="<%=userid%>">
            <input type="hidden" name="ousername" value="<%=username%>">
            <input type="hidden" name="cno" value="<%=cb.getCno()%>">
        
            <%
            System.out.println("오더폼"+cb.getCno());
            }// for

            %>
    </table>
		
		
		</div>
    </div>
  </div>
  
  <div class="accordion-item">
    <h2 class="accordion-header">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="true" aria-controls="flush-collapseThree">
        <b>결제정보</b>
      </button>
    </h2>
    <div id="flush-collapseThree" class="accordion-collapse collapse show" aria-labelledby="flush-headingThree">
      <div class="accordion-body" style="font-size:12px">
			<div>
				주문상품 <p>₩<%=df.format(totalAmount)%></p><br>
				배송비 <p>+₩<%=totalDeliveryFee%></p><br>
			</div>
			<div>최종 결제금액</div><p>₩<%=df.format(totalAmount + totalDeliveryFee)%></p>
		</div>
    </div>
    <div class="accordion-item">
    <h2 class="accordion-header" id="panelsStayOpen-headingFour">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="true" aria-controls="panelsStayOpen-collapseFour">
        <b>결제수단</b>
      </button>
    </h2>
    <div id="flush-collapseFour" class="accordion-collapse collapse show" aria-labelledby="flush-headingFour">
      <div class="accordion-body" style="font-size:12px">
		<div>결제수단 선택</div>
			<input type="radio" name="payment" value="무통장입금" onclick="selectPayment('무통장입금')">무통장입금
			<input type="radio" name="payment" value="신용카드" onclick="selectPayment('신용카드')">신용카드
			<input type="radio" name="payment" value="휴대폰" onclick="selectPayment('휴대폰')">휴대폰
		</div>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header" id="panelsStayOpen-headingFive">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFive" aria-expanded="true" aria-controls="panelsStayOpen-collapseFive">
        <b>적립 혜택</b>
      </button>
    </h2>
    <div id="flush-collapseFive" class="accordion-collapse collapse show" aria-labelledby="flush-headingFive">
      <div class="accordion-body" style="font-size:12px">
		<div>상품 적립금</div><p><%=df.format(totalreserves)%>원 적립예정</p>
		
		</div>
    </div>
  </div>
  </div>
  <br>
  <div>
  <p>구매조건 확인 및 결제진행 동의</p><br>
  <p><b>주문 내용을 확인하였으며 약관에 동의합니다.</b></p>
  </div>
   <input type="hidden" name="amount" value="<%=totalAmount+ totalDeliveryFee%>">
  <input type="hidden" name="totalreserves" value="<%=totalreserves%>">
  <input type="hidden" name="oqty" value="<%=totaloqty%>">
   <input type="hidden" name="pname" value="<%=allPname%>">
  <div><input type="submit" value="₩<%=df.format(totalAmount + totalDeliveryFee)%>&nbsp;결제하기" onclick="return payCheck()"></div>
 
</div>
</form>
</div>
<%@include file="prod_bottom.jsp"%>
