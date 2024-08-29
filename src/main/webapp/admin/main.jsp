<%@page import="gym.shop.mall.OrderBean"%>
<%@page import="gym.shop.mall.OrderDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="gym.user.UserBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gym.user.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="top.jsp" %>
 
 
 <% 
 
 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
 UserDao udao = UserDao.getInstance();
 ArrayList<UserBean> ulists = udao.getAllUserInfo();
 
 DecimalFormat df = new DecimalFormat("###,###");
 OrderDao odao = OrderDao.getInstance();
 
 int totalReserves =0;
 ArrayList<OrderBean> olists = odao.getAllOrders();
 
 %>
		<!-- MAIN -->
		<div class="main">
			<!-- MAIN CONTENT -->
			<div class="main-content">
				<div class="container-fluid">
					<!-- OVERVIEW -->
					<div class="panel panel-headline">
						<div class="panel-heading">
							<h3 class="panel-title">전체주문내역</h3>
							<p class="panel-subtitle"><%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(new java.util.Date()) %></p>
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col">
									<table class="table table-striped">
										<thead>
											<tr>
												<th>Order No.</th>
												<th>userid</th>
												<th>Amount</th>
												<th>Date &amp; Time</th>
												<th>Status</th>
											</tr>
										</thead>
										<tbody>
										<%
										
										for(OrderBean ob : olists){
										Date odate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ob.getOdate());
										String sdfdate = sdf.format(odate);
										%>
											<tr>
												<td><a href="#"><%=ob.getOno()%></a></td>
												<td><%=ob.getOuserid()%></td>
												<td><%=df.format(ob.getAmount())%>원</td>
												<td><%=sdfdate%></td>
												<td><span class="label label-success">COMPLETED</span></td>
											</tr>
											<%
											olists = odao.getAllOrdersByid(ob.getOuserid());
 											for(OrderBean ob1: olists){
	 										totalReserves += ob1.getTotalreserves(); 
 											}
 											%>
											<%}%>
											
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					
						<div class="col">
							<!-- TABLE HOVER -->
							<div class="panel">
								<div class="panel-heading">
									<h3 class="panel-title">회원정보</h3>
								</div>
								<div class="panel-body">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>#</th>
												<th>이름</th>
												<th>아이디</th>
												<th>성별</th>
												<th>생년월일</th>
												<th>주소</th>
												<th>이메일</th>
												<th>핸드폰 번호</th>
												<th>적립금</th>
												<th>가입날짜</th>
											</tr>
										</thead>
										<tbody>
										<%
										
										for(UserBean ub : ulists){
										Date odate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ub.getJoindate());
										String sdfdate = sdf.format(odate);
										%>
											<tr>
												<td><%=ub.getNo()%></td>
												<td><%=ub.getName()%></td>
												<td><%=ub.getId()%></td>
												<td><%=ub.getGender()%></td>
												<td><%=ub.getYear()%>년<%=ub.getMonth()%>월<%=ub.getDay()%>일</td>
												<td><%=ub.getRoadaddr()%><%=ub.getDetailaddr()%></td>
												<td><%=ub.getEmail()%></td>
												<td><%=ub.getPhone1()%>-<%=ub.getPhone2()%>-<%=ub.getPhone3()%></td>
												<td><%=df.format(ub.getReserves())%>원</td>
												<td><%=sdfdate%></td>
											</tr>
											<%}%>
										</tbody>
									</table>
								</div>
							</div>
							<!-- END TABLE HOVER -->
						</div>
					<div class="row">
    <div class="col">
        <!-- 할 일 목록 -->
        <div class="panel">
            <div class="panel-heading">
                <h3 class="panel-title">To-Do List</h3>
                <div class="right">
                    <button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-up"></i></button>
                    <button type="button" class="btn-remove"><i class="lnr lnr-cross"></i></button>
                </div>
            </div>
            <div class="panel-body">
                <ul class="list-unstyled todo-list">
                    <li>
                        <label class="control-inline fancy-checkbox">
                            <input type="checkbox"><span></span>
                        </label>
                        <p>
                            <span class="title">서버 다시 시작</span>
                            <span class="short-description"></span>
                            <span class="date"><%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(new java.util.Date()) %></span>
                        </p>
                        <div class="controls">
                            <a href="#"><i class="icon-software icon-software-pencil"></i></a> <a href="#"><i class="icon-arrows icon-arrows-circle-remove"></i></a>
                        </div>
                    </li>
                    <li>
                        <label class="control-inline fancy-checkbox">
                            <input type="checkbox"><span></span>
                        </label>
                        <p>
                            <span class="title">게시글 관리하기</span>
                            <span class="short-description"></span>
                            <span class="date"><%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(new java.util.Date()) %></span>
                        </p>
                        <div class="controls">
                            <a href="#"><i class="icon-software icon-software-pencil"></i></a> <a href="#"><i class="icon-arrows icon-arrows-circle-remove"></i></a>
                        </div>
                    </li>
                    <li>
                        <label class="control-inline fancy-checkbox">
                            <input type="checkbox"><span></span>
                        </label>
                        <p>
                            <strong>결제확인</strong>
                            <span class="short-description"></span>
                            <span class="date"><%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(new java.util.Date()) %></span>
                        </p>
                        <div class="controls">
                            <a href="#"><i class="icon-software icon-software-pencil"></i></a> <a href="#"><i class="icon-arrows icon-arrows-circle-remove"></i></a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <!-- 할 일 목록 종료 -->
    </div>
