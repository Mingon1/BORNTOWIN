<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="gym.shop.mall.OrderBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gym.shop.mall.OrderDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="top.jsp" %>
 <%
 DecimalFormat df = new DecimalFormat("###,###");
 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

 OrderDao odao = OrderDao.getInstance();
 ArrayList<OrderBean> olists = odao.getAllOrders();
 int totalAmount = 0;
 String sdfdate;
 for(OrderBean ob : olists){
	 totalAmount += ob.getAmount();
 Date odate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(ob.getOdate());
 sdfdate= sdf.format(odate);
 }
 %>
		<!-- END LEFT SIDEBAR -->
		<!-- MAIN -->
		<div class="main">
			<!-- MAIN CONTENT -->
			<div class="main-content">
				<div class="container-fluid">
					<h3 class="page-title">매출통계</h3>
					<div class="row">
						<div class="col">
							<div class="panel">
								<div class="panel-heading">
									<h3 class="panel-title">총매출:<%=df.format(totalAmount)%>원</h3>
								</div>
								<div class="panel-body">
									<div id="demo-bar-chart" class="ct-chart"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- END MAIN CONTENT -->
		</div>
		<!-- END MAIN -->
		<div class="clearfix"></div>
		<footer>
			<div class="container-fluid">
				<p class="copyright">Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a>
</p>
			</div>
		</footer>
	</div>
	<!-- END WRAPPER -->
	<!-- Javascript -->
	<script src="assets/vendor/jquery/jquery.min.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<script src="assets/vendor/chartist/js/chartist.min.js"></script>
	<script src="assets/scripts/klorofil-common.js"></script>
	<script>
	$(function() {
		var options;

		var data = {
			labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
			series: [
				[200, 380, 350, 320, 410, 450, 570, 400, 555, 620, 750, 900],
			]
		};

		// bar chart
		options = {
			height: "700px",
			axisX: {
				showGrid: false
			},
		};

		new Chartist.Bar('#demo-bar-chart', data, options);

	});
	</script>
</body>

</html>
