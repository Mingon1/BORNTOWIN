<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="top.jsp" %>

<style>
    form{
    	text-align: center;
    	border: 1px;
    }
    
    input[type="text"] ,
    select {
        border: 1px solid #000; 
        border-left: none;
        border-right: none;
        border-top: none; 
        padding: 5px; 
        color: #000; 
        background-color: #fff; 
    }
    input[type="submit"]{
     
    color:#191919; 
    cursor: pointer; 
    border: 1px solid #191919;
	box-sizing: border-box;
	border-radius: 3px;
}

</style>
<form name="f" method="post" action="findid_proc.jsp">
<div class="titleArea">
    <h3 style="font-size: 18px;"><b>아이디 찾기</b></h3>
    <div style="text-align: center;">
            <p>가입하신 방법에 따라 아이디 찾기가 가능합니다.</p>
            <p>이름과 휴대폰 번호를 입력해 주세요.</p>
    </div>
    <br>
</div>
    <div>
        <p Style="text-align:center;"><b>아이디 찾기</b></p>
        <p>
            <strong style="display: inline-block; width: 70px; text-align: left;">이름</strong> 
            <input type="text" name="name" width = "30%">
        </p>
        <p>
            <strong style="display: inline-block; width: 70px; text-align: left;">전화번호</strong> 
            <select name="phone1">
            	<option>010</option>
            	<option>011</option>
            	<option>016</option>
            	<option>017</option>
            </select>-
            <input type="text" name="phone2" size="4">-
            <input type="text" name="phone3" size="4">
        </p>
    </div><br>
    <div>
        <input style ="width: 400px;" type="submit" value="확인">
    </div>
</form>


<%@ include file="bottom.jsp" %>