</div>
						<div class="col">
							<!-- TIMELINE -->
							<div class="panel panel-scrolling">
								<div class="panel-heading">
									<h3 class="panel-title">Recent User Activity</h3>
									<div class="right">
										<button type="button" class="btn-toggle-collapse"><i class="lnr lnr-chevron-up"></i></button>
										<button type="button" class="btn-remove"><i class="lnr lnr-cross"></i></button>
									</div>
								</div>
								<div class="panel-body">
									<ul class="list-unstyled activity-list">
										<li>
											<img src="assets/img/user1.png" alt="Avatar" class="img-circle pull-left avatar">
											<p><a href="#">Michael</a> has achieved 80% of his completed tasks <span class="timestamp">20 minutes ago</span></p>
										</li>
										<li>
											<img src="assets/img/user2.png" alt="Avatar" class="img-circle pull-left avatar">
											<p><a href="#">Daniel</a> has been added as a team member to project <a href="#">System Update</a> <span class="timestamp">Yesterday</span></p>
										</li>
										<li>
											<img src="assets/img/user3.png" alt="Avatar" class="img-circle pull-left avatar">
											<p><a href="#">Martha</a> created a new heatmap view <a href="#">Landing Page</a> <span class="timestamp">2 days ago</span></p>
										</li>
										<li>
											<img src="assets/img/user4.png" alt="Avatar" class="img-circle pull-left avatar">
											<p><a href="#">Jane</a> has completed all of the tasks <span class="timestamp">2 days ago</span></p>
										</li>
										<li>
											<img src="assets/img/user5.png" alt="Avatar" class="img-circle pull-left avatar">
											<p><a href="#">Jason</a> started a discussion about <a href="#">Weekly Meeting</a> <span class="timestamp">3 days ago</span></p>
										</li>
									</ul>
									<button type="button" class="btn btn-primary btn-bottom center-block">Load More</button>
								</div>
							</div>
							<!-- END TIMELINE -->
						</div>
					</div>
					
						</div>
					</div>
				</div>
			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN -->
	<!-- Javascript -->
	<script src="assets/vendor/jquery/jquery.min.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script src="assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
	<script src="assets/vendor/chartist/js/chartist.min.js"></script>
	<script src="assets/scripts/klorofil-common.js"></script>
	
</body>

</html>
