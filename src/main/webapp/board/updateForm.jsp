<%@page import="board2.BoardBean"%>
<%@page import="board2.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/board/bscript.js"></script>

<%@include file="board_top.jsp"%>


<style>

		body {
           font-family: Arial, sans-serif;
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
    <%
    request.setCharacterEncoding("UTF-8");
    
    String bno = request.getParameter("bno");
    String pageNum = request.getParameter("pageNum");
    
    BoardDao bdao = BoardDao.getInstance();
    BoardBean bb = bdao.getArticle(bno);
	String requestDir = request.getContextPath()+"/clothes";

    %>
</head>
<body>
    <form style="width: 80%; margin: 30 auto; padding: 40px; border: 1px solid #ccc; border-radius: 5px;
            background-color: #fff;" action="updateboardproc.jsp?bno=<%=bb.getBno()%>&pageNum=<%=pageNum%>" name="f" method="post" enctype="multipart/form-data">
    <div>
        <b>Q&A</b>
    </div><br><br>
        <div>
            <input type="file" name="pimage" > <br>
            <p style="width: 150px;"><img src="<%=requestDir + "/" + bb.getPimage() %>" width= "150px" height="150px"></p>
            <input type="text" name="pimage2" value="<%=bb.getPimage()%>"> <br>
            <input type="hidden"name="bid" value="<%=userid%>">
            <input type="hidden"name="writer" value="<%=bb.getWriter()%>">
            <input type="hidden" name="reg_date" value="<%=bb.getReg_date()%>">
        </div>
        <hr width="90%">
        제목<div>
            <input type="text" name="title" placeholder="제목을 입력하세요" value="<%=bb.getTitle()%>">
        </div>
        <div class="textLengthWrap">
            <span class="textCount">0</span> / <span class="textTotal">200</span>자
        </div>
        <div>
            <textarea id="textBox" maxlength="200" placeholder="내용을 입력하세요" name="content"><%=bb.getContent()%></textarea>
        </div>
        <div>
            <input type="password" name="passwd" placeholder="비밀번호">
        </div>
        <div>
            <input type="radio" name="secret" value="public"> 
            <label for="public">공개글</label> 
            <input type="radio" name="secret" value="private"> 
            <label for="private">비밀글</label>
        </div>
        <div>
            <ul>
                <li>상품과 관련없는 내용 또는 이미지, 욕설/비방, 개인정보 유출 등은 비공개 처리 될 수 있습니다.</li>
                <li>작성된 게시물은 운영 및 마케팅에 활용될 수 있습니다.</li>
            </ul>
        </div>
        <div>
            <input type="button" value="목록" onclick="location.href='board.jsp'"> 
            <input type="submit" value="수정"> 
            <input type="reset" value="취소">
        </div>
    </form>
<%@include file="board_bottom.jsp"%>
