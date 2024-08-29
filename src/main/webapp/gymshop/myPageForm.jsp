<%@page import="board2.ReviewBean"%>
<%@page import="board2.ReviewDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="gym.shop.mall.OrderBean"%>
<%@page import="gym.shop.mall.OrderDao"%>
<%@page import="gym.user.UserBean"%>
<%@page import="gym.user.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/member/userscript.js"></script>
<%@include file="prod_top.jsp"%>
    
<style>
input[type="text"],
input[type="password"],
select {
    border: 1px solid #000; 
    border-left: none;
    border-right: none;
    border-top: none; 
    padding: 5px; 
    color: #000; 
    background-color: #fff; 
}

span.error-message {
    color: red;
}

input[type="submit"] {
    width: 40%; 
    color:#191919; 
    cursor: pointer; 
    border: 1px solid #191919;
    box-sizing: border-box;
    border-radius: 3px;
    padding: 8px 0;
    margin-top: 10px; 
}
input[type="button"] {
  background-color: #000;
  color: #fff;
  border: none;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 12px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 4px;
}

input[type="button"]:hover {
  background-color: #333; 
}
.accordion-button {
    border: none; /* 테두리 없애기 */
    background-color: white; /* 배경 흰색 */
    color: black; /* 글자색 검은색 */
    font-size: 15px; 
    padding: 5px;
  }

</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
                    
<%

String pno= request.getParameter("pno");
UserDao udao = UserDao.getInstance();
UserBean ub = udao.getAllUser(userid);
OrderDao odao =OrderDao.getInstance();
ArrayList<OrderBean> olists = odao.getAllOrdersByid(ub.getId());

DecimalFormat df = new DecimalFormat("###,###");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

ReviewDao rdao = ReviewDao.getInstance();
ArrayList<ReviewBean> rlists = rdao.getArticlesByRuserid(ub.getId());

