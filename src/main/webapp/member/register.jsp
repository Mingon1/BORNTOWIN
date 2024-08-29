<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/script.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/member/userscript.js"></script>
    <%@ include file="top.jsp" %>
    
<style>
form{
margin : auto;
padding-left: 40px;
}
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
    margin-bottom: 10px; /* 여백 추가 */
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

</style>
    <form action="registerProc.jsp" method="post" name="f">
	<div>
    <div>
    	<b>아이디<font color="blue">*</font></b> <input type="text" name="id">
    	<input type="button" value="중복체크" onclick="duplicate()">
    	</div>
    	<p id="idmsg"></p>
    <br><br>
    
    <div><b>비밀번호<font color="blue">*</font></b> <input type="password" name="passwd" onBlur="pwcheck()"></div>
    <span>(영문 대소문자/숫자/특수문자 중 2가지 이상 조합,8자~15자)</span>
    <p id="pwmsg"></p>
    <br><br>
    
    <div><b>비밀번호 확인<font color="blue">*</font></b> <input type="password" name="repasswd" onKeyUp="repwcheck()"></div>
    <p id="repwmsg"></p>
    <br><br>
    
    <div><b>이름<font color="blue">*</font></b> <input type="text" name="name"></div>
	<p id="namemsg"></p>
    <br><br>
    
    <div><b>전화번호<font color="blue">*</font></b>
    		<select name="phone1">
            	<option>010</option>
            	<option>011</option>
            	<option>016</option>
            	<option>017</option>
            </select>-
            <input type="text" name="phone2" size="4" maxlength="4">-
            <input type="text" name="phone3" size="4" maxlength="4"></div>
    <br><br>
    
    <div><b>생년월일<font color="blue">*</font></b>
    <select name="year" >
    <%for(int i=2024; i>1950; i--){ %>
    <option><%=i%></option>
    <%}%>
    </select>년
    
    <select name="month">
    <%for(int i=1; i<=12; i++){%>
    <option><%=i%></option>
    <%}%>
    </select>월
    <select name="day">
    <%for(int i=1; i<=31; i++){%>
    <option><%=i%></option>
    <%}%>
    </select>일
    <br><br>
    </div>
    
    <div><b>성별<font color="blue">*</font></b>
    <input type="radio" name="gender" value="남">남
    <input type="radio" name="gender" value="여">여
    </div>
    <br>
    
    <div><b>이메일<font color="blue" >*</font></b> 
    <input type="text" name="email" onBlur="emcheck()"></div>
    <span>(@를 포함하고 도메인주소가 들어가야합니다.)</span>
    <p id="emailmsg"></p>
    <br><br>
    
    <div><b>주소<font color="blue">*</font></b>
    <input type="text" id="sample4_postcode" name="postaddr" placeholder="우편번호">
	<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
	<input type="text" id="sample4_roadAddress" name="roadaddr" placeholder="도로명주소">
	<input type="text" id="sample4_jibunAddress" name="jibunaddr" placeholder="지번주소">
	<span id="guide" style="color:#999;display:none"></span>
	<input type="text" id="sample4_detailAddress" name="detailaddr" placeholder="상세주소">
	<input type="text" id="sample4_extraAddress" name="exaddr" placeholder="참고항목">
    </div>

	<div><input type="submit" value="회원가입" onclick="return Check()"></div>
	</div>
    </form>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <%@ include file="bottom.jsp" %>
    