<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="top.jsp" %>
<style>
    form{
    	text-align: center;
    	border: 1px;
    }
    
    input[type="text"] {
        border: 1px solid #000; 
        border-left: none;
        border-right: none;
        border-top: none; 
        padding: 5px; 
        width: 200px; 
        color: #000; 
        background-color: #fff; 
    }
     input[type="submit"]{
    width: 40%; 
    color:#191919; 
    cursor: pointer; 
    border: 1px solid #191919;
	box-sizing: border-box;
	border-radius: 3px;
}

    td {
        border: none; /* 테이블의 테두리를 없앰 */
    }
</style>
<form action="findpw_proc.jsp">
<div class="titleArea">
    <h3 style="font-size: 18px;"><b>비밀번호 찾기</b></h3>
</div>
<br>
    <div>
        <p><b>비밀번호 찾기</b></p>
        <p>
            <strong style="display: inline-block; width: 70px; text-align: left;">이름</strong> 
            <input type="text" name="name">
        </p>
        <p>
            <strong style="display: inline-block; width: 70px; text-align: left;">아이디</strong>
            <input type="text" name="id">
        </p>
    </div><br>
    <div>
        <input type="submit" value="확인">
    </div>
</form>


<%@ include file="bottom.jsp" %>