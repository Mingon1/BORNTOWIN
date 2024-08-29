<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="top.jsp" %>

    <style>
    form {
    margin: 0 auto; 
    background-color: #fff; 
}
input[type="text"],
input[type="password"],
input[type="submit"] {
    width: 100%;
    padding: 7px;
    margin: 3px 0;
    border: 1px solid #191919;
    border-radius: 3px;
    box-sizing: border-box; 
}
input[type="button"]{
	width: 100%;
	padding: 7px;
	border: 1px solid #191919;
	box-sizing: border-box;
	border-radius: 3px;
	background-color: #fff; 
}
input[type="submit"] {
    background-color: #191919; 
    color: white; 
    border: none; 
    cursor: pointer; 
}

</style>

<div align="center"><h4><b>로그인</b></h4></div><br><br>
<form name="myform" method="post" action="loginpro.jsp" style="width:30%">

<div><input type="text" name="id" placeholder="아이디 또는 이메일"></div>
<div><input type="password" name="passwd" placeholder="비밀번호"></div>
<div><input type="submit" value="로그인"></div>
<br>

<div><input type="button" value="회원가입" onclick="location='<%=request.getContextPath()%>/member/register.jsp'"></div>
<br><br>

<div><a href="<%=request.getContextPath()%>/member/findid.jsp" ><font color="black"><b>아이디찾기</b></font></a><font color="gray">또는</font><a href="<%=request.getContextPath()%>/member/findpw.jsp"><font color="black"><b>비밀번호찾기</b></font></a></div>


</form>

<%@ include file="bottom.jsp" %>