<%@page import="gym.shop.mall.CartBean"%>
<%@page import="gym.shop.mall.CartDao"%>
<%@page import="gym.admin.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gym.admin.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
    function checkKeyword() {
        var keywordInput = document.querySelector('.searchform input[type="text"]');
        var keyword = keywordInput.value.trim();
        
        if (keyword === '') {
            alert('검색어를 입력해주세요.');
            keywordInput.focus();
            return false; 
        }
        return true; 
    }
    
    function AfterLogin() {
    	alert("로그인 후 사용해주세요.");
        window.location.href = "<%=request.getContextPath()%>/login.jsp";
    }
             
</script> 

<style>
body{
height: 100vh;
}
</style>
    <% 
    request.setCharacterEncoding("UTF-8");
    String userid = (String)session.getAttribute("userid");
    String username = (String)session.getAttribute("username");
    String pno1 = (String)session.getAttribute("pno");
   /*  System.out.println("top.username:"+username);
    System.out.println("userid:"+userid);
    System.out.println("pno1:"+pno1); */
    CartDao cdao = CartDao.getInstance();
    ArrayList<CartBean> clists = cdao.getAllCartListById(userid);
    int cnt = cdao.getCartListCount(userid);
    //System.out.println("장바구니 갯수:"+cnt);
    %>
<!DOCTYPE HTML>

<html lang="en-US">

<head>

	<meta charset="UTF-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1">

	<title>본투윈</title>

	<!-- Latest compiled and minified CSS -->

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

	<!-- Google Font -->

	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700|Raleway:400,300,500,700,600' rel='stylesheet' type='text/css'>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.css" type="text/css">

    <!-- Theme Stylesheet -->

    <link rel="stylesheet" href="<%=request.getContextPath()%>/mainBoot/css/style.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/mainBoot/css/responsive.css">

</head>

<body>

    <div class="top-bar">

        <div class="container">

            <div class="row">

                <div class="col-md-6">

                    <div class="social pull-left">

                        <ul>

                            <li><a href="https://www.instagram.com/borntowin.co.kr/?hl=ko"><i class="fa fa-instagram"></i></a></li>

                            <li><a href="https://www.youtube.com/hashtag/%EB%B3%B8%ED%88%AC%EC%9C%88"><i class="fa fa-youtube"></i></a></li>

                        </ul>

                    </div>

                </div>

                <div class="col">

                    <div class="action pull-right">

                        <ul>

                            <% if (userid == null) { %>
                			<li><a href="<%=request.getContextPath()%>/login.jsp"><i class="fa fa-user"></i>로그인</a></li>
                			<li><a href="<%=request.getContextPath()%>/member/register.jsp"><i class="fa fa-lock"></i>회원가입</a></li>
            				
            				<% } else if(userid.equals("admin")){ %>
                            <li><a href="<%=request.getContextPath()%>/admin/main.jsp"><i class="fa fa-user-o"></i>관리자페이지</a></li>
            				<li><font color="#fff"><%=username%>님</font>&nbsp; &nbsp; &nbsp;<a href="<%=request.getContextPath()%>/logout.jsp"><i class="fa fa-lock"></i>로그아웃</a></li>
           					<% }else{ %>
                			<li><font color="#fff"><%=username%>님</font>&nbsp; &nbsp; &nbsp;<a href="<%=request.getContextPath()%>/logout.jsp"><i class="fa fa-lock"></i>로그아웃</a></li>
                            <%}%>
                            <% if (userid == null) { %>
    						<li><a href="#" onclick="AfterLogin()">마이페이지</a></li>
							<% } else { %>
    						<li><a href="<%=request.getContextPath()%>/gymshop/myPageForm.jsp?pno=<%=pno1%>">마이페이지</a></li>
							<% } %>

           </ul>

                    </div>

                </div>

            </div>

        </div>

    </div>

    <div class="header">

        <div class="container">

            <div class="row">

                <div class="col-md-3 col-sm-4">

                    <div class="logo">

                        <a href="<%=request.getContextPath()%>/main.jsp">

                            <img src="<%=request.getContextPath()%>/images/logo.png" alt="GYM-shop">

                        </a>

                    </div>

                </div>

                <div class="col-md-7 col-sm-5">

                    <div class="search-form">

                        <form class="searchform" method="post" action="<%=request.getContextPath()%>/gymshop/searchForm.jsp" role="search" onsubmit="return checkKeyword();">

<div class="form-group">
    <div class="input-group">
        <input type="text" class="form-control" name="keyword" placeholder="Search">
        <span class="input-group-btn">
            <button class="btn btn-default" type="submit"><i class="fa fa-search" style="height: 20px"></i></button>
        </span>
    </div>
</div>
                        </form>

                    </div>

                </div>

                <div class="col-md-2 col-sm-3">

                    <div class="cart">

                        <div class="cart-icon">
                        	
							<%
							if(clists.size()>0){
							for(CartBean cb : clists){
							%>
                            <a href="<%=request.getContextPath()%>/gymshop/cartlist.jsp?pno=<%=cb.getPno()%>"><%}%><i class="fa fa-shopping-cart"></i></a>
							<%}else{%>
							 <a href="<%=request.getContextPath()%>/gymshop/cartlist.jsp?pno=1"><i class="fa fa-shopping-cart"></i></a><!--번호를 뭐라도 보내주자 -->
							<%}%>
                        </div>

                        <div class="cart-text">

                            장바구니(<b><%=cnt%></b>)

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

    <div class="navigation">

        <nav class="navbar navbar-theme">

          <div class="container">

            <!-- Brand and toggle get grouped for better mobile display -->

            <div class="navbar-header">

              <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false">

                <span class="sr-only">Menu</span>

                <span class="icon-bar"></span>

                <span class="icon-bar"></span>

                <span class="icon-bar"></span>

              </button>

            </div>

            <div class="shop-category nav navbar-nav navbar-left">

                <!-- Single button -->

                <div class="btn-group">

                  <button type="button" class="btn btn-shop-category dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

                    Shop<span class="caret"></span>

                  </button>

                  <ul class="dropdown-menu">

                    <li><a href="<%=request.getContextPath()%>/gymshop/allproduct.jsp">ALL</a></li>
                    
                    <li><a href="<%=request.getContextPath()%>/gymshop/cateproduct.jsp?pcategory=Top">Top</a></li>
                    
                    <li><a href="<%=request.getContextPath()%>/gymshop/cateproduct.jsp?pcategory=BOTTOM">BOTTOM</a></li>
                    
                    <li><a href="<%=request.getContextPath()%>/gymshop/cateproduct.jsp?pcategory=Women">Women</a></li>

                    <li><a href="<%=request.getContextPath()%>/gymshop/cateproduct.jsp?pcategory=BAG">BAG</a></li>
                    
                    <li><a href="<%=request.getContextPath()%>/gymshop/cateproduct.jsp?pcategory=OUTER">OUTER</a></li>

                  </ul>

                </div>

            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->

            <div class="collapse navbar-collapse" id="navbar">

              <ul align="right"  class="nav navbar-nav navbar-right">

                <li><a href="<%=request.getContextPath()%>/gymshop/about.jsp">ABOUT</a></li>

                <li><a href="<%=request.getContextPath()%>/board/board.jsp">Q&A</a></li>

                <li><a href="<%=request.getContextPath()%>/gymshop/reviewList.jsp">REVIEW</a></li>
                
                <li><a href="<%=request.getContextPath()%>/gymshop/notice.jsp">NOTICE</a></li>

              </ul>

            </div><!-- /.navbar-collapse -->

          </div><!-- /.container-fluid -->

        </nav>

    </div>