<%@page import="board2.ReviewBean"%>
<%@page import="board2.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/board/bscript.js"></script>

<%@include file="prod_top.jsp"%>

<% 
String rno = request.getParameter("rno");
String rpasswd = request.getParameter("rpasswd");
ReviewDao rdao = ReviewDao.getInstance();
ReviewBean rb = rdao.getArticle(rno);
String requestDir = request.getContextPath()+"/clothes";

%>
<style>

		body {
           font-family: Arial, sans-serif;
        }
        form {
            width: 80%;
            margin: 30 auto;
            padding: 40px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
        }
        .textLengthWrap {
            margin-top: 10px;
            text-align: right;
        }
        .textCount {
            font-weight: bold;
            color: #333;
        }
        .textTotal {
            color: #999;
        }
        ul {
            padding: 0;
            font-size: 12px;
            color: #A4A4A4;
        }
        ul li {
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="password"] {
            width: 30%;
            border: 1px solid #000;
            border-left: none;
            border-right: none;
            border-top: none;
            color: #000;
            background-color: #fff;
            margin-bottom: 10px; /* 여백 추가 */
        }
        input[type="file"] {
            display: inline-block;
            margin-bottom: 10px;
        }
        input[type="submit"] {
            padding: 7px;
            margin: 5px 0;
            border: 1px solid #191919;
            border-radius: 3px;
            align: right;
            background-color: #A4A4A4;
            color: #000;
            cursor: pointer;
        }
        input[type="button"],
        input[type="reset"] {
            padding: 7px;
            border: 1px solid #191919;
            border-radius: 3px;
            background-color: #fff;
        }
           
        input[type="button"]:hover,
        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: #D8D8D8;
        }
    </style>
</head>
<body>
    <form action="updateReviewProc.jsp" name="f" method="post" enctype="multipart/form-data">
    <div>
        <b>리뷰 수정</b>
    </div><br><br>
        <div>
            <input type="file" name="rimage"> <br>
            <p style="width: 150px;"><img src="<%=requestDir + "/" + rb.getRimage() %>" width= "150px" height="150px"></p>
            <input type="text" name="pimage2" value="<%=rb.getRimage()%>"> <br>
            <input type="hidden"name="ruserid" value="<%=userid%>">
            <input type="hidden"name="rwriter" value="<%=username%>">
            <input type="hidden"name="rno" value="<%=rno%>">
            <input type="hidden"name="rpasswd" value="<%=rpasswd%>">
        </div>
        <hr width="90%">
        <div>
            <input type="text" name="rtitle" value="<%=rb.getRtitle()%>"placeholder="제목을 입력하세요">
        </div>
        <div class="textLengthWrap">
            <span class="textCount">0</span> / <span class="textTotal">200</span>자
        </div>
        <div>
            <textarea id="textBox" maxlength="200" cols="60" rows="5"  placeholder="내용을 입력하세요" name="rcontent"><%=rb.getRcontent()%></textarea>
        </div>
        <div>
            <ul>
                <li>상품과 관련없는 내용 또는 이미지, 욕설/비방, 개인정보 유출 등은 비공개 처리 될 수 있습니다.</li>
                <li>작성된 게시물은 운영 및 마케팅에 활용될 수 있습니다.</li>
            </ul>
        </div>
        
        <div>
            <input type="button" value="뒤로" onclick="location.href='myPageForm.jsp'"> 
            <input type="submit" value="수정"> 
            <input type="reset" value="취소">
        </div>
    </form>
<%@include file="prod_bottom.jsp"%>