%>
<div class="accordion" id="accordionPanelsStayOpenExample">
  <div class="accordion-item">
    <h2 class="accordion-header btn btn-transparent border-0" id="flush-headingOne">
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="true" aria-controls="flush-collapseOne">
        정보수정
      </button>
    </h2>
    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionPanelsStayOpenExample">
      <div class="accordion-body" style="font-size:12px">
      <form action="<%=request.getContextPath()%>/member/updateinfoProc.jsp" method="post" name="f">
   
    <div>
    	<input type="hidden" name="id" value="<%=ub.getId()%>">
    	<%System.out.println("폼아이디:"+ub.getId());%>
    
    
    <div><b>이름<font color="blue">*</font></b> <input type="text" name="name" value="<%=ub.getName()%>"></div>
	<p id="namemsg"></p>
    <br><br>
    
    <div><b>전화번호<font color="blue">*</font></b>
    		<select name="phone1">
            	<option>010</option>
            	<option>011</option>
            	<option>016</option>
            	<option>017</option>
            </select>-
            <input type="text" name="phone2" size="4" maxlength="4" value="<%=ub.getPhone2()%>">-
            <input type="text" name="phone3" size="4" maxlength="4" value="<%=ub.getPhone3()%>"></div>
    <br><br>
    
     <div><b>생년월일<font color="blue">*</font></b>
    <select name="year" >
    <%for(int i=2024; i>1950; i--){ %>
    <option <%= ub.getYear().equals(String.valueOf(i)) ? "selected" : "" %>><%=i%></option>
    <%}%>
    </select>년
    
    <select name="month">
    <%for(int i=1; i<=12; i++){%>
    <option <%= ub.getMonth().equals(String.valueOf(i)) ? "selected" : "" %>><%=i%></option>
    <%}%>
    </select>월
    <select name="day">
    <%for(int i=1; i<=31; i++){%>
    <option <%= ub.getDay().equals(String.valueOf(i)) ? "selected" : "" %>><%=i%></option>
    <%}%>
    </select>일
    <br><br>
    </div>
    
    <div><b>성별<font color="blue">*</font></b>
    <input type="radio" name="gender" value="남" <%= ub.getGender().equals("남") ? "checked" : "" %>>남
    <input type="radio" name="gender" value="여" <%= ub.getGender().equals("여") ? "checked" : "" %>>여
    </div>
    <br>
    
    <div><b>이메일<font color="blue" >*</font></b> 
    <input type="text" name="email" value="<%=ub.getEmail()%>" onBlur="emcheck()"></div>
    <span>(@를 포함하고 도메인주소가 들어가야합니다.)</span>
    <p id="emailmsg"></p>
    <br><br>
    
    <div><b>주소<font color="blue">*</font></b>
    <input type="text" id="sample4_postcode" name="postaddr" value="<%=ub.getPostaddr()%>"placeholder="우편번호">
	<input type="button" onclick="sample4_execDaumPostcode()"  value="우편번호 찾기"><br>
	<input type="text" id="sample4_roadAddress" name="roadaddr" value="<%=ub.getRoadaddr()%>" placeholder="도로명주소">
	<input type="text" id="sample4_jibunAddress" name="jibunaddr" value="<%=ub.getJibunaddr()%>" placeholder="지번주소">
	<span id="guide" style="color:#999;display:none"></span>
	<input type="text" id="sample4_detailAddress" name="detailaddr" value="<%=ub.getDetailaddr()%>" placeholder="상세주소">
	<input type="text" id="sample4_extraAddress" name="exaddr" value="<%=ub.getExaddr()%>" placeholder="참고항목">
    </div>

	  <div><input type="submit" value="정보수정"></div>
	</div>
    </form>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
      </div>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header btn btn-transparent border-0" id="flush-headingTwo">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
        비밀번호 변경
      </button>
    </h2>
    <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionPanelsStayOpenExample">
      <form name="pwf" method="post" action="<%=request.getContextPath()%>/member/changePw.jsp">
      <div class="accordion-body" style="font-size:12px">
		<div><b>비밀번호<font color="blue">*</font></b> <input type="password" name="passwd" onBlur="pwcheck()"></div>
    <span>(영문 대소문자/숫자/특수문자 중 2가지 이상 조합,8자~15자)</span>
    <p id="pwmsg"></p>
    <br><br>
    <input type="hidden" name="id" value="<%=ub.getId()%>">
    <div><b>비밀번호 확인<font color="blue">*</font></b> <input type="password" name="repasswd" onKeyUp="repwcheck()"></div>
    <p id="repwmsg"></p>
    <br><br>
    </div>
    <div><input type="submit" value="변경하기"></div>
      </form>
  </div>
  
  <div class="accordion-item">
    <h2 class="accordion-header btn btn-transparent border-0" id="flush-headingThree">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
        주문 내역
      </button>
    </h2>
    <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionPanelsStayOpenExample">
      <div class="accordion-body" style="font-size:12px">
      
			<div><h4>주문한 상품:</h4></div>
			
			<%
			int i =1;  
			for(OrderBean ob : olists){
			Date odate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ob.getOdate());
			String sdfdate = sdf.format(odate);
			%>
			<div><h4><b><%=i%>:</b></h4></div>
			<hr>
			<div>
			주문한 상품:<%=ob.getPname()%>
			<input type="button" value="후기작성하기" onclick="location='reviewForm.jsp?pno=<%=pno%>'">
			</div>
			<hr>
			<div>주문한 상품갯수:<%=ob.getOqty()%>개</div>
			<hr>
			<div>결제 금액:<%=df.format(ob.getAmount())%>원</div>
			<hr>
			<div>주문 날짜:<%=sdfdate%></div>
			<hr>
			<%
			i++;
			}
			%>
		</div>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header btn btn-transparent border-0" id="flush-headingFour">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFour" aria-expanded="false" aria-controls="flush-collapseFour">
       	작성한 리뷰
      </button>
    </h2>
    <div id="flush-collapseFour" class="accordion-collapse collapse" aria-labelledby="flush-headingFour" data-bs-parent="#accordionPanelsStayOpenExample">
      <div class="accordion-body" style="font-size:12px">
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
				if(rlists.size() == 0){
				%>	
					<tr>
						<td colspan="6" align="center">작성한 글이 없습니다</td>
					</tr>
					</table>
				<%
				}else{
					for(ReviewBean rb : rlists){
						Date regDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rb.getRegdate());
						String sdfdate = sdf.format(regDate);
				    	String requestDir = request.getContextPath()+"/clothes";

				%>
					<tr>
						<td style="vertical-align: middle;"><%=rb.getRno()%></td>
						<%if(rb.getRimage()==null){
						%>
						<td></td>
						<%}else{%>
						<td>
            			<p style="width: 100px;"><img src="<%=requestDir + "/" + rb.getRimage() %>" width= "10%" height="100px"></p>
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
						<a href="mycontent.jsp?rno=<%=rb.getRno()%>&ruserid=<%=rb.getRuserid()%>"><%=rb.getRtitle()%></a>
							
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
  </div>
  
  <div class="accordion-item">
    <h2 class="accordion-header btn btn-transparent border-0" id="flush-headingFive">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFive" aria-expanded="false" aria-controls="flush-collapseFive">
        회원 탈퇴
      </button>
    </h2>
    <div id="flush-collapseFive" class="accordion-collapse collapse" aria-labelledby="flush-headingFive" data-bs-parent="#accordionPanelsStayOpenExample">
      <div class="accordion-body" style="font-size:12px">
      		<div>
      		가입된 회원정보가 모두 삭제됩니다. 작성하신 게시물은 삭제되지 않습니다.<br>
      		탈퇴 후 같은 계정으로 재가입 시 기존에 가지고 있던 적립금은 복원되지 않습니다.<br>
      		회원 탈퇴를 진행하시겠습니까?(<font color="red">※버튼을 클릭하면 바로 삭제됩니다</font>)
      		</div>
			<input type="button" value="탈퇴하기" onclick="location='<%=request.getContextPath()%>/member/deleteAccount.jsp?id=<%=ub.getId()%>'">
		</div>
    </div>
  </div>
</div>
    
    

<%@include file="prod_bottom.jsp"%>